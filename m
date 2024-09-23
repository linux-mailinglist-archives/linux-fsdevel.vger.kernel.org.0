Return-Path: <linux-fsdevel+bounces-29869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38597EE31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE063B2080B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1019E83D;
	Mon, 23 Sep 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CqPNJnHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032619415E;
	Mon, 23 Sep 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105384; cv=none; b=MkvxUgO/uYxnvCM6aDWO+IAPAQ0FGclqgsCb7gsShJmZhB661jYYZsEEO9lo5WOp1AljQqEp0U5uOYcMf7iF1WMkhxrgUgZQEqDxSJsccDlRStlVT6eViNGPbogbU/qdhDaMIK3UAnxVZkplerjBHBITI3yOAVGjVY/Dp6MY1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105384; c=relaxed/simple;
	bh=XBDS9+zFPYaTYRZiKoC57H9q+/jBQoCHNLX6kyjgK9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYohKToy4SMIymdmy9HqzYS9ZnkIB3aI49i1eW31WVipwKB7YC6zykzUnClJluPJiOPfFdamtkFrxC91/fgJQfHlbU9NCGZZd4nBWlkZMHHeIMtCQOPIlQWFgKfkKFDCIaDRnaWv28uEGzTnrheBhJAuMmZcVkxVkMHcaIveyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CqPNJnHo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0fTTsQj3ZdvTBprqSSqQ54OSPZpIeMu3ngGG0FwbbT8=; b=CqPNJnHo8N1Nq+z+C8ThkJaFjl
	JeSFXBbSFE26oqiey4vjNO3dK49+ZUTRWkgYJAxHm6gTSQG+NGuFVI46i/IipS6M6/6QO3fzHs99b
	dl+zhXdwXm0UknzTXSWVdHXoyo97ZU3S/fFulGu8nYhQ+eoeK/TAUeRgUXQLVQKNXycpupym6ytva
	CxEFadFOL2cbc6LatwSpnbkJW+dO+/TSe4TrNAzo+s/deEobQg+Cu0dE8uxgLu0szyUUdTZw+7v59
	tXzHWC3/deKnbC83L+JHwiWDq+ZI1mhb3/5UD2uYSd2TkHSUltAidMzQ0CHqT72EJZIjwVtJwQ0ei
	OzXI75Mg==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl0Q-0000000HVGU-1Q7D;
	Mon, 23 Sep 2024 15:29:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
Date: Mon, 23 Sep 2024 17:28:23 +0200
Message-ID: <20240923152904.1747117-10-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
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
index aff9e8305399ee..cc768f0139d365 100644
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


