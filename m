Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA77535DC41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhDMKMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 06:12:39 -0400
Received: from mx2.veeam.com ([64.129.123.6]:51054 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhDMKMh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:12:37 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 845C4413F8;
        Tue, 13 Apr 2021 06:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1618308733; bh=KVaunZlEMVWQnrc1yBLkhiLrCr2+c4AzQTndPC6rMPs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=uXeiLc01lBdezX2KrGB/dDxAIYKre/2FhvFu52oL2yPz9EGMAiVbqh8sSkocX86K4
         OL0HlOYy0TN6aH3z5WnJyGQf1OzXjWQoxQJJNbAdQnVBBVLWqk2CJ+IzaAznJJK1hV
         moViM837AKvgiajPb0UuoPof6s/S9txs5wvioDdA=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 13 Apr 2021
 12:12:11 +0200
Date:   Tue, 13 Apr 2021 13:12:06 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v8 0/4] block device interposer
Message-ID: <20210413101206.GA17754@veeam.com>
References: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
 <20210409152355.GA15109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210409152355.GA15109@redhat.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59647461
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 04/09/2021 18:23, Mike Snitzer wrote:
> On Fri, Apr 09 2021 at  7:48am -0400,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
> > I think I'm ready to suggest the next version of block device interposer
> > (blk_interposer). It allows to redirect bio requests to other block
> > devices.
> > 
> > In this series of patches, I reviewed the process of attaching and
> > detaching device mapper via blk_interposer.
> > 
> > Now the dm-target is attached to the interposed block device when the
> > interposer dm-target is fully ready to accept requests, and the interposed
> > block device queue is locked, and the file system on it is frozen.
> > The detaching is also performed when the file system on the interposed
> > block device is in a frozen state, the queue is locked, and the interposer
> > dm-target is suspended.
> > 
> > To make it possible to lock the receipt of new bio requests without locking
> > the processing of bio requests that the interposer creates, I had to change
> > the submit_bio_noacct() function and add a lock. To minimize the impact of
> > locking, I chose percpu_rw_sem. I tried to do without a new lock, but I'm
> > afraid it's impossible.
> > 
> > Checking the operation of the interposer, I did not limit myself to
> > a simple dm-linear. When I experimented with dm-era, I noticed that it
> > accepts two block devices. Since Mike was against changing the logic in
> > the dm-targets itself to support the interrupter, I decided to add the
> > [interpose] option to the block device path.
> > 
> >  echo "0 ${DEV_SZ} era ${META} [interpose]${DEV} ${BLK_SZ}" | \
> >  	dmsetup create dm-era --interpose
> > 
> > I believe this option can replace the DM_INTERPOSE_FLAG flag. Of course,
> > we can assume that if the device cannot be opened with the FMODE_EXCL,
> > then it is considered an interposed device, but it seems to me that
> > algorithm is unsafe. I hope to get Mike's opinion on this.
> > 
> > I have successfully tried taking snapshots. But I ran into a problem
> > when I removed origin-target:
> > [   49.031156] ------------[ cut here ]------------
> > [   49.031180] kernel BUG at block/bio.c:1476!
> > [   49.031198] invalid opcode: 0000 [#1] SMP NOPTI
> > [   49.031213] CPU: 9 PID: 636 Comm: dmsetup Tainted: G            E     5.12.0-rc6-ip+ #52
> > [   49.031235] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> > [   49.031257] RIP: 0010:bio_split+0x74/0x80
> > [   49.031273] Code: 89 c7 e8 5f 56 03 00 41 8b 74 24 28 48 89 ef e8 12 ea ff ff f6 45 15 01 74 08 66 41 81 4c 24 14 00 01 4c 89 e0 5b 5d 41 5c c3 <0f> 0b 0f 0b 0f 0b 45 31 e4 eb ed 90 0f 1f 44 00 00 39 77 28 76 05
> > [   49.031322] RSP: 0018:ffff9a6100993ab0 EFLAGS: 00010246
> > [   49.031337] RAX: 0000000000000008 RBX: 0000000000000000 RCX: ffff8e26938f96d8
> > [   49.031357] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff8e26937d1300
> > [   49.031375] RBP: ffff8e2692ddc000 R08: 0000000000000000 R09: 0000000000000000
> > [   49.031394] R10: ffff8e2692b1de00 R11: ffff8e2692b1de58 R12: ffff8e26937d1300
> > [   49.031413] R13: ffff8e2692ddcd18 R14: ffff8e2691d22140 R15: ffff8e26937d1300
> > [   49.031432] FS:  00007efffa6e7800(0000) GS:ffff8e269bc80000(0000) knlGS:0000000000000000
> > [   49.031453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   49.031470] CR2: 00007efffa96cda0 CR3: 0000000114bd0000 CR4: 00000000000506e0
> > [   49.031490] Call Trace:
> > [   49.031501]  dm_submit_bio+0x383/0x500 [dm_mod]
> > [   49.031522]  submit_bio_noacct+0x370/0x770
> > [   49.031537]  submit_bh_wbc+0x160/0x190
> > [   49.031550]  __sync_dirty_buffer+0x65/0x130
> > [   49.031564]  ext4_commit_super+0xbc/0x120 [ext4]
> > [   49.031602]  ext4_freeze+0x54/0x80 [ext4]
> > [   49.031631]  freeze_super+0xc8/0x160
> > [   49.031643]  freeze_bdev+0xb2/0xc0
> > [   49.031654]  lock_bdev_fs+0x1c/0x30 [dm_mod]
> > [   49.031671]  __dm_suspend+0x2b9/0x3b0 [dm_mod]
> > [   49.032095]  dm_suspend+0xed/0x160 [dm_mod]
> > [   49.032496]  ? __find_device_hash_cell+0x5b/0x2a0 [dm_mod]
> > [   49.032897]  ? remove_all+0x30/0x30 [dm_mod]
> > [   49.033299]  dev_remove+0x4c/0x1c0 [dm_mod]
> > [   49.033679]  ctl_ioctl+0x1a5/0x470 [dm_mod]
> > [   49.034067]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
> > [   49.034432]  __x64_sys_ioctl+0x83/0xb0
> > [   49.034785]  do_syscall_64+0x33/0x80
> > [   49.035139]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > When suspend is executed for origin-target before the interposer is
> > being detached, in the origin_map() function the value of the
> > o->split_binary variable is zero, since no snapshots were connected to it.
> > I think that if no snapshots are connected, then it does not make sense
> > to split the bio request into parts.
> 
> The dm-snapshot code requires careful order of operations.  You say you
> removed the origin target.. please show exactly what you did.  Your 4th
> patch shouldn't be tied to this patchset. Can be dealt with
> independently.

To create a snapshot, the snapshot-origin from dm-snap must be connected to
the device. I do it like this:
 DEV=/dev/nvme0n1p2
 DEV_SZ=$(blockdev --getsz ${DEV})
 echo "0 ${DEV_SZ} snapshot-origin [interpose]${DEV}" | \
 	dmsetup create dm-origin --interpose

Next, I create the snapshot itself and mount it:
 META=/dev/nvme0n1p1
 ORIGIN=/dev/mapper/dm-origin
 echo "0 ${DEV_SZ} snapshot ${ORIGIN} ${META} N 8" | \
 	dmsetup create dm-snapshot
 mount /dev/mapper/dm-snapshot /mnt/snap

Releasing the snapshot:
 umount /mnt/snap
 dmsetup remove dm-snapshot

Remove snapshot-origin:
 dmsetup remove dm-origin

I think it's hard to make a mistake here, although the documentation describes
creating a snapshot using lvcreate, not dmsetup.

As for the fourth patch - I agree - this should be the next step, after the
idea of the interposer is accepted.

> 
> > Changes summary for this patchset v7:
> >   * The attaching and detaching to interposed device moved to
> >     __dm_suspend() and __dm_resume() functions.
> 
> Why? Those hooks are inherently more constrained.  And in the case of
> resume, failure is not an option.
> 
> >   * Redesigned th submit_bio_noacct() function and added a lock for the
> >     block device interposer.
> >   * Adds [interpose] option to block device patch in dm table.
> 
> I'm struggling to see why you need "[interpose]" (never mind that this
> idea of device options is a new construct): what are the implications?
> Are you saying that a table will have N devices with only a subset that
> are interposed?

