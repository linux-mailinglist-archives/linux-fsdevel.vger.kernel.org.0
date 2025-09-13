Return-Path: <linux-fsdevel+bounces-61199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3FB55E29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB597BD112
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C40D1F463E;
	Sat, 13 Sep 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cROztID4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395631E9B1C
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734656; cv=none; b=cgT8lR5ZAT8FuuetS2fAmjMTV9bMujKr5YVz/gY/lcBF9XbvU3tHQdnHIJUVdhOEkYLtk+I5lZrau+gHlvwz8FyTKN8Wn8GTUFUVp9Zp+YQfZoraG4DfkInK3MIebkKDjcUcQOP5oNbCgO26gfeEV+hRWArIr7G7BduSmN34VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734656; c=relaxed/simple;
	bh=ycpaoNa3MN6uF82TEzzmVwGPWKJsfjTrnr+qTVnDsf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/6dPjtce2ouujq3cLXpXmudNVDeCqSCwpAAiN0RV/l8znH8rnVSBzGo3e8MMjyLmnINmQ2uYIcr2zI7CerNEhBVH7VHA8+Jzpu6E/Dwcf0izFPpreTx7JFyyZmasnOxwKNnLzsdFUIj4KRNTtSjq5e0QrVGjpv022fHPyJNsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cROztID4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32de2189729so1777611a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734654; x=1758339454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=cROztID4fSyst4TeqU9SosaOvuP8PaVXUvHYyKXqpJZvd7+wITk5/wVzfEAddvyT2i
         96hR6N8zZ0c++t4psIugtNXV6MuQx1bTj3zkf+i7GEWzYXcIwt7DTJb2JHFZt1ulaUmX
         9RJEZ1rG3ee/47oFCpE2KCLjGzqhS1FePE40lajSbKXjktPbCPqFF8EZvRw1M/bMvAjR
         NWZ2yb9Q2NpgTW8PnJogiigKJ363hNEZ46Mfg4kl43DwnM9tZ1+HTQA4y8uPgn2Ja/9C
         lBKMXzJiLXvYc1kvl83JJmzkkEgxrFYTLu6p/t+DR/6TMQhIUnlfhjCz3wbgnW24UWvF
         OSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734654; x=1758339454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUVL95c0pEIZMhDo9pFvxVeTSyzxblZ+STNvH3cwOYE=;
        b=lUTv+32bvDA2raAlLzBp7+AJxbYGbrhqFtpmYXDJamztqjhktOvx19GUwaIwfRJu3Z
         ugjeX6G7F4cI1+TzGI/KmAHdPDFwEFhClK47L1l8ovmu7m1EnLHtZUgazBH1zCKRkD88
         jMUn/UWDTs57mBgDZ6nMjkO+dHI3O0L7IcfTVlyaDtTeYUZRMbyRzRLc+VB5vlKRIoU9
         FtGqw36EQk+Miv9L8EsaX/06G9B6vv7s8rBo/xDY/Sqe92iYk3hbOzaekjI77XHX/vhT
         2JdNsXzCg8grx9ucuCzav805LOCpIlDRmoo4n7ah9sOfUe/uXTU5tESvey1/frz7a7ur
         kHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVtU4jOrdfSBqGaje4PUBKvcLYUfqSGczYPmU2LkpLymoZFVEmgU2JQmQRaToggIXXN3NDz5JFXujGKeEbB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTko/mIfXunLPEgZxMyBwcGAtEdnB8O8s/0gnC8Cz9OaU880vO
	8dAAXl92ejor1YboM8elc5kScVmcyB6FWDtsXmf9lXpeLCNaQpqQs80p
X-Gm-Gg: ASbGncuAZGGA522DXF9pGRpuUkB8JRH8auyMmqeIDfPYJuhvYZcnXzXLX+s41D3Or1h
	6o7phGWRxG4r77cwU1um2BQcJLa83F+JKWaodV7tOeNrOFHlc+zrTLdr9cl+UfQiRjEqLJugJP0
	1HVPmt6CEb1D20KGkMv7x05KN+aojC4bUfP/Acb5FJY6HXZ8GpD2UTureT4lwQzA/GUo/M/AyQA
	EadkkqoBJ18Nef/kEtdBgj6B++XGubIn/1d7SUfdZDgU73UzUocJvtG+i05r32wkrQpC7HW6o6b
	+nD0l7lxrnKFgLiFa4knAyD1dGeYVNr0lgnZUO6Xnz/L72CqthFad9Xr4xXRL7B+eJlggDECfRX
	UNK9C2s1hrlBYSCPZ9JUeIoBF6InkC4PMtA==
X-Google-Smtp-Source: AGHT+IFTSjLSmIonQ/tT9ymELWFyPtl8pb8LOwBSdF0oV1rT/SaH3ISod88rjuwb2oTrX2uuYFgG6Q==
X-Received: by 2002:a17:90b:1810:b0:327:7c8e:8725 with SMTP id 98e67ed59e1d1-32de4f8ad49mr6517497a91.10.1757734654423;
        Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:34 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 3/4] iomap: make iomap_write_end() return the number of written length again
Date: Sat, 13 Sep 2025 11:37:17 +0800
Message-ID: <20250913033718.2800561-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250913033718.2800561-1-alexjlzheng@tencent.com>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the next patch, we allow iomap_write_end() to conditionally accept
partial writes, so this patch makes iomap_write_end() return the number
of accepted write bytes in preparation for the next patch.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 109c3bad6ccf..7b9193f8243a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,7 +873,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
-static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	flush_dcache_folio(folio);
@@ -890,11 +890,11 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return false;
+		return 0;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
-	return true;
+	return copied;
 }
 
 static void iomap_write_end_inline(const struct iomap_iter *iter,
@@ -915,10 +915,10 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
 }
 
 /*
- * Returns true if all copied bytes have been written to the pagecache,
- * otherwise return false.
+ * Returns number of copied bytes have been written to the pagecache,
+ * zero if block is partial update.
  */
-static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
+static int iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 		struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -926,7 +926,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 	if (srcmap->type == IOMAP_INLINE) {
 		iomap_write_end_inline(iter, folio, pos, copied);
-		return true;
+		return copied;
 	}
 
 	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
@@ -934,7 +934,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 
 		bh_written = block_write_end(pos, len, copied, folio);
 		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
-		return bh_written == copied;
+		return bh_written;
 	}
 
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
@@ -1000,8 +1000,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			flush_dcache_folio(folio);
 
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
-		written = iomap_write_end(iter, bytes, copied, folio) ?
-			  copied : 0;
+		written = iomap_write_end(iter, bytes, copied, folio);
 
 		/*
 		 * Update the in-memory inode size after copying the data into
@@ -1315,7 +1314,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1327,7 +1326,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		cond_resched();
@@ -1388,7 +1387,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	do {
 		struct folio *folio;
 		size_t offset;
-		bool ret;
+		int ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
@@ -1406,7 +1405,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, write_ops, bytes, folio);
-		if (WARN_ON_ONCE(!ret))
+		if (WARN_ON_ONCE(ret != bytes))
 			return -EIO;
 
 		status = iomap_iter_advance(iter, &bytes);
-- 
2.49.0


