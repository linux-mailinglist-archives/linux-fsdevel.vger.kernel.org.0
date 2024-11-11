Return-Path: <linux-fsdevel+bounces-34358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ACE9C4AA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DADB3107A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CF1E0DDA;
	Mon, 11 Nov 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s3fWExQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAF1D1728
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368953; cv=none; b=kal77eA2EXencPd9uaRrC50Qka1rrqPHkWpb9B2dbU+/AW/ePNAQL71q+g42OSIJ2bX7DIG9NPAddMlsNSSS5Du7eaUyysc8/CvBt3DKtqmEWqjl+JlvXUqTv8oI3QYHtOPzAyGXSRgSIkySQHg44JbsZK9lVUYLJQVGyDoGFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368953; c=relaxed/simple;
	bh=cP6gr8wADb4EASrEnj9VSH3qpQrBlalS1qET7KiSVew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLfH371EyF4/hrceVUxSfKbpR9eeJcZGi+GBrdnnuiLNFCloMGuBuLS6dmZKjIMTkJJbyBc2IIsqeXHrNv6J/fvrNAtwkLIZ55PSDuYgX2xhmXGhAf/Lpn93kuwTZuHId7ppSsKWuPGGzBJJbXg9ANLB3czRPPLxorXPNdaJxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s3fWExQA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so4205770b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368952; x=1731973752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieWCO7ZvnQOESu0rOvKqnHS1oC/GZ0fSczrbrfzlBys=;
        b=s3fWExQAqJNrjrhXBcABkuMixXrWdIudo4LplxBPh5u2i3FIjQz8RSwmrUEgHJwJZq
         4nbroCZ69uk0s+dMKoqZuQA55Q5dTQoVv2sORNjhWPfC/aSmYILESoMsUEEb8Csh+yKz
         24tJ1Cgq7JAqc5GibDIG0D5vvDg2IQ/lkgMaALDkkKdTBtUlskK/8Nj7xgcWo/hfFMJb
         lyavRh1R1g/HoSPd37GSLf9ifexOvMNPCvg0YrR2Va5+2oULo5MjCxjric8+vwXL4mFH
         T7mi/ZhHCZGKMmuF3nrFGuz8GPZkC76x1KAiPgeBGpMVdgciw11mo/kH0lOSTZs8rjYu
         ukoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368952; x=1731973752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieWCO7ZvnQOESu0rOvKqnHS1oC/GZ0fSczrbrfzlBys=;
        b=L2RHwv0ub08Uq0O20ZKEsGf4vUT0QlBpQ8Y2tvA5a5mcPb3gza2pKli4m911qjFzAK
         NEgUbcccq2g5tbA6h7qVKGM4kD+nOKLR5fJ1guT8IStmcbbDEKKArX+aO3VLlHRlrZ05
         TduYZ8bfKZSKZtuP6Rlwvhj2clcn+wSmcJrAX+2X0Mr00TeVPQlORtvPnAdLFQsoDZQn
         rixioFQlPBmqfgv09ZkWCUdUV3iZeAD2jE6CTC1ohi9x96iwKTe5faeBzjvVxk0y1ERn
         g4bE5y/z6/I2vgkpilWjv1OtWDUtSR/QTErmXSOL8X9lAsGNkUOtz/dssUYj01JHUX93
         Diog==
X-Forwarded-Encrypted: i=1; AJvYcCVhLyGhS5qyEnJTkV4qldlyr6EGpJPJR/9HJW9EnoJPbircq4+EqUSwODZmzdJiwKy5EN/aneu8Ki7ZqBfp@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKsUncRVdaZbuzM9yMK73H2QyC6wOnUHutg6m1aFk74WpME0r
	NigeB0khNwZwWJpgv2aICcoxJo5X4iCMZ3rRVXmBjOXl/C1AUIl2HH8LkbY/sFQ=
X-Google-Smtp-Source: AGHT+IEuKUU8LmiDGdVSE8HEQD2DSqpmQWqCoCseRpXFHWRMzDS4n8tdQLpPQA0yFxWxU+7dmSvSgA==
X-Received: by 2002:a05:6a00:a1d:b0:71e:693c:107c with SMTP id d2e1a72fcca58-724132c15a3mr18685493b3a.11.1731368951711;
        Mon, 11 Nov 2024 15:49:11 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:10 -0800 (PST)
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
Subject: [PATCH 15/16] xfs: flag as supporting FOP_UNCACHED
Date: Mon, 11 Nov 2024 16:37:42 -0700
Message-ID: <20241111234842.2024180-16-axboe@kernel.dk>
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


