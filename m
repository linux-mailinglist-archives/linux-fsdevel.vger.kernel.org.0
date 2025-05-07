Return-Path: <linux-fsdevel+bounces-48429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C8AAEDF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8103188CE70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC7E22D7BD;
	Wed,  7 May 2025 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaPmW32a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2322B8A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746653796; cv=none; b=oJWbBVvC13rplhKM21ymQmsb2VR539k+vIzrAk81uDM4X3usXybagSpLWgxdrR9ACQrHdB+Bqgf/DrU7yWFAcebVakjLmu+4WkfgvmUT41regV58j+cm5WbL37nFZpqFRfDy/OiQM3v8dfK8tLlVSGrtJix/0tNSEXt7lRA2bPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746653796; c=relaxed/simple;
	bh=rf1Gmwr6WthhJ4eu6zM0aOsriwhnXZ9Mu6TEWRFlGgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYTv0radxARsA96UOs2XkcbOT815sqP+kozr+n8CPxyfNNmWU4pUsr24pO/nXdqsvCmlhI6SFEdockySgy+jp0b8PrGQJp69XdHRvj7VIj2cRQa2jzvSDalOZgjQwNrXAbLK9AJimHPqXE9/+vklPJtLRMQiSG3z/sbCQgUXaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaPmW32a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA497C4CEE2;
	Wed,  7 May 2025 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746653796;
	bh=rf1Gmwr6WthhJ4eu6zM0aOsriwhnXZ9Mu6TEWRFlGgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaPmW32apFHwgWmFJ9h4cZxpOSCHIHJXPxRr0eRRusD6ZVS/14XoI0ktxt0dsd8Pt
	 Pz5pDLa0Zw2pMVCsMVMsc1pCuxevwlGVM00xh4I/CgZJQxnGyol9CehTCWhaTjAEgn
	 ZH/4aVXdHtxilbfR8RSyKpIUZLaem9HnrCk35jPG+7fdJGRdzEIsGuKWhh77/lam83
	 5XadviB+4FOCkff77rVllMQTa53MCO+sG7MIMuuQR8+Suf6U9Ut66ysL1L8XrlLqxd
	 ofFYofGmWSN+J0zhpawz2vPtuH5ZoyYGk4eTKE0qB0G3F002NPzHDwdLI3wdJf+xVG
	 UaAdKWmPmPe+w==
Date: Wed, 7 May 2025 21:36:33 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	chao@kernel.org, lihongbo22@huawei.com
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
Message-ID: <aBvSYa-0IxQREIUV@google.com>
References: <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
 <aBtyRFIrDU3IfQhV@google.com>
 <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>
 <aBu5CU7k0568RU6E@google.com>
 <e72e0693-6590-4c1e-8bb8-9d891e1bc5c0@redhat.com>
 <aBvCi9KplfQ_7Gsn@google.com>
 <f1674387-66d3-443f-8d48-74d8dfd111f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1674387-66d3-443f-8d48-74d8dfd111f1@redhat.com>

On 05/07, Eric Sandeen wrote:
> On 5/7/25 3:28 PM, Jaegeuk Kim wrote:
> >> But as far as I can tell, at least for the extent cache, remount is handled
> >> properly already (with the hunk above):
> >>
> >> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> >> # mount /dev/vdb mnt
> >> # mount -o remount,noextent_cache mnt
> >> mount: /root/mnt: mount point not mounted or bad option.
> >>        dmesg(1) may have more information after failed mount system call.
> >> # dmesg | tail -n 1
> >> [60012.364941] F2FS-fs (vdb): device aliasing requires extent cache
> >> #
> >>
> >> I haven't tested with i.e. blkzoned devices though, is there a testcase
> >> that fails for you?
> > I'm worrying about any missing case to check options enabled by default_options.
> > For example, in the case of device_aliasing, we rely on enabling extent_cache
> > by default_options, which was not caught by f2fs_check_opt_consistency.
> > 
> > I was thinking that we'd need a post sanity check.
> 
> I see. If you want a "belt and suspenders" approach and it works for
> you, no argument from me :)

Thanks. :)

I just found that I had to check it's from remount or not. And, this change does
not break my setup having a specific options. Let me queue the series back and
wait for further review from Chao.

---
 fs/f2fs/super.c | 54 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d89b9ede221e..0ee783224953 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1412,6 +1412,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (f2fs_sb_has_device_alias(sbi) &&
+			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
 		return -EINVAL;
@@ -1657,6 +1658,33 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	f2fs_apply_quota_options(fc, sb);
 }
 
+static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi, bool remount)
+{
+	if (f2fs_sb_has_device_alias(sbi) &&
+	    !test_opt(sbi, READ_EXTENT_CACHE)) {
+		f2fs_err(sbi, "device aliasing requires extent cache");
+		return -EINVAL;
+	}
+
+	if (!remount)
+		return 0;
+
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
@@ -2616,21 +2644,15 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
+	err = f2fs_sanity_check_options(sbi, true);
+	if (err)
 		goto restore_opts;
-	}
-#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -2663,12 +2685,6 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
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
@@ -4808,11 +4824,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	default_options(sbi, false);
 
 	err = f2fs_check_opt_consistency(fc, sb);
-	if (err < 0)
+	if (err)
 		goto free_sb_buf;
 
 	f2fs_apply_options(fc, sb);
 
+	err = f2fs_sanity_check_options(sbi, false);
+	if (err)
+		goto free_options;
+
 	sb->s_maxbytes = max_file_blocks(NULL) <<
 				le32_to_cpu(raw_super->log_blocksize);
 	sb->s_max_links = F2FS_LINK_MAX;
-- 
2.49.0.1015.ga840276032-goog


