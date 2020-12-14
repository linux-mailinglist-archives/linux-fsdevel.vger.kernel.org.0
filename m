Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B72DA3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 00:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408328AbgLNXCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 18:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408029AbgLNXCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607986887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NZ41tlcAvHRg9DaYGIdtPXF0NMAQ11HmPpMP2IZjUo=;
        b=NQ/g6CxPDbQI3WHiLGc9MvSXK9u2WbUJZmG3cjOdS0ViezZDkZHXjaHv/N/HpQe0tWSV1E
        o/L4QLvg0LLWn5M8ys5smXFxi35K9VP3a+BwYQUCUySPfH95W/rw0Kvv2t2oFV77uCa3vg
        P0zKYkSMeTkrGWkEanYsZ4TriqUyi78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-WjYbYX1mPXaJLDp-B6J0Dg-1; Mon, 14 Dec 2020 18:01:23 -0500
X-MC-Unique: WjYbYX1mPXaJLDp-B6J0Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D28E51922021;
        Mon, 14 Dec 2020 23:01:21 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-168.rdu2.redhat.com [10.10.114.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 799A86E53E;
        Mon, 14 Dec 2020 23:01:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 10A1F220BCF; Mon, 14 Dec 2020 18:01:21 -0500 (EST)
Date:   Mon, 14 Dec 2020 18:01:21 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201214230121.GB3453@redhat.com>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-3-jlayton@kernel.org>
 <20201214213843.GA3453@redhat.com>
 <20201214220413.GA6508@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214220413.GA6508@ircssh-2.c.rugged-nimbus-611.internal>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:04:14PM +0000, Sargun Dhillon wrote:
> On Mon, Dec 14, 2020 at 04:38:43PM -0500, Vivek Goyal wrote:
> > On Sun, Dec 13, 2020 at 08:27:13AM -0500, Jeff Layton wrote:
> > > Peek at the upper layer's errseq_t at mount time for volatile mounts,
> > > and record it in the per-sb info. In sync_fs, check for an error since
> > > the recorded point and set it in the overlayfs superblock if there was
> > > one.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > While we are solving problem for non-volatile overlay mount, I also
> > started thinking, what about non-volatile overlay syncfs() writeback errors.
> > Looks like these will not be reported to user space at all as of now
> > (because we never update overlay_sb->s_wb_err ever).
> > 
> > A patch like this might fix it. (compile tested only).
> > 
> > overlayfs: Report syncfs() errors to user space
> > 
> > Currently, syncfs(), calls filesystem ->sync_fs() method but ignores the
> > return code. But certain writeback errors can still be reported on 
> > syncfs() by checking errors on super block.
> > 
> > ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > 
> > For the case of overlayfs, we never set overlayfs super block s_wb_err. That
> > means sync() will never report writeback errors on overlayfs uppon syncfs().
> > 
> > Fix this by updating overlay sb->sb_wb_err upon ->sync_fs() call. And that
> > should mean that user space syncfs() call should see writeback errors.
> > 
> > ovl_fsync() does not need anything special because if there are writeback
> > errors underlying filesystem will report it through vfs_fsync_range() return
> > code and user space will see it.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/ovl_entry.h |    1 +
> >  fs/overlayfs/super.c     |   14 +++++++++++---
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > Index: redhat-linux/fs/overlayfs/super.c
> > ===================================================================
> > --- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
> > +++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
> > @@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
> >  {
> >  	struct ovl_fs *ofs = sb->s_fs_info;
> >  	struct super_block *upper_sb;
> > -	int ret;
> > +	int ret, ret2;
> >  
> >  	if (!ovl_upper_mnt(ofs))
> >  		return 0;
> > @@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
> >  	ret = sync_filesystem(upper_sb);
> >  	up_read(&upper_sb->s_umount);
> >  
> > -	return ret;
> > +	if (errseq_check(&upper_sb->s_wb_err, sb->s_wb_err)) {
> > +		/* Upper sb has errors since last time */
> > +		spin_lock(&ofs->errseq_lock);
> > +		ret2 = errseq_check_and_advance(&upper_sb->s_wb_err,
> > +						&sb->s_wb_err);
> > +		spin_unlock(&ofs->errseq_lock);
> > +	}
> > +	return ret ? ret : ret2;
> >  }
> >  
> >  /**
> > @@ -1873,6 +1880,7 @@ static int ovl_fill_super(struct super_b
> >  	if (!cred)
> >  		goto out_err;
> >  
> > +	spin_lock_init(&ofs->errseq_lock);
> >  	/* Is there a reason anyone would want not to share whiteouts? */
> >  	ofs->share_whiteout = true;
> >  
> > @@ -1945,7 +1953,7 @@ static int ovl_fill_super(struct super_b
> >  
> >  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> >  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > -
> > +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> >  	}
> >  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
> >  	err = PTR_ERR(oe);
> > Index: redhat-linux/fs/overlayfs/ovl_entry.h
> > ===================================================================
> > --- redhat-linux.orig/fs/overlayfs/ovl_entry.h	2020-12-14 15:33:43.934400880 -0500
> > +++ redhat-linux/fs/overlayfs/ovl_entry.h	2020-12-14 15:34:13.509400880 -0500
> > @@ -79,6 +79,7 @@ struct ovl_fs {
> >  	atomic_long_t last_ino;
> >  	/* Whiteout dentry cache */
> >  	struct dentry *whiteout;
> > +	spinlock_t errseq_lock;
> >  };
> >  
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > 
> 
> This was on my list of things to look at. I don't think we can / should use 
> errseq_check_and_advance because it will hide errors from userspace.

Hi Sargun,

I have been struggling to figure out when to use
errseq_check_and_advance() and when to use this error_check() and
errorseq_set() combination.

My rational for using errseq_check_and_advance() is that say there
is an unseen error on upper super block, and if overlayfs calls
syncfs(), then this call should set SEEN flag on upper super
block, isn't it. This is equivalent of an app directly calling
syncfs() on upper.

If we use error_check() and errseq_set() combination, then we
are just reading state of upper superblock but really not impacting
it despite the fact overlay apps are calling syncfs().

Comapre it with fsync(). For non-volatile overlay, an fsync() overlay
call will set SEEN flag on upper file. And I believe same thing
should happen for ovl_syncfs() call as well. It makes more sense to me.

Wondering how will it hide errors from user space. ovl "struct file"
will have its own f->f_sb_err initialized from overlay superblock. And
if overlay super block gets updated with error, a later
errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err) should
still return an error.

