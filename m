Return-Path: <linux-fsdevel+bounces-13204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB786D188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 19:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA6B2664D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2B7828D;
	Thu, 29 Feb 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="JlCKzFPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A97828A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.18.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230127; cv=none; b=HfmgvAVxxe2hTdstLOOnwh98JE1vV06iyDV1obSRsg48luXluDC4hsWgCZvgdhraozmO/G5+B0QZ4uHy9OOdQZNcKeHO/d1HluL/k/VbupcAQOxr+u6ZBBzYoZi8X2jCHA8N2rw04NILs5in59si7D6q0jWJV5LxfAgwZ4o0jkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230127; c=relaxed/simple;
	bh=avE4HEyQXq7lv4N7LDCr8WnLr3pHRL2DRKJrWUJgBiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtmNrC3SyPUaAWVECjRbaT8+6aG3R9jGYIaB0uzERtMEBGTwSSNIYOlewambaM9pNf/3zzY7/XUuOWMfGFuUru3LgQthi+LegV9onqCN+jHa8PkPcQg0OJyM3OZTCAMAFFZgTorhkCLlH0H465xt5Y+C/+9LdeYjNTgy3nrJBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net; spf=pass smtp.mailfrom=alarsen.net; dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b=JlCKzFPq; arc=none smtp.client-ip=144.76.18.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alarsen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alarsen.net
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:c713:57f7:beab:ac7f])
	by joe.alarsen.net (Postfix) with ESMTPS id E7343181432;
	Thu, 29 Feb 2024 19:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1709230111; bh=f45qG9k9n+UrPSj5kSJLgLTC+jmEFstnN8C9k/JrcJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlCKzFPqCQqD6HSbPxMMwx+fepc4m7yxKrt6r6vUROeDFR4WwFydVhiYRXbq+njZQ
	 Ah/lZXf97yHlIIf6mwQbszUhapmkAey7U9g9E8g9RvOuWUIxiRRwSzKUvP03Xy19ev
	 kpHCrkT630xwSVVoumLXBs29OMylxdI7zb23RIyk=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id CFD24E4D;
	Thu, 29 Feb 2024 19:08:31 +0100 (CET)
From: Anders Larsen <al@alarsen.net>
To: linux-fsdevel@vger.kernel.org, Bill O'Donnell <bodonnel@redhat.com>
Cc: brauner@kernel.org, sandeen@redhat.com, Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [PATCH v2] qnx4: convert qnx4 to use the new mount api
Date: Thu, 29 Feb 2024 19:08:31 +0100
Message-ID: <2870477.mvXUDI8C0e@oscar>
In-Reply-To: <20240229161649.800957-1-bodonnel@redhat.com>
References: <20240229161649.800957-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On 2024-02-29 17:15 Bill O'Donnell wrote:
> Convert the qnx4 filesystem to use the new mount API.
> 
> Tested mount, umount, and remount using a qnx4 boot image.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> ---
> 
> v2: Remove redundant initialization of qs in qnx4_reconfigure().
> 
> ---
>  fs/qnx4/inode.c | 47 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 6eb9bb369b57..7b5711f76709 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/buffer_head.h>
>  #include <linux/writeback.h>
>  #include <linux/statfs.h>
> +#include <linux/fs_context.h>
>  #include "qnx4.h"
> 
>  #define QNX4_VERSION  4
> @@ -30,28 +31,33 @@ static const struct super_operations qnx4_sops;
> 
>  static struct inode *qnx4_alloc_inode(struct super_block *sb);
>  static void qnx4_free_inode(struct inode *inode);
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data);
>  static int qnx4_statfs(struct dentry *, struct kstatfs *);
> +static int qnx4_get_tree(struct fs_context *fc);
> 
>  static const struct super_operations qnx4_sops =
>  {
>  	.alloc_inode	= qnx4_alloc_inode,
>  	.free_inode	= qnx4_free_inode,
>  	.statfs		= qnx4_statfs,
> -	.remount_fs	= qnx4_remount,
>  };
> 
> -static int qnx4_remount(struct super_block *sb, int *flags, char *data)
> +static int qnx4_reconfigure(struct fs_context *fc)
>  {
> +	struct super_block *sb = fc->root->d_sb;
>  	struct qnx4_sb_info *qs;
> 
>  	sync_filesystem(sb);
>  	qs = qnx4_sb(sb);
>  	qs->Version = QNX4_VERSION;
> -	*flags |= SB_RDONLY;
> +	fc->sb_flags |= SB_RDONLY;
>  	return 0;
>  }
> 
> +static const struct fs_context_operations qnx4_context_opts = {
> +	.get_tree	= qnx4_get_tree,
> +	.reconfigure	= qnx4_reconfigure,
> +};
> +
>  static int qnx4_get_block( struct inode *inode, sector_t iblock, struct
> buffer_head *bh, int create ) {
>  	unsigned long phys;
> @@ -183,12 +189,13 @@ static const char *qnx4_checkroot(struct super_block
> *sb, return "bitmap file not found.";
>  }
> 
> -static int qnx4_fill_super(struct super_block *s, void *data, int silent)
> +static int qnx4_fill_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct buffer_head *bh;
>  	struct inode *root;
>  	const char *errmsg;
>  	struct qnx4_sb_info *qs;
> +	int silent = fc->sb_flags & SB_SILENT;
> 
>  	qs = kzalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
>  	if (!qs)
> @@ -216,7 +223,7 @@ static int qnx4_fill_super(struct super_block *s, void
> *data, int silent) errmsg = qnx4_checkroot(s, (struct qnx4_super_block *)
> bh->b_data); brelse(bh);
>  	if (errmsg != NULL) {
> - 		if (!silent)
> +		if (!silent)
>  			printk(KERN_ERR "qnx4: %s\n", errmsg);
>  		return -EINVAL;
>  	}
> @@ -235,6 +242,18 @@ static int qnx4_fill_super(struct super_block *s, void
> *data, int silent) return 0;
>  }
> 
> +static int qnx4_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, qnx4_fill_super);
> +}
> +
> +static int qnx4_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &qnx4_context_opts;
> +
> +	return 0;
> +}
> +
>  static void qnx4_kill_sb(struct super_block *sb)
>  {
>  	struct qnx4_sb_info *qs = qnx4_sb(sb);
> @@ -376,18 +395,12 @@ static void destroy_inodecache(void)
>  	kmem_cache_destroy(qnx4_inode_cachep);
>  }
> 
> -static struct dentry *qnx4_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> -{
> -	return mount_bdev(fs_type, flags, dev_name, data, qnx4_fill_super);
> -}
> -
>  static struct file_system_type qnx4_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "qnx4",
> -	.mount		= qnx4_mount,
> -	.kill_sb	= qnx4_kill_sb,
> -	.fs_flags	= FS_REQUIRES_DEV,
> +	.owner			= THIS_MODULE,
> +	.name			= "qnx4",
> +	.kill_sb		= qnx4_kill_sb,
> +	.fs_flags		= FS_REQUIRES_DEV,
> +	.init_fs_context	= qnx4_init_fs_context,
>  };
>  MODULE_ALIAS_FS("qnx4");

Acked-by: Anders Larsen <al@alarsen.net>




