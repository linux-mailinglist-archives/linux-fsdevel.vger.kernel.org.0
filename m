Return-Path: <linux-fsdevel+bounces-73920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E589ED24753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39AC4308BA48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7977395268;
	Thu, 15 Jan 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BNfncaCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298D38F244
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479936; cv=none; b=SzxGlxdjoy0WCyRb5Ff+Nv1GTdipmbBQffeG04yDm/TPwFljmKcUsUY1ssz+/CgQ7N52D8TIUT6F4zVDNK5VP0XsnsQuI9zuq9NyIsjP2SxXxzdQAMOZy75xbokiW8pWlWlzLxkUQp6wv5UxI6IlgOSKfU7Y6P49B7uTCqVLxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479936; c=relaxed/simple;
	bh=etPKXtHCKEvPTG4ROUavwgWdckq17JRZUEjh8R0kcaU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=i3Y73ihRqNGbCDk09xIeZnNeLWKcIQLEjv1Ji/6QKlE9D3TsEr3h1hNssuCDKnlkA9sRs9bKoz/Gh5Qmc4CfcDqM8/uyfePxWY14HXTl0k2jcrTqA/KM+l95ZGH2Tm8jsOnKF6wMSEVNZEAXJ7G461LFpbZLfN1c3DQsPwZoD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BNfncaCx; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3ec47e4c20eso646342fac.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768479930; x=1769084730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4FJZkv1O9333QAICtsYPXc5rbuwh1kULVRZezBOP4A=;
        b=BNfncaCxvdrX4YIejDrgKW1B795zI7dAm0uGvfUFW4cZpOewgQffLyY06qRzyya77A
         cARK4ZwQEy+G6BBNTC4N8yJ61IbnaJPmHBPW04nnWzNxPLb55M4T24647o1L6TwFDb6B
         a4ONT/rTxDITor64RNKnxhttCeM3R9Eem2DG45aDtE+Q3q6WoGK6K7nfNPRuBWpNrhkb
         uCSjYsMH6+i7M+JCNgeD4+icA5d64e/lSALf3ml2u/8Lcgn6fFxpvmTmJeKb9jBs0joB
         CfqvC9jnfknTQOe2pFcz6wkG8i2H0ICz22xJNw0KcYo1tyeAxAU2V218Kv81/CKGOuZs
         XJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479930; x=1769084730;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4FJZkv1O9333QAICtsYPXc5rbuwh1kULVRZezBOP4A=;
        b=U5vCzR+MCgAGKkIULRxrgD36FdetUZL7AvEyoGhDL6HFcdWs3RA5Z1+54+hxQJfkRG
         +x25FjwE46mhiAX+9WhER+nV09o2rF5YUj/kFugnkhJ3DNIqvj085cu9mRL/1iCiEWPJ
         0vCwVkRuQrV3cAbZP5zq6D2udNJsPpqoOl2sRAb7leXU7yMNMB4CvDJBD9I/uBjoOzWP
         TB1WGOTCof6YKnutzSvO6E5BR6TNBGXMaoXcHwzS4VfIWqDXy8N+I6/SpIPyqnoCoDN1
         J/LYjRgRg7u1iov679QuoBCCUu2PJPj6WJdfq0uH9IMgP203n0yMKIzUvcWDKEOHNdPc
         dyeA==
X-Gm-Message-State: AOJu0YxzVUhrqpXT6Zp52Wehec7eI7/zC0jGvCM2/rT4LPq/Q8205Srv
	XGh9yocidzRidrW8aln+Subz06u9QWb13xonc7Hg5YQPUij/Rio0xJfSjtHDmdKs/2tRKlDjvzD
	WMJYl
X-Gm-Gg: AY/fxX5ORAMCPYrAcU2t8KoglRtKuWfh6oQuLJzYiNkSsSiIp72ObSoXHmIE2wTS/BI
	LRjqOWtQDjeJpJsaE4Qmx2Cqx3Ru2wY7TzhW1CoXgrUn7YACRGAqyMmnDEukDRuQrGyjsEvNisb
	3j1yiiMBmSOgg20wUz0H3P6S6Haed4EwmSTo0r9bt0mSiPheUUWXheS0d2ZJmYChCmrwvbdSA29
	HSlapQr00HLOYqfY2j+jcF/pxUJc8O97DT1fVF9qt3keogcRdTAivzNrh8KX2sf6uvI5Ul77WIn
	nfIBF/ALVb7/x8NDsZM1WR9GULvZICkXkpzDb1AHsIvKUXcRPNSoKLM7v/645WreD8FbAbuk9Og
	VRvizTVBk7SzmvoqGuROQLUM9AG6XbjOCnKmGl4iGuxUuieBXKvBGYB8NFAw1qNC7A4VtjK8/NY
	+gv73lQxLG
