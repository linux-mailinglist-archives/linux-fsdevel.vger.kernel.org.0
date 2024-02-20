Return-Path: <linux-fsdevel+bounces-12159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1859085C098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EB028384D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8834763F3;
	Tue, 20 Feb 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDctjIF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194E78662
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444912; cv=none; b=AXxDCu0wypap0X48gvmPWheMuG5anRh7jbg/fXDLSiCPAnDwEZcO3h5EkUDyZ0negS1yaDBGV+xb4jmUSIOmXGYtWLAY4G0uIPHzzSpjEEXN04JTJRHCGfLUYOM3FwRO6gjuk5Fsq/Pxg0704ppJ8UY7W5etYydiLCp6T2tDhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444912; c=relaxed/simple;
	bh=+SlKbQOANw5JVrUc7LYo4d4/sSlPeMEAvUUHKgwwH54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwRdteGAm2PvVzWDLkLtIhH8ZLzv15nZUGG597Nhf26G3DKcy2s+OWaTQYiK2/hl+Y3NkxkRWlWk5JMfVXaOuu26tnoFWoMcCeCJNLMT7vmNy/lZFFA2Yc62ECudlTbBspjRrcKlHrpIgWE83ZqVd30RYtL9q1zIUBDsmWdj9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDctjIF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708444909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTUhVHiNHUwUT8Vch9WdYbMOZl0ZQlzk58jgl/b4Kjs=;
	b=aDctjIF5hMozAP88ZfHXcjd7KizLRYYk/FGx+ixEgDhiOcQEVH4rpE4SmnK7y7B0B0y3/3
	0FH2jKhQSK8smBHkKzx2r9wDlc7gV0VSU907WBUrMg1ySo7Jdpx51fENXcjbT3mNQ2libg
	Q6HVt91nbCX3NqzT74aOGIFwDFUGlHU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-CYYAsyf-PFKlPqRFO0S5xg-1; Tue,
 20 Feb 2024 11:01:45 -0500
X-MC-Unique: CYYAsyf-PFKlPqRFO0S5xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E372D3813F2C;
	Tue, 20 Feb 2024 16:01:44 +0000 (UTC)
Received: from redhat.com (unknown [10.22.33.227])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A33B82864;
	Tue, 20 Feb 2024 16:01:44 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:01:43 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: convert efs to use the new mount api
Message-ID: <ZdTM5y7rGzDKaizR@redhat.com>
References: <20240220003318.166143-1-bodonnel@redhat.com>
 <20240220-vagabunden-orchester-9067bc0c98a4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-vagabunden-orchester-9067bc0c98a4@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Feb 20, 2024 at 09:42:35AM +0100, Christian Brauner wrote:
> On Mon, Feb 19, 2024 at 06:33:18PM -0600, Bill O'Donnell wrote:
> > Convert the efs filesystem to use the new mount API.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> 
> Thanks for doing this. One question below.
> 
> >  fs/efs/super.c | 114 ++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 84 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/efs/super.c b/fs/efs/super.c
> > index f17fdac76b2e..c837ac89b384 100644
> > --- a/fs/efs/super.c
> > +++ b/fs/efs/super.c
> > @@ -14,19 +14,14 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/vfs.h>
> >  #include <linux/blkdev.h>
> > -
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
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
> > @@ -35,15 +30,6 @@ static void efs_kill_sb(struct super_block *s)
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
> > @@ -63,6 +49,27 @@ static struct pt_types sgi_pt_types[] = {
> >  	{0,		NULL}
> >  };
> >  
> > +enum {
> > +	Opt_explicit_open,
> > +};
> > +
> > +static const struct fs_parameter_spec efs_param_spec[] = {
> > +	fsparam_flag    ("explicit-open",       Opt_explicit_open),
> > +	{}
> > +};
> 
> That looks like it is copy-pasted from zonefs?

Yes. efs_param_spec will be removed in v2.

> 
> > +
> > +/*
> > + * File system definition and registration.
> > + */
> > +static struct file_system_type efs_fs_type = {
> > +	.owner			= THIS_MODULE,
> > +	.name			= "efs",
> > +	.kill_sb		= efs_kill_sb,
> > +	.fs_flags		= FS_REQUIRES_DEV,
> > +	.init_fs_context	= efs_init_fs_context,
> > +	.parameters		= efs_param_spec,
> > +};
> > +MODULE_ALIAS_FS("efs");
> >  
> >  static struct kmem_cache * efs_inode_cachep;
> >  
> > @@ -108,18 +115,10 @@ static void destroy_inodecache(void)
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
> > @@ -249,26 +248,26 @@ static int efs_validate_super(struct efs_sb_info *sb, struct efs_super *super) {
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
> >  	}
> > -  
> > +
> >  	/* read the vh (volume header) block */
> >  	bh = sb_bread(s, 0);
> >  
> > @@ -294,7 +293,7 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
> >  		pr_err("cannot read superblock\n");
> >  		return -EIO;
> >  	}
> > -		
> > +
> >  	if (efs_validate_super(sb, (struct efs_super *) bh->b_data)) {
> >  #ifdef DEBUG
> >  		pr_warn("invalid superblock at block %u\n",
> > @@ -328,6 +327,61 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
> >  	return 0;
> >  }
> >  
> > +static void efs_free_fc(struct fs_context *fc)
> > +{
> > +	kfree(fc->fs_private);
> > +}
> > +
> > +static int efs_get_tree(struct fs_context *fc)
> > +{
> > +	return get_tree_bdev(fc, efs_fill_super);
> > +}
> > +
> > +static int efs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > +{
> > +	int token;
> > +	struct fs_parse_result result;
> > +
> > +	token = fs_parse(fc, efs_param_spec, param, &result);
> > +	if (token < 0)
> > +		return token;
> 
> Any mount option here is completely ignored, no? Why even have any mount
> options then? It's not required to implement ->parse_param.

Correct. My wrong-thinking was that parse_param needed to be there for vfs,
regardless of the lack of mount options. I'll remove it.

Thanks for the review. I'll submit a v2.
Bill

> 
> > +	return 0;
> > +}
> > +
> > +static int efs_reconfigure(struct fs_context *fc)
> > +{
> > +	sync_filesystem(fc->root->d_sb);
> > +
> > +	return 0;
> > +}
> > +
> > +struct efs_context {
> > +	unsigned long s_mount_opts;
> > +};
> > +
> > +static const struct fs_context_operations efs_context_opts = {
> > +	.parse_param	= efs_parse_param,
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
> > +	fc->ops = &efs_context_opts;
> > +
> > +	return 0;
> > +}
> > +
> >  static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
> >  	struct super_block *sb = dentry->d_sb;
> >  	struct efs_sb_info *sbi = SUPER_INFO(sb);
> > -- 
> > 2.43.2
> > 
> 


