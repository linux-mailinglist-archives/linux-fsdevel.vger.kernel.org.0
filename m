Return-Path: <linux-fsdevel+bounces-62478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F2FB943A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0514218A7C28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 04:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514D284687;
	Tue, 23 Sep 2025 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np7XVXeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99928152A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601333; cv=none; b=SiNW2ZrnGa7Z7sbVBAgG+ed55kdt7jbb6qsErAzQ3WDt7+Q3kEwAvBcrIeLWFhXcsUK7yYS4HhQQWSLG5oGUFOtF3uzvXtbc8rqnQo8boeEhbZK9sfYtxfHowGbpssxhd7Bw0KcGAZAGou1U0XCi5xfl00vDCShxWFmGSXluWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601333; c=relaxed/simple;
	bh=zpvEKZqLhwIOmRHUipSf1LyZBL80ITB37XK2LvCaT4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpW0ujBcL+7Wtn9PLz1mXe6cusg1PhE4h6RfwAWzUOh2TSg+KGMF2mNT/dRlhx6qP5VG5UcpavCr9g8ex7oN75WFB8AEikdpO32zoEAUJiuJFvbKg6vg1WUAozLxJw6dL1HKpt603pznNQndelwxCqvms3CB8/WMbZhTsl1AO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np7XVXeh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so3052100a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601331; x=1759206131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nDNxXFU6/HO7z5iXuMR9cVnSyuTgICPbquGVbvl6vg=;
        b=np7XVXehliYilDBlAhJdCZXRHsSa4eV3yIB3vm1tEaexFoM4zthPU49+XCWe88jd9m
         HTOC29E2ZbtC0Ybpqi7lL+PwBjAb+V420zF2u/NAjHoPcWnNAs1qfk8LloMGVSs8yBpc
         xBJcmxeaX2kskV2tXhzhT76dUJUGC4Jchm5/1aq8wjojwXQFiwkAbwLBxxPxVcclNzdO
         OAggBCuGk5YgvHo2MZqdxc3Z+5fHADOnK17xZoiKR4QlPlHSLY0X6T5ZF8fQZgz4MwNz
         S/EDRVxKzyx9js7a3VywfYN3Y0zYZ/28Uvpy/2IVie7eJ4iFGfMQtgHTON9c45ceIzPq
         Hwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601331; x=1759206131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nDNxXFU6/HO7z5iXuMR9cVnSyuTgICPbquGVbvl6vg=;
        b=KhB0XOLlwoGGQPAONNwL5FMB33XuFlgHdV1w40W0vJ2cCy6BoOmfqh7Sg6mXHjprBa
         9dO/941GM2xH3HEQScsRECdp6DCtjfH8GJBx/Ly1WFelPaV9b+IYDmfZ4F64emQkth4U
         M5P4ouafuPO8HkW9zkVY3ccRe2pFOj/AERlg1jnnSRHgyYRzfXYkBO8mFHS0oDsV2fml
         Zi4c5sFbpUXjEFs4dRZWp5y6/XgJeSwV8e+A8b1Pd2SaDW0cVnn40FQEDeOaxErR31sW
         0dAt/ah9rg5xrFJHQgnIsEZ3L+y+jg4dwp7IT+ntTJZaFv6G4baXwREJ79Dg3UUkPXeG
         GFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVigaSoCFTwsVA3t5+w9plloQkHDkzqf2IODMQRDWKMd+IjN5oZDiiuxY3wca0VTG9/1gwXH/ocNek+U+Hk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IfZZ2KF8Dm5MMwuBHOhWJ1DUwOCnOYg8m3TbHYgzcyclz8+N
	LNw78xkfgU8D2YYk1CQ0NWGygIK5YSxfxU3ytio9XGQUY7qFivtLB7Beu4/DcFqN
X-Gm-Gg: ASbGnctUGEAnCTD7BS7q+F1pcSU6N+utFfH/JkCengpa+ifbtX9ITA7ZzNMEzVOpR3V
	CUfmDE1qz474PvC/lbmRil+Czep9wMFdyx/Rp+yNC5kpd3U75a2WF/5l6qzVkRHO17TVpt0Swt8
	CV+k33CzdVTbvjL5JVSZN1Z0zGeuKNjb/J0ak8LRd3zUVrMnk0KdISdPAzWCD8S08j/lZU3dUzz
	cTmx3edboDxA0oqL22TfIO9ugpdFHyCxyFF79iM5VrqEGm0KVjvKXpqu8oXYBZfxNRXdKYH6WoE
	GbvFaP7RelU3PuO+kD9rnZdeWVOf7+PJzHuoJe3yM5SP5SEUEqDIYX60qiNmskTJ5wUdf6TkP+r
	HdSXjCZL8y4evj2/yN61wVCuj9Ia+zP/eSw==
X-Google-Smtp-Source: AGHT+IF7vHoIXKK7ahfVkrWmvrmfXhwv4d6xCB5n1yI9ZZQycPuvOWR5cPz7VJstzs3WJ12MlmIo+Q==
X-Received: by 2002:a17:90b:4b82:b0:330:604a:1009 with SMTP id 98e67ed59e1d1-332a95c82d3mr1254994a91.23.1758601330689;
        Mon, 22 Sep 2025 21:22:10 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:10 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 4/4] iomap: don't abandon the whole copy when we have iomap_folio_state
Date: Tue, 23 Sep 2025 12:21:58 +0800
Message-ID: <20250923042158.1196568-5-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250923042158.1196568-1-alexjlzheng@tencent.com>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Currently, if a partial write occurs in a buffer write, the entire write will
be discarded. While this is an uncommon case, it's still a bit wasteful and
we can do better.

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy from the beginning of the
folio in the next iteration, which means 2MB-3kB of bytes is copy
duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration,
which means there's only 1kB we need to copy duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy

Although partial writes are inherently a relatively unusual situation and do
not account for a large proportion of performance testing, the optimization
here still makes sense in large-scale data centers.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6e516c7d9f04..3304028ce64f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,6 +873,25 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
+static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
+		size_t copied, struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	unsigned block_size, last_blk, last_blk_bytes;
+
+	if (!ifs || !copied)
+		return 0;
+
+	block_size = 1 << inode->i_blkbits;
+	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
+	last_blk_bytes = (pos + copied) & (block_size - 1);
+
+	if (!ifs_block_is_uptodate(ifs, last_blk))
+		copied -= min(copied, last_blk_bytes);
+
+	return copied;
+}
+
 static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
@@ -881,17 +900,24 @@ static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
 	 * don't have to worry about a read_folio reading them and overwriting a
-	 * partial write.  However, if we've encountered a short write and only
-	 * partially written into a block, it will not be marked uptodate, so a
-	 * read_folio might come in and destroy our partial write.
+	 * partial write.
 	 *
-	 * Do the simplest thing and just treat any short write to a
-	 * non-uptodate page as a zero-length write, and force the caller to
-	 * redo the whole thing.
+	 * However, if we've encountered a short write and only partially
+	 * written into a block, we must discard the short-written _tail_ block
+	 * and not mark it uptodate in the ifs, to ensure a read_folio reading
+	 * can handle it correctly via iomap_adjust_read_range(). It's safe to
+	 * keep the non-tail block writes because we know that for a non-tail
+	 * block:
+	 * - is either fully written, since copy_from_user() is sequential
+	 * - or is a partially written head block that has already been read in
+	 *   and marked uptodate in the ifs by iomap_write_begin().
 	 */
-	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
-	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
+		copied = iomap_trim_tail_partial(inode, pos, copied, folio);
+		if (!copied)
+			return 0;
+	}
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), copied);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
-- 
2.49.0


