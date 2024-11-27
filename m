Return-Path: <linux-fsdevel+bounces-35960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7124E9DA25E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C1B239F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED3146019;
	Wed, 27 Nov 2024 06:37:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BBDF9DD;
	Wed, 27 Nov 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689438; cv=none; b=n+D6bIHcb/+3FyG6gSPdjPue36oNSoWTHKse9Zpu3M/X8ojs4qdigBzlHAPwxPCRMs48Uvmmm7mVIAWZobauMChG1dmrNX+hXL6iyYWI1FRlTaGqrkJ2hY981bDMMKmrwf+meZIwCMeu//3rMOFDGLL+g3jKLx9iGV+27YZe5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689438; c=relaxed/simple;
	bh=gYJV8hiVcdY74IiYP2sBRprveGPHCp6BspuPNxXO+xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1jlV7rU4eKtfdTVHghFfuiP/F1eMMiYDG/7E/2pja6QEPe/0MPdHYgcikIneAnMMslmEmlH0pruaSHmRMlnVfzAliaDBz06BaE0PzVtyj4zNtXFW0+SscKMtsgloPMDNINA5l/yE01s6rB0QSBm9qeyNtdbvFLS5V1b7D743oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XyqS70dWmz1jw1g;
	Wed, 27 Nov 2024 14:35:03 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C1F31A016C;
	Wed, 27 Nov 2024 14:37:10 +0800 (CST)
Received: from localhost.huawei.com (10.175.112.188) by
 dggpemf500017.china.huawei.com (7.185.36.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Nov 2024 14:37:10 +0800
From: Long Li <leo.lilong@huawei.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent append writes
Date: Wed, 27 Nov 2024 14:35:02 +0800
Message-ID: <20241127063503.2200005-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

During concurrent append writes to XFS filesystem, zero padding data
may appear in the file after power failure. This happens due to imprecise
disk size updates when handling write completion.

Consider this scenario with concurrent append writes same file:

  Thread 1:                  Thread 2:
  ------------               -----------
  write [A, A+B]
  update inode size to A+B
  submit I/O [A, A+BS]
                             write [A+B, A+B+C]
                             update inode size to A+B+C
  <I/O completes, updates disk size to min(A+B+C, A+BS)>
  <power failure>

After reboot:
  1) with A+B+C < A+BS, the file has zero padding in range [A+B, A+B+C]

  |<         Block Size (BS)      >|
  |DDDDDDDDDDDDDDDD0000000000000000|
  ^               ^        ^
  A              A+B     A+B+C
                         (EOF)

  2) with A+B+C > A+BS, the file has zero padding in range [A+B, A+BS]

  |<         Block Size (BS)      >|<           Block Size (BS)    >|
  |DDDDDDDDDDDDDDDD0000000000000000|00000000000000000000000000000000|
  ^               ^                ^               ^
  A              A+B              A+BS           A+B+C
                                  (EOF)

  D = Valid Data
  0 = Zero Padding

The issue stems from disk size being set to min(io_offset + io_size,
inode->i_size) at I/O completion. Since io_offset+io_size is block
size granularity, it may exceed the actual valid file data size. In
the case of concurrent append writes, inode->i_size may be larger
than the actual range of valid file data written to disk, leading to
inaccurate disk size updates.

This patch modifies the meaning of io_size to represent the size of
valid data within EOF in an ioend. If the ioend spans beyond i_size,
io_size will be trimmed to provide the file with more accurate size
information. This is particularly useful for on-disk size updates
at completion time.

After this change, ioends that span i_size will not grow or merge with
other ioends in concurrent scenarios. However, these cases that need
growth/merging rarely occur and it seems no noticeable performance impact.
Although rounding up io_size could enable ioend growth/merging in these
scenarios, we decided to keep the code simple after discussion [1].

Another benefit is that it makes the xfs_ioend_is_append() check more
accurate, which can reduce unnecessary end bio callbacks of xfs_end_bio()
in certain scenarios, such as repeated writes at the file tail without
extending the file size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link[1]: https://patchwork.kernel.org/project/xfs/patch/20241113091907.56937-1-leo.lilong@huawei.com
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
v4->v5: remove iomap_ioend_size_aligned() and don't round up io_size for
	ioend growth/merging to keep the code simple. 
 fs/iomap/buffered-io.c | 10 ++++++++++
 include/linux/iomap.h  |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d42f01e0fc1c..dc360c8e5641 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1774,6 +1774,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 {
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
+	loff_t isize = i_size_read(inode);
 	int error;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
@@ -1789,7 +1790,16 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 	if (ifs)
 		atomic_add(len, &ifs->write_bytes_pending);
+
+	/*
+	 * If the ioend spans i_size, trim io_size to the former to provide
+	 * the fs with more accurate size information. This is useful for
+	 * completion time on-disk size updates.
+	 */
 	wpc->ioend->io_size += len;
+	if (wpc->ioend->io_offset + wpc->ioend->io_size > isize)
+		wpc->ioend->io_size = isize - wpc->ioend->io_offset;
+
 	wbc_account_cgroup_owner(wbc, folio, len);
 	return 0;
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5675af6b740c..75bf54e76f3b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -335,7 +335,7 @@ struct iomap_ioend {
 	u16			io_type;
 	u16			io_flags;	/* IOMAP_F_* */
 	struct inode		*io_inode;	/* file being written to */
-	size_t			io_size;	/* size of the extent */
+	size_t			io_size;	/* size of data within eof */
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	struct bio		io_bio;		/* MUST BE LAST! */
-- 
2.39.2


