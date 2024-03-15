Return-Path: <linux-fsdevel+bounces-14443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0287CD94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B81F22517
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C079381DF;
	Fri, 15 Mar 2024 13:01:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362C250EB;
	Fri, 15 Mar 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507670; cv=none; b=lXWy0dy839se03jRcAfG8AZOI8A1q95H/GBmeggMcXAksUVde3t4zmqrGUFI6B+rdGGp34ejBzYmvsbtrTqVpP11Ap/SztioXth6wCq/GBe79CCmS5j1Bu3kgDlxp7/ExgRisKXx4MVA0Qs6L12qJTGo/dhGpNsx26z2Kth0HlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507670; c=relaxed/simple;
	bh=HJGL//A0L5qdlG/WeENfCkvp9PkY1yEc2bCwKIn8Zz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gWepYhLs4/iuowueugkY/2KAp+1HVCf5rtk8804PbT9VsoM6h8U3mu1kSP04bIZy4biv3vsrxcxMK2W7PnAidhLvir0NqL2T83DFd1UTZpaTIALrpmv8hetIC/kkFdAUX4tNWZzLzCkQm/ba4KM1zWbWSg2SgUWd1gBeDVTnRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tx49y6m6Mz4f3m7B;
	Fri, 15 Mar 2024 21:00:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B33C01A017A;
	Fri, 15 Mar 2024 21:01:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9RvRldVMfHA--.12032S7;
	Fri, 15 Mar 2024 21:01:02 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 03/10] xfs: make xfs_bmapi_convert_delalloc() to allocate the target offset
Date: Fri, 15 Mar 2024 20:53:47 +0800
Message-Id: <20240315125354.2480344-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9RvRldVMfHA--.12032S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1rXw15Ary5Kr1fCFyUKFg_yoW5AF4xpF
	Z3G34rKr4qqw1fZFnIyF1Yqw1Ska1xCF48CF4xWrnxZay5Zr1fWF1vkF1F934UArWfX3Wj
	qr45Aa47W398Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
	U
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since xfs_bmapi_convert_delalloc() only attempts to allocate the entire
delalloc extent and require multiple invocations to allocate the target
offset. So xfs_convert_blocks() add a loop to do this job and we call it
in the write back path, but xfs_convert_blocks() isn't a common helper.
Let's do it in xfs_bmapi_convert_delalloc(), preparing for the post EOF
delalloc blocks converting in the buffered write begin path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 34 ++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_aops.c        | 15 +--------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 07dc35de8ce5..042e8d3ab0ba 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4516,8 +4516,8 @@ xfs_bmapi_write(
  * invocations to allocate the target offset if a large enough physical extent
  * is not available.
  */
-int
-xfs_bmapi_convert_delalloc(
+static int
+__xfs_bmapi_convert_delalloc(
 	struct xfs_inode	*ip,
 	int			whichfork,
 	xfs_off_t		offset,
@@ -4648,6 +4648,36 @@ xfs_bmapi_convert_delalloc(
 	return error;
 }
 
+/*
+ * Pass in a dellalloc extent and convert it to real extents, return the real
+ * extent that maps offset_fsb in iomap.
+ */
+int
+xfs_bmapi_convert_delalloc(
+	struct xfs_inode	*ip,
+	int			whichfork,
+	loff_t			offset,
+	struct iomap		*iomap,
+	unsigned int		*seq)
+{
+	int			error;
+
+	/*
+	 * Attempt to allocate whatever delalloc extent currently backs offset
+	 * and put the result into iomap.  Allocate in a loop because it may
+	 * take several attempts to allocate real blocks for a contiguous
+	 * delalloc extent if free space is sufficiently fragmented.
+	 */
+	do {
+		error = __xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+					iomap, seq);
+		if (error)
+			return error;
+	} while (iomap->offset + iomap->length <= offset);
+
+	return 0;
+}
+
 int
 xfs_bmapi_remap(
 	struct xfs_trans	*tp,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 813f85156b0c..376ec0993943 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -248,7 +248,6 @@ xfs_convert_blocks(
 	int			whichfork,
 	loff_t			offset)
 {
-	int			error;
 	unsigned		*seq;
 
 	if (whichfork == XFS_COW_FORK)
@@ -256,20 +255,8 @@ xfs_convert_blocks(
 	else
 		seq = &XFS_WPC(wpc)->data_seq;
 
-	/*
-	 * Attempt to allocate whatever delalloc extent currently backs offset
-	 * and put the result into wpc->iomap.  Allocate in a loop because it
-	 * may take several attempts to allocate real blocks for a contiguous
-	 * delalloc extent if free space is sufficiently fragmented.
-	 */
-	do {
-		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+	return xfs_bmapi_convert_delalloc(ip, whichfork, offset,
 				&wpc->iomap, seq);
-		if (error)
-			return error;
-	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
-
-	return 0;
 }
 
 static int
-- 
2.39.2


