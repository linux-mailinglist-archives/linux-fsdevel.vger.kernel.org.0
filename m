Return-Path: <linux-fsdevel+bounces-20081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC458CDF90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C3B21D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 02:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915A2AD38;
	Fri, 24 May 2024 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdM1qTRO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E323D2;
	Fri, 24 May 2024 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519012; cv=none; b=lIvN4yQUCfLbTMwyi1RdzQgcbTc9pqDsMkPKap3Jiv1CNLLNVZKyYAUyP4wGsgqndyIKuPCP5ScaVUbIpnLmEX6a3ngiGzfKVxzysQ8YYYaOhiAsGkYQRBcOk1BKc6AK+GyIji67xGf7TJSPHX2c4HNPQKkls84UxKSlf7OOkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519012; c=relaxed/simple;
	bh=I47oGGk36vQtphOqG9IoTTYjE7Q5s4/MicU4RJRTlvU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZjOcWXpfCqz/ggcX7s768SPv8caQpKXpc0YdBmJuHVo/uFP1s6Ui46vJRVSiTWc2t96ZQPpc0wXhHSlcGDVfA5N1uqwHun/JSYhxP71+RCuLlo/ekW3NB7RD+/aiEBwGgj4DLs2n3zrEFxBCpfiwYN5phZXEV3nuXekkNJHLMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdM1qTRO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24ca2f48031so125719fac.0;
        Thu, 23 May 2024 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716519010; x=1717123810; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SASRSpkrtcKtFFyiMHRs0i11BtPvoBcdeEVAkFViJVg=;
        b=hdM1qTRO8olrXdsu2SUwMOCj6XOkTmD/epP6l49b8rxMfAdfLgeckZzx2pPeEJBXk4
         1Seix50uu2s7OWrR+V4Sq3iwJYlC2MjiRlVUa6uGeNKv+FTtexvcrWvIonVqNDriW09j
         IdR7Jzfsg/yjCbVfZS6RvWcxHDN2DwpGjtjN5eF03UN9TBQ9vZpVThiyGpiJ/9XvmoCX
         HVrnOLWKsSfKUvRODoL/WjlHrZasBUHZ+qw0tSB5mI/G28uxe8fkwbAEceZEo6YBp69q
         W1MXJa5Gg/zJ5BBw7qeLcToONP1qCD6s2LKJdj/F2Vgu9BS5cVSycbTNbbxUTsLS2U0L
         3DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716519010; x=1717123810;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SASRSpkrtcKtFFyiMHRs0i11BtPvoBcdeEVAkFViJVg=;
        b=JHe8oDIX3tJyaWDaNTyDhyQNypGrYdEGohq7t/TUDO5+LHyDBSk0VPNCOQAce7e9g7
         ujK3j08srHe+F3XjR1erQ219JLlfCCUtZVPLjt8r13m5ET19gnNuFg8gH/leDjXseRgD
         DpADAHKcYxvBuX/6x5OYm+beLJlC1x/3HYBL3NUlHM6KvB+YAwIDs/nNm7JAR+CskvxP
         hQA33yChwtEVDRAtXowgXK4hdvvvVJxjDPyJpoxMtZFhuoab/yeSz9xoCG5aQCnbdUXh
         iRjymeVZNv/yU3rsikWa7zhHGJSF7Jbz+qNPBhr3W5jz3RgRafL7+dHCCDHVYfUi3LmY
         8z6w==
X-Forwarded-Encrypted: i=1; AJvYcCW3ceB0dMfhDrwxo0f4Mi7V9HfPkqA/8rubhWNCUutHqFGPjoba/7xTHF1ZTc5n/9PMDRVI35oeiy6tJ6va1ZpuErkxNUN9qNiP8ZiuSVdAMwoumEr61kSRijrZSCuzzkighzJ1Mo6oSE0E+Q==
X-Gm-Message-State: AOJu0Yxh5qlZm3/2x04IS9XHPeyv4OIaCe5wsZi8a61n09SjGVBz007Q
	as79/1++IsJL8mDu91bw69O9OZHuE4dDR+aY5k4vMHz/X9rraYEH
X-Google-Smtp-Source: AGHT+IHjIaQY5M4+FeKKHj21CXeWPLfDUdZEOx3f9Iqn0FFDfQycAqmJHbytyZu+YhfBpAIMmy4WrQ==
X-Received: by 2002:a05:6870:2320:b0:23d:79c3:5629 with SMTP id 586e51a60fabf-24ca12f4b25mr1126716fac.28.1716519009762;
        Thu, 23 May 2024 19:50:09 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fc36c608sm287453b3a.92.2024.05.23.19.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:50:09 -0700 (PDT)
