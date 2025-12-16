Return-Path: <linux-fsdevel+bounces-71490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE2FCC50ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DA030402EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7583370ED;
	Tue, 16 Dec 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="YD4REUXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9572EAD1C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765915222; cv=none; b=jLSlb7uEiQkY5TrxIISPgGK7W7LqA5/WfaSEUktmN54IVtgBtMny1wlHZ9zwkJt+2oX8BXBffduXmx6XC6DPtctcZlQlk7zxRmGZbn1ttsr/7mZz0o4GSpn9DRR3hpyA7qfeEirgSqzWJWifd+UffS84zlPjcNhRMNjcuuQz5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765915222; c=relaxed/simple;
	bh=W9myzMlDVTfDdzd2dxRqugETmI9Y3kZ4dF3KewVdvTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY+niGMfiMMJj4jLE+9H18E9UUJ/aDrCiAyCAa7i4SbnNyCxFzm3YcN/iNEakyZIEjzxpVVvnd7lkHgJ3VgEASpFpY+ads4NG91YklevSL55Yp4LpxR2mpDlZ7AQO9cILxHXoKIeE7SVy6PeJ7sEDZxww2aGw4p+grWxrotZvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=YD4REUXR; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78e7cfd782aso26863507b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1765915219; x=1766520019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce5/Jr+wXPPAgYBiuheNMGHCY0MttENpNDX20Yhq0K4=;
        b=YD4REUXRUHGvS+huWIEc/0By59SEsOz7NPuFVFelPHCkReK1Y96iqAeWPRqWjsXRLF
         5AyJeUh5MFtJ4dQ+8J/Ng4Zpx4fM7oFKsc9x5EVYxQSV5isdjAEJ+XKH86txNI/uTOjc
         NfZD9Xq56P+0+IDR2Ez4H6lPxqeSNkt6kV20Yc2a+O7RVxYPm8/502Sfm5pXKxSLQpsx
         rhImIGS5w2/5V7FDKjnZX+GYkZFgwhhpkP112eMb4WQ1sOH9FjGD1qkmJOySmL89YrYe
         rdwNeFQGBK8id5PUS3+pMY8PcfY8Wlbekb8IsPxLAmNdilNCo2Gs9+se8P9pqzyNlvV6
         LH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765915219; x=1766520019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce5/Jr+wXPPAgYBiuheNMGHCY0MttENpNDX20Yhq0K4=;
        b=f0HnG/3h2xuc9RRkBBGO2h2PrR/XSp/Jn05P8Qbv44QjLHIkXhWFsu+gZCZXlXMDuU
         sl6T9sgPUCRgN7VkdO/HNp1MZ4Isqss/dUTiaA7tB0+u2XdX9BpMl8tsdfN0/lyMKGoH
         iaD1R5GJqlzsI2D45Ld/F6t+ZqpZJnpEQxC5p0JuhE45wK46DS4+ERXGSieZ86492BUy
         /QFFVP2O9dxJAMCUXYwPq7kaGZmhXKxBzwYMU056EOqm4NlXZr0qwuu3UMwkVo6Mkw2q
         IU+z627I5QmfA/NO3riuvOw8zuYisoqCVrB+g8NBXOfQ7OIYPxLPvbYpOSe0qmuNoDD0
         1Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCXzIJYqdVT01t0I8LgJocxVFG1SHmPKI8zr/q+D8DBPQxtUtN2BhG2RcmzOc5o5XN6PVt7lUrBOBHu8wQ24@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqR58Z2Tw4Gb/kKMBWHlqAAU2dVAQkEQEpHh87N7LcVfICIvA
	+F8Iz7NuECKaz9PT82I0yyUiMXysS6gpz3Q7+pO9mCYhNLS0EfKhCGiAFOC5nQ7Dx1Q=
X-Gm-Gg: AY/fxX7eJAjxZyRdN8b98c3sY1m1JbryiHi5XMKol1Zvtcud8ZVOOYzKLdNVBe5FLyY
	UCLPnowP8e24DofkpQvJX58R15pnrnIdtxcLVse6XKSxpKhjdbx13RAwkADqC7dhP1RFBXsrSC4
	A+VU3MWnWZq4QFdqw6UGR30kcvEauXN1heM+OkMSPJiTBN2N+UgcxHPAiNxuCSjA2nncvoMYS1y
	d25VVD+EvVvWT5yk+XEqYWgY9SOxi51/UhBlO0qwPwW6z1UjgjyB3txtZjTsmrR43enui8ISLzq
	qwW6YcHVqn1QAk41bI5OGYkddJjdNrTUkjohGg4D/YSy058YlUU2N0jPOr1n24+8Unj03VQenqN
	a8ejbjLIIJEFFmYgvHe8CQ1Ff9WJDvmqJRqEP6AZsnnsmWOkHMmLT1Yj4X187awalGIOk9Co4iE
	fmn9qAKjHbahY5PSOARFPfXTS3vMHRtAxJkj0luAY=
X-Google-Smtp-Source: AGHT+IFss4XifqHhQdhVU+8YTknoHGIrjYBMPTiUOuaw5AB/60y6F7hQuTuki2v3rPw9Z10H0e6/0w==
X-Received: by 2002:a05:690e:1c08:b0:645:5b0e:c916 with SMTP id 956f58d0204a3-6455b0ecbcdmr10495906d50.3.1765915219244;
        Tue, 16 Dec 2025 12:00:19 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:877:a727:61cf:6a50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e5bc1sm42744327b3.30.2025.12.16.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 12:00:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	Pavan.Rallabhandi@ibm.com
Subject: [PATCH v3] ceph: rework co-maintainers list in MAINTAINERS file
Date: Tue, 16 Dec 2025 12:00:06 -0800
Message-ID: <20251216200005.16281-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch reworks the list of co-mainteainers for
Ceph file system in MAINTAINERS file.

Fixes: d74d6c0e9895 ("ceph: add bug tracking system info to MAINTAINERS")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..f17933667828 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5801,7 +5801,8 @@ F:	drivers/power/supply/cw2015_battery.c
 
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
-M:	Xiubo Li <xiubli@redhat.com>
+M:	Alex Markuze <amarkuze@redhat.com>
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
@@ -5812,8 +5813,9 @@ F:	include/linux/crush/
 F:	net/ceph/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
-M:	Xiubo Li <xiubli@redhat.com>
 M:	Ilya Dryomov <idryomov@gmail.com>
+M:	Alex Markuze <amarkuze@redhat.com>
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-- 
2.52.0


