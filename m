Return-Path: <linux-fsdevel+bounces-54256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB197AFCC9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710641AA8141
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D552E0902;
	Tue,  8 Jul 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSPtHoN9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018B2E0408;
	Tue,  8 Jul 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982724; cv=none; b=euosSdcVXU6TB+cC2t1cX01pQV80uF1EMBhJzpEvlw5NWRLFNPMG8jVmHreSKCd0zq0/avGaVgw4tHwzlFQNM42vwyIdq+66pnxdWPqvKyhHmNtf3XjMejseFzeIjYZYSsrJc7aHnCnyIkB4qn7WDsXuvG3rQ2GTjkPR7LV5xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982724; c=relaxed/simple;
	bh=+Cia67d2eSDaFAFhGLlbwSrmJgHlJqp1F9QBO2L2gtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+WdlG4O4sqirC7ndAeCMNFwwagKnL3ujGBaE2wujDlJXd3jWIqfL1nWtkuJNq7Irvrv9H+C113RPyuy2nz7FNxZJz1LJKzLUY1PJeYczAcw8pZvUk1c2Dq7ISgxxHamGTFpKFElf7UIazsyI6QOwk6EaJgvJBxcwrtlre4yoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bSPtHoN9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MZ1ReoSBh8oElboc7UTpUyiXMn1q4fTO7oFbwDD3KCg=; b=bSPtHoN9Kl8XuQ5p/47mBZqSWP
	J4VuVmcu059/9UbZn7EB5zrPjwIu1UwxA67lyeMN0XoLhOmG1a8Cz6fi0N1XGIyyn/df9fx54lAdX
	wZ8pLFF/XYX/YnahfDaaiC8DmqXqp4shSAeIiAkrY+B+IcGlFKmK0CmrPM+JEdRlE9a1ayOxDRblP
	fhXkI/qjBWkd49qXIqvebZBjvBncEvYesSYhM370geNEmQrfTipAtl/SM8ip00PnJeT4AxizMxY1I
	l6AJ1FmkeFkXcvlgAubWsBu1abkf2GBXcSljV+oA7XQR8GND1mj+LDq1c7HLtR/vGerOzryLA951I
	9/BprYQQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ8jq-00000005UU7-0QYN;
	Tue, 08 Jul 2025 13:52:02 +0000
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
Date: Tue,  8 Jul 2025 15:51:15 +0200
Message-ID: <20250708135132.3347932-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
References: <20250708135132.3347932-1-hch@lst.de>
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
index c1075f3027ac..1c18925070ca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1651,10 +1651,8 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1708,7 +1706,6 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1735,8 +1732,10 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
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


