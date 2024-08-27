Return-Path: <linux-fsdevel+bounces-27298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C69600E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF361C20DDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECD148FE1;
	Tue, 27 Aug 2024 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vNR4qr0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1F146A63;
	Tue, 27 Aug 2024 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735451; cv=none; b=SCF6kcYXf+sd76/sEQsG6RkJKlxxenxrx4iSdQgUHW+K6qGCKdWkxAKfc1N0XRKmzzRPwmGoEG9sRKumVVKwUHdTbPq584gA5ve/f/sMAuZgFETw7mWZPlHOI3xnZ8Ar3SA9BpbUOovOtOqWAOMgnjYFqvjNz6DfFeSwqPufMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735451; c=relaxed/simple;
	bh=ACHWv/iI3n4rZN/gbrtcyU4IJVTRKj4Z5bjjDuZyb9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWKGbdkFqWv5sq3OoVxiKogMuAo/k4dBDFQLWgu478zv1p8Am1PkdPXsqKw/YP8yd+hzA+Gd8VNe9FDKZFJMfbvcREr4pAYsqa1lK9gWFe2tgMW4OKhA2g/UuVdgmUEw2KzwqAHKAwkzKA1IZuGZSV9Y/U026cW+RV7eemYefYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vNR4qr0y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qXkyyr1IuAVPFFE5sHbXWp59fULbLEbsebjfeO/WvEY=; b=vNR4qr0ySEbINOqNaOELTDEonN
	3jeTfKZK0J2sea4Diy2W8X+COoIxSsyrtE+ladKllrFJxHwZ70+DpCAPap77Vq6EakxzV/rGCUTtK
	sMsk92Dq/wAojIthNI+ym4QIiG6N7TNM39fElI/Snkbp92/7kY86ti6xYQWfDhPHb7xTC7TwaLyQT
	ZVUs23+JyEK03WuCuNCZtmlYJOWWfc9hMJQ98dxQiNvhXKdDuNfWYz8C2KcLVnOxmI0NCycur4bSo
	FvgmJpWqhKpWxbSY67KYG8vIQvgXhClkNGoszNT0pS24LF7sM5rVagop7SvNIxrpo5bNfe7juiEbQ
	eXooQFHg==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTh-00000009owm-38Ch;
	Tue, 27 Aug 2024 05:10:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] xfs: share a bit more code in xfs_buffered_write_iomap_begin
Date: Tue, 27 Aug 2024 07:09:55 +0200
Message-ID: <20240827051028.1751933-9-hch@lst.de>
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

Introduce a local iomap_flags variable so that the code allocating new
delalloc blocks in the data fork can fall through to the found_imap
label and reuse the code to unlock and fill the iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 24d69c8c168aeb..e0dc6393686c01 100644
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
2.43.0


