Return-Path: <linux-fsdevel+bounces-68350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1DC59696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00A0D5010C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902D35A157;
	Thu, 13 Nov 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4GW79O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EE35971E
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056747; cv=none; b=W6gYD867nu+rhSQSC2IVYXk6yFNKoMYk5FzB4EBM0DFA+GAajP2iu14maTKiQhG+o98orcIcW1v1jPuss51n8T9v1yK8XlZoHOYY2Tn1cz9sS/WJlrZt1MJrU2FXbaJmB8buzCDIV9NAUVXsD1plyMI7NAA6TKTkwpp4th6FZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056747; c=relaxed/simple;
	bh=6KDipog60jJRtdpe/L8UVeJv+BBHGlJ3knFNcVlyIQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKBY1EPz785Sjhv9uXJt+Gapjk87K/SLZUa35YMcR8S0z7g5xwjJQZa0DS3OT7jIBvjY4AG47qUCzvMEqMNrHR7VgDyFf37RiIuDQiRR456AbbI2kquB0XJBJQVOU47khaI3j74VESktfNRvU6L92WGu0L+A/CJl9EG3Fv0MEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4GW79O+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710022571cso11041385e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056740; x=1763661540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhulRitCHLk55X25ktDbKVFp9M47dlMqdu3BLv9Bbao=;
        b=i4GW79O+Fw9lEfa1HqRHPDOAI1Iy2DlBXuLrqlXnlfpm4UWcupKfQAQAhe4lCSrCcz
         HryRBXsqxBfKVI6aUuvwhjQfHBlgS1F2qiT9+P+LYIXOsiuJwaUupglQy6d14mcBIp2y
         UzIhFWR5NmgFOqUVnpyPQb4e3SwXya9nCOtrY+lIGXyPWWYRvrQOXLKGiJQTfELsq3YF
         hOlaaELum1J+GO0CL3c9Y2H6GfDsdvZwPlydSP07wygtsNRRtTsCOTs2GhoB7VeOadnO
         pgZ8TKj8xHP+KTjlh0+C9DPFd8RyV3vbTGZ6CDXWhmySEOk5Twc/dxyG6T4MjCirQRCz
         4HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056740; x=1763661540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhulRitCHLk55X25ktDbKVFp9M47dlMqdu3BLv9Bbao=;
        b=IImDcjHSaj6StogC4EXPyLCJOEU03drb7h1rQ9KOja6arQA5TbNyd+XjaWQwcGD05l
         MJ86aQhJwjpnA1JKSCi97AIC/zI7or8EIxIU9z/X6sMk33/oZs146zmezFigmVtMl4QU
         +0tC+eW6qTyyzMue+yGo8auHVCgb1cNz2VngJCMkUI1PLWuopPzbdz+zdGX0RpXb0smA
         nYSJlTnVBlcDssfiQtOP3EIDnn0K+CRZnMdDZG5Te8aOztYjE1cglb9DMSev4tDVnRj9
         Oa1hlnJjuQT4Qt0IYEj8D36RVFfVvhbkPfrpfRz7NVRbvpZCqjhLBmpMs2XeMdSl5JSG
         wKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTMcPx2ckf/XTMHfK9/b9/jwNHBSNggrXX9GesCNnaVKdBFSDm8A1LKIjQ9t30l/sxA5/GaRNirjzl+xFx@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+UZjhkHyLpN8oJwqFVEyeuM0o4mIauicx8TUQ+HhMKcmktq5
	WhOkKTlJs3tojKqh0MCInkIUndcoSSWl2MEJCBYim6+825SrJVgmlCx6
X-Gm-Gg: ASbGnctQbJbljjvXCK5eppPjJZtXmxMVCV6eSBpA4z0WzZM1q7CLoL/1HCuNYW0Wgnc
	/yOWEy630dXEeRqK5gyrKSL7JSckyImHAoN20WIuWJRpxj77gRkBJGhJ9VhBDK2o1wq+C8WeCk5
	nnWXLETMBak4FmMVaOKgIo9LuXMFCe4wrymad+KcfcOUt6ao+LlQ2IYnmPah88HKnhZ8FEbcJnZ
	BeUZFsiMx1Nkcsaf7SI+BBxe4UsjqWT3m4gzwkyHcP7qJUFieJqnv7xTegdftmqR2SuJW5kHp29
	xTMa6TbIqa+1U+Pl/mSOXMiq6SUbnNu6KbmGcjrUj641A2AjH4EXtPiDayTb49fEXeJWzH0r8V7
	AwGL2YTguNLTAanCQB8sghuzOOemx2M/09i9fTz4DzIJ0ZUmTyt//4ejAA2h7/QNMsVzh9UBdHd
	VM4n+zPLsJOAXhIPL8NAheq+Kk13+PRwYNTSyMFtqaDjUmOeyL
