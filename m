Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934171F951
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 06:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjFBE1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 00:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjFBE1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:27:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9911AC
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 21:27:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3524RFOi005028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 00:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685680037; bh=RByivo28/wDS1hbfVNssrhoQJ9lRgUXU3X/ToX9MAnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MUVQVwlzNKMzmChuhJwbvMhYGPUanRXvQ0C4Gml8kg1RzeXSNuWVekg44nscuRY2U
         EbMIk2jf6SDQxzLZRmw0+aC6b/3NZhOl5Fs7uDBBRKDPhMFHsT31qEi5Vmm9gU0R3c
         bfXpyvzXrr9rEyHdwwSsUCUyE2Q9/9yqniZlvMSeftf8WUdUHEE6MvyuW3UGGR03Uc
         FO1bGIUAjFUU1aT7loB3hMbx9r4MKqkfOicI6N2B3PA1/6714jbzKC3NkHa4wep7+B
         MYHC1KlVJuJ+HK/j5fdKI1uX15C6HE1wHHdZ+4cviMQe/IfiQElVZIHcUlcnrNTTtR
         KXZmy6CJM7AEQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DC80A15C02EE; Fri,  2 Jun 2023 00:27:14 -0400 (EDT)
Date:   Fri, 2 Jun 2023 00:27:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602042714.GE1128744@mit.edu>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602012335.GB16848@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> Someone ought to cc Ted since I asked him about this topic this morning
> and he said he hadn't noticed it going by...
> 
> > > > In addition the uuid should be set when the filesystem is mounted.
> > > > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > > > change the uuid.
> > > 
> > > IMO, that ext4 functionality is a landmine waiting to be stepped on.
> > > 
> > > We should not be changing the sb->s_uuid of filesysetms dynamically.
> > 
> > Yeah, I kinda agree. If it works for ext4 and it's an ext4 specific
> > ioctl then this is fine though.
> 
> Now that Dave's brought up all kinds of questions about other parts of
> the kernel using s_uuid for things, I'm starting to think that even ext4
> shouldn't be changing its own uuid on the fly.

So let's set some context here.  The tune2fs program in e2fsprogs has
supported changing the UUID for a *very* long time.  Specifically,
since September 7, 1996 (e2fsprogs version 1.05, when we first added
the UUID field in the ext2 superblock).  This feature was added from
the very beginning since in Large Installation System Administration
(LISA) systems, a very common thing to do is to image boot disks from
a "golden master", and then afterwards, you want to make sure the file
systems on each boot disk have a unique UUID; and this is done via
"tune2fs -U random /dev/sdXX".  Since I was working at MIT Project
Athena at the time, we regularly did this when installing Athena
client workstations, and when I added UUID support to ext2, I made
sure this feature was well-supported.

The tune2fs program allows the UUID to be changed via the file system
is mounted (with some caveats), which it did by directly modifying the
on-disk superblock.  Obviously, when it did that, it wouldn't change
sb->s_uuid "dynamically", although the next time the file system was
mounted, sb->s_uuid would get the new UUID.  If overlayfs and IMA are
expecting that a file system's UUID would stay consant and persistent
--- well, that's not true, and it has always been that way, since
there are tools that make it trivially easy for a system administrator
to adjust the UUID.

In addition to the LISA context, this feature is also commonly used in
various cloud deployments, since when you create a new VM, it
typically gets a new root file system, which is copied from a fixed,
read-only image.  So on a particular hyperscale cloud system, if we
didn't do anything special, there could be hundreds of thousands VM's
whose root file system would all have the same UUID, which would mean
that the UUID... isn't terribly unique.

There are many problems that can result, but for example, if the user
or SRE were to take a cloud-level block device snapshot of a
malfunctioning VM, and then attach that snapshot on another VM, it is
quite possible that there might be two file systems mounted on a
particular VM that both have the same UUID ---- one for the "real"
root file system, and the other for the "bad" root file system that is
being examined.  Attempts to do mounts or umounts by UUID will then
result in hilarity.  (Not to mention potentially confusing support
personnel who might be looking at a metadata-only dump of the file
system.)

And so a common practice is for some cloud agents or init scripts to
change the root file system's UUID to a new random value when the VM
is first initially booted.  Yes, this can potentially cause problems
if the UUID is in /etc/fstab, but these scripts will typically update
/etc/fstab and make other userspace adjustments while they are at it.

In the case of Cloud Optimized OS, the change of the UUID via "tune2fs
-U random /dev/sdaX" was done in one systemd unit file, while systemd
unit file would try to to resize the partition to fill the size of the
root file system (since the VM can be created with the root disk
larger than the minimum size required by the cloud image).  These two
unit files can run at the same time, and so there was a very small
probability that userspace directly changing the superblock could race
with file system resize operation, such that one or the other
operation failing due to a bad superblock checksum error.

This is the reason why we added the ext4 ioctl; it was intended for
the express use of "tune2fs -U", and like tune2fs -U, it doesn't
actually change sb->s_uuid; it only changes the on-disk superblock's
UUID.  This was mostly because we forgot about sb->s_uuid, to be
honest, but it means that regardless of whether "tune2fs -U" directly
modifies the block device, or uses the ext4 ioctl, the behaviour with
respect to sb->s_uuid is the same; it's not modified when the on-disk
uuid is changed.

> > > The VFS does not guarantee in any way that it is safe to change the
> > > sb->s_uuid (i.e. no locking, no change notifications, no udev
> > > events, etc). Various subsystems - both in the kernel and in
> > > userspace - use the sb->s_uuid as a canonical and/or persistent
> > > filesystem/device identifier and are unprepared to have it change
> > > while the filesystem is mounted and active.

Note that the last sentence is a bit ambiguous.  There is the question
of whether sb->s_uuid won't change while the file system is mounted,
and then there is the question of whether s_uuid is **persistent**
---- which is to say, that it won't change across mounts or reboots.

If there are subsystems like IMA, overlayfs, pnfs, et.al, which expect
that, I'm sorry, but sysadmin tools to make it trivially easy to
change the file system UUID long-predate these other subsystems, and
there *are* system adminsitrators --- particularly in the LISA or
Cloud context --- which have used "tune2fs -U" for good and proper
reasons.

> ...just like Dave just said.  Heh. :(

Heh, indeed.  :-/

					- Ted
