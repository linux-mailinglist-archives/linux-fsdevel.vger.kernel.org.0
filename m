Return-Path: <linux-fsdevel+bounces-70545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435FC9E93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41442349937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A752E11C7;
	Wed,  3 Dec 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpftLkTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0842E0924
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755331; cv=none; b=Feq3mTPX1TAE4W5tcrTSkFWZGW4smcvXQsWKQJIQNtGO4Y/iHCr3A4Xdp+taBxB0iBPsVivjm2f1lGv8su4+tLUViEYeUCvoYMwyAITRKfw6VmVOfkxv5BSddBJt3pfADROQhKMqC+1KHBtHsJnwj1oz9rEew7A/y9YHhsDQHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755331; c=relaxed/simple;
	bh=vHSgsHxd+j0S3DehVoM3Pol/Lt8pmnytid2IwqfB6YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0KNhRKymyjC+gbsMZvPgfPFlx+Q5Iw4lKLL3o1zRnOyLCuI8EmhPVgv7m5BdspcF38ITqvwZWn0ef0O3tFY/7J5FwEKEpqFqA1pyWo1i6nrIjftsOA/+V2uYpDwdFteY+XbkpLw7MW+qyurZsF/Tc5JlfFB73CLoPolSkaqKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpftLkTR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7633027cb2so988985266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764755325; x=1765360125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWEe6E7kY036NNeOydAjfClB9oAoxEJ+UkZpb0fwzDw=;
        b=ZpftLkTRb8pAqWIGvNK88Y2hbW1ChSoalPw6kBRZCQrnLO+J5kyVnK1JBbY+HF9og0
         oUtjNHXhTEAqJZELvyrxju1qhWJEu/BxiQ7R2tZmdULs9B3U/hwsFH6N2k6uvhNgnsBX
         +Jd3DorOekDFhD36bbfvBflJwZUxFE63mu5BuEnL/MhZBLdtGlKLzgbNdHX2t25OLhjV
         FSTYUCSeXhyukM6+pb6Om812wpJozMrqIqh1mMj3ecSBdwOoyzhQF1JETGf/2gT+DI9V
         Yam+9eqn2luAYLJBkVfWIAxsJj/mZF2FSW9FGUNwo0IigcN6CHqBJiomz9lNAOsRc3Rm
         2pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755325; x=1765360125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWEe6E7kY036NNeOydAjfClB9oAoxEJ+UkZpb0fwzDw=;
        b=HTTJwrl9G7luBVVyexP21Wf8rf6FZ/MKjVdbMbZHNEOf6LiaSi5zXWsq29JhzfUrj/
         UmSg+S49otPJtEv/dUqQ6HgAbtabfbtQeNo3qWOAXPbE6r3rlXLrG3z+vww7Ks2RHwIp
         aXFZc+w4y6Hi5KjTlRt3YfRtczbVHqpWUxoadnzS0dPnkWAjWjT5oBJW5wdTFgVuPBOw
         0+BZ0i12oKqEIYSUkZBgDTQVjXiL31tuMhgwqLJQe/UkqflwNNiuh3VKFzgyl7Uw48NX
         wM+o730F4fBQfXl74E4z1vwskJATwHK6LqD69k80C60tSWy/3SfsPg/ctifcNtNGjjW/
         t9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRJTVsQqJpDWi2XYICMQErY5P5bvpdvCdWArlR7gwuTHcn7s+tutcbFenYotjZrymxyV+Itf7IF1M/k1Hm@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhSHCBVove1HvQYW98/7/1hdvTaDf1E1/H+0A3uNzck+2Y/tM
	feIUmvxfTTh+luqc+tLKAEqupsaaORDwNBy5KnUOUT8Al4CsNEOUIi48
X-Gm-Gg: ASbGncsDfnn38CR/x2lHR2mx4zmFZ1WGZ7cmSR9W5BevZndkj5IDHS6ecteh7jVvAGj
	U/H4nAtk1FaF4wDTxyQQrarLIuyHbUJ9DGvH2p4IeiR7dv8dVPRJf37df1YRy87d9wMvOiUvVbf
	fWdUzsU1uFtQzWvqAB85XtYQd5VdEXJBl1MK3pfN+seEOYPLAXnf+yXaZhNaiAzCcua43yqFoja
	RnyPPfbPzxyEnFnLSXlqvHl0aUzOVxZvkrhOfgXZiDNP7g8CPpXrnWuV/eJA00/BAE2p1jt4V0B
	puD8E6KPliUlmNA8pvSDYk0IniH6BFT3OhNWbVMo1gvMpBxJQjydqZQWjnXQBwZgYeObQFlRSt+
	wbY/Vylo/bo5XLBQr43JENStV5hYXk1v9crXR+xRZPryMqJcTMMGmqBlQBzMN+y3G7Ui1lNdpOf
	73NfLiD9PWZXYH5ly0iqp5OnUjbhF3ugQnG0cyXfqFreXxU15HTPirTREiuyA=
X-Google-Smtp-Source: AGHT+IENmccYJBAs3VEPI5Kdejm4ZodPqOPyP4J6UpUjSv3xkEttJriw6FgQYZ4MjjNJWSoQCzLYTA==
X-Received: by 2002:a17:907:6ea1:b0:b76:7b85:f630 with SMTP id a640c23a62f3a-b79dc51a4c1mr152463566b.34.1764755324873;
        Wed, 03 Dec 2025 01:48:44 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a4a652sm1779148366b.65.2025.12.03.01.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:48:44 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 2/2] fs: track the inode having file locks with a flag in ->i_opflags
Date: Wed,  3 Dec 2025 10:48:37 +0100
Message-ID: <20251203094837.290654-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203094837.290654-1-mjguzik@gmail.com>
References: <20251203094837.290654-1-mjguzik@gmail.com>
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

- no changes, this is a resend of v3, which is already rebased on
  everything

 fs/locks.c               | 14 ++++++++++++--
 include/linux/filelock.h | 15 +++++++++++----
 include/linux/fs.h       |  1 +
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9f565802a88c..7a63fa3ca9b4 100644
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
index 04ceeca12a0d..094b0adcb035 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -631,6 +631,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_MGTIME		0x0020
 #define IOP_CACHED_LINK		0x0040
 #define IOP_FASTPERM_MAY_EXEC	0x0080
+#define IOP_FLCTX		0x0100
 
 /*
  * Inode state bits.  Protected by inode->i_lock
-- 
2.48.1


