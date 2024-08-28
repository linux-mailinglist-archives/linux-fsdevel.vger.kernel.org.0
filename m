Return-Path: <linux-fsdevel+bounces-27497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74EC961C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB9C1F25D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2C149C53;
	Wed, 28 Aug 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE1XsnkA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDE132132;
	Wed, 28 Aug 2024 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814256; cv=none; b=mzd857QP9MwAXspnmulp80RtFfvWyRnh2GgYqKdxwrJfjI8KT4stDlkd7vPUxRtRaZ6xciqmFNPJ/d+SslhxHCumcZZZiKcAxyttfDt+9Xo/7bet2sZYxN6j3Aja4mChA+DrdQ3P/AHSYHOy/WOesoOzOmNFaRjYInpNYDclxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814256; c=relaxed/simple;
	bh=AKUKeXG3rR4W64tTAZjDR7220EmBnpL03mh0NUmcuXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQn53caO6gzFsLGUSuPKbT/DvPxpD5g6yc3V/ard1A14A5SxQ1U6KSvk+HblGmpFJkmlsM/o0MPRBe5Hr/scdYow4KkBM9ifoOsNclRxJTItBJ3m2DQfBVdTeeCb5vBY+L8lZB9pIg/xzm37tC0dBd7CeGq0OIXjOl+yjWyH3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE1XsnkA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c1324be8easo120148a12.1;
        Tue, 27 Aug 2024 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814254; x=1725419054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9R7Mhbk+Se4PIDhpm0/p6nrldMPUtb+oC6vNd91DMo=;
        b=AE1XsnkAw14RfqXi6Nl1oqdu7S2gdUsvqRT7RHeuW5mZ/z9TLNKk1F+Oxe3/d8t++0
         tBpNCs/w43yuEoFopclB1plI6IZsFBXXa7cZUdBNug/MVqcUsl3GQ61Dxt3hT8Ottk9d
         pJkyXkAHA023bAwEUCiX+SrhyGH0grPpFlt2a6OQMOPH8+vBSbLWzCt5IxIf6vsjsJcz
         bHZwjZD5Ml5p1bxnujfeCqutxK2HaADzu751Numeq8hpDoteJMVUdQ7sn7K8mrlojx+I
         bbbxAsDG2VeVoOLVZH93lwcx0vNVLkc0WqTCx8k26rb6Di4ZTu9aOC0e3fC5ey5Vl4Dm
         Z/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814254; x=1725419054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9R7Mhbk+Se4PIDhpm0/p6nrldMPUtb+oC6vNd91DMo=;
        b=KlfSL4Pl2h6Drwr/i1ttwkod5WSVS69cvGHTOX8jU/mEIcY6kVNhvDNVhAd55WIhrm
         pNXECPaQB8RYuoK2x0WuDIvl6GcTuAH2IShW7l0P3Z5zUvwTRGaTd2JeQno0Zaheu2pO
         I/LcqSZoayvFE56K1ZuuwJmHQw/4bsC9XbbnkkCLP4ytdMzBLfHFlxiy8cVgheb9iTbx
         DHjR7RhhuO1/6gDnvwv4OGISIqOsxrQSWamLlR0Nz042E2SUCN8GXOi5VCH6y3/aRtZI
         6DEg1WdqCYkkRhHAl5viKAPzdzHW6DvuIrj8LM0CSv5XWNBI11KpTgJmDNjDoimsJwo+
         uTGw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+eQr1oxnEkDm58EL8SlSWRSm8fYTtroroNrEqHaBImQiIUbnduriHCpxv5ovGNraADaBWJj3B5fBzTQieA==@vger.kernel.org, AJvYcCUF9Qd3tXnIiatWQYh6lhuA9SLcR8t957sKOkfGA8f7amLZf/IYj5B7QCP1uis1de/RN3KQMTU/0nCYw81p5//439+Uspj2@vger.kernel.org, AJvYcCW8KQY97vn9+V/psunq6WqjJnjgzyP8IJgYcddnbwOvlXm6OKGAEH9jUREdRi5S7S1DEn2Zk88yFMVJsjPJNJzoAvRJ@vger.kernel.org, AJvYcCWGBiEYMB+aQITZlPM9E7iBUWlr1J8tTg+IBfIvfZG8DWCiYMu94IR1/xXxjhz4ISfPsaFh0zZm@vger.kernel.org, AJvYcCWWtsKiNDOH6HFzEssEfnReudmg74mAj9D7KotwjYjJ4uYMwxWap/jca1rwfWOUFDe81yd/gesPlg==@vger.kernel.org, AJvYcCX59CRocOyi+vdEzgWXqEIOrBIeABgsyXF6fS+w8hS8hWhWwDDZ64Oq9H21X/qL1JFsDgAh@vger.kernel.org, AJvYcCXVRFq5BrICch8XvrWmvGV+4k6FpNIWqTXY5LMEaYs08XAqC3VAvi43XjceHYxR/W3OGDqYcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXokGO/NSOaEljZXUG0tDMrygQUvRUnKvdnkC+1fCHStDlCXdP
	r86S8zi2KPSStxIxqJ6ffW+USX4An8BCSPLybL26UwCeeyyRgjYB
X-Google-Smtp-Source: AGHT+IGCtw+zPOY+Vs3gCNaMxterxPo1VEjCCML55T5/9brSfwlu9kiROVQ6nSIbi2XhsLWhhe27AA==
X-Received: by 2002:a17:90b:3b49:b0:2d3:d79f:e8b7 with SMTP id 98e67ed59e1d1-2d843c16e68mr1209703a91.5.1724814253885;
        Tue, 27 Aug 2024 20:04:13 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:04:13 -0700 (PDT)
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
Subject: [PATCH v8 5/8] mm/util: Fix possible race condition in kstrdup()
Date: Wed, 28 Aug 2024 11:03:18 +0800
Message-Id: <20240828030321.20688-6-laoar.shao@gmail.com>
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

Let's fix it by explicitly adding a NUL terminator.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>
---
 mm/util.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index bd283e2132e0..9a77a347c385 100644
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
+		 * called. Therefore, we need to add a NUL termimator.
+		 */
+		buf[len - 1] = '\0';
+	}
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
-- 
2.43.5


