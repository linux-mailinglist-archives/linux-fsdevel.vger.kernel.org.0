Return-Path: <linux-fsdevel+bounces-34357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB09C4A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689181F211CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE261D14E5;
	Mon, 11 Nov 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MQOeFTKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF881D07AB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368952; cv=none; b=o2lL6SdJN0MUtnORosMkKr2Eu8dkSWRhNke1JluwkFEsrLTGuKL3nCd6tOiQEeu7nyTvr1vjuqumGQEOtzJnLmJ84QAi7I5MfnsLiwwCLNGBAn8k2rssUb3pRRqpRM1k3PDfzrWSe/srdJHWT7a+7qGa1ZP0gzln2YPcoEkY9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368952; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grTGQfMXcb05iKdtnfLsVfQd4Qdsyo2Q22uZ0rK9LR66MM5usGx94xe9UEmZKQnBx3jtUgs03DUsAfeWlHAy1yAKqoZSGOXCkvxppm9/F6binBv3zbQ68iD+bYKEwqTUfzV1CX8ZFOdSKs9WAxcag2YMGc1BuuG5lAt33Ebxl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MQOeFTKf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e625b00bcso4090871b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368950; x=1731973750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=MQOeFTKfgntx/fL0KS1w5ehtnzLw2J47Mgw4aCD7qt3FE0GsZguoRF9UzEZDgQNRgw
         aFV52MGH6xiQKxHGYiA1kQ5dpioB9Eb2OR4Hcr1snqxBl+9BCvPqY53HaGpaY5Dv+Kxt
         5uSsPI702LUrz9n1i44B0UVSu0D/HdbH9sI6vGKOckND5vcI7xCVX4UyWAKHjqOvqbeV
         H6z2/+sDDjg6Ql5St4JCD+3NCRqUcBKc2ATPKwnEKp4Z874xUa6nZGAqIBzYYA1Ms9TM
         2EC1Jigln0/b4vOYbtqVWAsGezZdc3xX9GQP/UGaLCY75z7A1NSNfrTGydecQF7a/u2V
         zVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368950; x=1731973750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=NKL3z6vCaGyCGzahZnL/ReUUF4lHc73NVMQRScqRqgcPnBI8bJAePe+3L7fF5X4DV0
         2/8B5QFKhMQNDu7BAdsnjZDqwsq3IlX6huWRdAWhyx+QKzO/CsJL2JdH8IGpiDtEG7AY
         5PJgHU/R/Sak+Jm7cFSNoddCHDNaQ8hn+k2H8G2adyk9arh+L63WQZaD7HKm3EbMdMAK
         l4Xmi5X/28DwLRxA1vI5MDmi7hYQYejV4TVtTfOz03BKRl2ZEmXcvP7fJHxVzuO5gTu2
         9jjlbgNRjH4iqLsGl7TD7MMLP4D+Pp0pr5xjG4qKNHLR3826gwWk2NMkkz8gM1wnavIv
         0Ntg==
X-Forwarded-Encrypted: i=1; AJvYcCUVbPltrLmDbKFD9bd2D0O5XSTwvDXXv/yykE5GOgpJum3iAxBqlhvempyzDRiSPmaBb8tW4TyRJWBp1YF3@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCYqafJeh48RidNgv2+3TZ+XItxDaYnwsh+GSUz8XIiEBJNc+
	mYEETMg+VpOD41aJMqGxNjCxfD3OqedeqXOE5P7ebGP4HbC1VFiwxpTlw+KzDUM=
X-Google-Smtp-Source: AGHT+IGxdsMu1dfGOYWXi1R28aWFhjsN5Q3I34Dwpy3CjKRXcDtvBr7LZlUVTVK3RyQbj+sGtC8u7g==
X-Received: by 2002:a05:6a00:3a29:b0:71e:680d:5e94 with SMTP id d2e1a72fcca58-724133510d7mr19932677b3a.19.1731368949731;
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] xfs: punt uncached write completions to the completion wq
Date: Mon, 11 Nov 2024 16:37:41 -0700
Message-ID: <20241111234842.2024180-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need non-irq context guaranteed, to be able to prune ranges from
the page cache. Treat them like unwritten extents and punt them to the
completion workqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..c86fc2b8f344 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -416,9 +416,12 @@ xfs_prepare_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction or need blocking
+	 * context to the completion wq
+	 */
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	    (ioend->io_flags & (IOMAP_F_SHARED|IOMAP_F_UNCACHED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 	return status;
 }
-- 
2.45.2


