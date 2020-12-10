Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C232D6BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgLJX24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:28:56 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48675 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgLJX2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:28:34 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0307058DE93;
        Fri, 11 Dec 2020 09:09:15 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1knU7f-002d19-0G; Fri, 11 Dec 2020 09:09:15 +1100
Date:   Fri, 11 Dec 2020 09:09:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 4/8] vfs: Add superblock notifications
Message-ID: <20201210220914.GG4170059@dread.disaster.area>
References: <20201208003117.342047-1-krisman@collabora.com>
 <20201208003117.342047-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208003117.342047-5-krisman@collabora.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=20KFwNOVAAAA:8 a=bIklqNNcAAAA:8
        a=7-415B0cAAAA:8 a=XzQluxY8ozV8i3kBV7QA:9 a=i2Bh8MKloSl-hS_9:21
        a=cWOelMYJJw8xPhJN:21 a=CjuIK1q_8ugA:10 a=EkVPmbJYC8N8lJNKmfU-:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:31:13PM -0300, Gabriel Krisman Bertazi wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Add a superblock event notification facility whereby notifications about
> superblock events, such as I/O errors (EIO), quota limits being hit
> (EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
> process asynchronously.  Note that this does not cover vfsmount topology
> changes.  watch_mount() is used for that.

watch_mount() is not in the upstream tree, nor is it defined in this
patch set.

> Records are of the following format:
> 
> 	struct superblock_notification {
> 		struct watch_notification watch;
> 		__u64	sb_id;
> 	} *n;
> 
> Where:
> 
> 	n->watch.type will be WATCH_TYPE_SB_NOTIFY.
> 
> 	n->watch.subtype will indicate the type of event, such as
> 	NOTIFY_SUPERBLOCK_READONLY.
> 
> 	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
> 	record.
> 
> 	n->watch.info & WATCH_INFO_ID will be the fifth argument to
> 	watch_sb(), shifted.
> 
> 	n->watch.info & NOTIFY_SUPERBLOCK_IS_NOW_RO will be used for
> 	NOTIFY_SUPERBLOCK_READONLY, being set if the superblock becomes
> 	R/O, and being cleared otherwise.
> 
> 	n->sb_id will be the ID of the superblock, as can be retrieved with
> 	the fsinfo() syscall, as part of the fsinfo_sb_notifications
> 	attribute in the watch_id field.
> 
> Note that it is permissible for event records to be of variable length -
> or, at least, the length may be dependent on the subtype.  Note also that
> the queue can be shared between multiple notifications of various types.

/me puts on his "We really, really, REALLY suck at APIs" hat.

This adds a new syscall that has a complex structure associated with
in. This needs a full man page specification written for it
describing the parameters, the protocol structures, behaviour, etc
before we can really review this. It really also needs full test
infrastructure for every aspect of the syscall written from the man
page (not the implementation) for fstests so that we end up with a
consistent implementation for every filesystem that implements these
watches.

Other things:

- Scoping: inode/block related information is not "superblock"
  information. What about errors in non-inode related objects?
- offets into files/devices/objects need to be in bytes, not blocks
- errors can span multiple contiguous blocks, so the notification
  needs to report the -byte range- the error corresponds to.
- superblocks can have multiple block devices under them with
  individual address ranges. Hence we need {object,dev,offset,len}
  to uniquely identify where an error occurred in a filesystem.
- userspace face structures need padding and flags/version/size
  information so we can tell what shape the structure being passed
  is. It is guaranteed that we will want to expand the structure
  definitions in future, maybe even deprecate some...
- syscall has no flags field.
- syscall is of "at" type (relative path via dfd) so probably shoudl
  be called "watch..._at()"

Fundamentally, though, I'm struggling to understand what the
difference between watch_mount() and watch_sb() is going to be.
"superblock" watches seem like the wrong abstraction for a path
based watch interface. Superblocks can be shared across multiple
disjoint paths, subvolumes and even filesystems.

The path based user API is really asking to watch a mount, not a
superblock. We don't otherwise expose superblocks to userspace at
all, so this seems like the API is somewhat exposing internal kernel
implementation behind mounts. However, there -is- a watch_mount()
syscall floating around somewhere, so it makes me wonder exactly why
we need a second syscall and interface protocol to expose
essentially the same path-based watch information to userspace.
Without having that syscall the same patchset, or a reference to
that patchset (and man page documenting the interface), I have no
idea what it does or why it is different or why it can't be used for
these error notifications....

/me wonders what applications are suppose to do if they have a watch
on a path that then gets over-mounted by a different filesystem and
so their watch for that path is effectively now stale because
operations on that path now redirect to a different mount and
superblock....

> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index f27ac94d5fa7..3e97984bc4c8 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -51,6 +51,9 @@ COND_SYSCALL_COMPAT(io_pgetevents);
>  COND_SYSCALL(io_uring_setup);
>  COND_SYSCALL(io_uring_enter);
>  COND_SYSCALL(io_uring_register);
> +COND_SYSCALL(fsinfo);
> +COND_SYSCALL(watch_mount);
> +COND_SYSCALL(watch_sb);

I think these need to be in the patches that introduce these
syscalls, not this one.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
