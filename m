Return-Path: <linux-fsdevel+bounces-27299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2129600EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059A41F2320A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF305149E16;
	Tue, 27 Aug 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vpmWYNyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E03149013;
	Tue, 27 Aug 2024 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735454; cv=none; b=WG1OVDvv5VttUc/Nf5srH6hKHFUgWuIQyXobT/nQmi5WPESABDo/FzrAmPJzEvUyAY2DRwB+ipXWBG5hjnU81D0z7TM+n59SPkdPGWqq0Wxya5TtRMwjz4EkY5T/yXjnScNk1BTE6JhxDDkEioJtnH9UmYZNTw60BiDipVogC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735454; c=relaxed/simple;
	bh=ZTCOquPpCzRzhjZXWOklBFJz78YTG5Dd6Ir+XG9apok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ5QZqu1N9hApNMxYISVa9mTS9M0UXoLF8Xmjih4ykJftzqNYPEoi9kul6CRlu4+VHINFd/NA8oHTPAEZaGv04wlsOBrCyE+fKwLhxrQdIz8tVDaqA4+cHWNdRNr5H73BpAQszflJqUqz3hRVxfAQdfnog7hTND65gpWrku80gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vpmWYNyL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sk5n7rYhl7O2On1J9SYWjeUEsfz3Nm7b0kEgPbon5ZU=; b=vpmWYNyLzvtwNO91g2ZOT047Bp
	Tm9YDqLxAWa1Y+dRCO4FOgPSJu6QxVFqXtOdFkafPlpZD2s9Hm307pMS1vjYV9A3ZaIZJPWpAE9hE
	mIojFbsDxy632W2BTeZwdjd4ZiCf5DEsmShHxpYXCB610wsAE9OPQwJuJVHUQm7Q36jB2DdmLN+R9
	2rGNPQnUFyIbtM65wYo5JuoxLmQyS6WSOTtVR5ns9KUNKeaTx1RDoEWsV8A8mBae+hJSRhfktWKpo
	pQdGvHlLlPsEfxUPggJTcVlHmYeid5lg4nCeHXlsGLYOZgN4+LusS9WuTRQ7uiuN1wLdbPwBUmwTc
	43Q6OJbA==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTk-00000009oxF-0Yb8;
	Tue, 27 Aug 2024 05:10:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
Date: Tue, 27 Aug 2024 07:09:56 +0200
Message-ID: <20240827051028.1751933-10-hch@lst.de>
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

Change to always set xfs_buffered_write_iomap_begin for COW fork
allocations even if they don't overlap existing data fork extents,
which will allow the iomap_end callback to detect if it has to punch
stale delalloc blocks from the COW fork instead of the data fork.  It
also means we sample the sequence counter for both the data and the COW
fork when writing to the COW fork, which ensures we properly revalidate
when only COW fork changes happens.

This is essentially a revert of commit 72a048c1056a ("xfs: only set
IOMAP_F_SHARED when providing a srcmap to a write"). This is fine because
the problem that the commit fixed has now been dealt with in iomap by
only looking at the actual srcmap and not the fallback to the write
iomap.

Note that the direct I/O path was never changed and has always set
IOMAP_F_SHARED for all COW fork allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index e0dc6393686c01..22e9613a995f12 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1186,20 +1186,19 @@ xfs_buffered_write_iomap_begin(
 	return 0;
 
 found_cow:
-	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
+				xfs_iomap_inode_sequence(ip, 0));
 		if (error)
 			goto out_unlock;
-		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
-		xfs_iunlock(ip, lockmode);
-		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED, seq);
+	} else {
+		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
 	}
 
-	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
+	iomap_flags = IOMAP_F_SHARED;
+	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
 
 out_unlock:
 	xfs_iunlock(ip, lockmode);
-- 
2.43.0


