Return-Path: <linux-fsdevel+bounces-12123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3C85B646
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02301F220B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AA664D4;
	Tue, 20 Feb 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QISnZzZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD5664C3;
	Tue, 20 Feb 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419206; cv=none; b=esyfv2qDDum43G9gNPyoa+hZgWre4MAoCgZIle1Ag94CKDe1jEsmDs3aAxReYOj6z8LKU4XQ0NhiMAf9u8URYiIdlnpEm1hArZq5ijo8yuVvKSecrPF+egnblmFyT4s/1i+Yb7oOjEEgBSvL0dP/XgN3jZRmLovYvDGzkTAsyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419206; c=relaxed/simple;
	bh=PJX9nxRLEeoQwdUnmOqN3H2dctwppjpelMENczAYtJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlK9GM4kyJ/eZEu1ngOZCB8LXM8QnH1lz2C0CpupzqSktWggF7eZghgsn/UcVznI5+OZoLBIe1+988T+peCPxMyptz8ge12YXAyevnCoDdErguXsxDE0+2veZxBswVZytczhhyPlqJqq7z2wcoIlfZ1ebo3SKAJbnI3rt4zTGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QISnZzZ7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419202;
	bh=PJX9nxRLEeoQwdUnmOqN3H2dctwppjpelMENczAYtJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QISnZzZ7KXVGg1T7oPWsyGpge3L8xRwxFPHEU8reETwgOv3wT68lfYY0n71LieToc
	 teQ2of1OPiELpnTUYlZojXRftIMXGdx+MOlrimcQLKwzgI9+XCV1tT0apbTZwGL08N
	 VfW3i6DbE/S2jPaiVGjNfDgYwrLeePKdTsg+wUe6xxy7nc7EEuiGgidc+Q19BgDU/l
	 h4UBJE/usHSrJ01gILnP8cuJtVCLgBlr6c32kdK9lEYocJoGXGFBh0hdg+WO/YODv3
	 1PR9g9EB6gz/pMt6vvS3+XaEIsNUAOXT8G12T6aYTG3qMP2DN9c1M1QN5vbMPiNPei
	 IHGG5dcC8XQIQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 027D837820A1;
	Tue, 20 Feb 2024 08:53:18 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH v12 8/8] f2fs: Move CONFIG_UNICODE defguards into the code flow
Date: Tue, 20 Feb 2024 10:52:35 +0200
Message-Id: <20240220085235.71132-9-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220085235.71132-1-eugen.hristev@collabora.com>
References: <20240220085235.71132-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
[eugen.hristev@collabora.com: port to 6.8-rc3]
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/namei.c | 10 ++++------
 fs/f2fs/super.c |  8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ba11298b7837..c317bfd1c344 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -577,8 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -587,7 +586,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		trace_f2fs_lookup_end(dir, dentry, ino, err);
 		return NULL;
 	}
-#endif
+
 	new = d_splice_alias(inode, dentry);
 	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
 				ino, IS_ERR(new) ? PTR_ERR(new) : err);
@@ -640,16 +639,15 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at f2fs_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
+
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b718bebfaa1..07c54981cb6b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -312,7 +312,7 @@ struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
-							F2FS_NAME_LEN);
+						   F2FS_NAME_LEN);
 	return f2fs_cf_name_slab ? 0 : -ENOMEM;
 }
 
@@ -1360,13 +1360,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (f2fs_sb_has_casefold(sbi)) {
+
+	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
-#endif
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
-- 
2.34.1


