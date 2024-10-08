Return-Path: <linux-fsdevel+bounces-31296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206A099435B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B521F23189
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAA1C2443;
	Tue,  8 Oct 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wHgH5Qd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89F1C0DFA;
	Tue,  8 Oct 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378010; cv=none; b=kIweoQkMsfrUUu0ULzbY5F81NX31j9JzpnW6yuybBpq+i50n7GT59s/SLhAipUyZ5cQZSgYW3VFP9zGP8vEaTRa+dRs/XjufgFg0svvaSnXp6c4a7s9MIu5aHandJopHuN5kDFRaZGYUJVJGfAf57V49QRckcgtkql+9Jzx6lsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378010; c=relaxed/simple;
	bh=bhKFBPaOneHIY70Kq4UU/SytJqlf8QS+WjAvVF/Kw68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNE2JA26XcD8gxLZvaw1EFu1g08g4aZvlkOuiUsR3We3Z+2cl+Om2BMWJ7pLksDWjaGBtDMvxPhy7pibJXHaIgBs1FTHqO4nplNbABrHOw6SATYw+fatnZfWIwyYzURiQgedtEeTQVJeDu/dB4jHsQn7w5ShgX45XllenbtsFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wHgH5Qd5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sFd7ysRgiIAiFaMOmGgFNsfkt8drGq1IVn/63x0zxLo=; b=wHgH5Qd55g5MZhnWitZOwl7Xfn
	POV/4rt/BHkv26xYdlK0eCuAdKu4vbtpEE9ptyjFpFk8EpfVWi7/6sEH4xkmQSD5qM8iw/DJpIaia
	nytllDULqjOGfSZGq6BeF5qL3dj3ZkkmOMMwC4Ru4l8SRxnWpVq5wznZdj56qW8AdS5/2yGv9n9RL
	kztyZ2gm6W/0emIw2+yP56y+8cYCC6z76cJe3fTW9/Kj5cNQ1ovmWYe1mRtys5iQf4bBvBnvggW06
	Rf+UgAoRo1AIfspq6lSJZnQ5yQH9FUEvYT5eZckJiyM7xinvDaFuPiC23UP4KXIPoTnPTAI+H6gD9
	x1W3iunA==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64d-00000005Bjc-3QAJ;
	Tue, 08 Oct 2024 09:00:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
Date: Tue,  8 Oct 2024 10:59:20 +0200
Message-ID: <20241008085939.266014-10-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008085939.266014-1-hch@lst.de>
References: <20241008085939.266014-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ebd0c90c1b3d8e..0317bbfeeb38f3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1186,20 +1186,20 @@ xfs_buffered_write_iomap_begin(
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
+		xfs_trim_extent(&cmap, offset_fsb,
+				imap.br_startoff - offset_fsb);
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
2.45.2


