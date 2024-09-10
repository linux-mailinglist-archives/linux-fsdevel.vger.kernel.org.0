Return-Path: <linux-fsdevel+bounces-28987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F3D972867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51959285476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F64168C20;
	Tue, 10 Sep 2024 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUZ1z8ZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB120314;
	Tue, 10 Sep 2024 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943204; cv=none; b=q3G1EF61XcTaSrTXdrLw4HYJbBKzN9M3XnJzMWfy+hzuEqgSZafI0mcXGl2uJA5wYe6C/nHhfmQxjy8RAz001SKX3maOLgFCkUl++/OdP7SLaQJetemo18Hm5ZkuwstVNZX+rPJ7LXDQGfZcNzsMBLVLVKa0jefaydSUkPAJMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943204; c=relaxed/simple;
	bh=CDzp0dMm3xII5YrfwApUJVyNipvJ3ywSLpHm5eqxzvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMQNzfvLz4zBZI5m2K2lRt8rKKNSOLy+h0xFN41zEAiTclEKXGPkKDcEqAKkmduwTPsxPCn80jd0OcnfN6+7vm5CK4yEI6VONHOE4fSgJEnSA2bJpyfEDvgPEV4yw7M6Bu7PorKtOsSCui7M8UBk4tVSBU6uhQPw0VIVA7BlHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aUZ1z8ZF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=65GMZMNJfA5vB+7N3WUjJmHe5n7XNdxbM1BK8UMavEY=; b=aUZ1z8ZFSwa5AZitnUYduhU+NL
	osubyDqVRFxcdFEdfop8GsQ92W7ifqPkYgH8T3iLafFqqqhXrOu+K/dwuMjJMQcFaXu8jDwBYaxIQ
	LmXmHKoHrJeCYyJAS2U/Gufpfrzw17c2hM+XzBoaG0BYa9oOv331vlQjIgKcHA0CQbmj7MHsTTzjl
	Kffx2tR+VMKgsHN1vo4Bd5IUWckB5dsXMD1kbb1RGeYVpMu7MGpXbdlJuI8LD/6bPdz0yWvpFxp83
	Ie8hm63mtbcbTH0wScYeP2I8wu0CffiXXT/l/zMz/ehpKrpGsR1f4wf58qbuHsjy9/oHFDnVPAmLt
	1pzS2C5Q==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfZ-00000004Elj-2NwU;
	Tue, 10 Sep 2024 04:40:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] iomap: improve shared block detection in iomap_unshare_iter
Date: Tue, 10 Sep 2024 07:39:04 +0300
Message-ID: <20240910043949.3481298-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently iomap_unshare_iter relies on the IOMAP_F_SHARED flag to detect
blocks to unshare.  This is reasonable, but IOMAP_F_SHARED is also useful
for the file system to do internal book keeping for out of place writes.
XFS used to that, until it got removed in commit 72a048c1056a
("xfs: only set IOMAP_F_SHARED when providing a srcmap to a write")
because unshare for incorrectly unshare such blocks.

Add an extra safeguard by checking the explicitly provided srcmap instead
of the fallback to the iomap for valid data, as that catches the case
where we'd just copy from the same place we'd write to easily, allowing
to reinstate setting IOMAP_F_SHARED for all XFS writes that go to the
COW fork.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 69a931de1979b9..737a005082e035 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1337,16 +1337,25 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	loff_t written = 0;
 
-	/* don't bother with blocks that are not shared to start with */
+	/* Don't bother with blocks that are not shared to start with. */
 	if (!(iomap->flags & IOMAP_F_SHARED))
 		return length;
-	/* don't bother with holes or unwritten extents */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+
+	/*
+	 * Don't bother with holes or unwritten extents.
+	 *
+	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
+	 * unsharing requires providing a separate source map, and the presence
+	 * of one is a good indicator that unsharing is needed, unlike
+	 * IOMAP_F_SHARED which can be set for any data that goes into the COW
+	 * fork for XFS.
+	 */
+	if (iter->srcmap.type == IOMAP_HOLE ||
+	    iter->srcmap.type == IOMAP_UNWRITTEN)
 		return length;
 
 	do {
-- 
2.45.2


