Return-Path: <linux-fsdevel+bounces-12187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7702885CB9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994021C21AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D321B15442C;
	Tue, 20 Feb 2024 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcoswLMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C67154429
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470090; cv=none; b=ktSvhX6qOlim4MZ8GOPYlTdxJL0dCG6A5PnbarGSALJm0M4P2rQgBHIiCJIVSMwG/lYh0/tNk4hrac2vcGJBgbIz+Iowmb8X7mEE8SarxDNJRb34H8ecJko+5uXf5+yMGNOh3Ux5lG5OyFOMxbMhk0Gl0DMN8xxEQ2b2jowrY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470090; c=relaxed/simple;
	bh=T2CP7q8wSqlZKl4e6mNNd3d+tWM6nIG4oyI/sSjT/pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww4xuROadJwLSLiw2TomV3fg8lPG8/49rHtiKqJkpxWWAV2jItfymmWVxdpInVk6q18RkGh9Dd9sgUxuhwsobUkZCKCf3xK3sb7pGlE2eG/e04aEtr1tyKrJpTG0r7oqdK2cDwG1Ydkwig3cwO0Jnsm5rWi6AqOORsxZFwYqsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcoswLMS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708470087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnT+4WPmJ6q/ESkK4OLN7nmck6WuuTV+Q7zl1qXrtHI=;
	b=CcoswLMS8xo7SCgnzynZamdsBD291BCCkRQiEXMJsALo+3RHWBzzvufVF67IzH/iM7Dp58
	qr7V8ZbwGYvdmQpHPu7+btxdCY0+7QzQNYkfTaIFaX5P1ldLGKTCU+X9/PjjLKCKxIePXo
	XrVb3Lrp2BSOLiG6s1AgAbYjsySPdjo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-1RQxnM1dO0iqNEvp5ysrSA-1; Tue,
 20 Feb 2024 18:01:25 -0500
X-MC-Unique: 1RQxnM1dO0iqNEvp5ysrSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0075028B6AAC;
	Tue, 20 Feb 2024 23:01:25 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B67BC01644;
	Tue, 20 Feb 2024 23:01:24 +0000 (UTC)
Date: Tue, 20 Feb 2024 17:01:23 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] efs: convert efs to use the new mount api
Message-ID: <ZdUvQ5zPRxNohtSU@redhat.com>
References: <20240220164729.179594-1-bodonnel@redhat.com>
 <c3528c22-8385-455f-8b72-a6302b60c360@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3528c22-8385-455f-8b72-a6302b60c360@sandeen.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Tue, Feb 20, 2024 at 03:05:38PM -0600, Eric Sandeen wrote:
> On 2/20/24 8:45 AM, Bill O'Donnell wrote:
> > Convert the efs filesystem to use the new mount API.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> > 
> > Changelog:
> > v2: Remove efs_param_spec and efs_parse_param, since no mount options.
> 
> A few more items below
> 
> > ---
> >  fs/efs/super.c | 91 +++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 61 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/efs/super.c b/fs/efs/super.c
> > index f17fdac76b2e..d86c84e9e497 100644
> > --- a/fs/efs/super.c
> > +++ b/fs/efs/super.c
> > @@ -14,19 +14,13 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/vfs.h>
> >  #include <linux/blkdev.h>
> > -
> > +#include <linux/fs_context.h>
> >  #include "efs.h"
> >  #include <linux/efs_vh.h>
> >  #include <linux/efs_fs_sb.h>
> >  
> >  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf);
> > -static int efs_fill_super(struct super_block *s, void *d, int silent);
> > -
> > -static struct dentry *efs_mount(struct file_system_type *fs_type,
> > -	int flags, const char *dev_name, void *data)
> > -{
> > -	return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
> > -}
> > +static int efs_init_fs_context(struct fs_context *fc);
> >  
> >  static void efs_kill_sb(struct super_block *s)
> >  {
> > @@ -35,15 +29,6 @@ static void efs_kill_sb(struct super_block *s)
> >  	kfree(sbi);
> >  }
> >  
> > -static struct file_system_type efs_fs_type = {
> > -	.owner		= THIS_MODULE,
> > -	.name		= "efs",
> > -	.mount		= efs_mount,
> > -	.kill_sb	= efs_kill_sb,
> > -	.fs_flags	= FS_REQUIRES_DEV,
> > -};
> > -MODULE_ALIAS_FS("efs");
> > -
> >  static struct pt_types sgi_pt_types[] = {
> >  	{0x00,		"SGI vh"},
> >  	{0x01,		"SGI trkrepl"},
> > @@ -63,6 +48,17 @@ static struct pt_types sgi_pt_types[] = {
> >  	{0,		NULL}
> >  };
> >  
> > +/*
> > + * File system definition and registration.
> > + */
> > +static struct file_system_type efs_fs_type = {
> > +	.owner			= THIS_MODULE,
> > +	.name			= "efs",
> > +	.kill_sb		= efs_kill_sb,
> > +	.fs_flags		= FS_REQUIRES_DEV,
> > +	.init_fs_context	= efs_init_fs_context,
> > +};
> > +MODULE_ALIAS_FS("efs");
> >  
> >  static struct kmem_cache * efs_inode_cachep;
> >  
> > @@ -108,18 +104,10 @@ static void destroy_inodecache(void)
> >  	kmem_cache_destroy(efs_inode_cachep);
> >  }
> >  
> > -static int efs_remount(struct super_block *sb, int *flags, char *data)
> > -{
> > -	sync_filesystem(sb);
> > -	*flags |= SB_RDONLY;
> > -	return 0;
> > -}
> > -
> >  static const struct super_operations efs_superblock_operations = {
> >  	.alloc_inode	= efs_alloc_inode,
> >  	.free_inode	= efs_free_inode,
> >  	.statfs		= efs_statfs,
> > -	.remount_fs	= efs_remount,
> >  };
> >  
> >  static const struct export_operations efs_export_ops = {
> > @@ -249,26 +237,26 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
> >  	return 0;    
> >  }
> >  
> > -static int efs_fill_super(struct super_block *s, void *d, int silent)
> > +static int efs_fill_super(struct super_block *s, struct fs_context *fc)
> >  {
> >  	struct efs_sb_info *sb;
> >  	struct buffer_head *bh;
> >  	struct inode *root;
> >  
> > - 	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
> > +	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
> 
> Ok, I guess this and elsewhere is fixing up whitespace oddities,
> not adding them. :)

