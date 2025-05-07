Return-Path: <linux-fsdevel+bounces-48415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2FAAEC6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 21:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843994E6D2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907628C5D2;
	Wed,  7 May 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NndCIQPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956C20296E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647308; cv=none; b=ab1AdCmJYhtcUKJkdxbXF91RlgttMIIxn4tdqyLk8WZiQpQUcCNpyuFUgUe6HrWfqR0jaWX66GtkM+MbXSsbraJ7aE49AcB+iAKYAPGPtr3wweBSTfJDKBl2nkL71ubcT4Z/n85AMffzYsp5qEAhXFOYxGkbPRHwumV41WAnqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647308; c=relaxed/simple;
	bh=IInMCkeGYS3yNEyOzWr9WG7voW4M0XSBolMzIpmCnhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4EScOunC2Uo/KTBUJ5jjUURLPU5izlXr/1Up0xO5/xAXq1WO9MqjrkUHLssCjFaPDMZLE8vwWDgcKp7aMqVSIfV6ezw4+ih5TRQJQPrYGe/jcrror/0U/uXyRhh0XcsiLvagts8/4zOZ2S0S7HJPFsOCY/2GSikyFB5Ch3P/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NndCIQPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E64EC4CEE2;
	Wed,  7 May 2025 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647307;
	bh=IInMCkeGYS3yNEyOzWr9WG7voW4M0XSBolMzIpmCnhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NndCIQPI75HxXCIVO19XKIjnEtQwSzDSW+HWwVEv3jN1m39v/DAKvJ7ttujUWdvXS
	 0wMAipzJYktCkj28fIrArRwjWf7ZqVlTVXQlLbsJ0B4IUC6ny/l2D1UrhCOLBzU/sp
	 EltSw3pZctGZSphre1pqr7iJ2Y+831sTYnrQVBDgHFXJfOg9NGgTDivlpjIRuK8kVj
	 2s38NdBdRQZhTOdEf5OfWwHEnC7lRa9sHcgYrjNOIzF7i7KfhcoisomfngDNm7dlCs
	 C2nOSebvaExJQ41jZf3/dwqqjEmKcenj3kTr9x82EZeGT34Tw1uVmqU2iwAypWpx4i
	 tilUdjaZM8qqQ==
Date: Wed, 7 May 2025 19:48:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBu5CU7k0568RU6E@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
 <aBtyRFIrDU3IfQhV@google.com>
 <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>

On 05/07, Eric Sandeen wrote:
> On 5/7/25 9:46 AM, Jaegeuk Kim wrote:
> 
> > I meant:
> > 
> > # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> > # mount /dev/vdb mnt
> > 
> > It's supposed to be successful, since extent_cache is enabled by default.
> 
> I'm sorry, clearly I was too sleepy last night. This fixes it for me.
> 
> We have to test the mask to see if the option was explisitly set (either
> extent_cache or noextent_cache) at mount time.
> 
> If it was not specified at all, it will be set by the default f'n and
> remain in the sbi, and it will pass this consistency check.
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d89b9ede221e..e178796ce9a7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1412,7 +1414,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>  	}
>  
>  	if (f2fs_sb_has_device_alias(sbi) &&
> -			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
> +			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
> +			 !ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
>  		f2fs_err(sbi, "device aliasing requires extent cache");
>  		return -EINVAL;
>  	}

I think that will cover the user-given options only, but we'd better check the
final options as well. Can we apply like this?

---
 fs/f2fs/super.c | 50 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d89b9ede221e..270a9bf9773d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1412,6 +1412,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (f2fs_sb_has_device_alias(sbi) &&
+			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
 		return -EINVAL;
@@ -1657,6 +1658,29 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	f2fs_apply_quota_options(fc, sb);
 }
 
+static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_sb_has_device_alias(sbi) &&
+	    !test_opt(sbi, READ_EXTENT_CACHE)) {
+		f2fs_err(sbi, "device aliasing requires extent cache");
+		return -EINVAL;
+	}
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_has_blkzoned(sbi) &&
+	    sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+#endif
+	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
+		f2fs_warn(sbi, "LFS is not compatible with IPU");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
@@ -2616,21 +2640,15 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	default_options(sbi, true);
 
 	err = f2fs_check_opt_consistency(fc, sb);
-	if (err < 0)
+	if (err)
 		goto restore_opts;
 
 	f2fs_apply_options(fc, sb);
 
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi) &&
-		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
-		f2fs_err(sbi,
-			"zoned: max open zones %u is too small, need at least %u open zones",
-				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
-		err = -EINVAL;
+	err = f2fs_sanity_check_options(sbi);
+	if (err)
 		goto restore_opts;
-	}
-#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -2663,12 +2681,6 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 		}
 	}
 #endif
-	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
-		err = -EINVAL;
-		f2fs_warn(sbi, "LFS is not compatible with IPU");
-		goto restore_opts;
-	}
-
 	/* disallow enable atgc dynamically */
 	if (no_atgc == !!test_opt(sbi, ATGC)) {
 		err = -EINVAL;
@@ -4808,11 +4820,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	default_options(sbi, false);
 
 	err = f2fs_check_opt_consistency(fc, sb);
-	if (err < 0)
+	if (err)
 		goto free_sb_buf;
 
 	f2fs_apply_options(fc, sb);
 
+	err = f2fs_sanity_check_options(sbi);
+	if (err)
+		goto free_options;
+
 	sb->s_maxbytes = max_file_blocks(NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-- 
2.49.0.1015.ga840276032-goog


