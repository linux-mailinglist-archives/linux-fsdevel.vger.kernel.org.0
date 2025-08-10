Return-Path: <linux-fsdevel+bounces-57197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B947AB1F860
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CD9178D7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4611F3D54;
	Sun, 10 Aug 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGtFM2lE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C31EBFE0;
	Sun, 10 Aug 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801301; cv=none; b=pl8/MvMHAyyfNNH5+8xodg0zz5mZ4ybHsPt986iF0T2R8LaWjrhu5vXyXGmw6lJ4OyZULZCwIXvKkqQ8F9dtjgyTwiqAxS7GYd0o1soMVphjfI2QwkulbJeoV1xxwAjuMbE9GTi+quGQPB1w0ZYpjT1TVMfr83YAklDlGQcS5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801301; c=relaxed/simple;
	bh=f91rgHLwNB+kaNRll9YzR+6AonwBuqWBFl2wHR3nT/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaWhOrRv3s714DYdIBSn1Ys+EoYj3Bu4j3HKshBdDnNN0Jms9Oc9KQ7DRCFiK3PKD6YNRrTxgMGI8DxTTL3+VOR/VKW0IKBusN3aor0fy3+1vUd7KhaWM0I8+oQz5xPQi9BDTwuvAKxKaZKioR29xyLSgpqbdS4GJPaAKdorFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGtFM2lE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2406fe901fcso34975065ad.3;
        Sat, 09 Aug 2025 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754801298; x=1755406098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WgDdPYVPBRADyBnekFKAkUwtNUU9JGA/7ZCfzfiOSo=;
        b=mGtFM2lE3Cuu3TcGAMtss+IFzerxvZ5trW80+c5R88VMzqUlLD5Yzyp6pWwg7zHQkc
         QOdqcC7c28AOHLJj6BPbRyyvDgg3/g/93MNOPX1U5kw9gUwDXZidh90/G/pdNqSoguRM
         7p/65Q4y9VDbNHEtPMjQAW13acnMtKJAuYFhuvnjEsAD9LuTMPn7KgHYqODj8WHWIiz6
         3IYUKK86BYBt4bKLdfUf9jx3VzzQtVHZOEXk1NNPqGGqevs/Etbj9qjsiFQI99kyTw/B
         iL+NsW1OCQj+NQBfdMN65vdw8SoDHLa9t0KLW/qrKjUjs6EiUNsF/Qk5AWiyGMzAzAvh
         A7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801298; x=1755406098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WgDdPYVPBRADyBnekFKAkUwtNUU9JGA/7ZCfzfiOSo=;
        b=icVdovm1Sw2P8a3a3ayGEXtZKK4wZyqVA2JUJ99IUewPsl4TVbyaOYiB+qAZTV3g29
         o1RAwSGN1uOm0UDVUi3a8YlOdpKEyBiH45CVRuXLLPbXFIwhvwgBCSS5PLQMOAJGCUPu
         eBBNESSQ+0Mm8BC/SQDYDh3jpK04WDhRTPXhZFIK3t9K7w0z7DmhJvQRgn1bRDWrfBKg
         XxNaRerwo/6Ukk8+3N2uEq6VYtvP3AMbkRVQVHFrufNiUPx1DlUIaRQEuZTEXr2DPAId
         33yedOW6A/21jif25ntFBsBQ83d9qAX8wIv8NBBs7JjmwViCCPMTeTBBKxiEepm70c/i
         ncAA==
X-Forwarded-Encrypted: i=1; AJvYcCVpf6c1ftqjScRAKs9u9RBc6HHQXzo7akwILittnfsSdLdhDVnbsn8x51VTEeEueIJ7ZksmQDwCnICLZMxc@vger.kernel.org, AJvYcCX/QJYXKiyznV9LOkY49exIGS+ELnwtN8rBrIKzDLKcbFCXScm36kOxgaeVKdqXg2aeYcjAzq0ScthpooSC@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaWk0xTKG//l1XyjSqHjvtz2CKnMckRhrrIjpa5Q/zcDdN0EH
	wRzUjxuLsHsHFlqAVfxwIMF0sGkKIMbIfXbE9ScWXDhYXEk+8bHlZtJn0OrQAgo7
X-Gm-Gg: ASbGnctIqEVJ+hFiWOFkJ3MRQ7nd6wOmHGlZIb3H6P7ToDRSb/zY7MJ1vw1EWMmfvwX
	CVfSUj1ZKinjp3WworTNd3Br0wFwTKIJgah6tiMOBgnjrfcTm80/WQSQxqTTDRZPSHCmNIgZj25
	zf9oSHcqanzCHlQho4/WCN27ccrzMpkh9hQ4Yq2Is/gnU5EkQlXyt55xZiIm9B98ICZhmi2Cee4
	lUtCLuOuUG4pejrv+6NseFpUXjbGkknyUNYdnb2Ik6rVpXiNle/dQGadSgpGCa4XEuTM7dblmXA
	FXnCLYx/sme8yNAG2x39wc0zGaHbd/WltBFnNe+htK59shO7DVGnt2DzPrjZscR28rsLrUYt+f0
	IGBRlXMyEsQobwXgRrbjEnAHc4kkOGqUzDcQ=
X-Google-Smtp-Source: AGHT+IHio3NOxI6DmGDDGE5bzdJwsvlyHbEoU7dIG57TultqUhNsfx6zvUeKeTaf7HdT5Lwgw0mwpw==
X-Received: by 2002:a17:902:da82:b0:240:c678:c1ee with SMTP id d9443c01a7336-242c1ffb211mr118034015ad.11.1754801297656;
        Sat, 09 Aug 2025 21:48:17 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm244113645ad.113.2025.08.09.21.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 21:48:17 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 3/4] iomap: make iomap_write_end() return the number of written length again
Date: Sun, 10 Aug 2025 12:48:05 +0800
Message-ID: <20250810044806.3433783-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810044806.3433783-1-alexjlzheng@tencent.com>
References: <20250810044806.3433783-1-alexjlzheng@tencent.com>
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
index df801220f4b3..1b92a0f15bc1 100644
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


