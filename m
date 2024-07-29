Return-Path: <linux-fsdevel+bounces-24395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6A93EB84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63361F21FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929B7EF10;
	Mon, 29 Jul 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsEzvySQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F97D3E4;
	Mon, 29 Jul 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221071; cv=none; b=qYQu0EuSVqsKkMCOL36ascQ1KVqNfimW+XHUHyAjpx+VzeaJlxPo/CgJk9Z7sX3mQuVhUFGx8G/AizKjRmIQFrIkyyuVWoz0qirNd2sjUQ4DgL+WUpUzt4epwzwNEQXFJMluJSdtTWBSoSIiGfBPssubWanozPPSXBZsYKZEERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221071; c=relaxed/simple;
	bh=inPPFHuZm+7fEeywe6ogK4qmICCbgmhVjJQRSqf84EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piqLF5HxNhUNxgLSvnoNxpsQNkNhmtZqIc1mly/CfgjOwKZCcvfJISr7xqfzL06JCMrgkEokFB9WYPYTGhLgHaOgJ1x70GKcEFBFVJcxQuxDSrQmAkQBXUOveLGILg0T1KmARnYveQtUg99z6MZPNcwLVRa0EpbNo5fVredT3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsEzvySQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1665714a12.2;
        Sun, 28 Jul 2024 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221069; x=1722825869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxss6iSMiIilMwCNJtHyPtBSL44EBghXiK4U5v9w5a8=;
        b=OsEzvySQuN3fS7XRL/Ygzejo/N3gmMq++hmmtpcNMVLxuiPE7Xub8vDlZKy7KUCFv2
         ohCXK4DGYtz2SecqCa2sO2uVaI2ZRnXZl3NMXaxTr7c2Vdsj2vpe4UBH7Dt2Zn3rORSS
         9cr9PKoWUaVJn0y6wqCkXdmJe2ODZ4ZpUNMFg9Z9tuPqrNFVVSQ6y8YdOWZk3cIWdKJR
         tK66Mkuv38CGWkeFv6f22B9WxB3GCnGefGD1fy5xoSiIv6iHZ87lxim4ZtSRStnsJXsz
         RTXm9F/aIiM/yBZHWkCMiW4vuSQ4L/8O20HXFdQ7DrtT6B1Hb+boPfFwJFBTXPYc6eOG
         IPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221069; x=1722825869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxss6iSMiIilMwCNJtHyPtBSL44EBghXiK4U5v9w5a8=;
        b=qE+O/B8DIvOY2TyURxTTslsKRT9SceYLbR/ILUfYCfe/BTirP1YnBfhul88tsZjBei
         c1C4xHWfoIBhvAJY64inr7Ll2fPKMoSd+zxX/FtBJkQoxK25NG8Z/nzdPd+vBJVLVu8g
         a/rJN2Aze4XDSGvo+pBVGXbPUP0Ch3EyuLfJmU3gnk+8FEqjvQiZDQKRoLuZniiwBhaL
         WiPhPikJQX3u4AXoAVWuaD36BvYbQVVBPUPc1uXD/8u5HlmIDq2w2mV5z4XqYGiEVdBV
         Jmc7pYvASi4ZNjzoVVR3BA9hhrM9UNRpx4+RxgaUWh0538VvvcLd2NUHepb9jA6EKLyz
         2wLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPQzfg8zN/OGOzz/n+IBdIFaavfOoR+skAzWWLQKLsmcvkgK+qpnpM5RyQHEL5dvEFUt2ZaI1n3xodQZ5Gwyyv5Sg/un49KRm1IGGezTz5SpFItpd0LZ6FZKYfrR7hkPok0m+Q3Sk9BU14giWzZu3GrcAihYy0Bw0fvoJlR57sDqcm/abqPibrQ3I3pWuuGsG6Z1PgJEB/RfF1+Opge2mNSTKfjS2OX7OzqrCgvmvQ5gcvvsuoomlb5znpHfI4l2v44Tlul7qNggpI8tNLW/LxgNzrYK2J/MtupoJi5xk7ZJEi20QlCl6BJipn/Iq5nAQBkKpGcA==
