Return-Path: <linux-fsdevel+bounces-24394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38B93EB77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F1281C02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7DA7E576;
	Mon, 29 Jul 2024 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1wDZDN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07267C097;
	Mon, 29 Jul 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220803; cv=none; b=kCwjvQtdDZQSDeR/LnR+Yvn9p8nhbestVe/+QOtkkuQwxLR1MEWIyDXod5oS1udgsKknCeI80z5ktXOWVtWwqTKpjKKEM2fYjdLPIBdMasEfkXb7hlhTm6E0xM4tvfCzyFIlot31R8Dp+TVYMNOa0LdD/Zl2MQEPR5TZfs5UTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220803; c=relaxed/simple;
	bh=LGO/jG7Tv89MIg13raRY5z42pAUoAbxhcnib171V4yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpsFKQEpBPLHleg7EgJ/xhqWSYZnCDv/yXHL8IMtMZIdooSCGO/4QMe9WNW3nMdEC5OtLTjnrr6sbKNfgJgmiO+liBD3uvXhwtiwndqLeDr9tBpg+3XBy0N+Y6ki4U9gveCfqlJR7bbnlc3Mtd3pnZSCnQf0u7YivTIFU7J6+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1wDZDN5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so1535142a12.1;
        Sun, 28 Jul 2024 19:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220801; x=1722825601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rSpj4+mjUH2uIm/J6/DitPwV6C8fJ6cAywoYkpJrFY=;
        b=I1wDZDN5coC8uIxvA2mTRhc2EPYUm9cohl7OVcnBJ4Ln1cCirbEeABMP5NUOLWvU2g
         5lfpcVOAvTWWbyFnc1TJTdcobmC/qakPErrhytVzxzXZiK1Ob51vr95xTXJkCxkDNN/J
         tW9hkp4+DTPU1Kvwe2umx+U5iq8KqE2tqXdUws5OvuBcyJ/eeQfAt00z/qgwNbpTb/WO
         m95EjlKfknAcp9dVaC/yXflygwOPS/qPAZTc2bM+W7Erh/MPjxPRWthNdnTDib7/v+TT
         wWk7M9O5+WGpOyzSGYplOHdz0b8qgEuFpoJ7bdgUVfgmCh28gUAoP5mU7DkH03Xrx65i
         Eozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220801; x=1722825601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rSpj4+mjUH2uIm/J6/DitPwV6C8fJ6cAywoYkpJrFY=;
        b=F08uL+g+G/9GXkNcJtgPd8q58U8q+ATC4xZ13wS23inMNs0YhlgRssLnmXDk00EvsQ
         74nbGJq79hHL/HQ9ID98jI99qsog/b2jtoqYFUOKqZXv/CBEveEKogMMAfqqqJf+Qz4S
         QStI8oEogKCSk7CmHdFsphrMJgiWCduxAQF88prkOavUEINoAEeS8Svb2SV9vs8Pf0TL
         +WnxZSIqb0ga/UAvSYyp6VDJmtHHWtDIJKwwyYtjC8/Utdi2Zzsgjena7p5sabQT/1fT
         qG8UJWneQgGGYxVcqvfAApq04NtlWZv3eUFMt3sWxiJT2P2nNUVwGNs+CNe2gKQnHBN1
         eUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUR9jMsV0b+PKQehXUeLzz6jwC+jpOZr/oUPzAtDONozazNr2HcQ05inr5h0w0qpQt+ZNrVpFNWFpVqPHmY5RJGfQr3e9K4G+T4hgfevxuLXu+Kxhd53N4Q5h2/duM+6Vc/zsj8SGU2382vO5nkywdnbxjjxIdL3N3PnRhPUrGW2nk1q4ReSn5BZ3LvaIumNE7fMPniAdxSSiSWvQsp1qqRZT6iARzyvIQgz2sJyGugD7oWO2/w6mMAM7dzgluxBOcMdQrBGon/COlH+teUzsQ1LJPd+0R4p1l6pViBn0CJQXKzFjzF/g72Mx/vBdMPMBM0KUgT1w==
X-Gm-Message-State: AOJu0YwjE/5QeWA0qxrz05lY2BQVhSxFfB8obUGi/6vAu16MfPrCBMz8
	2UFd2AO63kUMrVqoQVxv5uEmsTmpy9iSAyhQk8OAHXsevqXfrEsu
X-Google-Smtp-Source: AGHT+IGTYP+13dgbaXUTcOaiyJPHukRZsfD9pPSgLtBCe0th4rvzpLqZDHRAsUFno3V6NU5AaOlIiQ==
X-Received: by 2002:a05:6a20:a105:b0:1c0:f2d9:a452 with SMTP id adf61e73a8af0-1c4a12a2e61mr4874235637.13.1722220801130;
        Sun, 28 Jul 2024 19:40:01 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.39.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:40:00 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 05/11] mm/util: Fix possible race condition in kstrdup()
Date: Mon, 29 Jul 2024 10:37:13 +0800
Message-Id: <20240729023719.1933-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
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