Yeah, I fixed some tabs to spaces whitespace, when I was in that area of code.

> 
> >  	if (!sb)
> >  		return -ENOMEM;
> >  	s->s_fs_info = sb;
> >  	s->s_time_min = 0;
> >  	s->s_time_max = U32_MAX;
> > - 
> > +
> >  	s->s_magic		= EFS_SUPER_MAGIC;
> >  	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
> >  		pr_err("device does not support %d byte blocks\n",
> >  			EFS_BLOCKSIZE);
> >  		return -EINVAL;
> 
> I think this can (should?) be converted to:
> 
> 		return invalf(fc,
> 			"device does not support %d byte blocks",
> 			EFS_BLOCKSIZE);
> 
> and similarly for other error printing failures along the fill_super path,
> with appropriate variants of invalf()/errorf()/warnf()/etc
> 
> (dhowells - am I right about this?)

I'm still looking at this.

> 
> >  	}
> > -  
> > +
> >  	/* read the vh (volume header) block */
> >  	bh = sb_bread(s, 0);
> >  
> > @@ -294,7 +282,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
> >  		pr_err("cannot read superblock\n");
> >  		return -EIO;
> >  	}
> > -		
> > +
> >  	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
> >  #ifdef DEBUG
> >  		pr_warn("invalid superblock at block %u\n",
> > @@ -328,6 +316,49 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
> >  	return 0;
> >  }
> >  
> > +static void efs_free_fc(struct fs_context *fc)
> > +{
> > +	kfree(fc->fs_private);
> > +}
> 
> unneeded; see below

Agreed.

> 
> > +static int efs_get_tree(struct fs_context *fc)
> > +{
> > +	return get_tree_bdev(fc, efs_fill_super);
> > +}
> > +
> > +static int efs_reconfigure(struct fs_context *fc)
> > +{
> > +	sync_filesystem(fc->root->d_sb);
> 
> I think you need:
> 
> 	fc->sb_flags |= SB_RDONLY;
> 
> here to preserve the original behavior in efs_remount()

Good catch. I had noticed that /proc/mounts changed the permission to rw,
but not behaving as rw.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +struct efs_context {
> > +	unsigned long s_mount_opts;
> > +};
> 
> This looks unused, and probably also copied from zonefs, which used it
> to store mount options - something efs doesn't have.

Agreed.

> 
> > +
> > +static const struct fs_context_operations efs_context_opts = {
> > +	.get_tree	= efs_get_tree,
> > +	.reconfigure	= efs_reconfigure,
> > +	.free		= efs_free_fc,
> > +};
> > +
> > +/*
> > + * Set up the filesystem mount context.
> > + */
> > +static int efs_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct efs_context *ctx;
> > +
> > +	ctx = kzalloc(sizeof(struct efs_context), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +	fc->fs_private = ctx;
> 
> so there's no reason to allocate and assign it here.
> which means efs_free_fc() doesn't need to exist either.

Agreed.

> 
> > +	fc->ops = &efs_context_opts;
> > +
> > +	return 0;
> > +}
> > +
> >  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
> >  	struct super_block *sb = dentry->d_sb;
> >  	struct efs_sb_info *sbi = SUPER_INFO(sb);
> 


