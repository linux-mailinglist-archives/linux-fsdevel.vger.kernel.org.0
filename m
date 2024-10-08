Return-Path: <linux-fsdevel+bounces-31293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0F994354
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF161F2475A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E0193082;
	Tue,  8 Oct 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cT+1AhLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571B1925B5;
	Tue,  8 Oct 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378000; cv=none; b=qEC7noJUZVgtxtvEpznuQfrP8Fgo/oAqrZzh/SqI7F3BF1NrOaEhMcsRagKX48zS/bHGvuTxwqNJZ6MZDEoZ3Ek50qTHE6JlMaWLvmgEv3txsmC99qFs7tIH8u1r1SKnvMAgDvrDDZIg7lKTUdoaBksu8njUC6wAOJac2BWD0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378000; c=relaxed/simple;
	bh=rpN5EGjdySfji5sacvcjvCizS5GJUEssLVN15UMMKGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmtsgt/KuN6o8JYwgU5DjJNu42OCRTU5xTh0zxUOFSSv/kT8A0x7H2tvOSlFjZVrvw5A5Bf2+qAKcnFW6dhsdE4BuuzMVfmA4cXIJLSe+IU7wcYdrwx/r14/CUCkPstUIlOeEIq2/GkCUeeiw7dEiLdz9ydK6AcgIA6f/s0pNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cT+1AhLI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x8sCGLULZboucVtBc/zobuHE80ejpIOa0pxyRQn2LPc=; b=cT+1AhLIZef3eBkRe7p2uhbM5u
	q+uWp3Oj6qzZm0PLhAUOydVYuzGBcBu07Zh10Ohk4FTAhapdCmwQG7QiQvJR6iZHfunqp6aAcJ9kX
	5VM9P7mXD0GHBBawkuXsuxFqocaqb42SxZdFb62EM1ki5Cb8GzjX432ZVxAVxoQnV3djPFOt9kiPg
	SIHM93EsoiQlDHNXru7Yz4VdgXr696vFYm+KYDSYVrBdkuif91te5G2beMByATC9Vfbv641IX8CAF
	HM6xSwTI1wPYSsfhmOFRDYnZ2OHhAN3KSkjn/0+6Cp0SK0Ze/0CLgSR2+g1HnhYP0NfeY1oMv9f/1
	IraTUnBw==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64U-00000005BeV-1Tjr;
	Tue, 08 Oct 2024 08:59:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/10] xfs: IOMAP_ZERO and IOMAP_UNSHARE already hold invalidate_lock
Date: Tue,  8 Oct 2024 10:59:17 +0200
Message-ID: <20241008085939.266014-7-hch@lst.de>
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

All XFS callers of iomap_zero_range and iomap_file_unshare already hold
invalidate_lock, so we can't take it again in
iomap_file_buffered_write_punch_delalloc.

Use the passed in flags argument to detect if we're called from a zero
or unshare operation and don't take the lock again in this case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4fa4d66dc37761..17170d9b9ff78a 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1239,10 +1239,18 @@ xfs_buffered_write_iomap_end(
 	if (start_byte >= end_byte)
 		return 0;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
-			xfs_buffered_write_delalloc_punch);
-	filemap_invalidate_unlock(inode->i_mapping);
+	/* For zeroing operations the callers already hold invalidate_lock. */
+	if (flags & (IOMAP_UNSHARE | IOMAP_ZERO)) {
+		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
+		iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
+				iomap, xfs_buffered_write_delalloc_punch);
+	} else {
+		filemap_invalidate_lock(inode->i_mapping);
+		iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
+				iomap, xfs_buffered_write_delalloc_punch);
+		filemap_invalidate_unlock(inode->i_mapping);
+	}
+
 	return 0;
 }
 
-- 
2.45.2


