Return-Path: <linux-fsdevel+bounces-37954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4479F95C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41C118889AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B02219EB8;
	Fri, 20 Dec 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u0xMnDTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB990218EAB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709720; cv=none; b=b77iE2+92ooUqsC5Kbfx8dpT2xiOEk+KR3hJHXjTlCJGCLRy9xHxPmBvLP3P7sTqocKTqWLoAuJmyNd2fqFuiPbMU4ZzT/QcFyXE+ZrrAYnSBSuA2txBAWZXxa1lhgUNWpP4D8GL1m5jI4Wiy5lPDAgm3rH1ZOcqkuy06YbsGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709720; c=relaxed/simple;
	bh=nP2D5ty4r2yjDcWsJ4kVfAz8c3OFcpVU3g/7tFCHj+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc89i5PoV6T/ZPq+/xCFC3OPy9yERvfaRz2mfHp5Jk3Hx+MbvWCepDBlisYoojcav59lk3xcWD/x+iVpipuhcc4Zgyopr3q4fOPNiLWHiv3jL9D3VRS900JUvIf7cL2ydBODthxbVjdzeDf5Ed4j7DhPc4NB92MbqP34Pxv6e6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u0xMnDTF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844ee166150so68485039f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709718; x=1735314518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymwG1n6nWD/uJHK94RoKI8EVCXuU9v7PVyju+T4v7w0=;
        b=u0xMnDTFqisiHf/UFpkVAqfaKJnXuM0CefNU15ODr/AWgfu4NslH7Njz41dtEJPEnz
         kZTbY6s6kfjRRBMWiN0eiYqEXuijdGCIQgrAQo7lyt/FAQC/HCwTzvaZ2NDBrTNY++vt
         i9AJha4TZTp769kHtXOEBdv/IIJMh7BrSeYAZpdvLLaoBgHsi1MPVa7H4Ji8GsGIevAC
         xlj5NOonwj0K4pAiALWP4iw8dkD//dGWZ904OdmJ84HXYPRgMFlUqZg+SgTvev21Yuhm
         7DQu5IIRGXRCw9eTRuN2Iim7CaynNJ+ImZlrHkkD2BbgfwBpX9cuUy3X90vaOaQn3IZN
         wxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709718; x=1735314518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymwG1n6nWD/uJHK94RoKI8EVCXuU9v7PVyju+T4v7w0=;
        b=CT34TX0IaFezpNtt/o43eb/guLc8jVFS4fUQIr1SlbSUDLCmwciLL8Iu3A6AbDO7FY
         X1GSBeo3qo7RP6qvDrU5Hyj4MkjngWZ4WQpT9sYAilDO1swq9ZQbdLhEWPkkb1XW40Ok
         TMYS6nIQ2Cxi9caAWaAe6IspVAk/JTnAlvMZiCYlhmMOk/tpoWPxI5/WtJK6LS3fkf68
         s+mXHXqn1yGeCjvSM0JeTswaSEoOSO11B5/ffvwdsYi9cam5AcPQlYj2X8nxDK3497TV
         J2KqisfShhtRUhiE2ar0oJaw8CNepVzCCTMmB4CZqS/axkTCdVB/OKW/1+aXysb3U8ae
         x35Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRsmEwQ2zYyxEnLaloQiZN585kRd3ou77HB1ytEKvWX82tGxueX6oddWHPixq/T6b2eapm3+h8kf/aRX7D@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7W70QQ4f0NXm4Kih4OSUTewbERcAX2Lq1bokMwUN+t9v5b2E8
	425tun14qcT0g9gwnJGcAsjYg/onLNeA2S6GyEjm31xhlz3t3Bp/z1LU86JfZjU=
X-Gm-Gg: ASbGnctt6srt0rJK+HJVN4z2HTH+TpgQJGn7XTxE4g6mJfQNskOLVPkV0bt0XYA7QC0
	S2U/0nBjcCp2KDC511jQwTjJ6zxXJs2mLDadCfGJSc8dt8MgthKXvT+WuoI3Ppb4wminXQRXpKk
	A1rfzUvJYHzZ/h9yFbOO9Zcq1CwWxU17OR1vItVO/e5iECdCBS4l7DV3jv2/qqP/TvuNzKsGVvM
	54hTZh+hZoWDDUlwzczG7M7oq71fgi0Eo8jWMto5ScnyGNmYH6je3NzJUEQ
X-Google-Smtp-Source: AGHT+IG3fN9OsN4GGTbFHoS9tD5hs657TGN6y3Qqvn5pakOnrgdzlOR3L4/c6Fhv1UMBXZPo8R74Hg==
X-Received: by 2002:a05:6e02:156d:b0:3ab:1b7a:593e with SMTP id e9e14a558f8ab-3c2d514f9ebmr38935955ab.19.1734709717719;
        Fri, 20 Dec 2024 07:48:37 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/12] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Fri, 20 Dec 2024 08:47:40 -0700
Message-ID: <20241220154831.1086649-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8b29323b15d7..220dc7c6e12f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2527,7 +2527,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2542,12 +2541,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


