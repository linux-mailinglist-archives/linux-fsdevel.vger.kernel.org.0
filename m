Return-Path: <linux-fsdevel+bounces-34160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802939C333E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AAC1C204F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDF192D6D;
	Sun, 10 Nov 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nNgGyGlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB175D26
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252577; cv=none; b=NuhvAeuYRSQV4zkOi3FjqzKQ6NkRC4X1g9vV+hpOr9C7fShkFqo/qzKAOri5RSUmUiQdHZJp0hXoWu48aESgDdPral67fJCt+1E/hI7oNnylc7NiFVdp5jVHXpe4XpNJDOzgipgcTdj5tKnLoyun0ZG0Q0rcxKw2vmeU6XrtR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252577; c=relaxed/simple;
	bh=cP6gr8wADb4EASrEnj9VSH3qpQrBlalS1qET7KiSVew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB+wbSOqe6t+g1/Z3U39sj4N8X/nZczC2Nte4BZo4xwup+wePXvzHoWQWSYMYgA8HA8P4r9QGyOnszbETwSCRrz1Wf4QROS5+Rd8LPIbWXETzclIL9aKrc2gIAttJQ//7SReXL9YP1DX1lngbmRpbKuM9m+J1QIMB+Gv1UMhr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nNgGyGlD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e9b55b83d2so1735736a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252576; x=1731857376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieWCO7ZvnQOESu0rOvKqnHS1oC/GZ0fSczrbrfzlBys=;
        b=nNgGyGlDhossD3IYkb7cZKYY6OTPoNH8VrLUz3yxK10gKKdjyEc06AeqtI+xzgtn9y
         asAtORaqqju5OGinAGYQT6QTzMzhZsfzGfhPtkcdO8LPVWc2y8I9eg3YfZCfb5rQbGlR
         mkCp1zVc1X3KE2JNODRI9ebbUz2QijrYD3qOBu37zA0KFAMiQalNd2sOI1sT7bgWMtAv
         k536RBeeAvvx9NGQeBeWob19O+jR9mNz0ckCjgjou+XfHhFTddN4vj+/DbuTobM+Tqtu
         /0HFT+Zkj3nV5Fw7lqZHUFqv6/cdZ3XLJav+YMeCGKWKbdj/If+WJ4KsPVqYrXVPveCb
         mu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252576; x=1731857376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieWCO7ZvnQOESu0rOvKqnHS1oC/GZ0fSczrbrfzlBys=;
        b=mRCg47Y8/qJouT6AaVofrg63ztYZ57j05KKMFfygVKMknyxvPa0eHoGxOk+3c7IiTn
         i4Mma1/Xptd/CKRpM82p1LRCzxFd/P79Uk92hG0cHl22Qp4JpF40rdgQECoq2CD56bBx
         IRqqGCDWBtwbHMyEGjihxFfMQ6STEQC/icaZfhooRmq6jbLnsDqSWh0p2omI9oSLLQ+Z
         a8JvGoQQEuIlJAqA3Q1fp3zyYR3JgJ+kzHWLUqGzSC5gRAHwJk3VkA4Ffp1RL51KCDkS
         aqVXiQgMiZSgwQU3LWEBhH5QFkQ3Vqj5NU4yDJlAqym/rZZjLiSWt92GdbFpTy8VSn4x
         24bA==
X-Forwarded-Encrypted: i=1; AJvYcCXVPgxsaOqXWlLNqrybIOAM3QI2cmtmsSmRV9GTliNR142ILyGlHXHh+uOWWgcUl9sZC+iaqIshrtdYqfiG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WRZ2MoHEjf4GuL0rVIjTCB88YizVx6j6X8j73X5FFQBI3o0z
	vKezqd6+XZymyw3tf6L9KuLNeg3ZlCRxCuNjhcEAQJtsw+i/fvzD0hFySN54sLc=
X-Google-Smtp-Source: AGHT+IHHwm5ckcwW6tzDCyvD/cFUv8RX7EzbVytEaqdSin9tImlfNCqPLYYgjj9DyXwqjBBAmsxOog==
X-Received: by 2002:a17:90b:180a:b0:2e2:d434:854c with SMTP id 98e67ed59e1d1-2e9b1655951mr13339967a91.2.1731252575687;
        Sun, 10 Nov 2024 07:29:35 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/15] xfs: flag as supporting FOP_UNCACHED
Date: Sun, 10 Nov 2024 08:28:07 -0700
Message-ID: <20241110152906.1747545-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read side was already fully supported, for the write side all that's
needed now is calling generic_uncached_write() when uncached writes
have been submitted. With that, enable the use of RWF_UNCACHED with XFS
by flagging support with FOP_UNCACHED.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b19916b11fd5..1a7f46e13464 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -825,6 +825,7 @@ xfs_file_buffered_write(
 
 	if (ret > 0) {
 		XFS_STATS_ADD(ip->i_mount, xs_write_bytes, ret);
+		generic_uncached_write(iocb, ret);
 		/* Handle various SYNC-type writes */
 		ret = generic_write_sync(iocb, ret);
 	}
@@ -1595,7 +1596,8 @@ const struct file_operations xfs_file_operations = {
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


