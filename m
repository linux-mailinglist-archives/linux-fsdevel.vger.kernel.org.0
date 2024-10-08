Return-Path: <linux-fsdevel+bounces-31295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7355994358
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5981F1F227E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAFF1C1AAE;
	Tue,  8 Oct 2024 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zZdVfRXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93F1AED31;
	Tue,  8 Oct 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378007; cv=none; b=Rt6zskKgu5z1ziJmS4hEbKSwh9pIEMjxu4WUGxh0KoUElSAzNlu4N0f02RQ9ptS0tnbruL6gggE2COKudtodn2zAiEy/ak0BygOW7laByNpk6BUBYTvLT4Vsr0B4M19OwR55fOt9BEIxZ1SdlhHTPbSZrlDyW56dbGEiEEfM1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378007; c=relaxed/simple;
	bh=2CNmI0j/06dGoT3k7rDyWfoTPV7gHWO+5J4mj+Ti+UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBzVVW+Ooooumz55W+JeODOwgDN14zxYDIyuA/KiyuqGeUokaAQyGkvfvWI1gOqFgTLUXwJJk/mDRIwIYO+B1e6hcoOOQfNsu0ZI0Zo6E8OMZzK1PENkuxMsigg89WCf9Uyv41B9b7rg8pNHWr3LgBHnGRhGo3kpjOu6D/yGWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zZdVfRXg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ikv+qWe6N7fcBH2M43aG4XHRSOtnGWE8dmrK5e3yxxM=; b=zZdVfRXgCtCspJZLA263FSXvd3
	R4aLD2axgREsiKm/+d4W0CVo8F8jWy2qkBxUjMUrC8deRw/wrcsEI6cAMZ0uqU4XrTCKiqvNUC8QH
	EUjYEw/TGJfa4oZvc8TrU4Stzd1b62+GPlqj67SOw7ZpYbHrPhvlnQfepkG4/iE2K+wAOBYxPS+QB
	W0uK/Bq4zppQONKk988/lflC3iSAeXrPihYetA42xQfUGHl8fDyrUk1KMPpFzH103ZXHcsFjP00gd
	genRSkhdv++05MTVaTav+blGzFOpj6zM25WQAtRUM510Kev5aW6Ojcg1tlAHaSBSI805nHS5rGpSD
	Oyyx2oQw==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64a-00000005Bi9-2WTJ;
	Tue, 08 Oct 2024 09:00:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] xfs: share more code in xfs_buffered_write_iomap_begin
Date: Tue,  8 Oct 2024 10:59:19 +0200
Message-ID: <20241008085939.266014-9-hch@lst.de>
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

Introduce a local iomap_flags variable so that the code allocating new
delalloc blocks in the data fork can fall through to the found_imap
label and reuse the code to unlock and fill the iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 03eb57a721ced0..ebd0c90c1b3d8e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -975,6 +975,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	unsigned int		iomap_flags = 0;
 	u64			seq;
 
 	if (xfs_is_shutdown(mp))
@@ -1145,6 +1146,11 @@ xfs_buffered_write_iomap_begin(
 		}
 	}
 
+	/*
+	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
+	 * them out if the write happens to fail.
+	 */
+	iomap_flags |= IOMAP_F_NEW;
 	if (allocfork == XFS_COW_FORK) {
 		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
 				end_fsb - offset_fsb, prealloc_blocks, &cmap,
@@ -1162,19 +1168,11 @@ xfs_buffered_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
-	 * them out if the write happens to fail.
-	 */
-	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
-	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
-
 found_imap:
-	seq = xfs_iomap_inode_sequence(ip, 0);
+	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 
 convert_delay:
 	xfs_iunlock(ip, lockmode);
-- 
2.45.2


