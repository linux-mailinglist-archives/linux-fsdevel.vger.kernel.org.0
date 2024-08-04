Return-Path: <linux-fsdevel+bounces-24944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977FA946D49
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C5281974
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914E200AE;
	Sun,  4 Aug 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIVl5rhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0881B5A4;
	Sun,  4 Aug 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758302; cv=none; b=C3q1sxxTtZexkbtgzUvifxt9Ux4AUGkugILQ/xmyODnRPq1U3VheQW2iiz49ckiYJ7ScGRhErfRgKdJwlMNRryibI1Kko+WBylgtuGTklnbJ7wQTSCgJq1rAeou7KRs2Fy4nFaW8N6RErmaj9xsiV6ZcRpHlfPNX7EUlNCZPFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758302; c=relaxed/simple;
	bh=ufZNTPTUnymrGi51MfWJYESJmDf38G9W+EaTMZbbTf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o78+MqCI90LdjZkRJvc7Fr5uAEr+wb5kPX9du8AIcLHUMC9IxrN6UcXE5b+hhpLw6tRaUTF4xbWbpjicBrAxU24iOEgEVfCqia83dktuP+Tn2LC+xmBNxZveu44hjA4sKpB15i9YwUJW7Sz48svXn2+zkZ4mwf1X/zg01/XPPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIVl5rhX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd69e44596so33007355ad.1;
        Sun, 04 Aug 2024 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758301; x=1723363101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS0UkRamrVL5XCR4Rnj9cLPm9Cl+fEpiyHi/lwqSnvY=;
        b=mIVl5rhXWK5xkGkCfsPW5zU22+u+fcLHq2hrsmPjUvD4JeY9a1BLG+SwKi9Uo9rrvU
         ARaD1wq5tPXCTRc8+b5qx/+H2l3yVblFUkXwS1USeRkWFh9nAwZRMH6M0PPElJBpUGKk
         yPk70yIV4f4Rgd0Z00PZyOvrzDxwhO0uIcUQq3D5kPa5qNMTqTOfiW0XWIMRZ5FgEU3B
         i7TXg8hhrjVpV2I/cxpzDe86EMXXxVjfg+FvMIp/kK/AsDQ2f1EqVPw2s5drfocTDpJY
         JTzqS2ia/ZG66S5MJXS4WQE//j6/lm7LX0e4DiS5lGtEFXOrMNcyF5tlFwle7KvaGzd9
         BplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758301; x=1723363101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS0UkRamrVL5XCR4Rnj9cLPm9Cl+fEpiyHi/lwqSnvY=;
        b=ZVI4cqbNg2W5vUKjfEalm/gLHl0/8M2Gq4gTbMyYxXbyz6ufysQHfyYGtEIvfcTNxM
         H/REhL5Dp98N64aq7jXiOh/xEhm14h3yk2MHaipu/v5mHchN6JrgPuFO33w7brsPT/Ar
         yXCB+OKN7ysaGmqYk6iSEzRd+jrU92qpKRq4SLF4vjQqn6uMnFqDciNC+0KoqA5DtOXw
         U37EIkAQplOlnagYg4meYF95lG+cDYz6UrUwTiYlCMEAd6xIZsJq064OE0ju6TiYTdNe
         re7EgMuWOsO0IPhix1JO8n7F3z6jFarm5LbWGp8WVCYUN5Nar042oA+uuaD2W44PJHE3
         3jvw==
X-Forwarded-Encrypted: i=1; AJvYcCVC0/AHYYjrW8sHZwZyzUnTbQaeTdkfV8IQTAQA8KcmNoLO7gp1vi+lyLS+BAcuQCy1sZ94rJyurP/IR6PVZv4mfKodJdxWLefn4R4azgurjdYj08nyzH+Do5wYlNLj3Ve7fYWBK2HceXT3UdXbdNYPWH6F0EliEg7SQVQrVaw/NeDYRuVpFR/5orXNaL/l5+22C6YGqIIEbV2VPkiS54LbFjwwB1UODHA6DFxHVJuhUkverQvWcWg9sje0zwG7bWfyoAbl1a6SAWbgXFosu9f+a6AcW6yij+JwpYVgjoEXypuJtuIZhjyGYF46U9M6sFqz+bMXpg==
X-Gm-Message-State: AOJu0YwC7bDCNznXb6U5JHmApmbNFZUI+jtfwHBw62gL3uwK93CO+xP9
	WKBbhmdhoVI4ZvwnlNcZ+85XcYq2P23be0L25aBWMM9EiefPgrIa
X-Google-Smtp-Source: AGHT+IEGtCQCVMnQCKfJ0+BIkhT35+DpDH9a54ylBrsi080HAExdi6zY8c1ZJxWy2ZwMLSFkL3dmww==
X-Received: by 2002:a17:903:1cb:b0:1fd:7ff5:c673 with SMTP id d9443c01a7336-1ff523ef0dfmr156564885ad.2.1722758300691;
        Sun, 04 Aug 2024 00:58:20 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:58:20 -0700 (PDT)
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
Subject: [PATCH v5 6/9] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Sun,  4 Aug 2024 15:56:16 +0800
Message-Id: <20240804075619.20804-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240804075619.20804-1-laoar.shao@gmail.com>
References: <20240804075619.20804-1-laoar.shao@gmail.com>
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
index 912d64ede234..2c5addabd6f7 100644
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
2.34.1


