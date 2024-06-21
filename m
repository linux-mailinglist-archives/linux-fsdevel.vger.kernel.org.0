Return-Path: <linux-fsdevel+bounces-22051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B980C9118A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F238B222FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856712CDAE;
	Fri, 21 Jun 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWHwxr5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5284FBF;
	Fri, 21 Jun 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937103; cv=none; b=HeQf9wACQvpA7HQcyEoT0EX82yHKQXDNAHLKJ2ilnmS0ta8qmIP2juKdPHRezqlmqN5z7n2/IK89qQMHa6d3PsIZ7C/16oPvDN38eD4nrgF7htvNuIyAvT1zzZFkwqZVDrfwmEE6OBbstsGiTXukuGfnDWJsxhQZ2rvcqCWDBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937103; c=relaxed/simple;
	bh=Kkeo6MG1a3qIIQSVqx8qXRklhPMiGFUJA/nbOkwLjy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAM7vlOQYwpD55QPIhglnj6l+LIYyoSMGuwxw8cp6QJwdonzYfsvZy89MJ8kthWkimB8U2B2biLwLIPcf4Q06pJTII8mmSfJZ6XsKeamf7UMYGKA1cCA1Q1aRocTK6uLiZXfjjN6bhuyaSUV6e3mrrxh2lEYJNHbbcrJosxP/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWHwxr5I; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-704313fa830so1321029b3a.3;
        Thu, 20 Jun 2024 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937101; x=1719541901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIxIpX3fSDij30wx/6pUEm1wGM6JrlT5xZ3d0lBG2nM=;
        b=XWHwxr5IJs5pY+6aUeh96ZLGYFnEGX4kNmZakghl4efSWIgcasnVezFzrcc1u2M0jG
         4zppdszGMHZjwgDADgRTgjyr38/rtGzVQINL2szrz48vG6pR8DHt1iXl+Iq/JuAG3MHy
         UYsbLbPa/7GoN5CI0fCIxo5f2Yfpbw44XaVIDZLup9gvOWAPwOOy/k1/0314OJLqunwv
         ZEvj2KkzyiJiRGU5f/FvjUAGyKxPxVEaLIXhl6l+geJ0fu4BLkWm6yH+5n8eof8kxQBL
         S+u3vVlsiNo5YL/V3/tBHxiv9wDuL3wwpQwYLa8txuY3Lu3GnU12w/EfdL420cxZb5Rg
         erEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937101; x=1719541901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIxIpX3fSDij30wx/6pUEm1wGM6JrlT5xZ3d0lBG2nM=;
        b=WOrqIejJubhdLHUmTPS8EWzHltCWQUHDEWqb9G/SssPbRu1kUmEKwywRLu4/gzr606
         ygdz4e6mXmdT/dbFOpv+QpQrT++w7YP3WKgTSoh+gIcF31GczJNy3Eo5CSO65IrDQkly
         wQSoEoeiFmKeMB0LrUN1Uxy0g3P63jgA9NWn2Hp8xsJqlY8XRV4DKHfbSbI9lHyCLfvw
         NEYLrvlGOV9zTNjW4SWT8cA/sgZ1cbHiKPlBYI0p/xv89YR2dKYN0j4gMFhmSUd6gRqS
         sXRUPxrO010CydEfNFEywGgKGW3rlfbL8jUBCE/wBWQ98Y0MrFB9gDHRyHQI4ye57S2i
         n6sg==
X-Forwarded-Encrypted: i=1; AJvYcCWooEQrfZMjOEoMekDBALm9DF7NZyyhvQ0wZ5XmOrl2Tx+OrnS6ct13Ok+2ckpoTVas4epdWfAHuXCBaA21h3+4WebMKJoM1fwqj+PZ3UfN1sinuMaCzijvZbjW3XYFLnmiv4E5nAy8aPiIgbNTpkeaaIO3oOsgPGtowmlNEhafKpuFy0LtlpynXFQc8emVmNij0+D63pgVyhBFMi+XSS1qg6uNTLycenkXR0ITpJWj7iWynYm/NmycuXOELMMENQBDaqQm7BoenonNDA338x9NkREMlgegSB1ioiJjCWzPfcfj8pbpw1sPOPuKnV7grhA6Q3a2Pw==
X-Gm-Message-State: AOJu0YzkgX/VvHhGl2XB6dqK8dpiudreTSUieOa9yGbzcSiI659KrsR2
	81Wzr+hMfuSgcePHqCXDzf9RAK7p1nZYOVkXHS05Tc/ribOAIZWH
X-Google-Smtp-Source: AGHT+IGYNoV/DB/o6zRof24rJ6xmZEwxYI9LpBEDyg5OiYjfuVgaYmaCgemL5OUn4y/KnIdaoKGjig==
X-Received: by 2002:a05:6a00:2f43:b0:704:2d64:747 with SMTP id d2e1a72fcca58-70629c1dcdbmr6929306b3a.7.1718937100840;
        Thu, 20 Jun 2024 19:31:40 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:31:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 06/11] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Fri, 21 Jun 2024 10:29:54 +0800
Message-Id: <20240621022959.9124-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240621022959.9124-1-laoar.shao@gmail.com>
References: <20240621022959.9124-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These three functions follow the same pattern. To deduplicate the code,
let's introduce a common help __kstrndup().

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/internal.h | 24 ++++++++++++++++++++++++
 mm/util.c     | 27 ++++-----------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..fd87f685739b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1521,4 +1521,28 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+/**
+ * __kstrndup - Create a NUL-terminated string from @s, which might be unterminated.
+ * @s: The data to stringify
+ * @len: The size of the data, including the null terminator
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Return: newly allocated copy of @s with NUL-termination or %NULL in
+ * case of error
+ */
+static __always_inline char *__kstrndup(const char *s, size_t len, gfp_t gfp)
+{
+	char *buf;
+
+	buf = kmalloc_track_caller(len, gfp);
+	if (!buf)
+		return NULL;
+
+	memcpy(buf, s, len);
+	/* Ensure the buf is always NUL-terminated, regardless of @s. */
+	buf[len - 1] = '\0';
+	return buf;
+}
+
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/util.c b/mm/util.c
index 41c7875572ed..d9135c5fdf7f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -58,17 +58,8 @@ char *kstrdup(const char *s, gfp_t gfp)
 	if (!s)
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
-	return buf;
+	len = strlen(s);
+	return __kstrndup(s, len + 1, gfp);
 }
 EXPORT_SYMBOL(kstrdup);
 
@@ -111,12 +102,7 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
 		return NULL;
 
 	len = strnlen(s, max);
-	buf = kmalloc_track_caller(len+1, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		buf[len] = '\0';
-	}
-	return buf;
+	return __kstrndup(s, len + 1, gfp);
 }
 EXPORT_SYMBOL(kstrndup);
 
@@ -195,12 +181,7 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 	if (!s)
 		return NULL;
 
-	buf = kmalloc_track_caller(len + 1, gfp);
-	if (buf) {
-		memcpy(buf, s, len);
-		buf[len] = '\0';
-	}
-	return buf;
+	return __kstrndup(s, len + 1, gfp);
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
-- 
2.39.1


