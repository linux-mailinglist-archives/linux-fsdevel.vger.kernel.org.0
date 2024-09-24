Return-Path: <linux-fsdevel+bounces-29940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC2D983F77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D131C22995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DEE148832;
	Tue, 24 Sep 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4F5HMWix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04F148316;
	Tue, 24 Sep 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163695; cv=none; b=NqZ/LC6yf/atsrtMKu2Dx4qnPVkgoGBG3FD8TZzUwJYgZlRNDZJRLZ1l6Vty8Cslbys7/M/W8znAsrYZaR6UJetK3tdMhYrQQN6GSrE97uesXB8gWSmZCZjXjGhHrG1+N7f9uRNVvbzjxd4A0l00TGjVGxL01wx/3+yw2K98/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163695; c=relaxed/simple;
	bh=69Bnqoynyjn/q+9NvkuWoLJnxVVYEkGzpkA69xAZ4gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzdSy1cFJeP9YdiI8tZUAMUDFZ3u0qsakFwNfaudRxz9RfQ8hWJ0gayNxT4Z/6ufCCygMI7426ap6xc1pMsBRoVQr5ezq/e6ZC7vHBUcB1KFf9Pjgh2epP36/n5Skd6Wtgz/nTOpi+9RY6A86MExWx4i4uq9zddlCv6nJ3SIwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4F5HMWix; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ey5NM8CBmP9xc4LLpfl6+DouXpz8NtpPwdSJkTH6978=; b=4F5HMWixQfM03ALlk/hw80X2Qh
	fnFXRTYZ87cSL0aZH5WVx5UHLdBSpILxUwK/EljSWT/XZKWDC6tRAkrj6JwOcQSfO2NH0+WZVolhZ
	9LealM8/6H4dUeSNUBiYltyHZjdg0Uvplvsc7Q1XMBjLFij6iQUpYTcHzF2oHplGVzLRegJiw3Lr4
	zFvUMCeXiM4JgYXlfEiPr++0wi/d+oYMuFRFgdCuDG6Li+GkbuPGuM5CX4hq33pno3W6nO18Vlkx0
	SoqXQDJ8vmbULNDf4ENkF98LuMWaAcCv1vttUcesYbLmbqppn/2Zv3lcPdKvE3x2pmVSzeL5xO+DK
	94jWEYeg==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0Av-00000001SLW-2Of6;
	Tue, 24 Sep 2024 07:41:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
Date: Tue, 24 Sep 2024 09:40:47 +0200
Message-ID: <20240924074115.1797231-6-hch@lst.de>
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


