Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672C12DAFC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgLOPIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 10:08:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730189AbgLOPIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s/sbqXBerqGZZxzlqEnzH31KNQI5SpRZuItSzr5wC2o=;
        b=YBfridtfLF6c0uT3Z0vePhB8n+BdIqDzs0D/WWWQeMDmqRCWjHXirfKRq2bIsf0a5t/Kca
        SDhiPOmpLs6h5PEb7HW69MxJIbmf0icdIASc2vLR/uyvDL5Sb+cg614Qpb0cZtjXdWW/MP
        KjSdpcYUDInfbTmSng8BZ06URxI2YkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-MClcRUfTPduqpEpeK0xctg-1; Tue, 15 Dec 2020 10:06:59 -0500
X-MC-Unique: MClcRUfTPduqpEpeK0xctg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC2C46D520;
        Tue, 15 Dec 2020 15:06:57 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-245.rdu2.redhat.com [10.10.117.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5FEF60854;
        Tue, 15 Dec 2020 15:06:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 282C0220BCF; Tue, 15 Dec 2020 10:06:57 -0500 (EST)
Date:   Tue, 15 Dec 2020 10:06:57 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 2/2] overlayfs: propagate errors from upper to
 overlay sb in sync_fs
Message-ID: <20201215150657.GB63355@redhat.com>
References: <20201213132713.66864-1-jlayton@kernel.org>
 <20201213132713.66864-3-jlayton@kernel.org>
 <20201214213843.GA3453@redhat.com>
 <979d78d04d882744d944f5723ad7a98b14badf8b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <979d78d04d882744d944f5723ad7a98b14badf8b.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 06:53:10PM -0500, Jeff Layton wrote:
> On Mon, 2020-12-14 at 16:38 -0500, Vivek Goyal wrote:
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
> >  fs/overlayfs/ovl_entry.h |    1 +
> >  fs/overlayfs/super.c     |   14 +++++++++++---
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > Index: redhat-linux/fs/overlayfs/super.c
> > ===================================================================
> > --- redhat-linux.orig/fs/overlayfs/super.c	2020-12-14 15:33:43.934400880 -0500
> > +++ redhat-linux/fs/overlayfs/super.c	2020-12-14 16:15:07.127400880 -0500
> > @@ -259,7 +259,7 @@ static int ovl_sync_fs(struct super_bloc
> >  {
> >  	struct ovl_fs *ofs = sb->s_fs_info;
> >  	struct super_block *upper_sb;
> > -	int ret;
> > +	int ret, ret2;
> >  
> > 
> > 
> > 
> >  	if (!ovl_upper_mnt(ofs))
> >  		return 0;
> > @@ -283,7 +283,14 @@ static int ovl_sync_fs(struct super_bloc
> >  	ret = sync_filesystem(upper_sb);
> >  	up_read(&upper_sb->s_umount);
> >  
> > 
> > 
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
> 
> I think this is probably not quite right.
> 
> The problem I think is that the SEEN flag is always going to end up
> being set in sb->s_wb_err, and that is going to violate the desired
> semantics. If the writeback error occurred after all fd's were closed,
> then the next opener wouldn't see it and you'd lose the error.

So this will happen only due to sync() path and not syncfs() path, right?
If we avoid calling errseq_check_and_advance() in sync() path in
ovleryafs(), then we always have a valid fd and marking error SEEN
on upper is perfectly valid?

> 
> We probably need a function to cleanly propagate the error from one
> errseq_t to another so that that doesn't occur. I'll have to think about
> it.

Thanks
Vivek

> 
> >  }
> >  
> > 
> > 
> > 
> >  /**
> > @@ -1873,6 +1880,7 @@ static int ovl_fill_super(struct super_b
> >  	if (!cred)
> >  		goto out_err;
> >  
> > 
> > 
> > 
> > +	spin_lock_init(&ofs->errseq_lock);
> >  	/* Is there a reason anyone would want not to share whiteouts? */
> >  	ofs->share_whiteout = true;
> >  
> > 
> > 
> > 
> > @@ -1945,7 +1953,7 @@ static int ovl_fill_super(struct super_b
> >  
> > 
> > 
> > 
> >  		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> >  		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> > -
> > +		sb->s_wb_err = errseq_sample(&ovl_upper_mnt(ofs)->mnt_sb->s_wb_err);
> >  	}
> >  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
> >  	err = PTR_ERR(oe);
> > Index: redhat-linux/fs/overlayfs/ovl_entry.h
> > ===================================================================
> > --- redhat-linux.orig/fs/overlayfs/ovl_entry.h	2020-12-14 15:33:43.934400880 -0500
> > +++ redhat-linux/fs/overlayfs/ovl_entry.h	2020-12-14 15:34:13.509400880 -0500
> > @@ -79,6 +79,7 @@ struct ovl_fs {
> >  	atomic_long_t last_ino;
> >  	/* Whiteout dentry cache */
> >  	struct dentry *whiteout;
> > +	spinlock_t errseq_lock;
> >  };
> >  
> > 
> > 
> > 
> >  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