What am I missing?

Vivek


> I think we 
> need something like:
> 
> At startup, call errseq_peek and stash that value somewhere. This sets the 
> MUSTINC flag.

So this errseq_peek() stuff is required only if we don't want to 
consume error while checking for error. In fact consuming error
is not bad as long as we do it only ovl_syncfs() path. In fact
it will match current semantics of syncfs().

But issue we have is that we want to check for error outside syncfs()
path too and don't want to consume it (otherwise it breaks the semantics
that it will bee seen marked in syncfs() path).

So that's why this notion of checking error without consuming it
so tha we can check it in remount path.

But in syncfs() path, it should be ok to consume unseen error and
we should be able to call errseq_check_and_advance(), both for
volatile and non-volatile mounts, isn't it?

For ther paths, like remount, we probably can stash away on persistent
storage and compare that value on remount and fail remount without
actually consuming unseen error (because it is not syncfs path). This
possibly can be used in other paths like read/write as well to
make sure we can notice error without consuming it.

IOW, we seem to have to paths we want to check errors in. In ovl_syncfs()
path we should be able consume exisiting unseen error on upper, so
errseq_check_and_advance() makes sense. In rest of the paths, we
should use new semantics to check for errors.

Vivek

> 
> At syncfs time: call errseq check, if it says there is an error, call 
> errseq_peek again, and store the error in our superblock. Take the error value 
> from the differenceb between the previous one and the new one, and copy it up to 
> the superblock.
> 
> Either way, I think Jeff's work of making it so other kernel subsytems can 
> interact with errseq on a superblock bears fruit elsewhere. If the first patch 
> gets merged, I can put together the patches to do the standard error bubble
> up for normal syncfs, volatile syncfs, and volatile remount.
> 

