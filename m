Return-Path: <linux-fsdevel+bounces-27292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CD9600DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F6283736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01091386C6;
	Tue, 27 Aug 2024 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wiL748Wc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FC12E1C2;
	Tue, 27 Aug 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735437; cv=none; b=riQvKcbeU6AY/NEikBnl1kSyLoHqMQW8gwcypkIngJsHsNl5Yo1boY1/4E4HKQxiqcWdV7wpZXVPz0zEYz3hE8Xv5a8NYDe9eDhnTLe2578cRAr3AlFOkkW+xrFsfN4gcBLVCMfhXVuECofTE6WmjBJh8EAfi/3kXP0lS7U5VTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735437; c=relaxed/simple;
	bh=OhrUbqMA5YqikZT7SBp5D6KCz4ZHbox0o4FAopPsr0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHbjz3Ueta79AyfKDtU2Qq4lHh2FUetJJgsGLLCqImkOx368qOI+AB1gD6yYqjuCtpDbdJxAZtH/1PawTxreUkIX+df4iXCPJUNIjpw2PLLKZozgHjZozbvdsfbkmC6ghJnZw/Bz7Ecw8InNzW4diLMcYDk/XhL+qJPzhnr9PQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wiL748Wc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rs1YtA5dqszfWt6gPNoh1kRFzMEOT8qnb4NpkMpHKM4=; b=wiL748WcBOzFvDbt/yYSBAZQO0
	jwhMa+a+xAtTmxE9LF+AgH08Grsc8rYR7JUs7eCke52o7+sPLKt7UPwv4ZFVg4ClhBrZ/7MZB647f
	j/D07Zs81F61HYT8vwZ50UNJ25g1kFKG/1jdU7XMqM6YG14N1jaVWrEALhzfJtzqWBP/4xaOHk2AO
	yMK58dOkq41cyP999KJcFZXYZ0/Oq04NNwyeQYnYn22VRvMyN3raXTKpWw1vkj7oIGDQ2Cx8Z5Yn7
	aTqFipgTRh/M8LIG/UeGMn1vqcOKmIA6Udcq6Xp2PZsVrqwQ2D4R8N5mG4/Qj9hR7ShCCIakVoWE+
	sZDGtH/g==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTT-00000009orK-1HWn;
	Tue, 27 Aug 2024 05:10:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/10] iomap: improve shared block detection in iomap_unshare_iter
Date: Tue, 27 Aug 2024 07:09:49 +0200
Message-ID: <20240827051028.1751933-3-hch@lst.de>
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
2.43.0