I'm analyzing how dmsetup works with strace. I get something like this
diagram:
 ioctl(3, DM_VERSION, ...
 ...
 read(0, "0 14675935 snapshot-origin [inte"..., 4096) = 53
 ...
 ioctl(3, DM_DEV_CREATE, ...
 ioctl(3, DM_TABLE_LOAD, ...
 ioctl(3, DM_DEV_SUSPEND, ...

ioctl DM_DEV_SUSPEND without the DM_SUSPEND_FLAG flag, which means that the
do_resume function is started. It turns out that only after the do_resume
DM target works, the target becomes ready to work.

Before that, we cannot attach the interposer, as the bio will not be
successfully processed by the interposer. It turns out that it is at the
final stage of initialization that we can safely connect the interposer.
Note that a special DMF_INTERPOSER_ATTACHED flag was provided, this allows
to connect the interposer only at the first resume.

When removing a DM target, there is a requirement that the DM target is closed
and not used by anyone. This ensures that no new bio requests to the DM target
will be received. But in the case of the interposer, this is not enough.
We need to lock the queue of the original block device and wait for all
previously created bio requests to complete. To do this, run dm_suspend() with
the DM_SUSPEND_DETACH_IP_FLAG flag.

If we look at the do_resume() function, it can finish with an error code for
various malfunctions and their processing is provided.

> 
> Just feels very awkward but I'll try to keep an open mind until I can
> better understand.

Ok. Let's look at a simple example. We need to attach the dm-era using the
interposer. This target uses two devices ${DEV} and ${META}.
 echo "0 `blockdev --getsz ${DEV}` era ${META} ${DEV} 128" | \
 	dmsetup create dm-era --interpose

The ${DEV} device needs to be attached using a interposer, while ${META} is
used to output the result of the module and must be opened in FMODE_EXCL mode.

It turns out that only the dm-target itself depends on which of the devices
can be connected via the interposer, and which can not. The [interpose] option
allows to explicitly specify this.

I don't really like the design with the [interpret] option either.
I think it's best to change the dm_get_device() call and explicitly specify
which device to open via the interposer. It depends on the DM target itself
whether it supports connection via the interposer and for which devices.
This would make the code more visual. But to do this, we will need to change
one line in each existing dm_target. You have already spoken out against
a similar decision. But maybe can you look at this solution again?
It will look something like this:

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index d9ac7372108c..461fd7656751 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1455,14 +1455,16 @@ static int era_ctr(struct dm_target *ti, unsigned argc, char **argv)

 	era->ti = ti;

-	r = dm_get_device(ti, argv[0], FMODE_READ | FMODE_WRITE, &era->metadata_dev);
+	r = dm_get_device(ti, argv[0], FMODE_READ | FMODE_WRITE, false, &era->metadata_dev);
 	if (r) {
 		ti->error = "Error opening metadata device";
 		era_destroy(era);
 		return -EINVAL;
 	}

-	r = dm_get_device(ti, argv[1], FMODE_READ | FMODE_WRITE, &era->origin_dev);
+	r = dm_get_device(ti, argv[1], FMODE_READ | FMODE_WRITE, ti->table->md->interpose, &era->origin_dev);
 	if (r) {
 		ti->error = "Error opening data device";
 		era_destroy(era);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..dc08e9b0c2fc 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -327,14 +327,14 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
  * it is accessed concurrently.
  */
 static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
-			struct mapped_device *md)
+			bool interpose, struct mapped_device *md)
 {
 	int r;
 	struct dm_dev *old_dev, *new_dev;

 	old_dev = dd->dm_dev;

-	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,
+	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev, interpose,
 				dd->dm_dev->mode | new_mode, &new_dev);
 	if (r)
 		return r;
@@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(dm_get_dev_t);
  * it's already present.
  */
 int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
-		  struct dm_dev **result)
+		  bool interpose, struct dm_dev **result)
 {
 	int r;
 	dev_t dev;
@@ -391,7 +391,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (!dd)
 			return -ENOMEM;

-		if ((r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {
+		if ((r = dm_get_table_device(t->md, dev, mode, interpose, &dd->dm_dev))) {
 			kfree(dd);
 			return r;
 		}
@@ -401,7 +401,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		goto out;

 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
+		r = upgrade_mode(dd, mode, interpose, t->md);
 		if (r)
 			return r;
 	}
> 
> >   * Fix origin_map() then o->split_binary value is zero.
> 
> Overall this effort, while appreciated in general, is getting more and
> more muddled -- you're having to sprinkle obscure code all over DM. And
> your patch headers are severely lacking for a v8 patch
> submission. Terse bullet points don't paint a very comprehensive
> picture. Please detail how a user is expected to drive this (either in
> patch headers and/or some Documentation file).
> 
> Mike
> 

Mike, thank you for appreciating my efforts. I'm getting deeper and deeper
into the DM code and trying to add new functionality to it in a harmonious way.
When discussing the previous patch, you were quite right to say that the
connection and disconnection of the interposer was not safe, although the code
looked simpler.
This time I tried to understand in detail the processes of creating and
removing DM targets. I tried to write the code as simple as possible and added
comments to make it as easy as possible to understand.
I think it would be great if you would indicate which code you found
"more muddled". I will be happy to rewrite it or give additional comments.

How a user is expected to drive this - I'll try to describe it in this email.
If this text suits you, I will create documentation based on it in the future.
At the current stage, I would not want to distract the people who are engaged
in checking the documentation, so as not to throw their work into the trash bin
as it happened with the documentation for the v4 patch.

===================
DM & blk_interposer
===================

Usually LVM should be used for new devices. The administrator have to create
logical volumes for the system partition when installing the operating system.
For a running system with partitioned disk space and mounted file systems,
it is quite difficult to reconfigure to logical volumes. As a result, all
the features that Device Mapper provides are not available for non-LVM systems.
This problem is partially solved by the interposer functionality, which uses
the kernel's blk_interposer.

Blk_interposer it allows to redirect bio requests from ordinal block devices
to DM target. It allows to attach interposer to original device "on the fly"
without stopping the execution of users programs.

Interposer for dm-flakey
========================
In a classic dm-flakey application, the /dev/sda1 device must be unmounted.
We have to create a new block device /dev/mapper/test and mount it. ::
 echo "0 `blockdev --getsz /dev/sda1` flakey /dev/sda1 0 1 3" | \
 	dmsetup create test
 mount /dev/mapper/test /mnt/test

The relationship diagram will look like this:
  +-------------+
  | file system |
  +-------------+
        ||
        \/
  +------------------+
  | /dev/mapper/test |
  +------------------+
        ||
        \/
  +-------------+
  | /dev/sda1   |
  +-------------+

blk_interposer allows to connect the DM target to a device that is already
mounted. Adding the --interpose flag to the command::
 echo "0 `blockdev --getsz /dev/sda1` flakey /dev/sda1 0 1 3" | \
     dmsetup create test --interpose

Now the relationship diagram will look like this:
  +-------------+
  | file system |
  +-------------+
        ||
        \/
  +----------------+
  | blk_interposer |
  +----------------+
        ||
        \/
  +--------------+
  | /dev/mapper/ |
  | test         |
  +--------------+
        ||
        \/
  +-------------+
  | /dev/sda1   |
  +-------------+

At the same time, we do not need to remount the file system. The new DM target
was added to the stack "on the fly" unnoticed by the user-space environment.

Interposer for dm-snap
======================

Suppose we have a file system mounted on the block device /dev/sda1::
  +-------------+
  | file system |
  +-------------+
        ||
        \/
  +-------------+
  | /dev/sda1   |
  +-------------+

To create a snapshot of a block device, we need to connect the dm-snap to this
device. To do this, use the --interpose flag when creating snapshot-origin.
 echo "0 `blockdev --getsz /dev/sda1` snapshot-origin /dev/sda1" | \
 	dmsetup create origin --interpose

In this case, thanks to blk_interposer, all bio requests from the file system
will be redirected to the new device /dev/mapper/origin.
Diagram ::

  +-------------+
  | file system |
  +-------------+
        ||
        \/
 +----------------+
 | blk_interposer |
 +----------------+
        ||
        \/
 +--------------+
 | /dev/mapper/ |
 | origin       |
 +--------------+
        || 
        \/
  +-----------+
  | /dev/sda1 |
  +-----------+

To create a snapshot, just use the new device /dev/mapper/origin:
 echo "0 `blockdev --getsz /dev/sda1` snapshot /dev/mapper/origin ${COW_DEVICE} N 8" | \
 	dmesetup create snapshot

Diagram::
  +-------------+       +--------------+
  | file system |       | backup agent |
  +-------------+       +--------------+
        ||                    ||
        \/                    ||
  +----------------+          ||
  | blk_interposer |          ||
  +----------------+          ||
        ||                    ||
        \/                    \/
  +--------------+     +---------------+
  | /dev/mapper/ | <=> | /dev/mapper/  |
  | origin       |     | snapshot      |
  +--------------+     +---------------+
        ||                    ||
        \/                    \/
  +-----------+        +---------------+
  | /dev/sda1 |        | ${COW_DEVICE} |
  +-----------+        +---------------+

The snapshot device on the /dev/mapper/snapshot device is now available for
mounting or backup.

-- 
Sergei Shtepa
Veeam Software developer.