From: Jung-JaeJoon <rgbi3307@gmail.com>
X-Google-Original-From: Jung-JaeJoon <rgbi3307@naver.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Jung-JaeJoon <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Modified XArray entry bit flags as macro constants
Date: Fri, 24 May 2024 11:49:45 +0900
Message-Id: <20240524024945.9309-1-rgbi3307@naver.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

From: Jung-JaeJoon <rgbi3307@gmail.com>

It would be better to modify the operation on the last two bits of the entry 
with a macro constant name rather than using a numeric constant.

#define XA_VALUE_ENTRY		1UL
#define XA_INTERNAL_ENTRY	2UL
#define XA_POINTER_ENTRY	3UL

In particular, in the xa_to_node() function, it is more consistent and efficient 
to perform a logical AND operation as shown below than a subtraction operation.

- return (struct xa_node *)((unsigned long)entry - 2);
+ return (struct xa_node *)((unsigned long)entry & ~XA_INTERNAL_ENTRY);

Additionally, it is better to modify the if condition below 
in the mas_store_root() function of lib/maple_tree.c to the xa_is_internal() inline function.

- else if (((unsigned long) (entry) & 3) == 2)
+ else if (xa_is_internal(entry))

And there is no reason to declare XA_CHECK_SCHED as an enum data type.
-enum {
-	XA_CHECK_SCHED = 4096,
-};
+#define XA_CHECK_SCHED          4096

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>

---
 include/linux/xarray.h | 55 ++++++++++++++++++++++--------------------
 lib/maple_tree.c       |  2 +-
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..d73dfe35a005 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -42,6 +42,16 @@
  * returned by the normal API.
  */
 
+#define XA_VALUE_ENTRY          1UL
+#define XA_INTERNAL_ENTRY       2UL
+#define XA_POINTER_ENTRY        3UL
+
+/*
+ * If iterating while holding a lock, drop the lock and reschedule
+ * every %XA_CHECK_SCHED loops.
+ */
+#define XA_CHECK_SCHED          4096
+
 #define BITS_PER_XA_VALUE	(BITS_PER_LONG - 1)
 
 /**
@@ -54,7 +64,7 @@
 static inline void *xa_mk_value(unsigned long v)
 {
 	WARN_ON((long)v < 0);
-	return (void *)((v << 1) | 1);
+	return (void *)((v << XA_VALUE_ENTRY) | XA_VALUE_ENTRY);
 }
 
 /**
@@ -66,7 +76,7 @@ static inline void *xa_mk_value(unsigned long v)
  */
 static inline unsigned long xa_to_value(const void *entry)
 {
-	return (unsigned long)entry >> 1;
+	return (unsigned long)entry >> XA_VALUE_ENTRY;
 }
 
 /**
@@ -78,7 +88,7 @@ static inline unsigned long xa_to_value(const void *entry)
  */
 static inline bool xa_is_value(const void *entry)
 {
-	return (unsigned long)entry & 1;
+	return (unsigned long)entry & XA_VALUE_ENTRY;
 }
 
 /**
@@ -111,7 +121,7 @@ static inline void *xa_tag_pointer(void *p, unsigned long tag)
  */
 static inline void *xa_untag_pointer(void *entry)
 {
-	return (void *)((unsigned long)entry & ~3UL);
+	return (void *)((unsigned long)entry & ~XA_POINTER_ENTRY);
 }
 
 /**
@@ -126,7 +136,7 @@ static inline void *xa_untag_pointer(void *entry)
  */
 static inline unsigned int xa_pointer_tag(void *entry)
 {
-	return (unsigned long)entry & 3UL;
+	return (unsigned long)entry & XA_POINTER_ENTRY;
 }
 
 /*
@@ -144,7 +154,7 @@ static inline unsigned int xa_pointer_tag(void *entry)
  */
 static inline void *xa_mk_internal(unsigned long v)
 {
-	return (void *)((v << 2) | 2);
+	return (void *)((v << XA_INTERNAL_ENTRY) | XA_INTERNAL_ENTRY);
 }
 
 /*
@@ -156,7 +166,7 @@ static inline void *xa_mk_internal(unsigned long v)
  */
 static inline unsigned long xa_to_internal(const void *entry)
 {
-	return (unsigned long)entry >> 2;
+	return (unsigned long)entry >> XA_INTERNAL_ENTRY;
 }
 
 /*
@@ -168,7 +178,7 @@ static inline unsigned long xa_to_internal(const void *entry)
  */
 static inline bool xa_is_internal(const void *entry)
 {
-	return ((unsigned long)entry & 3) == 2;
+	return ((unsigned long)entry & XA_POINTER_ENTRY) == XA_INTERNAL_ENTRY;
 }
 
 #define XA_ZERO_ENTRY		xa_mk_internal(257)
