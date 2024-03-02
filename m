Return-Path: <linux-fsdevel+bounces-13374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8E86F185
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9451C20B12
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162424A0E;
	Sat,  2 Mar 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQbBgWU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B722F0A
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398753; cv=none; b=bvw6QLzjSIzopmYrNBgD8MfJ9l9bV1VaevLnNZ02oFf/LJ4wL1hxYk5ZRVmRXC4S/4HqgA8K+XFa2lewiFvDzcLdj1wYY1lqMNj5hGvs5BCgRe6CUEJBgLqFtCp1tzMzhovC2RRjOiPEeiVRjQ7o8DW2wbQJY1khHMKB6SiyhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398753; c=relaxed/simple;
	bh=guA++MTUgy4ebAkTLo/2XYvVGJuvrbX5Miq8/ZmZuW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7SojgnjGCHDOXI2eVhWjcDiyztdcg0D6ZjHUoACICV+BQTHE7BaHDsMrlXF44jl11SUwWlBYNBsoxPMn20wqslIMTVtcG0vWXQOqVVthYboMdTPZ58xYl8XPi447Ox5/fnEQqPD0cFT+Y530+n3xgvPFkl8tjURvj/s13wQgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQbBgWU5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709398749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EIX1AZp6exxCDeijUxIebuaaLxBDXyc0bmAhlfZ5PA=;
	b=WQbBgWU5SsjCbN2rOeUyWzqbttbvpma8Qmfx636Vtk0ztGWXisETrNGCTAGsjltZ/8GrUE
	G8xIWQHUeDjd/udFjCljvOnIc3lnNCPhiJe93VtRy2+JexJRDkVPwA08JAZUO+Mz9atnZR
	uJ4nH1bzBpBh3yMDQG+Pi21w3itnsIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-eRitKrq1MFW9wilNQTl6Zw-1; Sat, 02 Mar 2024 11:59:07 -0500
X-MC-Unique: eRitKrq1MFW9wilNQTl6Zw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97CC5108BCA1;
	Sat,  2 Mar 2024 16:59:07 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F39BF96E9;
	Sat,  2 Mar 2024 16:59:06 +0000 (UTC)
Date: Sat, 2 Mar 2024 10:59:05 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, al@alarsen.net, brauner@kernel.org
Subject: Re: [PATCH] qnx6: convert qnx6 to use the new mount api
Message-ID: <ZeNa2Q6Z9h4egudd@redhat.com>
References: <20240229191317.805034-1-bodonnel@redhat.com>
 <68be6a82-f093-41d4-9467-4b4694e8c5f3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68be6a82-f093-41d4-9467-4b4694e8c5f3@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Feb 29, 2024 at 06:16:02PM -0600, Eric Sandeen wrote:
