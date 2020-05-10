Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34831CC74D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEJG0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgEJG0l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:26:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56CEC2082E;
        Sun, 10 May 2020 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589091998;
        bh=Toay2bmrDNhQNYr4sCvVRpMdDZtGbZ//xX1lpF0Dzy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UovzVWSp+YryU/vocM/Ma7+FuA/KqOxVsprpKCU49hreg5t7G4plwDcH9PNse0rX2
         YA8/5WJeUZ0xDRWis218hauXfsE6lHFLHHsgefU8sZnaq0b2gl2DOQDY3BugRtu2Hr
         VHoRazFKBqf913bl1sxR1Nfafsn+2MqXKkXjwAP8=
Date:   Sun, 10 May 2020 08:26:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/5] blktrace: fix debugfs use after free
Message-ID: <20200510062636.GA3400311@kroah.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509031058.8239-4-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 03:10:56AM +0000, Luis Chamberlain wrote:
> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> merged on v4.12 Omar fixed the original blktrace code for request-based
> drivers (multiqueue). This however left in place a possible crash, if you
> happen to abuse blktrace while racing to remove / add a device.
> 
> We used to use asynchronous removal of the request_queue, and with that
> the issue was easier to reproduce. Now that we have reverted to
> synchronous removal of the request_queue, the issue is still possible to
> reproduce, its however just a bit more difficult.
> 
> We essentially run two instances of break-blktrace which add/remove
> a loop device, and setup a blktrace and just never tear the blktrace
> down. We do this twice in parallel. This is easily reproduced with the
> break-blktrace run_0004.sh script.
> 
> We can end up with two types of panics each reflecting where we
> race, one a failed blktrace setup:
> 
> [  252.426751] debugfs: Directory 'loop0' with parent 'block' already present!
> [  252.432265] BUG: kernel NULL pointer dereference, address: 00000000000000a0
> [  252.436592] #PF: supervisor write access in kernel mode
> [  252.439822] #PF: error_code(0x0002) - not-present page
> [  252.442967] PGD 0 P4D 0
> [  252.444656] Oops: 0002 [#1] SMP NOPTI
> [  252.446972] CPU: 10 PID: 1153 Comm: break-blktrace Tainted: G            E     5.7.0-rc2-next-20200420+ #164
> [  252.452673] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> [  252.456343] RIP: 0010:down_write+0x15/0x40
> [  252.458146] Code: eb ca e8 ae 22 8d ff cc cc cc cc cc cc cc cc cc cc cc cc
>                cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00
>                00 00 <f0> 48 0f b1 55 00 75 0f 48 8b 04 25 c0 8b 01 00 48 89
>                45 08 5d
> [  252.463638] RSP: 0018:ffffa626415abcc8 EFLAGS: 00010246
> [  252.464950] RAX: 0000000000000000 RBX: ffff958c25f0f5c0 RCX: ffffff8100000000
> [  252.466727] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
> [  252.468482] RBP: 00000000000000a0 R08: 0000000000000000 R09: 0000000000000001
> [  252.470014] R10: 0000000000000000 R11: ffff958d1f9227ff R12: 0000000000000000
> [  252.471473] R13: ffff958c25ea5380 R14: ffffffff8cce15f1 R15: 00000000000000a0
> [  252.473346] FS:  00007f2e69dee540(0000) GS:ffff958c2fc80000(0000) knlGS:0000000000000000
> [  252.475225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  252.476267] CR2: 00000000000000a0 CR3: 0000000427d10004 CR4: 0000000000360ee0
> [  252.477526] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  252.478776] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  252.479866] Call Trace:
> [  252.480322]  simple_recursive_removal+0x4e/0x2e0
> [  252.481078]  ? debugfs_remove+0x60/0x60
> [  252.481725]  ? relay_destroy_buf+0x77/0xb0
> [  252.482662]  debugfs_remove+0x40/0x60
> [  252.483518]  blk_remove_buf_file_callback+0x5/0x10
> [  252.484328]  relay_close_buf+0x2e/0x60
> [  252.484930]  relay_open+0x1ce/0x2c0
> [  252.485520]  do_blk_trace_setup+0x14f/0x2b0
> [  252.486187]  __blk_trace_setup+0x54/0xb0
> [  252.486803]  blk_trace_ioctl+0x90/0x140
> [  252.487423]  ? do_sys_openat2+0x1ab/0x2d0
> [  252.488053]  blkdev_ioctl+0x4d/0x260
> [  252.488636]  block_ioctl+0x39/0x40
> [  252.489139]  ksys_ioctl+0x87/0xc0
> [  252.489675]  __x64_sys_ioctl+0x16/0x20
> [  252.490380]  do_syscall_64+0x52/0x180
> [  252.491032]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> And the other on the device removal:
> 
> [  128.528940] debugfs: Directory 'loop0' with parent 'block' already present!
> [  128.615325] BUG: kernel NULL pointer dereference, address: 00000000000000a0
> [  128.619537] #PF: supervisor write access in kernel mode
> [  128.622700] #PF: error_code(0x0002) - not-present page
> [  128.625842] PGD 0 P4D 0
> [  128.627585] Oops: 0002 [#1] SMP NOPTI
> [  128.629871] CPU: 12 PID: 544 Comm: break-blktrace Tainted: G            E     5.7.0-rc2-next-20200420+ #164
> [  128.635595] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> [  128.640471] RIP: 0010:down_write+0x15/0x40
> [  128.643041] Code: eb ca e8 ae 22 8d ff cc cc cc cc cc cc cc cc cc cc cc cc
>                cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00
>                00 00 <f0> 48 0f b1 55 00 75 0f 65 48 8b 04 25 c0 8b 01 00 48 89
>                45 08 5d
> [  128.650180] RSP: 0018:ffffa9c3c05ebd78 EFLAGS: 00010246
> [  128.651820] RAX: 0000000000000000 RBX: ffff8ae9a6370240 RCX: ffffff8100000000
> [  128.653942] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
> [  128.655720] RBP: 00000000000000a0 R08: 0000000000000002 R09: ffff8ae9afd2d3d0
> [  128.657400] R10: 0000000000000056 R11: 0000000000000000 R12: 0000000000000000
> [  128.659099] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000000000a0
> [  128.660500] FS:  00007febfd995540(0000) GS:ffff8ae9afd00000(0000) knlGS:0000000000000000
> [  128.662204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  128.663426] CR2: 00000000000000a0 CR3: 0000000420042003 CR4: 0000000000360ee0
> [  128.664776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  128.666022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  128.667282] Call Trace:
> [  128.667801]  simple_recursive_removal+0x4e/0x2e0
> [  128.668663]  ? debugfs_remove+0x60/0x60
> [  128.669368]  debugfs_remove+0x40/0x60
> [  128.669985]  blk_trace_free+0xd/0x50
> [  128.670593]  __blk_trace_remove+0x27/0x40
> [  128.671274]  blk_trace_shutdown+0x30/0x40
> [  128.671935]  blk_release_queue+0x95/0xf0
> [  128.672589]  kobject_put+0xa5/0x1b0
> [  128.673188]  disk_release+0xa2/0xc0
> [  128.673786]  device_release+0x28/0x80
> [  128.674376]  kobject_put+0xa5/0x1b0
> [  128.674915]  loop_remove+0x39/0x50 [loop]
> [  128.675511]  loop_control_ioctl+0x113/0x130 [loop]
> [  128.676199]  ksys_ioctl+0x87/0xc0
> [  128.676708]  __x64_sys_ioctl+0x16/0x20
> [  128.677274]  do_syscall_64+0x52/0x180
> [  128.677823]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The common theme here is:
> 
> debugfs: Directory 'loop0' with parent 'block' already present
> 
> This crash happens because of how blktrace uses the debugfs directory
> where it places its files. Upon init we always create the same directory
> which would be needed by blktrace but we only do this for make_request
> drivers (multiqueue) block drivers, but never for request-based block
> drivers. Furthermore, that directory is only created on init for the
> entire disk. This means that if you use blktrace on a partition, we'll
> always be creating a new directory regardless of whether or not you
> are doing blktrace on a make_request driver (multiqueue) or a
> request-based block drivers.
> 
> These directory creations are only associated with a path, and so
> when a debugfs_remove() is called it removes everything in its way.
> A device removal will remove all blktrace files, and so if a blktrace
> is still present a cleanup of blktrace files later will end up trying
> to remove dentries pointing to NULL.
> 
> We can fix the UAF by using a debugfs directory which moving forward
> will always be accessible if debugfs is enabled for both make_request
> drivers (multiqueue) and request-based block drivers, *and* for all
> partitions upon creation. This ensures that removal of the directories
> only happens on device removal and removes the race of the files
> underneath an active blktrace.
> 
> For partitions we simply symlink to the whole disk's debugfs_dir, as the
> debugfs_dir is shared anyway and this limits us to only run one blktrace
> for the entire disk.
> 
> We special-case a solution for scsi-generic which got blktrace support
> added by Christof via commit 6da127ad0918 ("blktrace: Add blktrace
> ioctls to SCSI generic devices") so upstream since v2.6.25. scsi-generic
> drives use a character device, however behind the scenes we have a scsi
> device with a request_queue. How this is used varies by class of driver
> (TYPE_DISK, TYPE_TYPE, etc). Care has to be taken into consideration of
> the fact that scsi drivers will probe asynchronously but the scsi-generic
> class_interface sg_add_device() will complete before. This means
> sd_probe() will use device_add_disk() for TYPE_DISK and have its
> debugfs_dir created *after* the scsi-generic device is created.
> 
> For scsi-generic then we symlink to the real debugfs_dir only during a
> blktrace ioctl, but we do this only once. We also have to special-case
> yet another solution for drivers which use the bsg queue.
> 
> This goes tested with:
> 
>   o nvme partitions
>   o ISCSI with tgt, and blktracing against scsi-generic with:
>     o block
>     o tape
>     o cdrom
>     o media changer
> 
> Screenshots of what the debugfs for block looks like after running
> blktrace on a system with sg0  which has a raid controllerand then sg1
> as the media changer:
> 
>  # ls -l /sys/kernel/debug/block
> total 0
> drwxr-xr-x  3 root root 0 May  9 02:31 bsg
> drwxr-xr-x 19 root root 0 May  9 02:31 nvme0n1
> drwxr-xr-x 19 root root 0 May  9 02:31 nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p1 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p2 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p3 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p5 -> nvme1n1
> lrwxrwxrwx  1 root root 0 May  9 02:31 nvme1n1p6 -> nvme1n1
> drwxr-xr-x  2 root root 0 May  9 02:33 sch0
> lrwxrwxrwx  1 root root 0 May  9 02:33 sg0 -> bsg/2:0:0:0
> lrwxrwxrwx  1 root root 0 May  9 02:33 sg1 -> sch0
> drwxr-xr-x  5 root root 0 May  9 02:31 vda
> lrwxrwxrwx  1 root root 0 May  9 02:31 vda1 -> vda
> 
> Code for handling the  ebugfs_dir did get more complicatd for
> scsi-generic but this is technical debt. For the other types of devices,
> this simplifies the code considerably, with the only penalty now being
> that we're always creating the request queue debugfs directory for the
> request-based block device drivers.
> 
> The symlink use also makes it clearer when the request_queue is shared.
> 
> This patch is part of the work which disputes the severity of
> CVE-2019-19770 which shows this issue is not a core debugfs issue, but
> a misuse of debugfs within blktace.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: yu kuai <yukuai3@huawei.com>
> Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
> Reported-by: syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
> Fixes: 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/blk-debugfs.c          | 187 +++++++++++++++++++++++++++++++++++
>  block/blk-mq-debugfs.c       |   5 -
>  block/blk-sysfs.c            |   3 +
>  block/blk.h                  |  16 +++
>  block/bsg.c                  |   2 +
>  block/partitions/core.c      |   9 ++
>  drivers/scsi/ch.c            |   1 +
>  drivers/scsi/sg.c            |  75 ++++++++++++++
>  drivers/scsi/st.c            |   2 +
>  include/linux/blkdev.h       |   4 +-
>  include/linux/blktrace_api.h |   1 -
>  include/linux/genhd.h        |  69 +++++++++++++
>  kernel/trace/blktrace.c      |  24 +++--
>  13 files changed, 385 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> index 19091e1effc0..d40f12aecf8a 100644
> --- a/block/blk-debugfs.c
> +++ b/block/blk-debugfs.c
> @@ -8,8 +8,195 @@
>  #include <linux/debugfs.h>
>  
>  struct dentry *blk_debugfs_root;
> +struct dentry *blk_debugfs_bsg = NULL;
> +
> +/**
> + * enum blk_debugfs_dir_type - block device debugfs directory type
> + * @BLK_DBG_DIR_BASE: the block device debugfs_dir exists on the base
> + * 	system <system-debugfs-dir>/block/ debugfs directory.
> + * @BLK_DBG_DIR_BSG: the block device debugfs_dir is under the directory
> + * 	<system-debugfs-dir>/block/bsg/
> + */
> +enum blk_debugfs_dir_type {
> +	BLK_DBG_DIR_BASE = 1,
> +	BLK_DBG_DIR_BSG,
> +};
>  
>  void blk_debugfs_register(void)
>  {
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  }
> +
> +static struct dentry *queue_get_base_dir(enum blk_debugfs_dir_type type)
> +{
> +	switch (type) {
> +	case BLK_DBG_DIR_BASE:
> +		return blk_debugfs_root;
> +	case BLK_DBG_DIR_BSG:
> +		return blk_debugfs_bsg;
> +	}
> +	return NULL;
> +}
> +
> +static void queue_debugfs_register_type(struct request_queue *q,
> +					const char *name,
> +					enum blk_debugfs_dir_type type)
> +{
> +	struct dentry *base_dir = queue_get_base_dir(type);
> +
> +	q->debugfs_dir = debugfs_create_dir(name, base_dir);
> +}
> +
> +/**
> + * blk_queue_debugfs_register - register the debugfs_dir for the block device
> + * @q: the associated request_queue of the block device
> + * @name: the name of the block device exposed
> + *
> + * This is used to create the debugfs_dir used by the block layer and blktrace.
> + * Drivers which use any of the *add_disk*() calls or variants have this called
> + * automatically for them. This directory is removed automatically on
> + * blk_release_queue() once the request_queue reference count reaches 0.
> + */
> +void blk_queue_debugfs_register(struct request_queue *q, const char *name)
> +{
> +	queue_debugfs_register_type(q, name, BLK_DBG_DIR_BASE);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_debugfs_register);
> +
> +/**
> + * blk_queue_debugfs_unregister - remove the debugfs_dir for the block device
> + * @q: the associated request_queue of the block device
> + *
> + * Removes the debugfs_dir for the request_queue on the associated block device.
> + * This is handled for you on blk_release_queue(), and that should only be
> + * called once.
> + *
> + * Since we don't care where the debugfs_dir was created this is used for all
> + * types of of enum blk_debugfs_dir_type.
> + */
> +void blk_queue_debugfs_unregister(struct request_queue *q)
> +{
> +	debugfs_remove_recursive(q->debugfs_dir);
> +}
> +
> +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> +						 const char *src,
> +						 const char *dst,
> +						 enum blk_debugfs_dir_type type)
> +{
> +	struct dentry *dentry = ERR_PTR(-EINVAL);
> +	char *dir_dst;
> +
> +	dir_dst = kzalloc(PATH_MAX, GFP_KERNEL);
> +	if (!dir_dst)
> +		return dentry;
> +
> +	switch (type) {
> +	case BLK_DBG_DIR_BASE:
> +		if (dst)
> +			snprintf(dir_dst, PATH_MAX, "%s", dst);
> +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> +			snprintf(dir_dst, PATH_MAX, "%s",
> +				 q->debugfs_dir->d_name.name);

How can debugfs_dir be NULL/error here?

And grabbing the name of a debugfs file is sketchy, just use the name
that you think you already have, from the device, don't rely on debugfs
working here.

And why a symlink anyway?  THat's a new addition, what is going to work
with that in userspace?

> +#ifdef CONFIG_DEBUG_FS
> +	p->debugfs_sym = blk_queue_debugfs_symlink(disk->queue, dev_name(pdev),
> +						   disk->disk_name);
> +#endif

No need to #ifdef this, right?

I feel like this patch series keeps getting more complex and messier
over time :(

greg k-h
