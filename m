Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189CD2E9E78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbhADUCQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 15:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhADUCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609790449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qouK5nWfYEyie46q+dkJgtJ0jRBuiXBKgmztVRhl43A=;
        b=dMEGlxH+qSWV8Ic/MrgWTn5umWHDVnMf5wI9A6SuvLqui4ssrpr5PryUaqriZ7X6DF6XED
        h0hZavjShG/Gw2/KLMJTO8amNJ3J9NFDxWqRV0p4cFcniOakXcU24tUP2tKedDNUdLOq5q
        11ec3stTL5mnmUK+Cp1sCkCcJWspquA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-TLzugGxvNuuh3otGhZ7bSw-1; Mon, 04 Jan 2021 15:00:45 -0500
X-MC-Unique: TLzugGxvNuuh3otGhZ7bSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB971107ACF5;
        Mon,  4 Jan 2021 20:00:42 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A715272A8;
        Mon,  4 Jan 2021 20:00:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EC137220BCF; Mon,  4 Jan 2021 15:00:36 -0500 (EST)
Date:   Mon, 4 Jan 2021 15:00:36 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20210104200036.GF63879@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > Currently syncfs() and fsync() seem to be two interfaces which check and
> > return writeback errors on superblock to user space. fsync() should
> > work fine with overlayfs as it relies on underlying filesystem to
> > do the check and return error. For example, if ext4 is on upper filesystem,
> > then ext4_sync_file() calls file_check_and_advance_wb_err(file) on
> > upper file and returns error. So overlayfs does not have to do anything
> > special.
> > 
> > But with syncfs(), error check happens in vfs in syncfs() w.r.t
> > overlay_sb->s_wb_err. Given overlayfs is stacked filesystem, it
> > does not do actual writeback and all writeback errors are recorded
> > on underlying filesystem. So sb->s_wb_err is never updated hence
> > syncfs() does not work with overlay.
> > 
> > Jeff suggested that instead of trying to propagate errors to overlay
> > super block, why not simply check for errors against upper filesystem
> > super block. I implemented this idea.
> > 
> > Overlay file has "since" value which needs to be initialized at open
> > time. Overlay overrides VFS initialization and re-initializes
> > f->f_sb_err w.r.t upper super block. Later when
> > ovl_sb->errseq_check_advance() is called, f->f_sb_err is used as
> > since value to figure out if any error on upper sb has happened since
> > then.
> > 
> > Note, Right now this patch only deals with regular file and directories.
> > Yet to deal with special files like device inodes, socket, fifo etc.
> > 
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/file.c      |  1 +
> >  fs/overlayfs/overlayfs.h |  1 +
> >  fs/overlayfs/readdir.c   |  1 +
> >  fs/overlayfs/super.c     | 23 +++++++++++++++++++++++
> >  fs/overlayfs/util.c      | 13 +++++++++++++
> >  5 files changed, 39 insertions(+)
> > 
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index efccb7c1f9bc..7b58a44dcb71 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -163,6 +163,7 @@ static int ovl_open(struct inode *inode, struct file *file)
> >  		return PTR_ERR(realfile);
> >  
> >  	file->private_data = realfile;
> > +	ovl_init_file_errseq(file);
> >  
> >  	return 0;
> >  }
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index f8880aa2ba0e..47838abbfb3d 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
> >  bool ovl_is_metacopy_dentry(struct dentry *dentry);
> >  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
> >  			     int padding);
> > +void ovl_init_file_errseq(struct file *file);
> >  
> >  static inline bool ovl_is_impuredir(struct super_block *sb,
> >  				    struct dentry *dentry)
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 01620ebae1bd..0c48f1545483 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -960,6 +960,7 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
> >  	od->is_real = ovl_dir_is_real(file->f_path.dentry);
> >  	od->is_upper = OVL_TYPE_UPPER(type);
> >  	file->private_data = od;
> > +	ovl_init_file_errseq(file);
> >  
> >  	return 0;
> >  }
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 290983bcfbb3..d99867983722 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -390,6 +390,28 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
> >  	return ret;
> >  }
> >  
> > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > +{
> > +	struct ovl_fs *ofs = sb->s_fs_info;
> > +	struct super_block *upper_sb;
> > +	int ret;
> > +
> > +	if (!ovl_upper_mnt(ofs))
> > +		return 0;
> > +
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +
> > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > +		return 0;
> > +
> > +	/* Something changed, must use slow path */
> > +	spin_lock(&file->f_lock);
> > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > +	spin_unlock(&file->f_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct super_operations ovl_super_operations = {
> >  	.alloc_inode	= ovl_alloc_inode,
> >  	.free_inode	= ovl_free_inode,
> > @@ -400,6 +422,7 @@ static const struct super_operations ovl_super_operations = {
> >  	.statfs		= ovl_statfs,
> >  	.show_options	= ovl_show_options,
> >  	.remount_fs	= ovl_remount,
> > +	.errseq_check_advance	= ovl_errseq_check_advance,
> >  };
> >  
> >  enum {
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 23f475627d07..a1742847f3a8 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -950,3 +950,16 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
> >  	kfree(buf);
> >  	return ERR_PTR(res);
> >  }
> > +
> > +void ovl_init_file_errseq(struct file *file)
> > +{
> > +	struct super_block *sb = file_dentry(file)->d_sb;
> > +	struct ovl_fs *ofs = sb->s_fs_info;
> > +	struct super_block *upper_sb;
> > +
> > +	if (!ovl_upper_mnt(ofs))
> > +		return;
> > +
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +	file->f_sb_err = errseq_sample(&upper_sb->s_wb_err);
> > +}
> > -- 
> > 2.25.4
> > 
> 
> I fail to see why this is neccessary if you incorporate error reporting into the 
> sync_fs callback. Why is this separate from that callback?

- Writeback error should be checked after __sync_blockdev() has been 
  called. And that's called by VFS and not in ->sync_fs. This can be
  changed by moving __sync_blockdev() insde ->sync_fs() for all
  filesystems which need it. And that's what Jeff had done in the
  past. That attempt did not make it upstream.

  https://lore.kernel.org/linux-fsdevel/20180518123415.28181-1-jlayton@kernel.org/ 

  Given this triggered changes all over the place, I started looking for
  alternatives. And thought adding a super operation to check for errors 
  solves the problem and keeps the changes to minimum.

> If you pickup Jeff's
> patch that adds the 2nd flag to errseq for "observed", you should be able to
> stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> in there instead instead of adding this new infrastructure.

Why to stash errseq in ovl_fs struct when we can directly compare it
with upper sb? "since" value is in "struct file" and current errseq
value is in upper_sb. Atleast to solve this problem it should not
be mandatory to stash errseq value in ovl_fs.

> 
> IMHO, if we're going to fix this, sync_fs should be replaced, and there should 
> be a generic_sync_fs wrapper which does the errseq, callback, and sync blockdev, 
> but then filesystems should be able to override it and do the requisite work.

Not exactly sure what you mean. But I guess you are falling back to the
idea of moving some of the vfs functionality of calling __sync_blockdev()
into filesystem ->sync_fs handler. That leads back to patches Jeff
Layton had posted in the past and is much more invasive change.

I am not against that approach but so far I have not seen any strong
interest from other in favor of that approach instead. So I find
this approach simpler and much less intrusive.

Vivek

