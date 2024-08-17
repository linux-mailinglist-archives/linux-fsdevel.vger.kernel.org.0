Return-Path: <linux-fsdevel+bounces-26165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C995551A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932D5B22F54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDE12CDAE;
	Sat, 17 Aug 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No9uGHvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2222334;
	Sat, 17 Aug 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863454; cv=none; b=f2JXWsX68P7v1F47ibo5NH2PYfIYhIrH/hF0OpGeJZz9iokcZBY0/CgtFVWNvSFW5/nMGGf636QxSn11qVw0ZxvmjJjnSsOqwg7eAj3g4KfV5bInEiIbTDOHRlO6V3OlYvjdcnYoGWXixMWri4+BmGR2CC1qkH/pP+B9d7zono0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863454; c=relaxed/simple;
	bh=ads9a+vJAdf3fW1daUgzeFpk3FAtZrgaeqt3aAf0isQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXTYymEfaZJo60vcDrfSTR8jgwXADIacEdqIKsLKD6UPZJL8uc1dimeH1AItf+qhVzDgkevTIEQvkbnBto59/KgpXtJybjY4vTkI5s1vCag1tuHusEFxZF+wYobD8sS/tqjnFkElnwq4Tgw2nmkpwb8hIgoIpEqosSMfYvKgFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No9uGHvi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2021537a8e6so8183015ad.2;
        Fri, 16 Aug 2024 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863452; x=1724468252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg8K6fIsZQLFiS7Xpg/1YZlm81yjN4oHJWyrWmInMGw=;
        b=No9uGHvixrC5zhJ6Qf5/Rujx/kNuE/tx4qUC2sbmesSYXTBeOu1HLmGVuwYXv6xvD4
         OFbyAz7bwd5HeyT10mLzSSEROQ4VJOqLj7o/UDzNORmVGasNcy1AlwkJZuW2uO1haagr
         harQUf2iU+m4WYBdER4eFDkwASWaGaDa+gxs4Rd/MZFX7GPgj/j4SaZJnUcVwnHRCZSv
         XuFb7OtvagPmlQ4d2/Xrsj4J2lMqH6/s47HLhOQhR6gQCieNDKYgEPFX0ZEf1KhkIwKC
         yGrdyIiH+VXNFX7/BA4dllwjkPHggG6XRri7Vwf4QHI9gilqa77i0/BYKiG7MjGq+Fyz
         OnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863452; x=1724468252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg8K6fIsZQLFiS7Xpg/1YZlm81yjN4oHJWyrWmInMGw=;
        b=N5+Zq6SO5agAtVPqpf+dS8MFArl89CsxgGy8MXfJU0AE+yUz9vUOpyB92cf3HgrGHC
         jxh2XEVHPrPHyiv2pFCeNeRmwXvTGi25yPgets6/bbfUj8Y03u4y4dCQT2NUQLjKlWh6
         s9Ho1LuS4a/MXHfcFcWtDE7vn0uj2gW0K2FBFQnuJw03StsBLvnGyrpR17e5oljRn/iZ
         CrT2P3BuRGlOagRAkTkoSfXh6bq8VJeuRhBBbz3vS71LSfbCS0losAW26K/iN8wifofw
         QegakhNwAB1+Qq+MYhsUcdXXDaY3CrYHgXfcpNmxenWNG+AXpTOdFMM99y8c5Ikl1rC5
         0phg==
X-Forwarded-Encrypted: i=1; AJvYcCUB5HjKjeJc2b4AEpAWRh2VoReKiwYK0jwypBOdW7ZcJcsodpDAlNGl0IKfST3xbJ3VeWxzJzXT@vger.kernel.org, AJvYcCUgwM47wEdJUaI/gvSYXa+yPC9maR2FZPKh4x4E8SGzX0qTz5nFvDRhzRORUUjuZRrdeHXXJA==@vger.kernel.org, AJvYcCValauww7PVH4JDRq4jZnnh/AwP2h/HsFCyk/ayTXO9uBVdUtjprhVfZ4oMcSHjkev7SbVsB2SxhL5nUuxhlJvU2AYsqCns@vger.kernel.org, AJvYcCVyspMNlPOoadfMhtccXlhqHnUNcH38XUUk4svBbgSSEjeNtqFNq6tVVLqZhJM4jfB30VXYgGrCxQ==@vger.kernel.org, AJvYcCWlmvE379tCHsFz3ZFTswtREL7BmxcWcvD8E8q03S7x6Y6UMSLXqAa60tjF40R+d8Qh9grB@vger.kernel.org, AJvYcCWrO5MMs7pVb1yu9N+aC6EorCnLYTr+Zf8zlUzisZLjeZa5SeZdSGDDOWjqgvUv2cIYw2JmMLYvTH0Kdl1xnVl23s96@vger.kernel.org, AJvYcCX61GWrt/cgfQd8YZiHu6alAARWleabAt/xc4OhxOuH5+K3gboyBcrnmC+ZlwU7zwCsS50pa4iq8wLOfeYOwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn2/3H9yvjYEafBUGDxet94X4TJPzYw2d1+gFpDZbRwcq7QVI
	FlWYl3X6Wr5e9IV+Qcn2bANMucxKYOakq22obqT1sya08jKENEls
X-Google-Smtp-Source: AGHT+IF3ZN+4FrJiR5tCQknEVTwkbUbAx80SeY+AiIkjp+qgoruwIjB5dCv+k+zHBrTId5++7+R3wA==
X-Received: by 2002:a17:902:cccc:b0:1fb:7b01:7980 with SMTP id d9443c01a7336-20203af4193mr61360745ad.0.1723863452450;
        Fri, 16 Aug 2024 19:57:32 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.57.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:57:31 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Date: Sat, 17 Aug 2024 10:56:21 +0800
Message-Id: <20240817025624.13157-6-laoar.shao@gmail.com>
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
index 983baf2bd675..4542d8a800d9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
 
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
2.43.5


