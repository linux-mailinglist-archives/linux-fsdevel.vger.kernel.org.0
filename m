Return-Path: <linux-fsdevel+bounces-57227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD5B1F999
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142A33BAC80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931B2571BF;
	Sun, 10 Aug 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjs3oJDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC271248F5F;
	Sun, 10 Aug 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754820966; cv=none; b=KOLH/ijx7hezK1K6OZPaix4Ba41aOKHErK79WbGerlY8hh1x+Oi2N5R4U3G1TQ/GdlAOHkNYaMAruUob6ipj2sZHQzHb0FUKcmdxEPA5uKBzLSJN2zIqIW7TjlPUokh9LmkPYrboaHwibwvXV8z3vTfWHH3P4mGJpZgyYfsG50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754820966; c=relaxed/simple;
	bh=pM70ONMWkVFOgrxrh7xrXySYMx9EuPeAq6ng5Zyjn7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA65RWm6A/tz7Ipa+XIOznDCmzYWUi+UYLTlz6Dn0W+L8iMTnQko3RoQp2XzSYyTRlzQb6SnZMeggXWE/fS+z79t+zqUJWo7h/Wz6gUTG2kX5p1Y01EIWhQpMxisHTxv5jVQp/o0Li2NWEjI4AriM5fsNaA97hlzv0qNrcnUr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjs3oJDl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f325c1bc1so3091397a91.1;
        Sun, 10 Aug 2025 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754820964; x=1755425764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JpF+zMohgtWkSabMp3xpC3OoiSf5ZyK7hwqHgyEfgs=;
        b=Zjs3oJDlyKg0hRJTYW3s7ZxwSQq3sLUs6aEMnEVJZjy4955TCOGqfNq55KAKyUk+6m
         V8X6IFEI1W5oeiTApWOcFsoB0GI1BsrYCp8qlbFRy2DENQG+2awQu9BrW1C1cPjZOfLa
         8LnyxJuWi39cLOjwCP023FM6/ZUwrvJibViRCUX3XezJa43BXUTmj7g2LqA79ij5XxWs
         pfIYqDwP8K0yIg9x3RJPPsDKT8TALXXRLgjNzmMF0Wg4pu2kkNmR109g67F68L9kdHk9
         VrxaLuoL7gp0QyRW1FAPfN6hM0R+T+MzVyp2XmxRg/69EvBC6xG12r5bxJqg7v/iuyia
         25AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754820964; x=1755425764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JpF+zMohgtWkSabMp3xpC3OoiSf5ZyK7hwqHgyEfgs=;
        b=YRAByXFulG/017Hj2blFPKSp9lagl3LSVNBTBJd1Trx0pWqp0moSQJxbwY7PdupkMn
         2AnVeTGRJQiy6wefVMg0k9w1J3SOAvu0sjMVqCBwnlOQE8aYiIkgkkmHjGxlHnRgAMgi
         GWpYA/xurJ/CmNqqnCVLZI7N30cKpi//tD/AaeYEp8KqBjljpuad0E4Ph/G8pCmuGc6Z
         UPVQx16Iv6ICGoh0pabRYrH+Y7kFzuUqjWxSdLfQ8iZQwtLqtexV/3tcDScJwbPzSpzv
         t8tfR7E+YXeqMZUCpuK/Nc44of259B6QwfQ/WcrwRGQhTAQYW5cvzaY6Epalx1UwgeQM
         kd/w==
X-Forwarded-Encrypted: i=1; AJvYcCVh78ANxk/Lx9Hl5JiTNA/4Ip5N/Lp6PvL37/kAZQVRJACXyru3CM/5RYXnWNhuYvp8MCFyDe9caYaYy9B7@vger.kernel.org, AJvYcCXCITELRFeSjhDlTwTrjqGGMYQPtsIWk1MnUt5sHKPYbQxgZ0Omg/QW3Bgght8A+joedik1GxiuyHESLpfj@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPb833EG40KEUujPeC4nsYS8DL7Uo3y/seUjD7TkYDQ027jRD
	ldcfk0taUIaAmhiFXBmc/HR63GDe1271Nn6f2MGF3RwNu08EGDpt+7aP
X-Gm-Gg: ASbGncthlRBXx1dGIugpRRiWrkAdGzim9GmNcaq9F573SU+19nb1//+yIahKR587QVz
	hwoLJRZQffpYowpEnpSM2aQWazv2j+3+UYo5fXm49AtasUfq38BsQbSxL25mumZiZkK5qzpq12q
	TqQKxFO3FPBaes1X4wWNqv74+66lahtYTBBbtPj9cgszNJZZ4KJQnE8uLHZnm2PMsYCBR2P6RSu
	gbxNFLB/3bujPzBC0lsE+ArCorAEGgJpP10bdmpklYheJDrtAuWRtcdpa9e5NFkAsF9Rr3vB2jr
	cI1JzO8aUITNwq+t1u460yXJY9NqdLM5yYYldk4p9FFA5sANeUVC/+ERsGl+8l45CrhfPgx4Gou
	dk/5yvFBl/JKU7ZKEAjvhphLhbX91s4HuwHc=
X-Google-Smtp-Source: AGHT+IFoyTnVPeVwt4GwqWXdRJFvf0VOIWLsKNY0q91al0tJ6xoRHw9fxfYy3W9/HvDj2sLsiKYGTw==
X-Received: by 2002:a17:90b:2e49:b0:31f:d0:95bc with SMTP id 98e67ed59e1d1-32183c4585dmr11018044a91.25.1754820963756;
        Sun, 10 Aug 2025 03:16:03 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259329sm11923432a91.17.2025.08.10.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 03:16:03 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2 3/4] iomap: make iomap_write_end() return the number of written length again
Date: Sun, 10 Aug 2025 18:15:53 +0800
Message-ID: <20250810101554.257060-4-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810101554.257060-1-alexjlzheng@tencent.com>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
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
index 641034f621c1..f80386a57d37 100644
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


