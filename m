Return-Path: <linux-fsdevel+bounces-54507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DCB003A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991D058290A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE825BF1C;
	Thu, 10 Jul 2025 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hooyGvKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930F25A620;
	Thu, 10 Jul 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154458; cv=none; b=QSADuqnhJiWWUXl9j5NAndb8xKG1c8K0lzsbwmNorl6d6oBjSlgGwu6Vk6/FxDyg1oAp1BSJScvY9Mlodwc4reDja25ZlZiGgH9rpzTzi6bvHkM8yNzamV1xukB/9b8s9AGw6VT3f6pfrkAggQ4Kk7Fk4dMyUAwhYFVOlkBIVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154458; c=relaxed/simple;
	bh=udYOYANUiPv+59RbSTnjvLoqD2kPROqTydJgynt7uMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBLfCZbwmwGXiUX6c+YYndb2CYJ8nnX43zRIxLs62/x/26YLQTn6oqDXLkgTLLECWvvtd2gaQCsQc/00Gfwn1SBdhL9/pcFBnxbX64rEzMauS3zSjrI2R41SO/eB9Vd3qGtoeVu2BllE4Lfx1vWySQTwkWynF+Ci7pSIBb7dRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hooyGvKr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WyoO8IVQLvyisS3NDP1Wqd0QkiAlrsGdlKdK/xEeQqk=; b=hooyGvKrUw17+RSlcso3x4d1of
	3zYdz2fD8CrNOBXp8/RICoar4uEMWUCVK1YY3P5TOwQskwgn/4F0mOIgNXIzOB1/z8ZszpYOVFGRR
	B7qcyvQDUrSnv+/vc+rrKJxm6F34ofNM8UMM2995LAak/Pua6UW24vNFhW+EJIMe8TdZg/9A76ZW3
	okxaNa+t+WeUaiYD8v3xMANYV2Y0t3wrsqWILsAxZCD13ns0+GE1/WeoxybDbeL+uZXJz80kneqhx
	uAl5zLgmWiRUOcQGEW1mC5Q78aLKNFGX47tJ55ZFtPJUi/45pxPttBLUEhEyKyjtzB+vMeu9WqWlo
	8tRD+/MA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZrPj-0000000BwXU-2Z5H;
	Thu, 10 Jul 2025 13:34:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 09/14] iomap: move folio_unlock out of iomap_writeback_folio
Date: Thu, 10 Jul 2025 15:33:33 +0200
Message-ID: <20250710133343.399917-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710133343.399917-1-hch@lst.de>
References: <20250710133343.399917-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: Joanne Koong <joannelkoong@gmail.com>

Move unlocking the folio out of iomap_writeback_folio into the caller.
This means the end writeback machinery is now run with the folio locked
when no writeback happened, or writeback completed extremely fast.

Note that having the folio locked over the call to folio_end_writeback in
iomap_writeback_folio means that the dropbehind handling there will never
run because the trylock fails.  The only way this can happen is if the
writepage either never wrote back any dirty data at all, in which case
the dropbehind handling isn't needed, or if all writeback finished
instantly, which is rather unlikely.  Even in the latter case the
dropbehind handling is an optional optimization so skipping it will not
cause correctness issues.

This prepares for exporting iomap_writeback_folio for use in folio
laundering.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e6e4c2d1b399..ca45a6d1cb68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1652,10 +1652,8 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1709,7 +1707,6 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1736,8 +1733,10 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
-	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
+		folio_unlock(folio);
+	}
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.2


