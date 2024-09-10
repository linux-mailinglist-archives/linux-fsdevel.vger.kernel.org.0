Return-Path: <linux-fsdevel+bounces-28996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF3972882
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A36028566E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8C178389;
	Tue, 10 Sep 2024 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muQucmso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EC166307;
	Tue, 10 Sep 2024 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943252; cv=none; b=ivFB8mlnd8c9htJAnIocvAY0K43fT2gfxAWe2g8J+qamgZmN9J0MjGBdmb2QrpzAUTMuWsCUd1277BxtD6Xke2lKynMiIKv/PlzVoSkH1ku1h6j+iAuPVg80EdOQWD3kMHrsW+bIxAYuAVI2qTeGsXkSLfUmpGZ0kOBdPLsdlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943252; c=relaxed/simple;
	bh=4maD5z+IXbk25zx+/tSRGC68EUzgF+Sgf9dLV6bUcLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3X0KV/K4Jh52p9DlccwUhbKE3x7DQhULaFP7I/a1NeMcv0sm92ApFfmTwgrCKcSQAeo3OjLv83b2oVYEiW1mGyjD+AnmMgtQjDDsth2iJDOwzc6SP7ZaYTj2qJnFsDZObO6Mmi1F38WZ3f/eFJb5HYLnpnWktNNXINkdeIMGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=muQucmso; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vGC/NeYTcKeyo4bZKNvm7OXcMfUhlpY5hpQcrztaI7k=; b=muQucmsosdiuIiF1As819luOwm
	x1Wu+1xi2U/8Vfr+ZXp+AqepZHnL/ImUr7aVoP0UAwIks6/mGueUnRCximPUHMAjRST6E56s+CXa/
	GI8I/QyesacL2yz4kKlFmUkWQXlAaIhkrszd9YmTGQkmPtxc71DREmtKHKZUFHYvQ13D0wFYrxNcT
	+vWN6Qfh2Q3wAHkV6YX4hSNwVPiGvUVWw54Cm521MOOOIPXbry/DPSc/AAB1OhuiZe8CAAupipjEr
	+uqgHs1muutG4ueLLNIGeDz/Ci6Kjv/ZuepxwfM8Xe37wmS6yzoh7HDkuRN+ISPohvRY1ccsS0cK1
	A1Z50VEw==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsgM-00000004F3j-0nnh;
	Tue, 10 Sep 2024 04:40:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] xfs: set IOMAP_F_SHARED for all COW fork allocations
Date: Tue, 10 Sep 2024 07:39:13 +0300
Message-ID: <20240910043949.3481298-12-hch@lst.de>
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
 fs/xfs/xfs_iomap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 12510380a495f8..844368b592f94f 100644
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
2.45.2


