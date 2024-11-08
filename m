Return-Path: <linux-fsdevel+bounces-34080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4F9C2457
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC61C23E66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24082220D7F;
	Fri,  8 Nov 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FGPBeUD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AA220D66
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087933; cv=none; b=SpWSsv9LFTWpnmJFIGZcnGvhoMwMut1OdpCGaWLWetPFT3dVO+rojEm0KCWnFuXIh0pHNkU9vzKfMYc80qmrMSZGRPgfFDtqEclWcm6StNpkgwuMZLtlAl4pv7Qwp3IjyDdACekWXLEcovRKiMPQ2XbcBO1d7AJrB8culgjrMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087933; c=relaxed/simple;
	bh=d/CoZrYwTsgzJr5kdSbJuWogGWKOW++I0TYgIw1Kixw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeC7rryKqgecDRfU3c9S2VqYZ+WIr5BPD5YaZ4JSb096jjS6TC35MOpAw9wv3Ri3tGPX3IcRvECDaZycxcaANef0dNYAiyjdIC2WBlzOnj1ruOzPZKqlRMXvzLaYKmAa+2jJXTxK7Em/hRm4Vu0kBDqQ2NxRctnJoC3FyvkDB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FGPBeUD9; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e6075cba82so1465607b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087931; x=1731692731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OLsZMH/yTrwPfT+lkkEOmz1bcJxf1X+T+9jhpWMtjM=;
        b=FGPBeUD9CWvRB8454/Ea0PAnycYBt8AlyFYEtmmRW3WW+259zUSK0hEFcnm49RvMwk
         E7GrOpFpN07yfuA3IghmeKc/PrqIltF/NxNAhd5toeLytE1NaGHh69gkFkdrWDgB875k
         /O+tFT96QZ6OUPric64N+CWkGvqaa2WbP18rH2OjnJV9ZIys5y37pwfApSI3o6W+Rtub
         r5BkwJT5etbx4K98QQ9nDwLfF2yUAMQydEnIu4VhL9LzQNrbNaz95c/89ATo6dTe/TnJ
         S6iaXGDj+T0I5CQ8BdoMbzFUFEPPjwu9trhzIiP4h4dZv3ujW8ETPd4l8YWopkgOT9z7
         su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087931; x=1731692731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OLsZMH/yTrwPfT+lkkEOmz1bcJxf1X+T+9jhpWMtjM=;
        b=IyYbqS/sWpv4B1zPdwQlcQVMjs9LjPEw1JmgfIDolpu0lA77Dfc1BGFzVWkkmxiQW6
         ASTK22Kv0B7GwsCXYatuXpePahd+Ew9LBEBSMv2oi5V3KEV72f92pCXQyVhikDRcP3t5
         2qpHMnvRGQmkcwbcrjEf1mFYlMYh4cQUDzxcqFi2XqYzNj8C6M1IhA6RGj39kcUUFXQc
         LS23qI9jy+2gjYV+7Wk7sV4W422XRNdrDCmbwqPhyCZJTaxTvT7reFf/meBaDiIZvmwe
         svoAzUu+gk12YFbjD8C7g1R3tWS2jgdSDeX8VID8JsYecWTc/8dk2ruLBEUCVueBDXMC
         P4uw==
X-Forwarded-Encrypted: i=1; AJvYcCWG07Q8RCgC/Svy+qc4OS2pGDpVv4VGlRBdfy0S+z3Xp8pasYLYDWGDjHCdPeQ5/vwRUSStgbgK+0toC4bE@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZZfaZJiygBTrIXzgcOx8TxkvHDHRHWNg4klh06hUH8rwCAmo
	P1YoGyF+TujHMm9h+anzHaQk8i32rgt7XUUWDKaoQzXcL/FCCu2yS23I2ag3Ta8=
X-Google-Smtp-Source: AGHT+IHwGGg69OZHlPE1gXTTmbyei/EPohHpGXOl/6pBBWBH6HgFHFaQI6UOOM7LN2ifcEJcud5MBQ==
X-Received: by 2002:a05:6808:219f:b0:3e6:366f:8e3b with SMTP id 5614622812f47-3e79475a747mr4137297b6e.39.1731087931319;
        Fri, 08 Nov 2024 09:45:31 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/13] xfs: flag as supporting FOP_UNCACHED
Date: Fri,  8 Nov 2024 10:43:36 -0700
Message-ID: <20241108174505.1214230-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap supports uncached IO, enable the use of RWF_UNCACHED with XFS by
flagging support with FOP_UNCACHED.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..4fe593896bc5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1595,7 +1595,8 @@ const struct file_operations xfs_file_operations = {
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE,
+			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
+			  FOP_UNCACHED,
 };
 
 const struct file_operations xfs_dir_file_operations = {
-- 
2.45.2


