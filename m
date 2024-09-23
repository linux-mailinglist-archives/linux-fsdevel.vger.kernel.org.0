Return-Path: <linux-fsdevel+bounces-29865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A597EE29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374BDB20A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C019E966;
	Mon, 23 Sep 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2dBOPVAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF719CD12;
	Mon, 23 Sep 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105370; cv=none; b=LNi7YFDTVb65WCo5Aw324qCqQS9ANDmi2ZDHYb8qi5UcaypwdBfnoOPNrNfYu3yoqsAQbPIbrqWnwyI0vbYKb9PBawI4P7jcN9z78Yt0f3ZalIszV93xYEhAJp4aaDkszHq2AI+4YontUjx3qs1sD18JeG6q1mI+8rla1hIDSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105370; c=relaxed/simple;
	bh=69Bnqoynyjn/q+9NvkuWoLJnxVVYEkGzpkA69xAZ4gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INknidG+bdJ/Uiylj+oscnuOPgLhSPTbLdMMVM8wHzHqh4+7ZG0jd+whg95CarahBRzBjzPKulSC929k/tikkXjS+KGi8a+45oyD7CkE3Jpdyfmwr9cGJvPTQhtVIY8otzmyj/jKDssXaDDK69Mbcaft5wAWUJslZlp4kywmjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2dBOPVAD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ey5NM8CBmP9xc4LLpfl6+DouXpz8NtpPwdSJkTH6978=; b=2dBOPVAD94LI68N3e3prtx8pLb
	cQ/foyK+PmFL67AOIjVye6tx1rGTm9n4Xgqm+bUk/FgdyNw3syZhHWXL+4bhUhQKxprFJougZG3mj
	mUVtUcUdypdojl+5m/9eE23SIlyV5qUC38zfGb21xr/kfOwz1kdMxBMDT+wMqNkicI1I3WSA6jaHe
	4TlnDcSmaRfLrhxlMZBQh5zjVHwHxGgKGays8tHugo7yIwzeyGPPqZH4gFjwz9iaDiZJh27WCvxvV
	0dsC7B+G3iQ7hQMLxD30765ZYQgr6MSeJdS7fXDSwboS8aLxytCMhzgQNg2G0/zOV2SLg5H+JFWT0
	TYUlrjPg==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssl0B-0000000HVAk-1hmm;
	Mon, 23 Sep 2024 15:29:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
Date: Mon, 23 Sep 2024 17:28:19 +0200
Message-ID: <20240923152904.1747117-6-hch@lst.de>
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

xfs_file_write_zero_eof is the only caller of xfs_zero_range that does
not take XFS_MMAPLOCK_EXCL (aka the invalidate lock).  Currently that
is actually the right thing, as an error in the iomap zeroing code will
also take the invalidate_lock to clean up, but to fix that deadlock we
need a consistent locking pattern first.

The only extra thing that XFS_MMAPLOCK_EXCL will lock out are read
pagefaults, which isn't really needed here, but also not actively
harmful.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  | 8 +++++++-
 fs/xfs/xfs_iomap.c | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3efb0da2a910d6..b19916b11fd563 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -364,6 +364,7 @@ xfs_file_write_zero_eof(
 {
 	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
 	loff_t			isize;
+	int			error;
 
 	/*
 	 * We need to serialise against EOF updates that occur in IO completions
@@ -411,7 +412,12 @@ xfs_file_write_zero_eof(
 	}
 
 	trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
-	return xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
+
+	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
+	error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
+	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
+
+	return error;
 }
 
 /*
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 01324da63fcfc7..4fa4d66dc37761 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1449,6 +1449,8 @@ xfs_zero_range(
 {
 	struct inode		*inode = VFS_I(ip);
 
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
+
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
-- 
2.45.2


