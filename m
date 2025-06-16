Return-Path: <linux-fsdevel+bounces-51755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32925ADB0DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AAB7A902F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46F2DBF7A;
	Mon, 16 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOj5n/kk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50512292B4E;
	Mon, 16 Jun 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078812; cv=none; b=UJyaFCbFUj3+UuwocV3qzSFG0dWjug9EnM7lUD0Z9OF2PiUWdYib9cTFjzrQVqZiIhovLkHSpYVMB1NQpwGwpACO8b6ZBcCa7lO0/PBxaPnz1vJy3S8D8Fvs7sADnkyd4OW4kPZ/1Lp+8RZi9tZdqpceVk48yTt/xPLWTXGlGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078812; c=relaxed/simple;
	bh=m7I06jC75jaXrOi5UUQN3XN9wcBZwbvN1C6TF1tPIvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooiQ5K6Klz9VUjDbE7tGrMDGiCocz7MMB+dGOl8yiNRCof4YvgD7fYi6fM8ddqkoRTFDacdTw1aIoiPG+7sSIZRIYKUZtwhiAPqO6owjZM7sbfOfZ0II3DkGB1R4V6jIh+Gfhe/lfovi7UiWKfAuL6IJ7KlinCvfQtaMBfdbbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KOj5n/kk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sCN+j9RzzmzUDJfCbVGiVrp2s36pGzoTkeYpMBsvvLg=; b=KOj5n/kkgzDVlXnAqWhGxcTQPy
	YkeflZBmufuNhcrSqL8TF3T9WeZle0Ub3pQ7jHRwxJmui2OzNIxqhILmbbKnlo03I1MGMs0GN6OLG
	K8JGSh6Ttl2HGsf0HK9LI51wRUwqyti0cYZI50uiDRWRfHRbA08KluK3FN0Ky7nWEoshZ5VycK66I
	c+pn9adetDX7wMJmOHr9G7PlM+elAWbstmEB2BEZYwyzw2FRa1faFbp1iGoCJ8IHe8lnEJBInJ82z
	xv8uacqLdW52vx9FFNbcdR1I4l58lJ5X+cIDeIXGTG3zwAMJhxL8gUk4VsENVR27Y0s1XWgKBiwb6
	Ir327PuQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Ra-00000004ScO-2YP1;
	Mon, 16 Jun 2025 13:00:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 2/6] iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
Date: Mon, 16 Jun 2025 14:59:03 +0200
Message-ID: <20250616125957.3139793-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616125957.3139793-1-hch@lst.de>
References: <20250616125957.3139793-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Joanne Koong <joannelkoong@gmail.com>

We don't care about the count of outstanding ioends, just if there is one.
Replace the count variable passed to iomap_writepage_map_blocks with a
boolean to make that more clear.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: rename the variable, update the commit message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71ad17bf827f..11a55da26a6f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1758,7 +1758,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
-		unsigned *count)
+		bool *wb_pending)
 {
 	int error;
 
@@ -1786,7 +1786,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
 					map_len);
 			if (!error)
-				(*count)++;
+				*wb_pending = true;
 			break;
 		}
 		dirty_len -= map_len;
@@ -1873,7 +1873,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	unsigned count = 0;
+	bool wb_pending = false;
 	int error = 0;
 	u32 rlen;
 
@@ -1917,13 +1917,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
-				rlen, &count);
+				rlen, &wb_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (count)
+	if (wb_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1945,7 +1945,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		if (!wb_pending)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
-- 
2.47.2


