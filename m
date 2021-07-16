Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD243CB030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhGPAyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhGPAyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626396671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAXgxy9Dn6W6U7dim+xGqCrdh99XBdSv2rHbgYmAceI=;
        b=Rwq8M1FQegh0qW8bDrCbc5bKzCCGWShpwPqgslRIgr5xyT05f5tIUrHTXzgipBSaJtpRHq
        lEEjzS69e9zEa7h4gN3cQ9sPVbN5fGcnFNs7b/3xlYQt5zZo45Eur3+ZFiwYEG91xr3pM1
        wKR7rMQZBDcpdWLJHg+2zQ2BXUqnqHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-HgJ1LNYgMD6ZNyF2nNHGVw-1; Thu, 15 Jul 2021 20:51:08 -0400
X-MC-Unique: HgJ1LNYgMD6ZNyF2nNHGVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C936801B0C;
        Fri, 16 Jul 2021 00:51:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-72.rdu2.redhat.com [10.10.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD1218AAB;
        Fri, 16 Jul 2021 00:51:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D5D9422021C; Thu, 15 Jul 2021 20:51:01 -0400 (EDT)
Date:   Thu, 15 Jul 2021 20:51:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 3/3] fuse: add per-file DAX flag
Message-ID: <YPDX9S3/TD3CL0CZ@redhat.com>
References: <20210715093031.55667-1-jefflexu@linux.alibaba.com>
 <20210715093031.55667-4-jefflexu@linux.alibaba.com>
 <20210716004028.GA30967@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716004028.GA30967@rsjd01523.et2sqa>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 08:40:29AM +0800, Liu Bo wrote:
> On Thu, Jul 15, 2021 at 05:30:31PM +0800, Jeffle Xu wrote:
> > Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> > this file.
> > 
> > When the per-file DAX flag changes for an *opened* file, the state of
> > the file won't be updated until this file is closed and reopened later.
> > 
> > Currently it is not implemented yet to change per-file DAX flag inside
> > guest kernel, e.g., by chattr(1).
> 
> Thanks for the patch, it looks good to me.
> 
> I think it's a good starting point, what I'd like to discuss here is
> whether we're going to let chattr to toggle the dax flag.

I have the same question. Why not take chattr approach as taken
by ext4/xfs as well.

Vivek

