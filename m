Return-Path: <linux-fsdevel+bounces-22750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BD91BAD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D383B21A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58314EC4C;
	Fri, 28 Jun 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilGcRyhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2F14F9FF;
	Fri, 28 Jun 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565556; cv=none; b=mX9piUg9d+ujaWCaxTf3RXDIyIkfeK80DAoreN5sgT7kNZSTxuzxyEm8jLbE4RDLVZoH6cgVrzZRUpzN4HvZVgRfUMOuZnnnF8eYWBKkA5E8kJ5XdLCnAqKZAwDx79B9jgbgRUTr4DSyTLm2FbA/F5pKiX0U64Ut4JMyXw14n0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565556; c=relaxed/simple;
	bh=LGO/jG7Tv89MIg13raRY5z42pAUoAbxhcnib171V4yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldMfVM/lhdbOTmmxvx6s+8+8AI0AJhLngGujmwoTe0Rm8gFb6VbykZPXEZ+cH9wAMRC8nHjkFlX3RY9uGx5DyPKtN2sON9u6fUZrCq6IvWE5rVnQag2XOBVg8Q5fSeDosomq4/VUr/2vsokVmbieMDGHrqfy+aSAkUhyhjq8wxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilGcRyhw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7226821ad86so233933a12.2;
        Fri, 28 Jun 2024 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565555; x=1720170355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rSpj4+mjUH2uIm/J6/DitPwV6C8fJ6cAywoYkpJrFY=;
        b=ilGcRyhwdv9aN6E5OCpfdwXYSIFUnL47k41DOtkTPo95zHMkDg+Amb92wt/kccMsbC
         FJ+9oGQbv1rCQvpVU7z71VMs4Momb+4KY34bMSUugstGdR8/J/whqUOxXBZGVhRJaBkm
         kdzlexvwLd5X4p4I71refgnwoev3byv//TZBrW8st3glKRrFcQg8dT0pUtvz0Cnc0S00
         oK17CwT9VVaguCJqAjh3bgxZtqrOS9+TSoeLL32LAoMam5j52+4C2J10xACXqbIoIt1F
         2a1rUymeU2p/ejhqe2/YsBdoitZ63MoZS8UIyanPRxHaWh98oyHsa6FN/1QkVX7GV+71
         fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565555; x=1720170355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rSpj4+mjUH2uIm/J6/DitPwV6C8fJ6cAywoYkpJrFY=;
        b=am8hw9xbShRwhBUfC3OZkOdNHfvWdASu9yAuwsY+iU1ezYB0xJ1yrMgG4Jh2Q/NHRG
         wGO8w2Q9MWJDFtm++omR8NgB/Kb0jq0nAQdIsKv4RkKZjwQpv1SKn8S2zL3oyOr3/9uL
         wqfiC9GUpO6pIxsTTxDJi633Kqgun0io5weUQcnfB/MONnCLcRVD29s+GV4qbMx1+I1g
         fewZkeqSbnwAUofkVcLaJGe1i2C6swrdWWRJOmXydnbSRt5k9cJ4/1jPHZ1YGbaJJLqC
         zMWS4xzF9pvBeIf4gIDRky02hTLgEcG0VICHW2jGS0xCLXQ42df/LD+p8/Xt4h06GRYX
         lPyg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmag/HJABDbu2rf7vvE9NOY3q6hbwbmggfXK3hAViJWAt8553WBogcm6MRKGtRXyxj1CMVcnGpby1rETukgV3xlUPi7Q7gwhdV0ad1q6RisDixn6ElSHwRa9zulLK1VGnaeKxQAr0KDDC3ZSu2g2sfCXG4iNoIsZ4BE3ls6ZZAVAhAPhW9LUYz1dIwutLnnXKVcgA4VOFr1OsU+nzcSbAvcqKJHC9WGipvu/tQHON3cJ0SvudoNQi0vw/v7ME2yIsBvU0//FFLXa7rUUrV1s9OdZtDf7k1bYDXZE+HM/nL7oo//Yrf46jq0Lqfv7cHogWH8s+vQ==
X-Gm-Message-State: AOJu0YwpMofFmef1EcEAuQx2eVNieluoRWb8kPgfHmW6AcaKtzvgu15T
	3GgCUnb62pocxjGGOVbG4dUKigO7NgEel9VL0S5ZEDzpLT0Gxkbw
X-Google-Smtp-Source: AGHT+IFlYRl3xHVXsC7P9mtN40+ZKznkLN9wN0U9RRVR76hQVjzS9rrWerayfKdnpHLG4c4CVUtojQ==
X-Received: by 2002:a05:6a20:4c16:b0:1bd:22fe:fcaa with SMTP id adf61e73a8af0-1bd22fefd3dmr9032557637.51.1719565554658;
        Fri, 28 Jun 2024 02:05:54 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm10473085ad.68.2024.06.28.02.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:05:54 -0700 (PDT)
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
	selinux@vger.kernel.org
Subject: [PATCH v4 05/11] mm/util: Fix possible race condition in kstrdup()
Date: Fri, 28 Jun 2024 17:05:11 +0800
Message-Id: <20240628090517.17994-5-laoar.shao@gmail.com>
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
2.43.5