@@ -220,7 +230,7 @@ static inline int xa_err(void *entry)
 {
 	/* xa_to_internal() would not do sign extension. */
 	if (xa_is_err(entry))
-		return (long)entry >> 2;
+		return (long)entry >> XA_INTERNAL_ENTRY;
 	return 0;
 }
 
@@ -1245,19 +1255,19 @@ static inline struct xa_node *xa_parent_locked(const struct xarray *xa,
 /* Private */
 static inline void *xa_mk_node(const struct xa_node *node)
 {
-	return (void *)((unsigned long)node | 2);
+	return (void *)((unsigned long)node | XA_INTERNAL_ENTRY);
 }
 
 /* Private */
 static inline struct xa_node *xa_to_node(const void *entry)
 {
-	return (struct xa_node *)((unsigned long)entry - 2);
+	return (struct xa_node *)((unsigned long)entry & ~XA_INTERNAL_ENTRY);
 }
 
 /* Private */
 static inline bool xa_is_node(const void *entry)
 {
-	return xa_is_internal(entry) && (unsigned long)entry > 4096;
+	return xa_is_internal(entry) && (unsigned long)entry > XA_CHECK_SCHED;
 }
 
 /* Private */
@@ -1358,9 +1368,10 @@ struct xa_state {
  * We encode errnos in the xas->xa_node.  If an error has happened, we need to
  * drop the lock to fix it, and once we've done so the xa_state is invalid.
  */
-#define XA_ERROR(errno) ((struct xa_node *)(((unsigned long)errno << 2) | 2UL))
-#define XAS_BOUNDS	((struct xa_node *)1UL)
-#define XAS_RESTART	((struct xa_node *)3UL)
+#define XA_ERROR(errno) ((struct xa_node *)             \
+        (((unsigned long)errno << XA_INTERNAL_ENTRY) | XA_INTERNAL_ENTRY))
+#define XAS_BOUNDS	((struct xa_node *)XA_VALUE_ENTRY)
+#define XAS_RESTART	((struct xa_node *)XA_POINTER_ENTRY)
 
 #define __XA_STATE(array, index, shift, sibs)  {	\
 	.xa = array,					\
@@ -1449,7 +1460,7 @@ static inline void xas_set_err(struct xa_state *xas, long err)
  */
 static inline bool xas_invalid(const struct xa_state *xas)
 {
-	return (unsigned long)xas->xa_node & 3;
+	return (unsigned long)xas->xa_node & XA_POINTER_ENTRY;
 }
 
 /**
@@ -1477,13 +1488,13 @@ static inline bool xas_is_node(const struct xa_state *xas)
 /* True if the pointer is something other than a node */
 static inline bool xas_not_node(struct xa_node *node)
 {
-	return ((unsigned long)node & 3) || !node;
+	return ((unsigned long)node & XA_POINTER_ENTRY) || !node;
 }
 
 /* True if the node represents RESTART or an error */
 static inline bool xas_frozen(struct xa_node *node)
 {
-	return (unsigned long)node & 2;
+	return (unsigned long)node & XA_INTERNAL_ENTRY;
 }
 
 /* True if the node represents head-of-tree, RESTART or BOUNDS */
@@ -1764,14 +1775,6 @@ static inline void *xas_next_marked(struct xa_state *xas, unsigned long max,
 	return entry;
 }
 
-/*
- * If iterating while holding a lock, drop the lock and reschedule
- * every %XA_CHECK_SCHED loops.
- */
-enum {
-	XA_CHECK_SCHED = 4096,
-};
-
 /**
  * xas_for_each() - Iterate over a range of an XArray.
  * @xas: XArray operation state.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..c08545f8b09b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3515,7 +3515,7 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
 {
 	if (likely((mas->last != 0) || (mas->index != 0)))
 		mas_root_expand(mas, entry);
-	else if (((unsigned long) (entry) & 3) == 2)
+        else if (xa_is_internal(entry))
 		mas_root_expand(mas, entry);
 	else {
 		rcu_assign_pointer(mas->tree->ma_root, entry);
-- 
2.17.1


