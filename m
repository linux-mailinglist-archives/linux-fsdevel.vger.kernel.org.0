Return-Path: <linux-fsdevel+bounces-44038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBEFA61A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9183519C434E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD82046BB;
	Fri, 14 Mar 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNrG48FW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67713A26D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741979679; cv=none; b=UlCEMJT/0KfnH0snyNh+z1c7Bfgzn1vlDfQyMZkN88cVjV45fpyEfwQjotq89MRJd7etal9IidpeM9decu1r08ZWEa3dqoC3GIp0rhwme0jcuybKD03kOTdJeEZlao704b1em5uADL+tGQHEJGdzbV4Eb6ZVzO55L8xiD9hqZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741979679; c=relaxed/simple;
	bh=oeqUSAir19HSDcgy3Z5u2895KftMZ6kkhw26NlAY6d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WR66t4RRwXR9LmvLeMlevRN7aNqukNhtshnQmCRvAxlAkXEmZnGDYDNiDBid8BClMvOa6Ap3f4Y7eUDqx/MU//VayBUBpdqCc1cckAAKa6ABkQjyYpXhS5J+IYu9npPNNcqqM9KoTBzU86WWmu2ZhLlKUtfW2T/3VKD5yQYH3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNrG48FW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feab7c5f96so22707607b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741979676; x=1742584476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ2anbtP4Q4wJZR809wsAN7phj3etC/sXSSBU9hO94s=;
        b=kNrG48FWaaObQdEKeZLIaL3OVQ1/T9AhIiOfNzPLQqHJ7JMLzaOdw89DYlkwnyIQLX
         2L1M4iBpXWsr3s7kj1Tw2/VuNSgsod+lrV0RXvYQcbU6EWPgu1E8OS++NwV4tdOghhH8
         ptm+3yb4SLR5qKvNShiyh38PaFSKmFHTxuxRlJOLD3RIKs23dDuiwWWWwdB9tBMMvbz5
         yBiuvxnYH4WbAlPu8hp2+TcyxBeghfaVt/26pBlu/xVr0sdbTDHAAp0Lx7n8J7hLKH6C
         PB72SARt63QKn2h+77xkir8unTjmNMX/Qs8eIhAMtWI1jb14Q8UDcbYv+896xBvQ4p8h
         I5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741979676; x=1742584476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ2anbtP4Q4wJZR809wsAN7phj3etC/sXSSBU9hO94s=;
        b=h8pSslvVlggsXRAUahdpcYI7klsCEo5j1b478JLY9JW/lsTNFZvVwE02FvyVeIDefj
         zwR70PgjD9dsaPCLdc7IMv9y6vt1VWaYFTNwX9o2JBqjUBRFT8pnDpr4Qsbr8DFOQ72p
         1ghDaQL/Cy+296Z9v0htDCIultIIeAedkgLOFJYlCNJRgDSDcU8wDXgB/OwLF6ab6pa4
         erRUWCkTswkHuk3erJ7J3O5x/ZDQKXoftzFxApmt+WRnGDg+aP3egLbpz18hCg9PI17i
         E+OFRwQUs6gUCYtMoBK0m3sz5J4kVCpNEmoaSZlncny9/lnC/6oTEiBCTPKM2NIFX1fz
         ehuw==
X-Forwarded-Encrypted: i=1; AJvYcCW4aQ8XCS4CeUBMFxx0xDwChIj6pWyIXEH0uVllKjNDjxT3r8a2zlf2asrq75kyyl1v/XPKzufKVzu9F4hb@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdl7AwUNBlwtXVvph8+0LWM3yIh+B0YsRRUsqPU0Ap96j9omr
	SeueIu9MGCphqQNhawSgW1Lo4kAH23EB0VO4UeGF/g6zisRR6FnJ
X-Gm-Gg: ASbGncsqs4orQwsES/zY7IrVmQlvoYIQRJVNliOWBwGhiW5xm6yEKm0/qXdnp4BHRDn
	vlUU4B40ub3ggswgKJwDcikyAQEj4i/ZzJsRJtRqO+1Qq1EQLMaLR4ejicfKCHuI7X9UuirrqM6
	P3dOCm8Dimye56ZCXTblPW6ARaQ+/7B4LayfGL5G1L76M4IgQDCol7/5wBd0+iaKfTiLtmmuMWI
	DZ8ccBB/IS3RweYTi0o+35um4aFJdhd3dD0yTPzU3LBuGZYxiXJDRsPki6snhaR5Cf3yLEAjzsS
	ykZEAMFaYEm2OvK8OlOnVaSbHohdi3oNZQ1AeMdd9A==
X-Google-Smtp-Source: AGHT+IGO+SGy3rZKHpfh27aXKmFHQtzd+6pZk+mGxntM/A3/VF2jkBw+3GRSxyz0kQUeQZK0usTO/g==
X-Received: by 2002:a05:690c:61c9:b0:6f9:af1f:fdcd with SMTP id 00721157ae682-6ff45f4aeb7mr52579807b3.11.1741979676199;
        Fri, 14 Mar 2025 12:14:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff3283e302sm10109657b3.22.2025.03.14.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:14:35 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH] fuse: fix uring race condition for null dereference of fc
Date: Fri, 14 Mar 2025 12:13:34 -0700
Message-ID: <20250314191334.215741-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition leading to a kernel crash from a null
dereference when attemping to access fc->lock in
fuse_uring_create_queue(). fc may be NULL in the case where another
thread is creating the uring in fuse_uring_create() and has set
fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
reads ring->fc.

This fix sets fc->ring only after ring->fc has been set, which
guarantees now that ring->fc is a proper pointer when any queues are
created.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
---
 fs/fuse/dev_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..618a413ef400 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -235,9 +235,9 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	init_waitqueue_head(&ring->stop_waitq);
 
-	fc->ring = ring;
 	ring->nr_queues = nr_queues;
 	ring->fc = fc;
+	fc->ring = ring;
 	ring->max_payload_sz = max_payload_size;
 	atomic_set(&ring->queue_refs, 0);
 
-- 
2.47.1


