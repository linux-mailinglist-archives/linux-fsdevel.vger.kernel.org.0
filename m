Return-Path: <linux-fsdevel+bounces-28992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD4972870
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B471F24B74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984516DECC;
	Tue, 10 Sep 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4dHXYmOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F320314;
	Tue, 10 Sep 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943228; cv=none; b=kB6JMggQ1sn1PUi7VDgXlAP4uK70A7Izbjm6wQBLzS0mzu9LV+JghfAlrpyqQUGz+UAWq8aKWL+vWQL8Uc85rhyS4fjUi9VDuDK4Ld4W0l5UZdmfd95LZTJ593j9qRy1mhPuMCWRZ5uzANH5BPU4RWBRj/S7jbl6H98EPfLnTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943228; c=relaxed/simple;
	bh=HfVkd7GW11kEBcImieZ5GwNYxexQBEullp4sYZrJaOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8ty73JKZ77nmAnBchSd2d5vfSkheNn6XNLEIize8ra4X51Gd/TQUNmAzRxiYNY8goeh3Bbzrr6bKZbiCKV7fRcRIhK4yorMTIRqy6v8qQAvsNkd4ZmdnPvF8gft/jku1a+x9IjkKOKk3M2wRrS/p3gtwlINyIv/PtjGfNgK9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4dHXYmOE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lun4qZniY6Ekn7h3h/Oe3yxhUyJkBjwi3IVnIRhocoA=; b=4dHXYmOE/K2U1PjzUSc7fcuIzm
	XYkVRxxRuIMomBXinF/jKZp3JrpvkRDwlflFLQy5Oh0WU9wE/Z69mrRifglxyE5Avj9repdy8pt/M
	Cz3Z/2ZULnntjl8FkFcdrk3pq6LaMkhIBiSiDVo9skErXymqVLMEzUHEwACVByn91bwlz4pQA2GmM
	jNNFxSuNA2B2ndA1HnIL9PLuClznS1r07NvdjbA1Wi4w80oAS6fNInwjIqijvlUS9cDGU+CmeYbR7
	18M4ZOB85vMRwq0PxpmzKd1W4xPM3P32KbHgZCY1ap2L7kMdUUIk9n0IOuiZzMeN3UHASl0xlRqUb
	LexQdARw==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfx-00000004EvN-2f8W;
	Tue, 10 Sep 2024 04:40:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
Date: Tue, 10 Sep 2024 07:39:09 +0300
Message-ID: <20240910043949.3481298-8-hch@lst.de>
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

xfs_file_write_zero_eof is the only caller of xfs_zero_range that does
not take XFS_MMAPLOCK_EXCL (aka the invalidate lock).  Currently that
is acrually the right thing, as an error in the iomap zeroing code will
also take the invalidate_lock to clean up, but to fix that deadlock we
need a consistent locking pattern first.

The only extra thing that XFS_MMAPLOCK_EXCL will lock out are read
pagefaults, which isn't really needed here, but also not actively
harmful.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 8 +++++++-
 fs/xfs/xfs_iomap.c | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a30fda1985e6af..37dc26f51ace65 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -357,6 +357,7 @@ xfs_file_write_zero_eof(
 {
 	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
 	loff_t			isize;
+	int			error;
 
 	/*
 	 * We need to serialise against EOF updates that occur in IO completions
@@ -404,7 +405,12 @@ xfs_file_write_zero_eof(
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
index 1e11f48814c0d0..3c98d82c0ad0dc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1435,6 +1435,8 @@ xfs_zero_range(
 {
 	struct inode		*inode = VFS_I(ip);
 
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
+
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
-- 
2.45.2


