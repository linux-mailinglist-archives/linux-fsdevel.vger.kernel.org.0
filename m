Return-Path: <linux-fsdevel+bounces-71833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C7CD6D90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 055433002FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD3338580;
	Mon, 22 Dec 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCXZkbJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5353385BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766425363; cv=none; b=Xw/A4nKRkKE8p8py6aQzZHcYpLkHWWaxwqv//hxywN+/sPqjasayWS0QLb7YcZ8sxMIYHNj02PGxc67g+T7rvnbe87l3xonqaHI6WmauYkN6kwBHDRhcmXnma3LN+vEHc529JM0oiDYDFIbKEdtJfc1WGfUXD8eVzG8T7AMJgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766425363; c=relaxed/simple;
	bh=5XEDHo/MEo1oeqzo4k8BNXaJQHhWq75fAaPjDpLCgv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYCWaQwOijdAAYlnhk0K54Wt4e9X1odqSyQfXW0rLN3UcPm6SP5YZd3kZ6cRl2fiCiimQognzio2y83qBYGL5CZFHiXARVs7tLWT+ZR0rl3Y48uRIGl2z6+2uMxeuAPHrF5i7Hoi1EUBioo6X/2zCUCRgV8bOCdJ/+6Lr38cyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCXZkbJv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so33661825e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766425360; x=1767030160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdLHLbhEkeqkx998gf2zcQmXjQM25BTRi7QLi//XCrk=;
        b=hCXZkbJvmETbeF986X1wDbOVfcV2QBgg29hEeJQpw5POAjdC3Rc0gB6eiJ1WZnHV8s
         l4MBMNknSuWG+blVn4URyUWa8Ssudgo0f5yGB7DJJnFqcfTf38Uepv3qIt3GY8GdqmlX
         NeyJq/mLyu7WHfx6dlt/DACw0Q1asxBvknVkHXJQYW4m601n/mOwnJU57YVVxwtIRWFX
         OsfvuP20xL81kOwmCn9ky1cSsHdxXxf/aFzqS8+3z61VBuuqekS6X55FrHnmSYXho1t/
         RVpd+MueOvXZAjDzBUekTUsU1IDgggHg22AFe6UpwgIKtlI5WpNTCXJ7tqCWxuVNkyFW
         gbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766425360; x=1767030160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdLHLbhEkeqkx998gf2zcQmXjQM25BTRi7QLi//XCrk=;
        b=Oerz5wApxohZWAxTU37DezvMxSmUZdHR7DifzOe1v+O7errpDTGA4tMwNqu4ARofU4
         JJ9DeuJ/J5iQLYTaIQnKJ4z2wiklIBWQpKusWDSNGq71gwIPAHsOQYd6QCRuQ4Z2ZvHc
         5K34I0BQ/faxQLG0GpyXUh++ueTamb7PbjaXgbyYNHkcwnxCfcnf+2PU2CPC4vIAxds3
         uHOiVJYkiGyBZKuOtZartfblanB03hR+bhTu2DlhT0gvWWUM1+mXn8ThdFjDMnwjsBbf
         0pA9H1jaZCLy+wW7OfNF8DEAFGnnMxwv9zQoBKsBfwrfrgFFyirn5sByGfbABtfkA0Wz
         MzUw==
X-Gm-Message-State: AOJu0YymS6Y9dFfL+R2qKrTNB8Q2p1hd60+gY6FIjIPVT/aqQe028QrV
	bYlTDHC+sMPHoCtOvLCPlR2lecZNhW89aKi9AuSMtsnMnemLtnrc/fHU
X-Gm-Gg: AY/fxX5X2RvDKPU8vjC3+5Uf8Q7pZYJHWZVbdVVx/JeaDZLssF1AMjJxrn+2t/fSlIR
	1sh1eq3myCwYrSsFpwYWJiK8tKZgmwudqU/TFW4t0vynPcOMmWJVwCe/AdFOmalRqoSgLwko9Xl
	F4CcxHKcAGKX5QOzeZarM6zARCwznZzQSUTM3ARydbICyPwHCqPyfGjQmlVSeyLui83gQ/m013k
	egh/hWC0AZrzLIXqKLR9zOemrpYfaXne5CcQ3qhoWOBURwrAp0yCFVJpO0adUZZfrjfaot8uEl4
	AvUyLW5WSRT6WQIBoEm1+QmKRqxWMmRDUT+7TuInOjLwYDiL8P1URqM/jID0C2czIA8dCYLRGFb
	C528x1GSWASNBbXs6QcthjJBByg9WK0WmH7618xfnyuw7gtU7A1JcEoVILJcmzfJ+tcUuzLC/PG
	1BgxeQoMATSby0xuINjL8dyeHKizIRo1Tj5YqLDN3bmpGXgsRm0gnf2z4lExmVOZKvSTVXjrMA
X-Google-Smtp-Source: AGHT+IGpUspWfOww5xR/M16SXxIQR1jtsxUyK9b9hx2bl0LlUSt0y53GfzRHsNxkqAruMVMsRr2Lwg==
X-Received: by 2002:a05:600c:4511:b0:477:af74:ed64 with SMTP id 5b1f17b1804b1-47d19593992mr112081445e9.27.1766425355849;
        Mon, 22 Dec 2025 09:42:35 -0800 (PST)
Received: from localhost (224.85-87-222.dynamic.clientes.euskaltel.es. [85.87.222.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193cbe58sm200372525e9.9.2025.12.22.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 09:42:35 -0800 (PST)
From: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Subject: [PATCH] proc: uptime: print 64-bit seconds values
Date: Mon, 22 Dec 2025 18:41:41 +0100
Message-ID: <20251222174141.39277-1-jaime.saguillo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uptime.tv_sec and idle.tv_sec are time64_t and may exceed unsigned
long on 32-bit kernels. Print them using a 64-bit format to avoid
truncation in /proc/uptime.

Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
---
 fs/proc/uptime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index b5343d209381..2b83435ad01e 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -30,10 +30,10 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 
 	idle.tv_sec = div_u64_rem(idle_nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
-	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-			(unsigned long) uptime.tv_sec,
+	seq_printf(m, "%lld.%02lu %lld.%02lu\n",
+			(long long) uptime.tv_sec,
 			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
-			(unsigned long) idle.tv_sec,
+			(long long) idle.tv_sec,
 			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
 	return 0;
 }
-- 
2.43.0


