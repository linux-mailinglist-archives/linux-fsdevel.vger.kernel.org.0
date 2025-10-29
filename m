Return-Path: <linux-fsdevel+bounces-66305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F331C1B282
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F974581729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0122BDC34;
	Wed, 29 Oct 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afb8UI02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B929B78D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745802; cv=none; b=thOKoKJMm4BwAr0Ck5OM1bnscI4eWOOjrMyt5j8F6iVJJc/78+fwt2o5kEOjZ29dtK0WR2rK5XItpI2w6ui7IeGmqDwxPmqdPDuatyGfbNWnqYTR7fGZAa60y2yIkanxtzHDmDhTga/ngv0scPwCERmaPrUs+jU2WZfaTyRkGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745802; c=relaxed/simple;
	bh=m5z8JwAcfPmz681g9ABLx9yKpNSDTqrw6F26lbhDvRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pB15/+R482zJoV6Vmp8j/9nHHYnBLG1JGjqMlZ1Jhrs7/D9SVP0OyjUqdd7mEahyVqOa0IKv4/sdtfRl5BGJFBebqmP/AibFk7s7rQbmA2njJI9jCqQnjVyXWPZk33XYg4irJGdOnfC2xjEHNYHlmtnxGNXoJyCmBtB2LNbVlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afb8UI02; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e9d633b78so263420166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761745799; x=1762350599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHRvKX7a1plwcuYKpnQYNjnuqWx3QMHmBPMlGSav5BA=;
        b=Afb8UI02AXrYVevWsAtuzoS7GiUcBDBvlbZ+CojX7oWf/w2ZNKOkEZEZEeClAP6IRR
         rIIPb0F160BD8pVIghA40fY99xPcKlU8Oa/EKu+IeCiPxqnsknPOt8yhybfsC2s3dIw8
         iVGZhUk/mU0kCL/I6tlqRQ1I2yFXEHvFEZUdrKoxOSSXpPEMCZzwDxZgbR+4LqZgWvsP
         IqW00AXXnl3bYa2cOBwlMlPzVv3njnZaL+tWlKDBUMMmmGcF+AqXZ1WWZOAIcf/DZBoi
         fa+dOiafFd9seuRMa1YYhzGBarptxNHkma8ZaKP8kf+LvuMc0YiXFKC8H+2j7pADimtY
         lkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745799; x=1762350599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHRvKX7a1plwcuYKpnQYNjnuqWx3QMHmBPMlGSav5BA=;
        b=F1A95LcLnMMyR5qL/uEtgWRih4c9stXpqk4v0KMJFDtfUetEB3tqnTAXoJO/WCZ8kV
         k/90D/wYhgF4jR2M8I91ZDFRtiuQBE5jnham2HvTyux+HC8rX7GVvVtDtARmefM0Pbp/
         SCdABwUiHhNnzFq+eBWv1DuGHoNCY0lKj8nPF5zTTtyGhPB3WqtPlc8wFekRTc3HAHbS
         TUQq01/LV9o6+3Vq5Fyk7KM7/0ZknqFRigGbBCG2DrpupHmxlhW21JKs3bx7YhT/tNQH
         Lyrs6vPMtsgkKx0qG6dymSnA/U7riXSDNodIruCPv4emh6dpG7ZpMVlnzhAo5mIdqpuF
         Nggg==
X-Forwarded-Encrypted: i=1; AJvYcCVbWRtPffOfQHPlo2KQ/np1NPN3Ll8urIwVf3FrLmeHsF36JMi/CzoGlxCTzjmUZRapN4HIQR/lsa7+Qtq1@vger.kernel.org
X-Gm-Message-State: AOJu0YwdBz7neb4+oG4kDWfxqyUWRitkh/LG+poOCruJTGy1OaMlXSSH
	1i3nElWKWrUB5Qtkti7j/PZdrHbmyMz5Hrqm2YGlUs7trFG+XHmuSCR3
X-Gm-Gg: ASbGnctltf/DsyQTkyvJgnLwZjqWWUsnULWrO6gUOHXgtLp8+X6+026fW6xludi+iqX
	DuMb7oSzqdky9PIw2c4m510oth9OZD9TWUJNuTl3HrBup6O/mvXC4oFPZod6Sw5IXJ1exUOPFuE
	bAjHQ+ey9YaXGwbxEpbDlmpC41seKqilKE3bzaDmn7lur1p9ks751+hNSk1E8ui571uOZieEKMA
	4HZwOIbfXrdlC7wr+XNuTQGDXwy12TG7tbPM1O6jOEg2SqcyLqK9K1PnalIkaHzu1k6xIi6daZS
	GARi8+yrqSDiS5Cp7BRRNi6MnkGu5Z1dvPrkR3OlnzIop11eYXe64g7IKzl8ZNB7+Fd1FnDoAlL
	8EXlUNmTBMNbYs3OrBBTpYGwZDDPnrmuydgJntElyIFtieFEQVTora12Q7QC7aaId9sFYct+T6u
	HieOpjb16VRz/1BYGOerfXy91ixeIyV2DBG3LhqFcoartQTQNz
X-Google-Smtp-Source: AGHT+IEisyenenOnF/O/4pE9L/Z9/7BlvbLNLGDTC1ejEMocq+xGj3sGbfBlGXhWWmAIhGAmK+J0OA==
X-Received: by 2002:a17:907:7213:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b6dbbe71b02mr842226166b.6.1761745799422;
        Wed, 29 Oct 2025 06:49:59 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6dad195456sm900898166b.72.2025.10.29.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:49:58 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: touch up predicts in putname()
Date: Wed, 29 Oct 2025 14:49:52 +0100
Message-ID: <20251029134952.658450-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. we already expect the refcount is 1.
2. path creation predicts name == iname

I verified this straightens out the asm, no functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

random annoyance i noticed while profiling

 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ba29ec7b67c5..4692f25e7cd9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -282,7 +282,7 @@ void putname(struct filename *name)
 		return;
 
 	refcnt = atomic_read(&name->refcnt);
-	if (refcnt != 1) {
+	if (unlikely(refcnt != 1)) {
 		if (WARN_ON_ONCE(!refcnt))
 			return;
 
@@ -290,7 +290,7 @@ void putname(struct filename *name)
 			return;
 	}
 
-	if (name->name != name->iname) {
+	if (unlikely(name->name != name->iname)) {
 		__putname(name->name);
 		kfree(name);
 	} else
-- 
2.34.1


