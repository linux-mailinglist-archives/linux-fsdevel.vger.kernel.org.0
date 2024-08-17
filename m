Return-Path: <linux-fsdevel+bounces-26166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAD95551F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF87CB22AE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43013210D;
	Sat, 17 Aug 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBfTMSHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A079F4EE;
	Sat, 17 Aug 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863463; cv=none; b=AFgxD1K+BjKBpzyLjKQkOKx49DuXGXVbu+ZXjiShm+kxndtvM8VvjLMD+N7VrmCU1geN9jgVfpeFHtsiqcQ22FM//+d4VWn2M5bHVheEyrCTnMiaU7sBZnIR4jm4S5b9OEKq7hqfkEHf4V6lxDJoKo9DBnUAa7Jcc79wWj1WXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863463; c=relaxed/simple;
	bh=5WV7uCuVFeiQhB6uPkorf9Ro8xX/Kt/wufZ1+PzCENI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dc7YnPJhtfeT6A2kQOPpzCJTZ+RFCIfEhRs+ye10aoPm7ZIGczXXf6DtdMSa/gW922BcNPUiCli4PcDo4rC5M+9BzEUMn+lyWd+bAJhTO6H0tbXw8UypuZ5nGwvu6yGiTvrnuhey42Ok2GWiZHCWdweZM7DGdav6AhZ/zzl1Lfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBfTMSHR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-202146e93f6so9373795ad.3;
        Fri, 16 Aug 2024 19:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863461; x=1724468261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY4VRCvd9L4i067FYJCdAQbgb2obGf5r9hy8hsyaNQ4=;
        b=XBfTMSHRTRM1SHKTmoSfOAbJlKQztYPuMKMrgzg9+9FpaIHC/crEaofGrfFFNA1zrx
         ovWlU0F2xxOe7G6roPFQdZrpZl4BkE99fzHcYb/GwV4Y/5tCUU7iH6hr+sHaf15kL75Z
         TCBa8iUZn9bXrM97iZLx+H24LNEWTv6DyA0VC9FfM7PKrYi+ydPThHWxPPU+gKyppXHy
         LI9ubaXrFv0MprwgxZf++a8GrcE7a6efamw1mC/N5w1FXGtd+mYRLER+3mhJN/pZBbuh
         T48l1cXxDBlmSVnuWciGOBOci+mE29fN+uKIKBahGwZzJoBvd/SIYO3BhJ9iyuO9IvQq
         1XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863461; x=1724468261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY4VRCvd9L4i067FYJCdAQbgb2obGf5r9hy8hsyaNQ4=;
        b=tV1YVXTnxI/t0wusjLn2sKAFrq4qvLR0DI6vp0axJDpIYAllcmmJlYBcQPIAnuEZjf
         giSh2YLsuVnuc5JpiKXV4+5ZoN0IK8VK2vlK49WTju0/hQJ/ni0cNrvpfXH9uUGmuDjU
         3kZ7C7wN4OJat4cW6LzUctjIFjFJihMQHg3seHs/ElL9pTaQzFrA9yuK88Yc9+6P5+HW
         uyIBiIVAYuw7HUXSaK23zOCcg1J1ZsO94yTTfCPwvAX6umcseAUePO3x6ZblPhQpewgy
         GQ8/0cnDExIsdW9ajW+k/5X4XzIz2fs+rJiM4uggO+RtO2TqUDFVQxZdlDYcoYqe4c0W
         tdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlu0IccO01YPRQf3xebcWFOTYhlSnwI8pKOtfuCEVKeCbHHOKyitNiS/Y1ug8v/8FGpwvDOX+EhrCXa6S8kwe42fMBq1SjgFAR09oYktsAReh1LueFGK/IV23S2qOZdaGzjTJip9oQzGkNGqwmPk3744IbJ8N+I7rz5TDxFO+EJcMMNldOeZWPQMA+R4RlTSmMsJMVpc4MPoDvH3PpjJzmammQ3HrsPqqbfdbyOBCFQ4+gjb+dqvI5Jr6ysETgVtKfB33/QiEHD4URV6/AwPSVcU1mOqmn1xFhHdEFULsY2/kHU4GsuvERVu1urU+BW00sRAucrA==
X-Gm-Message-State: AOJu0Yx3EICn6/LCxZEiWKZWN1ek6yv7XL1KLYmJVxsn4QKcuriFnEfn
	TTjGFtTLuUnFVqsNa8DjNog06b4/PSwedW3VyW5HXfIgwuh7PQvm9w6c05tagzM=
X-Google-Smtp-Source: AGHT+IEL7YdwJrnU7j+3S0kOHwdlHJumXPs1OdWAsSouquvh+afE8cHfhlG2TFnMxzOYJRDIWJjJ4Q==
X-Received: by 2002:a17:902:e549:b0:202:100f:7b9b with SMTP id d9443c01a7336-202100f7d6amr36403685ad.35.1723863461337;
        Fri, 16 Aug 2024 19:57:41 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	alx@kernel.org,
	justinstitt@google.com,
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
Subject: [PATCH v7 6/8] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Sat, 17 Aug 2024 10:56:22 +0800
Message-Id: <20240817025624.13157-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
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
index 4542d8a800d9..310c7735c617 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -45,33 +45,40 @@ void kfree_const(const void *x)
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
@@ -106,19 +113,7 @@ EXPORT_SYMBOL(kstrdup_const);
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
 
@@ -192,17 +187,7 @@ EXPORT_SYMBOL(kvmemdup);
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


