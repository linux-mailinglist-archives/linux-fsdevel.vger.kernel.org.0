Return-Path: <linux-fsdevel+bounces-22751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA891BAE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F71284FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80677154425;
	Fri, 28 Jun 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSIx8kUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAE14D719;
	Fri, 28 Jun 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565563; cv=none; b=f+YBkjdlG3Ey7shtfRnUDYi8oNa+1w0IJ12pZkevrFAv7ze+59K+n8sJH0lgdagj6oGQa2fY2FFmC79qJYtLVx2tnjwSkKFmYIgiO+IOL5RLxhZcjwbmTypmY8IF7c0M+4/tPBQOK8QuRAzZRUEkQDO8mkZ4lXKlc7v++I1fmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565563; c=relaxed/simple;
	bh=inPPFHuZm+7fEeywe6ogK4qmICCbgmhVjJQRSqf84EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdANDqR/z4AlTPnfGLFJNQE7BbO4oS5sWkASbYe0Ic9z0wZ9hXVqTUSW9ZPqut/0fy9Q4atYq0EHitaVs3OAbzqkr8FRVX2k1DoHbcFnUDxI7Msw5CYGFrKRfzQcXiqBNMcAxDVYQjENSDQ38f6FPWzQBDlsByMBXZvlVpMFXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSIx8kUG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa78306796so2162135ad.3;
        Fri, 28 Jun 2024 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565562; x=1720170362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxss6iSMiIilMwCNJtHyPtBSL44EBghXiK4U5v9w5a8=;
        b=jSIx8kUGU6V0zcqoDiuJBB56i42/XOJ9rcF+cwaz++3wR3U/UgbFjI5BvFczQE5FDY
         8jonScrWgXhStel2Wv5v1tT7w/o92QLN61x169ha2IoZLnrnXSQp9hk2/JO7zSgc/h8i
         tiPgwvN9n0eOoU4XrLYgo1qeOwjCJX6heE5XHUW+e2aFUu8mHiqBT1YxqcW0AJXAFSfF
         wALr0NgazWiAqP3PqiE3FcnCJqmC/U/Pc2Qv4pVgGcgRQ2MVJPlFSrCV6HeFI9omXxCk
         yl3e2Zon/mtZHuk7XFTGroo1nhPl3rtF56Wphnefyd3xCQgD7sCzeWDwbABdhF3O5QOS
         atLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565562; x=1720170362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxss6iSMiIilMwCNJtHyPtBSL44EBghXiK4U5v9w5a8=;
        b=YWbuu+fBV4BcUVBCYvt60muB00187ChI285PuqaWo/tOAxYBZW0b2n9tJV33/moMxW
         1Snv4oG5PLJ1TMAnsFj/YCh8dYi3kQ4Ed2g6Ef09R/T89NvpVbUmp/+UNKQnaC4XHJjb
         sNFjAO4rtFdOh4Ijn4ROQMkYxzQd3Jpobz8QuEu/+1pFUSEovZn/96ioXPx6S3johqjk
         MDz+AFJBssW9Ohgh77VCqCNyCbniBQPEX+gsDf5JPfmWGHvU9MpMBgC3CRHS72ASScQZ
         KfGxXKC1TidYbhrsMEoUsmxyFE2F22xVb0wyCudWVua4eQjZ9kzMz3H6Yb8JGZ64Mx1i
         bcBg==
X-Forwarded-Encrypted: i=1; AJvYcCWQQaR6k5Dyw3uWSFK/F3afFMVj0cb7HZqhNHu1A6KyRKC/uRQkwoo4panScCgSP7SkYPAxu/DiFl4zoNfnQOa3hckNA/cRRlWWb7yJ0B+yiiFuCC3hDjDwZPlu2qUI8NO+N+R3V4pFd5eHFHanyjU6YjNq1/o+1Eocs3uj0+mnZ4ky5dwBq/PqFdY1tR5hRBeyExPm7xQHwc7GavBLWfdnjRtAsJNa8UB2//YG94xqts1ChpyEHAoG5eIzMpC3t2KgobZQH0hra6x+6T8g4g5J9kNZ3qSroIKfACubLV9eu7M4+mJrqqYMoP/9QHT9K5AQBy8siA==
X-Gm-Message-State: AOJu0YzefTmfZkiF34Np8oTV5RYd9YaieleUB9N3S1yovJ2MYr/eMUB3
	7uzTB7xvtZ5Il79y6FnvoQ19CF5aUP3tcMECgTtr2jLmwAuSYC8T
X-Google-Smtp-Source: AGHT+IF41G2qRww4DdF/h1fHsQyMDqy+U0zSGeUJQI71N0qwJDXNmrrmWplbD4mTRfu3C38uIRvv6A==
X-Received: by 2002:a17:903:18d:b0:1fa:2001:d8ff with SMTP id d9443c01a7336-1fa2001dad7mr177652065ad.52.1719565561588;
        Fri, 28 Jun 2024 02:06:01 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:06:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	laoar.shao@gmail.com
Cc: akpm@linux-foundation.org,
	alexei.starovoitov@gmail.com,
	audit@vger.kernel.org,
	bpf@vger.kernel.org,
	catalin.marinas@arm.com,
	dri-devel@lists.freedesktop.org,
	ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	rostedt@goodmis.org,
	selinux@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Fri, 28 Jun 2024 17:05:12 +0800
Message-Id: <20240628090517.17994-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240628090517.17994-1-laoar.shao@gmail.com>
References: <20240628085750.17367-1-laoar.shao@gmail.com>
 <20240628090517.17994-1-laoar.shao@gmail.com>
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


