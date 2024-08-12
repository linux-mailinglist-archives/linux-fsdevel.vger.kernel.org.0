Return-Path: <linux-fsdevel+bounces-25620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D321A94E4FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539571F2192D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0301148837;
	Mon, 12 Aug 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhQEtGVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E74BE1;
	Mon, 12 Aug 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429874; cv=none; b=ZENwWoD16X+9jGg8vZzREgbZhpk5eUT78ChMtEou/Hs2dV3q4wzWyzwv0sqDvPLSoPRv4fyIgQPEp0swubLDar07XuvWgt6CkYEzZ28kkeR9tAKgDwiHtrZdnJLKL0xvV2ua9D+W87kutsGOUsFRgWM7sGkFAeb/nd2EWalywC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429874; c=relaxed/simple;
	bh=5WV7uCuVFeiQhB6uPkorf9Ro8xX/Kt/wufZ1+PzCENI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKWR8fCZfcNV5+Nc4S0KKe/nNJ4a2Uf8B8XuhlH/6OybtzLSIK6uI2/X0qCo7JFSVHiq0IJZ7t2X4uFUVr8nDZ+BsdOZ4+O8TyBBoTBJH4Hr9ByilSVudgzE02i+WyOen6OCWJCHTMhbB1/h52sPQVEL8QIZ+Vp+M5p59t2YdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhQEtGVL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc569440e1so35476085ad.3;
        Sun, 11 Aug 2024 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429872; x=1724034672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY4VRCvd9L4i067FYJCdAQbgb2obGf5r9hy8hsyaNQ4=;
        b=bhQEtGVLkFkmefwPn+/1+jt/l3pbsvjwUrQaOCbqFiFAA+CqnxXCchq+D4mfIV10/c
         wQ/MN/kOdKF4NZghZDZx0XkOuBGAVxtYL/OGLze4F1Z2wGqjd8o+PKiqwungGFKXMwhA
         0SdPDKImAp2aRmSwt0jI93DeMDP2F+zzmCjv1TU8zScy9UnHDoLjgZx7OZDKOemoD9eM
         YqcTZBtFezeITYfQUh73PBB77FIxMKhd1jdt3s2ZTSHmNnSzrDdg4x2Z981liyf705oP
         vHALtYofgQxVVfvYRNPLUe63q4b7cmh8VTrL6rSAL6HcQYqFysNs1U7mFEk2p16uIuFH
         PcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429872; x=1724034672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY4VRCvd9L4i067FYJCdAQbgb2obGf5r9hy8hsyaNQ4=;
        b=GOlrVEWeDUicTKfwrgtF54rLQZ04Ym+B8TutwJ/VeWI4XUwJzkTY1sr+r1xUX/Srrm
         0QYIyQt7o3qdon9Pn5n3ItgvTrudULzm9+FX9JceIHh2G5WuHAI3dfuP7qqqabF9/z60
         RrxmC2BTst/4lLIVuh2eSgkG9weei7gkHfnyKRE4T+d0IskO19sIP9BC5dJ5Q7BQBZ/z
         e7HkhovZgfTue961+a99t1Q7mfuG60au5F/noow6yYXERtrJvl3oDWc7Spr8M6e5CQ6K
         TlcyObaBpKrFJsAE+vJvEwKwQDZ+roidGz4GNiP+vJ7vyJBZ/2HS9ndBrwSbJjK9yT3W
         PTcw==
X-Forwarded-Encrypted: i=1; AJvYcCWKGXjkBifeIfhz8abWPJayuKIUuoXq+IZB32Tnyn1rmUDlvmp+trVADyD7deUVgWiQ0acpO1WAZNUmRcF7BdNJZT4cT9doaRHKNkJ5jv8S4HxPN+CliQf2RGDLRSMy9fnNfdKPJ5EBktWKnGPwdO+/3WT4RdMrHGgiCtlN7Q9a/juefgOz1lIlACCZA1AUM/PlvuF7nkETDHp53VBa4pPFGP8/uSDP2AqYvxwOc5GrKVfNSYL39q0a4p4qI3CMQLakfFAgh04G+/nO5x9BGWr3MyovdbuwYEA6JOorOG8S/KQaU4FlU+NXxtS4QuWX/XJQkB+KPA==
X-Gm-Message-State: AOJu0YzR3DHAMvsx07z9uu3CNHXN26+vkqlIlrjoL00EF3d3SYWoOFDb
	5FkZr8qhQITgpyPIOn0Swv/u/RrIlDLze3WAYQi2fMZCVETRKVhk
X-Google-Smtp-Source: AGHT+IGDYbe0RTpouvyRH8j57LNI0ygI4N2QpIwMJo/CclCqBa2C0H4JAnlCXTMiS2Sh5vz84U44EQ==
X-Received: by 2002:a17:902:dac3:b0:1fb:48c6:a2b0 with SMTP id d9443c01a7336-200ae4dbc8amr93864745ad.5.1723429872026;
        Sun, 11 Aug 2024 19:31:12 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.31.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:31:11 -0700 (PDT)
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
Subject: [PATCH v6 6/9] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Mon, 12 Aug 2024 10:29:30 +0800
Message-Id: <20240812022933.69850-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
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