> 
> My usecase is like, on the fuse server side, if a file is marked as
> DAX, then it won't change any more.  So this 'fuse_attr.flags' works
> for me at least.
> 
> thanks,
> liubo
> 
> > 
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> >  fs/fuse/dax.c             | 28 ++++++++++++++++++++++++----
> >  fs/fuse/file.c            |  4 ++--
> >  fs/fuse/fuse_i.h          |  5 +++--
> >  fs/fuse/inode.c           |  4 +++-
> >  include/uapi/linux/fuse.h |  5 +++++
> >  5 files changed, 37 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> > index 4873d764cb66..ed5a430364bb 100644
> > --- a/fs/fuse/dax.c
> > +++ b/fs/fuse/dax.c
> > @@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
> >  	.invalidatepage	= noop_invalidatepage,
> >  };
> >  
> > -static bool fuse_should_enable_dax(struct inode *inode)
> > +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
> >  {
> >  	struct fuse_conn *fc = get_fuse_conn(inode);
> >  	unsigned int mode;
> > @@ -1354,18 +1354,38 @@ static bool fuse_should_enable_dax(struct inode *inode)
> >  	if (mode == FUSE_DAX_MOUNT_NEVER)
> >  		return false;
> >  
> > -	return true;
> > +	if (mode == FUSE_DAX_MOUNT_ALWAYS)
> > +		return true;
> > +
> > +	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
> > +	return flags & FUSE_ATTR_DAX;
> >  }
> >  
> > -void fuse_dax_inode_init(struct inode *inode)
> > +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
> >  {
> > -	if (!fuse_should_enable_dax(inode))
> > +	if (!fuse_should_enable_dax(inode, flags))
> >  		return;
> >  
> >  	inode->i_flags |= S_DAX;
> >  	inode->i_data.a_ops = &fuse_dax_file_aops;
> >  }
> >  
> > +void fuse_update_dax(struct inode *inode, unsigned int flags)
> > +{
> > +	bool oldstate, newstate;
> > +	struct fuse_conn *fc = get_fuse_conn(inode);
> > +
> > +	if (!IS_ENABLED(CONFIG_FUSE_DAX) || !fc->dax ||
> > +	    fc->dax->mode != FUSE_DAX_MOUNT_INODE)
> > +		return;
> > +
> > +	oldstate = IS_DAX(inode);
> > +	newstate = flags & FUSE_ATTR_DAX;
> > +
> > +	if (oldstate != newstate)
> > +		d_mark_dontcache(inode);
> > +}
> > +
> >  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment)
> >  {
> >  	if (fc->dax && (map_alignment > FUSE_DAX_SHIFT)) {
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 97f860cfc195..cf42af492146 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3142,7 +3142,7 @@ static const struct address_space_operations fuse_file_aops  = {
> >  	.write_end	= fuse_write_end,
> >  };
> >  
> > -void fuse_init_file_inode(struct inode *inode)
> > +void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
> >  {
> >  	struct fuse_inode *fi = get_fuse_inode(inode);
> >  
> > @@ -3156,5 +3156,5 @@ void fuse_init_file_inode(struct inode *inode)
> >  	fi->writepages = RB_ROOT;
> >  
> >  	if (IS_ENABLED(CONFIG_FUSE_DAX))
> > -		fuse_dax_inode_init(inode);
> > +		fuse_dax_inode_init(inode, attr->flags);
> >  }
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index f29018323845..b0ecfffd0c7d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1000,7 +1000,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
> >  /**
> >   * Initialize file operations on a regular file
> >   */
> > -void fuse_init_file_inode(struct inode *inode);
> > +void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr);
> >  
> >  /**
> >   * Initialize inode operations on regular files and special files
> > @@ -1252,8 +1252,9 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
> >  			struct dax_device *dax_dev);
> >  void fuse_dax_conn_free(struct fuse_conn *fc);
> >  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
> > -void fuse_dax_inode_init(struct inode *inode);
> > +void fuse_dax_inode_init(struct inode *inode, unsigned int flags);
> >  void fuse_dax_inode_cleanup(struct inode *inode);
> > +void fuse_update_dax(struct inode *inode, unsigned int flags);
> >  bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
> >  void fuse_dax_cancel_work(struct fuse_conn *fc);
> >  
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index f6b46395edb2..47ebb1a394d2 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -269,6 +269,8 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
> >  		if (inval)
> >  			invalidate_inode_pages2(inode->i_mapping);
> >  	}
> > +
> > +	fuse_update_dax(inode, attr->flags);
> >  }
> >  
> >  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> > @@ -281,7 +283,7 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
> >  	inode->i_ctime.tv_nsec = attr->ctimensec;
> >  	if (S_ISREG(inode->i_mode)) {
> >  		fuse_init_common(inode);
> > -		fuse_init_file_inode(inode);
> > +		fuse_init_file_inode(inode, attr);
> >  	} else if (S_ISDIR(inode->i_mode))
> >  		fuse_init_dir(inode);
> >  	else if (S_ISLNK(inode->i_mode))
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 36ed092227fa..9ee088ddbe2a 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -184,6 +184,9 @@
> >   *
> >   *  7.34
> >   *  - add FUSE_SYNCFS
> > + *
> > + *  7.35
> > + *  - add FUSE_ATTR_DAX
> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -449,8 +452,10 @@ struct fuse_file_lock {
> >   * fuse_attr flags
> >   *
> >   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> > + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
> >   */
> >  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> > +#define FUSE_ATTR_DAX      	(1 << 1)
> >  
> >  /**
> >   * Open flags
> > -- 
> > 2.27.0
> 