X-Google-Smtp-Source: AGHT+IGTzdGiyvCT86uYe5CN+05Q9cy2uQL9eBgPXgJR513IAeBmeM4GOHih8eh/jELZCKZbBGNffw==
X-Received: by 2002:a05:600c:354b:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4778fea1239mr3513065e9.27.1763056739674;
        Thu, 13 Nov 2025 09:58:59 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm98888575e9.12.2025.11.13.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:58:59 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	jlayton@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/2] fs: track the inode having file locks with a flag in ->i_opflags
Date: Thu, 13 Nov 2025 18:58:51 +0100
Message-ID: <20251113175852.2022230-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113175852.2022230-1-mjguzik@gmail.com>
References: <20251113175852.2022230-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opening and closing an inode dirties the ->i_readcount field.

Depending on the alignment of the inode, it may happen to false-share
with other fields loaded both for both operations to various extent.

This notably concerns the ->i_flctx field.

Since most inodes don't have the field populated, this bit can be managed
with a flag in ->i_opflags instead which bypasses the problem.

Here are results I obtained while opening a file read-only in a loop
with 24 cores doing the work on Sapphire Rapids. Utilizing the flag as
opposed to reading ->i_flctx field was toggled at runtime as the benchmark
was running, to make sure both results come from the same alignment.

before: 3233740
after:  3373346 (+4%)

before: 3284313
after:  3518711 (+7%)

before: 3505545
after:  4092806 (+16%)

Or to put it differently, this varies wildly depending on how (un)lucky
you get.

The primary bottleneck before and after is the avoidable lockref trip in
do_dentry_open().

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

no changes, rebased on top of https://lore.kernel.org/linux-fsdevel/20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org/

 fs/locks.c               | 14 ++++++++++++--
 include/linux/filelock.h | 15 +++++++++++----
 include/linux/fs.h       |  1 +
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 7f4ccc7974bc..b58f7d65f1a9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -178,7 +178,6 @@ locks_get_lock_context(struct inode *inode, int type)
 {
 	struct file_lock_context *ctx;
 
-	/* paired with cmpxchg() below */
 	ctx = locks_inode_context(inode);
 	if (likely(ctx) || type == F_UNLCK)
 		goto out;
@@ -196,7 +195,18 @@ locks_get_lock_context(struct inode *inode, int type)
 	 * Assign the pointer if it's not already assigned. If it is, then
 	 * free the context we just allocated.
 	 */
-	if (cmpxchg(&inode->i_flctx, NULL, ctx)) {
+	spin_lock(&inode->i_lock);
+	if (!(inode->i_opflags & IOP_FLCTX)) {
+		VFS_BUG_ON_INODE(inode->i_flctx, inode);
+		WRITE_ONCE(inode->i_flctx, ctx);
+		/*
+		 * Paired with locks_inode_context().
+		 */
+		smp_store_release(&inode->i_opflags, inode->i_opflags | IOP_FLCTX);
+		spin_unlock(&inode->i_lock);
+	} else {
+		VFS_BUG_ON_INODE(!inode->i_flctx, inode);
+		spin_unlock(&inode->i_lock);
 		kmem_cache_free(flctx_cache, ctx);
 		ctx = locks_inode_context(inode);
 	}
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index dc15f5427680..4a8912b9653e 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -242,8 +242,12 @@ static inline struct file_lock_context *
 locks_inode_context(const struct inode *inode)
 {
 	/*
-	 * Paired with the fence in locks_get_lock_context().
+	 * Paired with smp_store_release in locks_get_lock_context().
+	 *
+	 * Ensures ->i_flctx will be visible if we spotted the flag.
 	 */
+	if (likely(!(smp_load_acquire(&inode->i_opflags) & IOP_FLCTX)))
+		return NULL;
 	return READ_ONCE(inode->i_flctx);
 }
 
@@ -471,7 +475,7 @@ static inline int break_lease(struct inode *inode, unsigned int mode)
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
-	flctx = READ_ONCE(inode->i_flctx);
+	flctx = locks_inode_context(inode);
 	if (!flctx)
 		return 0;
 	smp_mb();
@@ -490,7 +494,7 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	 * could end up racing with tasks trying to set a new lease on this
 	 * file.
 	 */
-	flctx = READ_ONCE(inode->i_flctx);
+	flctx = locks_inode_context(inode);
 	if (!flctx)
 		return 0;
 	smp_mb();
@@ -535,8 +539,11 @@ static inline int break_deleg_wait(struct delegated_inode *di)
 
 static inline int break_layout(struct inode *inode, bool wait)
 {
+	struct file_lock_context *flctx;
+
 	smp_mb();
-	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease)) {
+	flctx = locks_inode_context(inode);
+	if (flctx && !list_empty_careful(&flctx->flc_lease)) {
 		unsigned int flags = LEASE_BREAK_LAYOUT;
 
 		if (!wait)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a312700dfce2..867f967719a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -656,6 +656,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_MGTIME		0x0020
 #define IOP_CACHED_LINK		0x0040
 #define IOP_FASTPERM_MAY_EXEC	0x0080
+#define IOP_FLCTX		0x0100
 
 /*
  * Inode state bits.  Protected by inode->i_lock
-- 
2.48.1


