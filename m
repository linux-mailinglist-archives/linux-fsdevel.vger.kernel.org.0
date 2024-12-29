Return-Path: <linux-fsdevel+bounces-38253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC49FE0E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBB161BA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB572594BE;
	Sun, 29 Dec 2024 23:46:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [92.204.81.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8319939D
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735515993; cv=none; b=ZZJsmli0GgGd9F06D5LCm/RiKiNkL/krMgoMAsxEsUDjQqGQ+mQ7esS/Jra3YXPTvPo629GNFp7tw5Vn2ubw9AGeG3J0FEHW61pLV1ZPCfy4uHe4PXOwPh6yv9L1zm+vxA36I8eBsKLayfohrzhg6o2kVKHu9iA/e9fwZ5qN0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735515993; c=relaxed/simple;
	bh=7h17NvmeBVfmvRhFrDSw49oLJIF/d9PDoPZ8iQfKR3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/EmbdcGEr3zXCxelhmUXP2B7F2cU+aUQf8FkvTuGV7MUnqVthj5yWl5RmOR7HAqzTsKl1EQJGUVx3/EXl8AwKlTZPfwVK4BdKJVelRha9uaZ3sd0O6bh145srG8mvZXAEY/xBq8wgCcldvg5PdLg6BDx6Mp72Ec/OYYFrGkkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from raspberrypi.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id S2rotGQTRxZ1ZS2rxtFiTi; Sun, 29 Dec 2024 16:38:50 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6771dd8b
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=T0oYn0MT_amATRHXiuYA:9 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 1/4] squashfs: make squashfs_cache_init() return ERR_PTR(-ENOMEM)
Date: Sun, 29 Dec 2024 23:37:49 +0000
Message-Id: <20241229233752.54481-2-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241229233752.54481-1-phillip@squashfs.org.uk>
References: <20241229233752.54481-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE/udWkNi1AjlSTQMXTQa5ounKeB2YssuS7Nn/5fe27ETjX9cdHx+kWs+5dgxv5vZtYeIoWTLf99lBR15bb8yNE1e8c/n5YZRPsKhavOQYA5447TQUjJ
 bE07yaYY986n/PDt89wTXC9rNd4vtOm/9h/P0bz7Ff220Tbc69fIgiH5+pOKdowSFJSoTWRWg7xLeSRNFitPHfT2ARxDoHgC8Tg4JiZLHR0FWxLpwxU9eZ6A
 7ral6O4wXNswrH+HbAmWZSuq/vNhH6q7rtZIvZ5fsszJaP1TiM/MC7XEAPboMEAcCOSTXYn1nJPD9PnawSWBIpm0aWWyaqgWuIuQHcinbJY=

Make squashfs_cache_init() return an ERR_PTR(-ENOMEM) on failure rather
than NULL.

This tidies up some calling code, but, it also allows NULL to be returned
as a valid result when a cache hasn't be allocated.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/cache.c | 10 +++++++---
 fs/squashfs/super.c | 17 ++++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 5062326d0efb..4db0d2b0aab8 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -224,11 +224,15 @@ struct squashfs_cache *squashfs_cache_init(char *name, int entries,
 	int block_size)
 {
 	int i, j;
-	struct squashfs_cache *cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+	struct squashfs_cache *cache;
 
+	if (entries == 0)
+		return NULL;
+
+	cache = kzalloc(sizeof(*cache), GFP_KERNEL);
 	if (cache == NULL) {
 		ERROR("Failed to allocate %s cache\n", name);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	cache->entry = kcalloc(entries, sizeof(*(cache->entry)), GFP_KERNEL);
@@ -281,7 +285,7 @@ struct squashfs_cache *squashfs_cache_init(char *name, int entries,
 
 cleanup:
 	squashfs_cache_delete(cache);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 269c6d61bc29..fedae8dbc5de 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -314,26 +314,29 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_RDONLY;
 	sb->s_op = &squashfs_super_ops;
 
-	err = -ENOMEM;
-
 	msblk->block_cache = squashfs_cache_init("metadata",
 			SQUASHFS_CACHED_BLKS, SQUASHFS_METADATA_SIZE);
-	if (msblk->block_cache == NULL)
+	if (IS_ERR(msblk->block_cache)) {
+		err = PTR_ERR(msblk->block_cache);
 		goto failed_mount;
+	}
 
 	/* Allocate read_page block */
 	msblk->read_page = squashfs_cache_init("data",
 		msblk->max_thread_num, msblk->block_size);
-	if (msblk->read_page == NULL) {
+	if (IS_ERR(msblk->read_page)) {
 		errorf(fc, "Failed to allocate read_page block");
+		err = PTR_ERR(msblk->read_page);
 		goto failed_mount;
 	}
 
 	if (msblk->devblksize == PAGE_SIZE) {
 		struct inode *cache = new_inode(sb);
 
-		if (cache == NULL)
+		if (cache == NULL) {
+			err = -ENOMEM;
 			goto failed_mount;
+		}
 
 		set_nlink(cache, 1);
 		cache->i_size = OFFSET_MAX;
@@ -406,8 +409,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->fragment_cache = squashfs_cache_init("fragment",
 		min(SQUASHFS_CACHED_FRAGMENTS, fragments), msblk->block_size);
-	if (msblk->fragment_cache == NULL) {
-		err = -ENOMEM;
+	if (IS_ERR(msblk->fragment_cache)) {
+		err = PTR_ERR(msblk->fragment_cache);
 		goto failed_mount;
 	}
 
-- 
2.39.5


