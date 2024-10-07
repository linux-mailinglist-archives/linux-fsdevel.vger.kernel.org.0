Return-Path: <linux-fsdevel+bounces-31204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B36993003
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965511C23C3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8A1D9698;
	Mon,  7 Oct 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ8glgve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3D1D86F0;
	Mon,  7 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312643; cv=none; b=HTc970wFWKygRKjyfHuJ9OrFFcf/Td/65aCy6tfHMO6KM8O83VpD63YNtko1rJBbcWleKNB7ykD8hbpTHEMVv/PKMMsvw1IHW3e7aZusVGhk2o0Y8FnMOpxqGAr7VD5M9/2GWAY8UnyS29hXvblS7jPSO6PawbR8CRfcfwNm4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312643; c=relaxed/simple;
	bh=c5U2Exviiu6Srl3rXG6VqnIZy3pE3F88q4hZx/ZFdtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5DfhdqfFE8dNnrVbzlMRZ84QeA/tYgtSrS5ALMprW63H3dLYCgwXTQK0iOXxoL7YiN7NQ1FlDj0bgoNBzvqGQr7luxLw4PNUfUYbWLeZyABUQ2J29rHRVHUuyYGbDVx+KL+d01OHSJd8oKWEInMZ/9lYozGQZF7boSb+HBQtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ8glgve; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db54269325so3686890a12.2;
        Mon, 07 Oct 2024 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312641; x=1728917441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBFkTCCgw4nKzS/UQclQt52OlK7datrkk2Sl/mMl9SE=;
        b=QZ8glgve80KXfDl47oe49zH3KqODXChyaUElx9SQ+PRXEdvzPVYoJXc54F5ulr+GOs
         muMlFTeVPYNPGBegSFLHu/K/2pGx0DIkOqqDVzvc7IiCkzS+H9SoGj4FgumrH1WHj0H5
         IhZlZo1Y5c0uWpAehiNlGjF+CG/UCyVm6/k8ZWkfUMf68Ce4gOOglyDFoRNbxSOffwLN
         PiXdhhbnBj1JyqESAIc+kQS8ZblV90c+HF1//ghJGrrS6XJWGYMRhbo1r4jsEllXVsoX
         rsItvuNpfZOqR30QLtuEeqbQHnnq8rucCD+FvorV+HXcNqS4Eyqgf4bwOfSuhpDka06y
         fl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312641; x=1728917441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBFkTCCgw4nKzS/UQclQt52OlK7datrkk2Sl/mMl9SE=;
        b=whYDLHruUwDn96gImMVGKNw1Eh5jp60qF/aw0DAS8wuVGSb8KWYFfgeu8mSr+0BhmW
         DvBX4h66kfP9kuzJuHfTzj6RdmAXkQn1QYJIeDICu17a/SZesM4q+hZi4Zd+kgWyGzWP
         tFpCWsn+1oqyBBQR9aFXym0LkbRLzGgB7hS+W5W1WPVCCIB1xkDGBnFT4cU1oD88ORkl
         NY6iX3h8+ZmX46HWbVsa0AxQgZCOqI8VdPdaSLykZcCEo+yEG9bsD2J2nQeAbbFWXg2J
         liri37l3nJ8ByR9hhMbYJrT4SiGz7D3bgWolu1bPrIlHUg81TrfgMevnccFDi2LAhHy4
         m2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUM1RArpcYzljJIoPoao3a6oDN/0uCtgPlOnH75SAgyS9W0ihAt8DcpdLk6xQs7yzRjInwFsKoEVUcuHp9O0fvasp9Dtr41@vger.kernel.org, AJvYcCUUs/A0qK75H7M7HZQCMw98FI7o4EIfzU7LXJuL9c3l5FuM6fgBO1U9AJreshLm+4y3V2xu0qxnG9ululYtYw==@vger.kernel.org, AJvYcCW0BjQ79M2ksht0coRKULFXljRulhqwpsOqX5tdJ91ngZXvTAI5+RjSjDXlMaKUELpjL9tl6UK5nYoh8BPZZ4NRhRqx@vger.kernel.org, AJvYcCWCHWmt/sFo0SeVd5BnT11a/HV5q4ZMxpZvRvInJ+U1U2NZVJW5jZxj/1LfWvjWxvAtnufqM5JBkg==@vger.kernel.org, AJvYcCXByDPTjo0mBG9BveVInlfsObuxmbN02PtavMjxPc4l1201VGSm100eUIUgVvA456tKts+Qdw==@vger.kernel.org, AJvYcCXDxmENVC7IghhFgsPuaMD5dZfoPPd1KJ5GF+9w1F9T4nvAaviT92jYAWAgZYjQ2vTgy4mTViSI@vger.kernel.org, AJvYcCXEfJD8ADKdpN4KdcjypBIGV4ffCuAy3SPoF7vyf6hPBuGNfATJOItPpb5IHRhSMoR5MXDO@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCji9e4DjweBUfJ3s2D3kBGEuF+rpgHx2gbXPleQcS+12pnkM
	+0zx5kMjgXkLi2WpMIkP2ts2+Iy5wE+0IY61SB6cMeysTYhQUxbo
X-Google-Smtp-Source: AGHT+IGsy7J8upAtizdqT7cwdExa0Ot6GSfKRh917J35OaiwbZMAM2iFolVRA0oRI0wvfYtn8vWlEw==
X-Received: by 2002:a05:6a20:9f8f:b0:1d3:e4e:ff55 with SMTP id adf61e73a8af0-1d6dfa22f17mr20436900637.7.1728312641423;
        Mon, 07 Oct 2024 07:50:41 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:50:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
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
Subject: [PATCH v9 6/7] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
Date: Mon,  7 Oct 2024 22:49:10 +0800
Message-Id: <20241007144911.27693-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
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
 mm/util.c | 69 ++++++++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 858a9a2f57e7..c7d851c40843 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -45,34 +45,41 @@ void kfree_const(const void *x)
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
-		/*
-		 * During memcpy(), the string might be updated to a new value,
-		 * which could be longer than the string when strlen() is
-		 * called. Therefore, we need to add a NUL terminator.
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
@@ -107,19 +114,7 @@ EXPORT_SYMBOL(kstrdup_const);
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
 
@@ -193,17 +188,7 @@ EXPORT_SYMBOL(kvmemdup);
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


