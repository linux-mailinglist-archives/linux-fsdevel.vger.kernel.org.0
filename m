Return-Path: <linux-fsdevel+bounces-27498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4691961CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5095E1F25EE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382814A4C1;
	Wed, 28 Aug 2024 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvTL1WQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290A3AC2B;
	Wed, 28 Aug 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814265; cv=none; b=Z/Gc2SEHoUCmmpeYBqwEArlz7k2OzpCk3hW7/u5FPc7KCy2ISpTdzIpqEjJX1Uj8Pp6FeYvw83WXSK1i4t/x3ThpFXXIOd/FNCutlTJF0HcLgDRgeYJP635gQiZpaDXXgKOgYRudcty30DKXrt+geKWgvwjt9f/zNtGagX5kjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814265; c=relaxed/simple;
	bh=kJkXbz4A7GTjlabKI6l0OuSv1zIXTDblkh3pvhLskhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8dnO09e1aTcfAGm0gjHpWwEeMj3ZC2rcCNAt1kyvIbsPFrrSV7UpGcMvZcF2z1pMYgwyZpxI2YBGdUMf2Id/EgYlVhvwRDidyZFgS3xb+q3ZtodPdy76iqgFC4kn7WqQpyE0k58NYLWVd5V4N2bl/Z8z4B04N/lskMBen2O7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvTL1WQx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714287e4083so5562699b3a.2;
        Tue, 27 Aug 2024 20:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814263; x=1725419063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1UnhBnsG0EZ9945TsUyg6NQ1s52ltgN7fNtAXZRUfE=;
        b=SvTL1WQxhUtEBaSepL955CFDDOTvboqGrGHB6kwvuYb+vU9RyjFQyJMitRZQPVwaAb
         NOvN4Bp5h8ilKkxpTL/at6mN9FC37jCPLEJrSsVtN6dl6X/jauxi64oirenWPC1pNor6
         f1qHy/raOqbaaNt1+Q7V6WjFEiWwwxWcsE8tS/6tjLSpu5GiTu74gzlP4B8EkhlfgR89
         DqUCLFu/uXCUHjC8swwljfNQjp/WvuT+UU3k5w+oVOLtlSwB/khCOYkL03/SYWhlz4aP
         1bMy1jEt7sIHQM4M+l54jVjJgiKke6Y7sgR/3Ud2ghpUNgeaLnW76ZBsqHid3ZsS2pJM
         /Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814263; x=1725419063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1UnhBnsG0EZ9945TsUyg6NQ1s52ltgN7fNtAXZRUfE=;
        b=JSrM1x3SpA87I4tFAxBTYcrw/nP7ls7zFeLqPvuV6wuhxXQ3IftbMf8E6RrqSuZe9h
         PmusHRd9RUb6o3TvAloXw0YNEHteCXBczq/kQ4qJ/otnkxLm6KcUaWzRsq/3sr9O9+CM
         pOzyhz3N50zskoW0hP3ra00dwTXmg3kG16UtCp9xxfM3r5N0Ocz4MMPpwjR5qXNApQyf
         mcPqnmgUuLEyG2TAouUECiVBmxW3s34mJSRO1Tcq86ifWDZvB1K0+ggy4pqCrK5nWrhJ
         4ShErwwp8VckYlKRk6BaOvs3hzFU69TbEftgXVmvJ4Te0qBcWnTqh2UO/3vI5EH1fjAr
         slIA==
