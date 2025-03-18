Return-Path: <linux-fsdevel+bounces-44229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87D7A6640D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2021896268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96F49620;
	Tue, 18 Mar 2025 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvv5d17R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F5D528
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258543; cv=none; b=lLihckGSEc/jLFqzCt7W+bcpcCsQEOty24Js0KuKwlafA9OMo/+NaXrDinMTMxlFU04BnxJ4GCkc2laa8E5EZ5IEvumR2jthjix+mTsLX9anZpEFx1NKo7xK6wiXqS9R6/FMhCGVnD50N8/8nkoXtrK1Woqp1XT1gHL8Vq1AfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258543; c=relaxed/simple;
	bh=TrKHTqnAc8psWHA9wwBuOgOyApLKDpWkEDTCymEPh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zvs9c0YaIf46Vcs6chInntP5XGnvzy/Jp/U6E0+BXLFsT0loOYScDwPJPKEXHicqtzrU43LATDuRkkBIb6f/18IKFnvxm8GejB/d66XaDG/4s4iCiPl4kNdbWAvKg/Dsab3LJr0ka9zJrIfcB4DLIxCj84SVlR4p0bWIGFMcG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvv5d17R; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fece18b3c8so42460577b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742258541; x=1742863341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du9wf6xjdLnQ/AvUamvScmpKiuN1WUcim9PLb6tk9+4=;
        b=Mvv5d17RGB+QvlY2wV1naKH0VC5uzzpi+kwGw+vZHTHM+1fTzNjQa1zHpOuhzPP+tC
         Pt9QHpcRZf80h57s8wfErC/hRhYNEd9SkwW6U8izFVAuZq2VwE4CexQcGPwFqBGHDQxb
         ZOgRRAEUmnK/DXcQdCzj6JkBodXXlsC5cA/2kYwgKwH3qABmExwX8SyGv847bFz1qei3
         emjVItvCJlaLhIK9VYC2QKYhpMoosAozJa6UrqMPDuCMkc4YHRWBH2r17Tc6RuV+bPrw
         bIh9CM+T3H545Q6r9TrPeIVbQiFKOedM6q2iiT12UN6/EFQHu2L7mI+y+9c0ieRMVr4Z
         M0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258541; x=1742863341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du9wf6xjdLnQ/AvUamvScmpKiuN1WUcim9PLb6tk9+4=;
        b=g7qpNShLnoLej1ZIIfibDVxspdqQV0UXbdu32REuGT9YhpiwdCbahKNKQwiq8wiATW
         pEW+pdDMYYcvf52fmKcYdE7J1CIACpC7LOFObgXBGyyFB2VhrrwnzmY03a6u9A/e2ucp
         R9qFdeuG+Z29Q/BZmsbtsUR5RTlfow9SHyvSb8Ig8mjEooREP5WM3GVwMRmYWggZBi9N
         diEz02UA4nyG7WgUP5KPJYJQS3HsHdHwCQM1PlFcypQJJ03Yu6baiwpZZgWn2gtOiPYl
         JzAtwMAID/OPReqZC+ekLpnHNKTqn0O4osf3TRi9T7HvIdpEV41VuZ+0jDK2IM0MYfmU
         cA2w==
X-Forwarded-Encrypted: i=1; AJvYcCVDgbRrZ39j9qo1qlJOPMP4ZTeE3+QRRKam/IlVYHhBk0/6B0Ftp0RViO2fdeohunitlmh/qqcjqm7z4yIO@vger.kernel.org
X-Gm-Message-State: AOJu0YwzELnk39IwDqh/mH9LQNXrhaLVUJSiYaHsm9eab0BJ1MlH6PyP
	qrg4f5GS5GkesdO/O3SidxG6fKlCPgaQn4cmhEzsFR9ZiZBqIAST
X-Gm-Gg: ASbGncu2nfrkcgnlK2G37l0DOn2eHmM2X6ee+wiWJI+5uAfDJxLJU1nWUbaU+8W0OlC
	ynv2irho83c+LHa0UGC8F868MLLrA2wX08JGXpS9wn4b5xSblcmHntVUAElR9OZXv5jYOKDdkem
	gR0tYRzFcA31hI0gAMmv8vui7/dAmzsJ2AbKFYSGMGlJlVb6HWfsuZ13BtqybiicHveq16XWsHJ
	uC5wl1Xr5KSNpuviepFuxlnIWnxYGldxrP2hdFl7hOfuCvI/kG4WaLNSffG8ayiQaPOeeXDERI2
	uf5R04Tpf7ikJIB6FwDqUDwjU1vZT1jsEE2w7hunDw==
X-Google-Smtp-Source: AGHT+IEfW0IQXrOrmJXEq7vjxOwuCRPPGLIpjt7WVVifbGh7YHMp2yoTYroaHINwU/UDQj3UtEwtxQ==
X-Received: by 2002:a05:690c:6011:b0:6f9:9891:7a7f with SMTP id 00721157ae682-6ff460b19efmr174500267b3.25.1742258540748;
        Mon, 17 Mar 2025 17:42:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32c7c2d7sm24480697b3.77.2025.03.17.17.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:42:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1] fuse: remove unneeded atomic set in uring creation
Date: Mon, 17 Mar 2025 17:41:52 -0700
Message-ID: <20250318004152.3399104-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ring is allocated, it is kzalloc-ed. ring->queue_refs will
already be initialized to 0 by default. It does not need to be
atomically set to 0.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..f54d150330a9 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -239,7 +239,6 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	ring->nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
-	atomic_set(&ring->queue_refs, 0);
 
 	spin_unlock(&fc->lock);
 	return ring;
-- 
2.47.1


