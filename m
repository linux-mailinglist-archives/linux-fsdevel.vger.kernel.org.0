Return-Path: <linux-fsdevel+bounces-29941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA0983F79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502CE1C22A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901E149DE8;
	Tue, 24 Sep 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOw4owjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B0148316;
	Tue, 24 Sep 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163698; cv=none; b=jxIN/Hc90slj6DKEOecQf5MmFq0eanpE72PYpQfNpCiuiJ4ZdfcCXSVKswnn0lf8gb6VYx0d8LpzqSo/E0DhthvzlugRlY2tEdu5/lCeCr+qMri657RD7DERymX+YZXylCaYvacQZECepUo7/UWpEWNuU2SsRc494xrm0ozw0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163698; c=relaxed/simple;
	bh=WwkOtBxAHOCe3ChfEuy+WpbWlvtgUZdos5uae62up1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXnRops6KH4fzd9n7qpJMjCbuMtLBJTWlhbGMwCbJzn7IGaOW+uodhbUPE+Zn5q8L/AlMSIZghVXRAh4oGtxEWTg90b1VfbbZQPhdhpIxI9A4nLp7MdXctVYdBFm41B5ErSrdjh4e+a3zmVjtxFxMGd4v6q6cXIb7dOMfBXFHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOw4owjl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/3H48UhQGIVnkCntEamRIwbyShYar0tUIgYAmPnVW3E=; b=EOw4owjlTwVz1LKdgU3mWV9gz/
	zkdk8clIJsfvPt1SQuOt/D5Ga1pOwqdYcbhi3KcRNvLmPIpT8m58Tfh7TCxUsnAw9hSm8vASU0WF4
	X2etIRdV3E4DZ6Foyv6CrHWy2NRluD6z1Cjfbs4t/ysL0t3Dm42JfkPKNMjLZx/yXwOWN0LBxyo+7
	4GRMAE83rj06uoiNE3wa46CGukFTYYd3FaD7kemsEIplSPGli4nvBRdO7Phr1Pjpj/8mXbfMNmWw4
	S5JMeCqQM0Vig8AplzZ21hT0WLlU7V6xBA8RCTyWr1OcrCuIkRxGlFUqMQhtGQ2LHKq5Bs/aJtRkP
	ym0f8bdA==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0Ay-00000001SLo-0uOW;
	Tue, 24 Sep 2024 07:41:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] xfs: zeroing already holds invalidate_lock
Date: Tue, 24 Sep 2024 09:40:48 +0200
Message-ID: <20240924074115.1797231-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

All XFS callers of iomap_zero_range already hold invalidate_lock, so we can't
take it again in iomap_file_buffered_write_punch_delalloc.

Use the passed in flags argument to detect if we're called from a zeroing
operation and don't take the lock again in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4fa4d66dc37761..0f5fa3de6d3ecc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1239,10 +1239,17 @@ xfs_buffered_write_iomap_end(
 	if (start_byte >= end_byte)
 		return 0;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	/* For zeroing operations the callers already hold invalidate_lock. */
+	if (flags & IOMAP_ZERO)
+		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+	else
+		filemap_invalidate_lock(inode->i_mapping);
+
 	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
 			xfs_buffered_write_delalloc_punch);
-	filemap_invalidate_unlock(inode->i_mapping);
+
+	if (!(flags & IOMAP_ZERO))
+		filemap_invalidate_unlock(inode->i_mapping);
 	return 0;
 }
 
-- 
2.45.2


