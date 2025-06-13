Return-Path: <linux-fsdevel+bounces-51629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E0AD97B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD31BC2537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7D28DB7F;
	Fri, 13 Jun 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuLRTRIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5126B75E;
	Fri, 13 Jun 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851463; cv=none; b=e+5p44HctAXqD2aKGS2o+oe4JkkVox5OuUs71tCPTR1BqndAwQ0s9co1b7WmBQiYxSrdLt59YwzeoKynrgZW3QPNEm7nJPpyxmoZ+QomkGv6ESl1vP/ZM+SW3tmn5BP2xpffKHmP48lNMoqdYJ+u8EZduGSMr/cS248VaaUy61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851463; c=relaxed/simple;
	bh=sgMICdL3ooaOD8dX0MbQFDyQ2KWcdfUkUpMECyFqE7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQFU/fk+TAx9MCYkSJl1ejAtJDSgc4EuWqEVgxzE6OvetoLWmqbSA0F+Uib4XKmoWqPMZ5jCfV6Ac3skEYsXkYzSJozGJpYf7wTXeE1V/b8IA+bZLwkJx8rcnomeBsWjDKUE8yNU0u9v+jgBnFtK98g9PYrvlwT8TER8AS5hrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuLRTRIV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so27761275ad.2;
        Fri, 13 Jun 2025 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851461; x=1750456261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrVYqh63XTbsgRC7QC4xluur8az5PmdrxphWy97QeG4=;
        b=FuLRTRIV1HkPoHjsjZxVfvwmkDOYzI8hbOBAW2ZXvakHC8cS2F1TT9n3Gy+GTUcIn7
         3u1DE6M4TbuwXOQJckxr3f0ngKjq9MB4M73K2OrUKBn6w+C9W1gEd7jzD3hZiUDSNAgb
         /ufTA5FjcVaBH0kDumERZpVyt5uT8Utqi4ZH21ZtpDdNaNTm95j2ShwntKfV139EIBtn
         bR881PJ5iAybu1am1zsFtE4qxVlV9RTcU5qXhhrxiY4e4Fo1eYP8RvJ5wIMct+mPdhHI
         f21xt8EEgh+mReKd8sbT5tZVtw3RmM/g3DFeK9v5RSDF1Yk4O3QOQQWCtsappOCI9egE
         yTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851461; x=1750456261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrVYqh63XTbsgRC7QC4xluur8az5PmdrxphWy97QeG4=;
        b=UL6MV7rh7gPByaCMVdXro2qtrPVfPaGg+Cd5d1byCk5Oo6wNaiUoh80KgcUHRO/6dR
         MzPu8Uqw2LEL4dHIPzBnE6mCDbiKMAxAlpOCQPC+TG5vniPKgn16jc8V3wAblhhCaMVs
         xhHhjBqZ7bW0VexHrJQKnvJqc0PEbFEsx7sSVbF11cBM9J2cPUjJiVC8if/H4kzAvfIF
         P+JjI/zPRmxi+fAVQtxLuPvTjByyt2GXH4Avbl7SKvldy4O/ByEqvEsihFghUBCFTZGi
         TbA4oWTuz0h+4Kxr4jmqX6jW/zf/U9IMvr+U4Hh7jQ5/5xkLyCUvPoANW5hbohKwxaCa
         rsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mh717RazT9MKpo+7GZ4nuFrBWEBLaTAn29s83Rp+rsb9ouZPyGUv8iUNCfBFi95ZugQckHi60sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMkhtsb18aIhCSLgzVs6b4gXserkDZRD9axKYU61P8Or3WG3a3
	DQu3pbPMtPWAnZzgkYaBCyrVICM+E0uxz1180jUd/2V2m4Z4p2S2qqD6NzsWxQ==
X-Gm-Gg: ASbGncsPRPz3poqe/GWcGz3+xt0FVtwGf3SuwgOWHC0BLymvWxfquFq8G3HXe0yG+9t
	hLk+RHOEideRUHX1xN1movk3XZerNAhD+lg9mTNVwmW++OJVwcKq7M3fuAdcGNbpHMnztT8/Gm8
	+BE/pDuY3cqk/MLXDzy6+/ZQI324YBmE09fJp1k+rkEF6x/BRYgoIOyXWchx+gRIHUg9Or9MTVp
	QCwNCzMN8V8HFPsnEQTDYpOt8HZYdgzexlW2ehbXdf8bYRsB6NY9evtydPT4XXaoldF5zjU5n8I
	2GigXVCQ9vQwlGKrIKlCv4+0to0vbgvSPd5tF0O4oDG6bGMyC/U0GgfQ
X-Google-Smtp-Source: AGHT+IFZI+Sunqu6zEyk70MUTp/BQL2hyPWB4/E+aHD3SDgxCOKfP5IF91KEr5Uw9iPBb6nex76qgg==
X-Received: by 2002:a17:903:32cd:b0:234:f182:a754 with SMTP id d9443c01a7336-2366b176d1emr15985905ad.47.1749851461187;
        Fri, 13 Jun 2025 14:51:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca368sm19442455ad.201.2025.06.13.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 09/16] iomap: change 'count' to 'async_writeback'
Date: Fri, 13 Jun 2025 14:46:34 -0700
Message-ID: <20250613214642.2903225-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename "count" to "async_writeback" to better reflect its function and
since it is used as a boolean, change its type from unsigned to bool.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7063a1132694..2f620ebe20e2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1489,7 +1489,7 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, u64 pos, u64 end_pos,
-		unsigned dirty_len, unsigned *count)
+		unsigned dirty_len, bool *async_writeback)
 {
 	int error;
 
@@ -1516,7 +1516,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			error = iomap_bio_add_to_ioend(wpc, wbc, folio, inode,
 					pos, end_pos, map_len);
 			if (!error)
-				(*count)++;
+				*async_writeback = true;
 			break;
 		}
 		dirty_len -= map_len;
@@ -1603,7 +1603,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	unsigned count = 0;
+	bool async_writeback = false;
 	int error = 0;
 	u32 rlen;
 
@@ -1647,13 +1647,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
-				pos, end_pos, rlen, &count);
+				pos, end_pos, rlen, &async_writeback);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (count)
+	if (async_writeback)
 		wpc->nr_folios++;
 
 	/*
@@ -1675,7 +1675,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		if (!async_writeback)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
-- 
2.47.1