X-Forwarded-Encrypted: i=1; AJvYcCUTvzTBgvxXXtmMHULnuATx6Tn0Ak5D2inf2qUyPlQ7jpYNK9Fq8rcf5LiMSSS5YcE3dGF0@vger.kernel.org, AJvYcCUakcqjMItYlb065xL5TQZxPXtUA+yeWiL42C0IaR9t6RkKnr+dO4uqukKCeVeIYmCNxGTk6ogQmYdoWdGuBUnCxsxu@vger.kernel.org, AJvYcCVIUGqsU9p1uZEdfvjYqyZjxnjsvlhTbhS4UiEcQNyWEmMNzJSKdxJMc55dW5HNQshjxp2tKk2Wdkjxu3cA9w==@vger.kernel.org, AJvYcCWhGQBudu8RRbA/R6yYcyxjKdR2jGrvMIqwLZSeBecPQLHMqA3S23xSs2dhsTJIv6JqYYP8lg==@vger.kernel.org, AJvYcCWks6PeLSXbgD6zLUrv5rDI9f1cDlbf30Mqf4LKf09iw4jaxiKOESHTbx2jdelDuW2KodaJCscSz1oqLd/yzxBBoPlmbbuV@vger.kernel.org, AJvYcCWn+A8fxlChSoKOIZkK+ocsBuofmuNvfIkjgCA2eoIyas1O/1K9KrJ8erqRh44eeOS3IJxS4elu@vger.kernel.org, AJvYcCXy5LaVx+p1Rr6/ZEWS97UtVBRWzZ2KcWhB1Iw+TAVeU9mAwt99vmRAUMAFa0xZkqBUxhTWv2fvxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQu8o6FueWMvYZHMurLxSzNwQeDZ+j+PKK05u/02EH1DV6kxo
	dFeuivzKOoiinzK9/7xHyGbO+pptk1OkE1S8gW6qjmGzIsjRRgibgkOP7e8S
X-Google-Smtp-Source: AGHT+IG7QBffnYc0dCLvaTOX5KXK0mJkKlpaXmWfgPhMMu+561lRAfU2Q11Tqx0ug2HVRiltuCcmIg==
X-Received: by 2002:a05:6a20:b598:b0:1c4:b931:e2c4 with SMTP id adf61e73a8af0-1cc8b4bd8bamr18005852637.26.1724814263473;
        Tue, 27 Aug 2024 20:04:23 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.04.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:04:22 -0700 (PDT)
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
Subject: [PATCH v8 6/8] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Wed, 28 Aug 2024 11:03:19 +0800
Message-Id: <20240828030321.20688-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
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
Cc: Alejandro Colomar <alx@kernel.org>
---
 mm/util.c | 68 ++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 9a77a347c385..42714fe13e24 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -45,33 +45,41 @@ void kfree_const(const void *x)
 EXPORT_SYMBOL(kfree_const);
 
 /**
- * kstrdup - allocate space for and copy an existing string
- * @s: the string to duplicate
+ * __kmemdup_nul - Create a NUL-terminated string from @s, which might be unterminated.
+ * @s: The data to copy
+ * @len: The size of the data, not including the NUL terminator
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
+	/* '+1' for the NUL terminator */
+	buf = kmalloc_track_caller(len + 1, gfp);
+	if (!buf)
 		return NULL;
 
-	len = strlen(s) + 1;
-	buf = kmalloc_track_caller(len, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		/* During memcpy(), the string might be updated to a new value,
-		 * which could be longer than the string when strlen() is
-		 * called. Therefore, we need to add a NUL termimator.
-		 */
-		buf[len - 1] = '\0';
-	}
+	memcpy(buf, s, len);
+	/* Ensure the buf is always NUL-terminated, regardless of @s. */
+	buf[len] = '\0';
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
+	return s ? __kmemdup_nul(s, strlen(s), gfp) : NULL;
+}
 EXPORT_SYMBOL(kstrdup);
 
 /**
@@ -106,19 +114,7 @@ EXPORT_SYMBOL(kstrdup_const);
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
+	return s ? __kmemdup_nul(s, strnlen(s, max), gfp) : NULL;
 }
 EXPORT_SYMBOL(kstrndup);
 
@@ -192,17 +188,7 @@ EXPORT_SYMBOL(kvmemdup);
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
+	return s ? __kmemdup_nul(s, len, gfp) : NULL;
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
-- 
2.43.5


