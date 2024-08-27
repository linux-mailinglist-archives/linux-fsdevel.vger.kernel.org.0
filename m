Return-Path: <linux-fsdevel+bounces-27294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED89600E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2FB1C21D60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0A13E028;
	Tue, 27 Aug 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxJPAb4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C013CFB8;
	Tue, 27 Aug 2024 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735442; cv=none; b=pQu214QcFreldPjvhjnU2EM1ieK96K1LhT+t4QPE+xRMaX9zQ51ZwJ0NdroGC2SwoHcTpSEcTl4CgLZS7L/PQkiRw+27sge8F783OxFQPBgSkeIRTQBGB/vuV/Y9iGSY2lQcJPgFu64Bp9pWMcXGEvVmOUQHN/wzqJ7hN3FhCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735442; c=relaxed/simple;
	bh=BH3E2EljWKkt/EnwnIn+m7EMy7myNXtIz5HwY3J/w70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frPW+tcfCU/JMz5pqiuar0KyGzS4E7xF9az03nO6Asn8y7ZX1sAcgcSk4mz6DMIjb0xsICtBbPSrrb6hvI0bSmbVZHUE/UWYUS0dvEia7GRf/BJlMGmS0+RWRy89nWKpXKT0XCW+tgNNGdOYlnCuZveyPa+iaHHM5UyFZz2YdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZxJPAb4t; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rQX3p1gVPRWrNCtCKMUnpcimvyKViygFqeh0W5iRZZ0=; b=ZxJPAb4tqf5jOIWuYWUf84+zUt
	mBoC30AWCj1PWE39/B9TjyhprNUBIjyOPvYaa2VNtaLBxHDFKtGJsYA8KH1n52ZZTJEVwhkD1Bl7k
	a5XZ8HkxEHdEUQRcNtfOj9Ir60fmVN6nc2Brlw7/uDdcGbioC2xcx0JlceQSMwOyjOXz2TGoCcvgY
	2tPGk58nzB5bAAXgrKyfTxk8FrMEzUTZ3wMKhQnugBNwTc+I+ExrYU/pafWAuuQkQ/EepP25PPEwe
	rlFJo0Pry5v4aG24fqaTAP4Ke5L+v8QK9IHp44dV9Or+jVSUV4CpYmlF31o2TAEmgPsBdhpXqBCHA
	5z7jjzHw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTY-00000009otX-0P0Q;
	Tue, 27 Aug 2024 05:10:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/10] iomap: zeroing already holds invalidate_lock in iomap_file_buffered_write_punch_delalloc
Date: Tue, 27 Aug 2024 07:09:51 +0200
Message-ID: <20240827051028.1751933-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827051028.1751933-1-hch@lst.de>
References: <20240827051028.1751933-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

All callers of iomap_zero_range already hold invalidate_lock, so we can't
take it again in iomap_file_buffered_write_punch_delalloc.

Use the passed in flags argument to detect if we're called from a zeroing
operation and don't take the lock again in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 34de9f58794ad5..574ca413516443 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1198,8 +1198,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
  * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
  * the code to subtle off-by-one bugs....
  */
-static int iomap_write_delalloc_release(struct inode *inode,
-		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
+static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
+		loff_t end_byte, unsigned flags, iomap_punch_t punch)
 {
 	loff_t punch_start_byte = start_byte;
 	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
@@ -1210,8 +1210,13 @@ static int iomap_write_delalloc_release(struct inode *inode,
 	 * folios and dirtying them via ->page_mkwrite whilst we walk the
 	 * cache and perform delalloc extent removal. Failing to do this can
 	 * leave dirty pages with no space reservation in the cache.
+	 *
+	 * For zeroing operations the callers already hold invalidate_lock.
 	 */
-	filemap_invalidate_lock(inode->i_mapping);
+	if (flags & IOMAP_ZERO)
+		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	else
+		filemap_invalidate_lock(inode->i_mapping);
 	while (start_byte < scan_end_byte) {
 		loff_t		data_end;
 
@@ -1264,7 +1269,8 @@ static int iomap_write_delalloc_release(struct inode *inode,
 		error = punch(inode, punch_start_byte,
 				end_byte - punch_start_byte);
 out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
+	if (!(flags & IOMAP_ZERO))
+		filemap_invalidate_unlock(inode->i_mapping);
 	return error;
 }
 
@@ -1328,7 +1334,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 	if (start_byte >= end_byte)
 		return 0;
 
-	return iomap_write_delalloc_release(inode, start_byte, end_byte,
+	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
 					punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
-- 
2.43.0