X-Received: by 2002:a05:6870:478a:b0:3e7:d2b3:7a3 with SMTP id 586e51a60fabf-4040ba80820mr3306621fac.15.1768479929760;
        Thu, 15 Jan 2026 04:25:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40414c5d332sm3178044fac.20.2026.01.15.04.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 04:25:29 -0800 (PST)
Message-ID: <195c9525-281c-4302-9549-f3d9259416c6@kernel.dk>
Date: Thu, 15 Jan 2026 05:25:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fuse: use private naming for fuse hash size
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

With a mix of include dependencies, the compiler warns that:

fs/fuse/dir.c:35:9: warning: ?HASH_BITS? redefined
   35 | #define HASH_BITS       5
      |         ^~~~~~~~~
In file included from ./include/linux/io_uring_types.h:5,
                 from ./include/linux/bpf.h:34,
                 from ./include/linux/security.h:35,
                 from ./include/linux/fs_context.h:14,
                 from fs/fuse/dir.c:13:
./include/linux/hashtable.h:28:9: note: this is the location of the previous definition
   28 | #define HASH_BITS(name) ilog2(HASH_SIZE(name))
      |         ^~~~~~~~~
fs/fuse/dir.c:36:9: warning: ?HASH_SIZE? redefined
   36 | #define HASH_SIZE       (1 << HASH_BITS)
      |         ^~~~~~~~~
./include/linux/hashtable.h:27:9: note: this is the location of the previous definition
   27 | #define HASH_SIZE(name) (ARRAY_SIZE(name))
      |         ^~~~~~~~~

Hence rename the HASH_SIZE/HASH_BITS in fuse, by prefixing them with
FUSE_ instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..05ba065e4b40 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -32,9 +32,9 @@ struct dentry_bucket {
 	spinlock_t lock;
 };
 
-#define HASH_BITS	5
-#define HASH_SIZE	(1 << HASH_BITS)
-static struct dentry_bucket dentry_hash[HASH_SIZE];
+#define FUSE_HASH_BITS	5
+#define FUSE_HASH_SIZE	(1 << FUSE_HASH_BITS)
+static struct dentry_bucket dentry_hash[FUSE_HASH_SIZE];
 struct delayed_work dentry_tree_work;
 
 /* Minimum invalidation work queue frequency */
@@ -83,7 +83,7 @@ MODULE_PARM_DESC(inval_wq,
 
 static inline struct dentry_bucket *get_dentry_bucket(struct dentry *dentry)
 {
-	int i = hash_ptr(dentry, HASH_BITS);
+	int i = hash_ptr(dentry, FUSE_HASH_BITS);
 
 	return &dentry_hash[i];
 }
@@ -164,7 +164,7 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 	struct rb_node *node;
 	int i;
 
-	for (i = 0; i < HASH_SIZE; i++) {
+	for (i = 0; i < FUSE_HASH_SIZE; i++) {
 		spin_lock(&dentry_hash[i].lock);
 		node = rb_first(&dentry_hash[i].tree);
 		while (node) {
@@ -213,7 +213,7 @@ void fuse_dentry_tree_init(void)
 {
 	int i;
 
-	for (i = 0; i < HASH_SIZE; i++) {
+	for (i = 0; i < FUSE_HASH_SIZE; i++) {
 		spin_lock_init(&dentry_hash[i].lock);
 		dentry_hash[i].tree = RB_ROOT;
 	}
@@ -227,7 +227,7 @@ void fuse_dentry_tree_cleanup(void)
 	inval_wq = 0;
 	cancel_delayed_work_sync(&dentry_tree_work);
 
-	for (i = 0; i < HASH_SIZE; i++)
+	for (i = 0; i < FUSE_HASH_SIZE; i++)
 		WARN_ON_ONCE(!RB_EMPTY_ROOT(&dentry_hash[i].tree));
 }
 
-- 
Jens Axboe


