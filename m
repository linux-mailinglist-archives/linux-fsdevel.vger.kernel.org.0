Return-Path: <linux-fsdevel+bounces-71179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C725CCB7E3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 172B9300A548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 04:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E530DD3C;
	Fri, 12 Dec 2025 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="FIlbv5n/";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="4YqcHzy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3977293B75;
	Fri, 12 Dec 2025 04:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514884; cv=none; b=a/cNpY2+s59WS9kUtzNt5lQrJJeAlv28B8KSn/5XEBqqumJL+YcpYlg09/CuDgMUmOsYSO68pjBHTi0TtBJ+VNp0RX3tkzDclAvws7jmXSMChgsteTtbhHLaHsyI0viKtVCsJnd/GnnfhbYtXUmBqB9126Of7TgomixK0AyF7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514884; c=relaxed/simple;
	bh=oQ8Y/kMyCZ0dLJ/9krMxJ/+XBVev2UaK8gqT8RwfncM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbKdfonUz1/XburakJpdUjMOTLVeovH20dBJLc+IryCemnP0OZo4uVYeQ8+MpY5ac2Hxm/UzWKI+g3AMjSHnJee/zy4OArstJKpK9BM96RAO68Y2VQ7Z3PfSvYBoFaEI7BIkSEBrAPQuBp2qjx9m9wZVUa3pbBv1QjBQmNc+UAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=FIlbv5n/; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=4YqcHzy3; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4070026F765C;
	Fri, 12 Dec 2025 13:42:11 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1765514531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KHUgoQ5/iS4L3w4t0awN2lvE3rami5HzYGmoGr9mno=;
	b=FIlbv5n/6G0Og2UzN4e1TukLC2pBNdrzakiMUXZz0M3Kx3+JDdhvn5jCWDSn32dRC990pi
	lc9caIGfbYVyiTOZk4NPEvR/AKcPvLDHdbaGNdYVP8uGSbq+OVd2Xlhotb5dPGBHXYXGdR
	7JV7+jT9ZHxcpaT1o/eTK60QJFfCL1XinewS3gLTqVL6iv1eX7HyLqSUY2uSWKnUR9g2RN
	RdrWpRBj7mRaVkvnM9BUkkZDktg1+WnFC60jecexhRm9dlQokE543FRzkUfr9j2zwszI4q
	VtyX6hzN1oIawaPIM8OawkLeK4hSqcXtYPKYNomGZ7eNnT8JXNfQaaq7fb2+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1765514531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KHUgoQ5/iS4L3w4t0awN2lvE3rami5HzYGmoGr9mno=;
	b=4YqcHzy3bRXfr2dUPwYAFZTXwVEtwQqvyxQK4rzTHBwD6jMGFqnnr7QyAzeoVd6Us/w9cp
	mjz5UrYK5kkHe+AQ==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5BC4gAIx217415
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 13:42:11 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5BC4g9pw841740
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 13:42:09 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 5BC4g8RO841739;
	Fri, 12 Dec 2025 13:42:08 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        almaz.alexandrovich@paragon-software.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de,
        Chuck Lever
 <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/6] fat: Implement fileattr_get for case sensitivity
In-Reply-To: <20251211152116.480799-3-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
	<20251211152116.480799-3-cel@kernel.org>
Date: Fri, 12 Dec 2025 13:42:08 +0900
Message-ID: <87v7icl3a7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chuck Lever <cel@kernel.org> writes:

> From: Chuck Lever <chuck.lever@oracle.com>
>
> Report FAT's case sensitivity behavior via the new file_kattr
> case_info field. FAT filesystems are case-insensitive and do not
> preserve case at rest (stored names are uppercased).
>
> The case folding type depends on the mount options: when utf8 is
> enabled, Unicode case folding is used; otherwise ASCII case folding.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

I can't see the who and how to use this though, in msdos case, looks
like this should check "nocase" option.

Thanks.

> ---
>  fs/fat/fat.h         |  3 +++
>  fs/fat/file.c        | 18 ++++++++++++++++++
>  fs/fat/namei_msdos.c |  1 +
>  fs/fat/namei_vfat.c  |  1 +
>  4 files changed, 23 insertions(+)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index d3e426de5f01..38da08d8fec4 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -10,6 +10,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  
> +struct file_kattr;
> +
>  /*
>   * vfat shortname flags
>   */
> @@ -407,6 +409,7 @@ extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
>  extern int fat_getattr(struct mnt_idmap *idmap,
>  		       const struct path *path, struct kstat *stat,
>  		       u32 request_mask, unsigned int flags);
> +extern int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
>  extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
>  			  int datasync);
>  
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 4fc49a614fb8..123f4c1efdf4 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -16,6 +16,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/security.h>
>  #include <linux/falloc.h>
> +#include <linux/fileattr.h>
>  #include "fat.h"
>  
>  static long fat_fallocate(struct file *file, int mode,
> @@ -395,6 +396,22 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
>  	fat_flush_inodes(inode->i_sb, inode, NULL);
>  }
>  
> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> +
> +	/*
> +	 * FAT filesystems do not preserve case: stored names are
> +	 * uppercased. They are case-insensitive, using either ASCII
> +	 * or Unicode comparison depending on mount options.
> +	 */
> +	fa->case_info = sbi->options.utf8 ?
> +		FILEATTR_CASEFOLD_UNICODE : FILEATTR_CASEFOLD_ASCII;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fat_fileattr_get);
> +
>  int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
>  		struct kstat *stat, u32 request_mask, unsigned int flags)
>  {
> @@ -574,5 +591,6 @@ EXPORT_SYMBOL_GPL(fat_setattr);
>  const struct inode_operations fat_file_inode_operations = {
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 0b920ee40a7f..380add5c6c66 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -640,6 +640,7 @@ static const struct inode_operations msdos_dir_inode_operations = {
>  	.rename		= msdos_rename,
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };
>  
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 5dbc4cbb8fce..6cf513f97afa 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1180,6 +1180,7 @@ static const struct inode_operations vfat_dir_inode_operations = {
>  	.rename		= vfat_rename2,
>  	.setattr	= fat_setattr,
>  	.getattr	= fat_getattr,
> +	.fileattr_get	= fat_fileattr_get,
>  	.update_time	= fat_update_time,
>  };

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

