Return-Path: <linux-fsdevel+bounces-22050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B29118A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87F51F22A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7E12C465;
	Fri, 21 Jun 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFMqnkof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782153363;
	Fri, 21 Jun 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937092; cv=none; b=UZn4CmnPUuhruHovIrQkXYoxaDBiYqXp12LEhTVhpIHN/4Yqg51VHKvoc1cCucD7Hunt+v5XEC3K1WNud0bppozQcEzcUCeRyHyXoc8GdItluE5+85pWeFRVDM8P4i2tTReGk/BoJd92V2wbss0ieBfJLBSgtYhre7Sdm8Nm15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937092; c=relaxed/simple;
	bh=S6xlHCUZ8RVj52nTEtyM7y4GWTBUgn3H8PypqmREZuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpCD2JU4RJ2TJh0DT1UXN2p46yPXKH3PJYUkyaa4/ihsIG7DoGyGL0uv+E6+dvUEAmgwyOUy6tt0O25rsoNCcDvATTeng/kRdcUJBQxYOGcs9heCAKpTYSJTnq2xO2uv7Dn+IQz9P17h2h2zSoazQgKLjeMeHmPbyb4yHuxQwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFMqnkof; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d218ea7750so832375b6e.3;
        Thu, 20 Jun 2024 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937090; x=1719541890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K+hSkFBa/z9wm4YENh0APfdLPb/9OfvoDMj7Q9JegI=;
        b=bFMqnkoftcJATBB5G1orIk3RzC2QKIHHxJFG3K/Gys/y+WYK28OJtk+fxOKJKhA8LS
         Ca3Yo9OLxxocYjZSq08y0d09SrfynxRlEe7IW9eTcjy+67yR5fFzxy+TR8FUHA60hOSo
         eLyPvlXeR4/cSBHqWfNUwz7r1r8BGC9UbO2sxhWq8AZf81JthSmjn4yddVdtCSzBCoqS
         IIQnv8xu/0q4fC3f4lNSF6PCdY4VbQpPW+OW6PQ4cCx0rD6spCbpuEdYFCYYPm9cHDUa
         9OI8ExqitjdM+lkchkObt/lt0tnYYUXE7xZpYRxvaHPkHaKIsFUDmehsaUttemSVwLXa
         A4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937090; x=1719541890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K+hSkFBa/z9wm4YENh0APfdLPb/9OfvoDMj7Q9JegI=;
        b=FDc2dFDi9YBxT8ZspGuWh22p6Wq75nnAHEJf+OJe++IFXU7w51hkepSgrDe+qVhh7D
         C6I9NiicrMDLHSsCMCkCSkQXVWHvICIi7xinqu086vQJsYHpUxSGSGbpE9avb7vS5Qku
         1nEm4e9IFDB3N2uOmbAGPDNQfCCz8/mdqQ6SRPHIYUc9d74Uy3VENiR5inGzYCntEM6u
         bumdOTcWvRfR43Oj70BywnWBoQ58LxB/r9eE19c8/FuBD8ILRkQMjH3NrKAQQwYQdcZZ
         O2qv7TXUeoXyWSD90YcFexSqAAKxrMJxDAwc5t8XQnH5G20qP+HLHHD1TWly/uchHp3X
         atVw==
X-Forwarded-Encrypted: i=1; AJvYcCXxuxyhvqI2J/PjueOpySFIoVQe63OloLy6GyrGlIyvbmlNkzACvzAKlJoagrGW9AatvZmVx4vPNt32/BTy/2xPfUmoLQgvn6BebtZ069tsQwP9PVJG6OYvW5gwiX7KkxGs5S2Cb3v7iGKVCG6UvkMl4PTNqHD6Cm4kqjRF7mPgHCPsYfkNAeRODzv2yWyammJJM2pyALrYgcOGzvl22gzRl5xvlo9vB4/6b345+rzwielhNckGY4uVDWgS4NTUu/ZQMF51KpySm/QmdKjTX85O5hKQ2VwFxR67Ix9rBD76BWYaWroUdA2Q+nXBG6zj1VjzazX62g==
X-Gm-Message-State: AOJu0YwkwzE1U2ys8lCr4e6V4QE+SDI+rh4ZVOtt8WxZY34Lb4bEK4LX
	yJ3EbI78zu9ZYWlargvOHTxA48j0iPOfHUNtSwT7QxJMHb1zD6KJwW2WfpyU
X-Google-Smtp-Source: AGHT+IGPBhm+odN2LJAX3QWj+Jlu2WkC5FUNop9iFT0Xeg6XFGC2MN7wYjSEAKCdXzo9nJ50WQHXKg==
X-Received: by 2002:a05:6808:1789:b0:3d2:19da:9573 with SMTP id 5614622812f47-3d51b97ee20mr8962729b6e.15.1718937089513;
        Thu, 20 Jun 2024 19:31:29 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.31.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:31:29 -0700 (PDT)
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
Subject: [PATCH v3 05/11] mm/util: Fix possible race condition in kstrdup()
Date: Fri, 21 Jun 2024 10:29:53 +0800
Message-Id: <20240621022959.9124-6-laoar.shao@gmail.com>
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

In kstrdup(), it is critical to ensure that the dest string is always
NUL-terminated. However, potential race condidtion can occur between a
writer and a reader.

Consider the following scenario involving task->comm:

    reader                    writer

  len = strlen(s) + 1;
                             strlcpy(tsk->comm, buf, sizeof(tsk->comm));
  memcpy(buf, s, len);

In this case, there is a race condition between the reader and the
writer. The reader calculate the length of the string `s` based on the
old value of task->comm. However, during the memcpy(), the string `s`
might be updated by the writer to a new value of task->comm.

If the new task->comm is larger than the old one, the `buf` might not be
NUL-terminated. This can lead to undefined behavior and potential
security vulnerabilities.

Let's fix it by explicitly adding a NUL-terminator.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/util.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..41c7875572ed 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -60,8 +60,14 @@ char *kstrdup(const char *s, gfp_t gfp)
 
 	len = strlen(s) + 1;
 	buf = kmalloc_track_caller(len, gfp);
-	if (buf)
+	if (buf) {
 		memcpy(buf, s, len);
+		/* During memcpy(), the string might be updated to a new value,
+		 * which could be longer than the string when strlen() is
+		 * called. Therefore, we need to add a null termimator.
+		 */
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.39.1


