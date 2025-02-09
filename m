Return-Path: <linux-fsdevel+bounces-41312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B7A2DCB1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764B31645D5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBD18E764;
	Sun,  9 Feb 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB0HYRwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648915B115;
	Sun,  9 Feb 2025 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739098575; cv=none; b=Ojet/iuSrPDd+63AVjcGhU7aYWadUGL9o8cBGjSPUmyRp6Yy6TFWDmSszsdDiUqWHp6zDMSxlQnpqaDffdm6UjUILd6RVOPaUglUlu0pUSW17uf/GOCd1Ap+rwIZ5OZpq70ipYJGTFodF5QLo8aFun5Z+9ZOwRvR4Rfp/wJ1W/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739098575; c=relaxed/simple;
	bh=ONiMjHHVdhoYqpRD8ahcIFtIUNmu4tA3C9QJfm/kNOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzGAkbothSeWcxSzrelfFv4WB5Ox0RUUgot5vZxwHpqblfmqto/dDDoky4M5438IAq4cKReFUFrt71RlZRfgkXciygwQ40t3UlLKEf/8cldyCnKhWSLRn4mmUV51SPxkTIpzwTxmwChkcYoadGIpKUvk4Xn38x0Y4y1ZtMrQyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB0HYRwJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso9207745e9.3;
        Sun, 09 Feb 2025 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739098572; x=1739703372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofvb9pH0Z6dBkKkuyOdm5LbIOJbx3mZMTCci8CTCe0M=;
        b=MB0HYRwJkA0QQIOxY9CRbX8D4cMIJaZmaV6QCmd5LVI9McRW66gAXUVgE9eHbRcPse
         X/XYFO1fxH4YZvRdvSPf74TZXSkMVpZ5X0YHVuEqUsY6Ln+La03pAuct0knSwO/Y2V2T
         o1JSr+5DU8CEsiLPpW56RwJlIMiLKsaG7FOzCPpyE2X+VCBNlhjVJXJO4lUG0C9QWaSh
         38IE5GJcZOavavxzjsU64VJdPjTLfhXcJKXac3kzdIZdYlKRmk0acjXv6Rkp/Cg3EQIJ
         Q/2TD1OCYmV4OH1dLjfJPj8aZQaNviuvgivCMBBk84vc0uSZ8ZCouzglckrGImgIivsX
         v5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739098572; x=1739703372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofvb9pH0Z6dBkKkuyOdm5LbIOJbx3mZMTCci8CTCe0M=;
        b=eC0xXrdpVPdCqR2MyP1cQUeqHg+tsJ4H1GzhtSLYPR6Xjbj4Of9TdCJuEkJSkoGVdz
         Xy3sff9aM5KbOIoVxPm4nkDcKgI54q9VirPlbImfK+rbjJlahjvEpte8rNFsx6LIlwWs
         QAxN4dEFcKVOE7w8fe8R3Jd28IGH68+nL36fM8JbNkTg9BiRTs1X0csb0YFkU4TfDSBK
         gl+e9i75xGlKwGDSfYZJrKTHdNffM9h3NzorsMteNqSn1buK2COfBDzmLeD8bfD5ruTj
         yX8zT7QJRfj+jnDndQQ0Jc6canK9QsTvPyGbwYg/AeYV/soRrmuur+Wwo/u12SDq/BKa
         sHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxpbSXD0uonKp38/HpIpMUZY+ZPswGvBaUP7Lp0Kq4uM2WN/6Wrimy+GMCVueNzL9J19bVj8nAEVApxZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOaIdxqDs3vuqTQ/d1iRxL8lHSX9Qe5cNG+EniC8TJJJATrOT
	2zEUw75GEE0IgT50B//wf43rn3T8mujelyOgbG5p7u/GdhopP85g4KpfJw==
X-Gm-Gg: ASbGncsjJy8DMKdKsy9tfXB0dXZSC/Z3QaWfoTHoGlPuDHnDv6PVyzgXsL4TNkKHyYb
	YfzfduZ6cizLLQK5CtIB9N/ezMwiJeq/vy22ewnJkUaGFL/cfiEIekbMMVwpJvhxXO3b/TBgkBx
	HnArovBdX0vmdcqvIlphIOiNujtlVhKg+hB9klqi9DLI/EBGRcKCgy7hNgGK6GhG+SbMS32ZXzM
	Zich1/9t/PP3QGnOepkRkVgK+CLrNefvgG5jRr6VK+WihZHcqlJMKnXSVTEPIRGi9ZRyBwyndzb
	iYlImFUP+xapDeVHVCODneApWwjI0qU0hqBtvE5IQKjuBqukN+4TXqfUVKERs5fBkAJ568xI
X-Google-Smtp-Source: AGHT+IGfedtCnoqqu0WKQxB1WNNXshg1L9oFgVr24twpRh84aojcjQeKQaoft4ruOZ0M4f0PguiDtA==
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr30970415e9.12.1739098571684;
        Sun, 09 Feb 2025 02:56:11 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb781bdcsm6325791f8f.23.2025.02.09.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 02:56:11 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
Date: Sun,  9 Feb 2025 10:55:59 +0000
Message-Id: <20250209105600.3388-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250209105600.3388-1-david.laight.linux@gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2865baf54077a added 'user address masking' to avoid the
serialising instructions associated with access_ok() when using
unsafe_get_user().

However the code pattern required is non-trivial.
Add a new wrapper masked_user_read_access_begin() to simplify things.
Code can then be changed:
-		if (!user_read_access_begin(from, sizeof(*from)))
+		if (!masked_user_read_access_begin(&from, sizeof(*from)))
			return -EFAULT;
		unsafe_get_user(xxx, &from->xxx, Efault);
If address masking is supported the 'return -EFAULT' will never happen.

Add the matching masked_user_write_access_begin().
Although speculative accesses aren't an issue, it saves the conditional
branch.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index e9c702c1908d..5a55152c0010 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -33,6 +33,15 @@
 })
 #endif
 
+/*
+ * Architectures can reduce the cost of validating user addresses by
+ * defining masked_user_access_begin().
+ * It should convert any kernel address to the base of an unmapped
+ * page (eg that of a guard page between user and kernel addresses)
+ * and enable accesses to user memory.
+ * To avoid speculative accesses it should use ALU instructions
+ * (eg  a compare and conditional move).
+ */
 #ifdef masked_user_access_begin
  #define can_do_masked_user_access() 1
 #else
@@ -41,6 +50,18 @@
  #define mask_user_address(src) (src)
 #endif
 
+#ifdef masked_user_access_begin
+#define masked_user_read_access_begin(from, size) \
+	((*(from) = masked_user_access_begin(*(from))), 1)
+#define masked_user_write_access_begin(from, size) \
+	((*(from) = masked_user_access_begin(*(from))), 1)
+#else
+#define masked_user_read_access_begin(from, size) \
+	user_read_access_begin(*(from), size)
+#define masked_user_write_access_begin(from, size) \
+	user_write_access_begin(*(from), size)
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.39.5