> On 2/29/24 1:13 PM, Bill O'Donnell wrote:
> > Convert the qnx6 filesystem to use the new mount API.
> > 
> > Untested, since there is no qnx6 fs image readily available.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> >  fs/qnx6/inode.c | 119 +++++++++++++++++++++++++++++-------------------
> >  1 file changed, 72 insertions(+), 47 deletions(-)
> > 
> > diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> > index a286c545717f..0df5a92a8b65 100644
> > --- a/fs/qnx6/inode.c
> > +++ b/fs/qnx6/inode.c
> > @@ -19,11 +19,12 @@
> >  #include <linux/buffer_head.h>
> >  #include <linux/writeback.h>
> >  #include <linux/statfs.h>
> > -#include <linux/parser.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/mount.h>
> 
> I *think* you can lose this include too but not a big deal.
> 
> >  #include <linux/crc32.h>
> >  #include <linux/mpage.h>
> > +#include <linux/fs_parser.h>
> > +#include <linux/fs_context.h>
> >  #include "qnx6.h"
> >  
> >  static const struct super_operations qnx6_sops;
> > @@ -31,7 +32,7 @@ static const struct super_operations qnx6_sops;
> >  static void qnx6_put_super(struct super_block *sb);
> >  static struct inode *qnx6_alloc_inode(struct super_block *sb);
> >  static void qnx6_free_inode(struct inode *inode);
> > -static int qnx6_remount(struct super_block *sb, int *flags, char *data);
> > +static int qnx6_reconfigure(struct fs_context *fc);
> >  static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf);
> >  static int qnx6_show_options(struct seq_file *seq, struct dentry *root);
> >  
> > @@ -40,7 +41,6 @@ static const struct super_operations qnx6_sops = {
> >  	.free_inode	= qnx6_free_inode,
> >  	.put_super	= qnx6_put_super,
> >  	.statfs		= qnx6_statfs,
> > -	.remount_fs	= qnx6_remount,
> >  	.show_options	= qnx6_show_options,
> >  };
> >  
> > @@ -54,10 +54,12 @@ static int qnx6_show_options(struct seq_file *seq, struct dentry *root)
> >  	return 0;
> >  }
> >  
> > -static int qnx6_remount(struct super_block *sb, int *flags, char *data)
> > +static int qnx6_reconfigure(struct fs_context *fc)
> >  {
> > +	struct super_block *sb = fc->root->d_sb;
> > +
> >  	sync_filesystem(sb);
> > -	*flags |= SB_RDONLY;
> > +	fc->sb_flags |= SB_RDONLY;
> >  	return 0;
> >  }
> >  
> > @@ -222,35 +224,36 @@ enum {
> >  	Opt_err
> >  };
> >  
> > -static const match_table_t tokens = {
> > -	{Opt_mmifs, "mmi_fs"},
> > -	{Opt_err, NULL}
> > +struct qnx6_context {
> > +	unsigned long s_mount_opts;
> > +};
> 
> s_mount_opts seems to be a write-only variable. It's set in 
> qnx6_parse_param() but nothing ever reads it?
> 
> > +
> > +static const struct fs_parameter_spec qnx6_param_spec[] = {
> > +	fsparam_flag	("mmi_fs",	Opt_mmifs),
> > +	{}
> >  };
> >  
> > -static int qnx6_parse_options(char *options, struct super_block *sb)
> > +static int qnx6_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  {
> > -	char *p;
> > -	struct qnx6_sb_info *sbi = QNX6_SB(sb);
> > -	substring_t args[MAX_OPT_ARGS];
> > -
> > -	if (!options)
> > -		return 1;
> > -
> > -	while ((p = strsep(&options, ",")) != NULL) {
> > -		int token;
> > -		if (!*p)
> > -			continue;
> > -
> > -		token = match_token(p, tokens, args);
> > -		switch (token) {
> > -		case Opt_mmifs:
> > -			set_opt(sbi->s_mount_opt, MMI_FS);
> > -			break;
> > -		default:
> > -			return 0;
> > -		}
> > +	struct qnx6_context *ctx = fc->fs_private;
> > +	struct fs_parse_result result;
> > +	int opt;
> > +
> > +	opt = fs_parse(fc, qnx6_param_spec, param, &result);
> > +	if (opt < 0)
> > +		return opt;
> > +
> > +	switch (opt) {
> > +	case Opt_err:
> > +		ctx->s_mount_opts |= result.uint_32;
> > +		break;
> 
> Not sure what's going on here. Opt_err is not associated with any
> valid mount option.
> 
> > +	case Opt_mmifs:
> > +		ctx->s_mount_opts |= QNX6_MOUNT_MMI_FS;
> > +		break;
> 
> This sets QNX6_MOUNT_MMI_FS into ctx->s_mount_opts but it looks like
> nothing ever reads it back out of the context.
> 
> In qnx6_fill_super uptream, this handles the case where the mmi_fs option
> was set:
> 
>          if (test_opt(s, MMI_FS)) {
>                 sb1 = qnx6_mmi_fill_super(s, silent);
>                 if (sb1)
>                         goto mmi_success;
>                 else
>                         goto outnobh;
>         }       
> 
> Under the new mount api, the mmi_fs state needs to be saved in the
> filesystem context when it's parsed, then tested here, to do the right
> thing in fill_super when that option has been set.
> 
> > +	default:
> > +		return -EINVAL;
> >  	}
> > -	return 1;
> > +	return 0;
> >  }
> >  
> >  static struct buffer_head *qnx6_check_first_superblock(struct super_block *s,
> > @@ -293,22 +296,24 @@ static struct buffer_head *qnx6_check_first_superblock(struct super_block *s,
> >  static struct inode *qnx6_private_inode(struct super_block *s,
> >  					struct qnx6_root_node *p);
> >  
> > -static int qnx6_fill_super(struct super_block *s, void *data, int silent)
> > +static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
> >  {
> >  	struct buffer_head *bh1 = NULL, *bh2 = NULL;
> >  	struct qnx6_super_block *sb1 = NULL, *sb2 = NULL;
> >  	struct qnx6_sb_info *sbi;
> > +
> >  	struct inode *root;
> >  	const char *errmsg;
> >  	struct qnx6_sb_info *qs;
> >  	int ret = -EINVAL;
> >  	u64 offset;
> >  	int bootblock_offset = QNX6_BOOTBLOCK_SIZE;
> > +	int silent = fc->sb_flags & SB_SILENT;
> >  
> > -	qs = kzalloc(sizeof(struct qnx6_sb_info), GFP_KERNEL);
> > -	if (!qs)
> > +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> > +	if (!sbi)
> >  		return -ENOMEM;
> > -	s->s_fs_info = qs;
> > +	s->s_fs_info = sbi;
> 
> Not sure what this change is for. The existing code is a little odd, it
> allocates *qs as a struct qnx6_sb_info and assigns it to s->s_fs_info, then
> reads it back out of s->s_fs_info via QNX6_SB(s) and assigns that to *sbi;
> I don't see any real reason for that dance, it's 2 pointers w/ the same value.
>  
> But, with your change *qs is never initialized, and yet this:
> 
> outnobh:
>         kfree(qs);
> 
> remains, which would free the uninitialized pointer variable.
> 
> I don't think any of the above needs to change for this conversion.
> 
> -Eric

v2 patch sent.
Thanks-
Bill

> 
> >  	/* Superblock always is 512 Byte long */
> >  	if (!sb_set_blocksize(s, QNX6_SUPERBLOCK_SIZE)) {
> > @@ -316,11 +321,6 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
> >  		goto outnobh;
> >  	}
> >  
> > -	/* parse the mount-options */
> > -	if (!qnx6_parse_options((char *) data, s)) {
> > -		pr_err("invalid mount options.\n");
> > -		goto outnobh;
> > -	}
> >  	if (test_opt(s, MMI_FS)) {
> >  		sb1 = qnx6_mmi_fill_super(s, silent);
> >  		if (sb1)
> > @@ -632,18 +632,43 @@ static void destroy_inodecache(void)
> >  	kmem_cache_destroy(qnx6_inode_cachep);
> >  }
> >  
> > -static struct dentry *qnx6_mount(struct file_system_type *fs_type,
> > -	int flags, const char *dev_name, void *data)
> > +static int qnx6_get_tree(struct fs_context *fc)
> >  {
> > -	return mount_bdev(fs_type, flags, dev_name, data, qnx6_fill_super);
> > +	return get_tree_bdev(fc, qnx6_fill_super);
> > +}
> > +
> > +static void qnx6_free_fc(struct fs_context *fc)
> > +{
> > +	kfree(fc->fs_private);
> > +}
> > +
> > +static const struct fs_context_operations qnx6_context_ops = {
> > +	.parse_param	= qnx6_parse_param,
> > +	.get_tree	= qnx6_get_tree,
> > +	.reconfigure	= qnx6_reconfigure,
> > +	.free		= qnx6_free_fc,
> > +};
> > +
> > +static int qnx6_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct qnx6_context *ctx;
> > +
> > +	ctx = kzalloc(sizeof(struct qnx6_context), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +	fc->ops = &qnx6_context_ops;
> > +	fc->fs_private = ctx;
> > +
> > +	return 0;
> >  }
> >  
> >  static struct file_system_type qnx6_fs_type = {
> > -	.owner		= THIS_MODULE,
> > -	.name		= "qnx6",
> > -	.mount		= qnx6_mount,
> > -	.kill_sb	= kill_block_super,
> > -	.fs_flags	= FS_REQUIRES_DEV,
> > +	.owner			= THIS_MODULE,
> > +	.name			= "qnx6",
> > +	.kill_sb		= kill_block_super,
> > +	.fs_flags		= FS_REQUIRES_DEV,
> > +	.init_fs_context	= qnx6_init_fs_context,
> > +	.parameters		= qnx6_param_spec,
> >  };
> >  MODULE_ALIAS_FS("qnx6");
> >  
> 