X-Gm-Message-State: AOJu0YxZmZiLAT/XeIs0qknPAZn9FpEhQvR2oqSIrrbGXBtTL3Tm4jx1
	1Hq18lktu+LvRWJyadPX3mvCkrYol3ICt6R0VHvIHno4L46I45fg
X-Google-Smtp-Source: AGHT+IG7/eKYXg7QfYOb1CdYS0BMtkGw6Mkjs56lIRKp/S/546Q1z5Hj0Wkc3TWWQHawrwJ+z6MQVw==
X-Received: by 2002:a05:6a20:1582:b0:1c4:c7ae:ecea with SMTP id adf61e73a8af0-1c4c7aeefb4mr1212793637.11.1722221069087;
        Sun, 28 Jul 2024 19:44:29 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:44:28 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Mon, 29 Jul 2024 10:37:14 +0800
Message-Id: <20240729023719.1933-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three functions follow the same pattern. To deduplicate the code,
let's introduce a common helper __kmemdup_nul().

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/util.c | 67 +++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 41c7875572ed..62a4686352b9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -43,33 +43,40 @@ void kfree_const(const void *x)
 EXPORT_SYMBOL(kfree_const);
 
 /**
- * kstrdup - allocate space for and copy an existing string
- * @s: the string to duplicate
+ * __kmemdup_nul - Create a NUL-terminated string from @s, which might be unterminated.
+ * @s: The data to copy
+ * @len: The size of the data, including the null terminator
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  *
- * Return: newly allocated copy of @s or %NULL in case of error
+ * Return: newly allocated copy of @s with NUL-termination or %NULL in
+ * case of error
  */
-noinline
-char *kstrdup(const char *s, gfp_t gfp)
+static __always_inline char *__kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 {
-	size_t len;
 	char *buf;
 
-	if (!s)
+	buf = kmalloc_track_caller(len, gfp);
+	if (!buf)
 		return NULL;
 
-	len = strlen(s) + 1;
-	buf = kmalloc_track_caller(len, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		/* During memcpy(), the string might be updated to a new value,
-		 * which could be longer than the string when strlen() is
-		 * called. Therefore, we need to add a null termimator.
-		 */
-		buf[len - 1] = '\0';
-	}
+	memcpy(buf, s, len);
+	/* Ensure the buf is always NUL-terminated, regardless of @s. */
+	buf[len - 1] = '\0';
 	return buf;
 }
+
+/**
+ * kstrdup - allocate space for and copy an existing string
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Return: newly allocated copy of @s or %NULL in case of error
+ */
+noinline
+char *kstrdup(const char *s, gfp_t gfp)
+{
+	return s ? __kmemdup_nul(s, strlen(s) + 1, gfp) : NULL;
+}
 EXPORT_SYMBOL(kstrdup);
 
 /**
@@ -104,19 +111,7 @@ EXPORT_SYMBOL(kstrdup_const);
  */
 char *kstrndup(const char *s, size_t max, gfp_t gfp)
 {
-	size_t len;
-	char *buf;
-
-	if (!s)
-		return NULL;
-
-	len = strnlen(s, max);
-	buf = kmalloc_track_caller(len+1, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		buf[len] = '\0';
-	}
-	return buf;
+	return s ? __kmemdup_nul(s, strnlen(s, max) + 1, gfp) : NULL;
 }
 EXPORT_SYMBOL(kstrndup);
 
@@ -190,17 +185,7 @@ EXPORT_SYMBOL(kvmemdup);
  */
 char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 {
-	char *buf;
-
-	if (!s)
-		return NULL;
-
-	buf = kmalloc_track_caller(len + 1, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		buf[len] = '\0';
-	}
-	return buf;
+	return s ? __kmemdup_nul(s, len + 1, gfp) : NULL;
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
-- 
2.43.5


