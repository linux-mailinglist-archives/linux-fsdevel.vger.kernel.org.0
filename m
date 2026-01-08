Return-Path: <linux-fsdevel+bounces-72791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795BCD01FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAA6937F64AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3333803C5;
	Thu,  8 Jan 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e5OYp+6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3037E2E4;
	Thu,  8 Jan 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858651; cv=none; b=haiREq2x1pIFfpVpc7+IbMdwN/Gucc4sYmhcEQGJl2t+2r99i+k/G1r2wW55/YOKgkwFdF8lh1MBrnjsq6tsDZGZ7ezhmoLugPYtmB1bhPJwHKBx45Q6wKCb9KYtef4grTqPrn8QBhc6yONGDsSfskExJTskUTvJeFs44n/cgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858651; c=relaxed/simple;
	bh=Jkg76GN876FLHX9JO/vRg6R8P8IvvWMAN51ZlTa0aQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWWkiCvwVD72nz6Mz0hwrTfGOz0/gtm4D8MRDl8JSUwVHMAQKCdgPCn93DXKzJbRJimfY2i5ZXI/uYCb6KegeWjXW9pL6YpgYz7pwNdfEcKSk4vV9A+8uubrkXO1QT0bjSiCYavqtvIOeLqLnKbfrWu09pAaHLkkBeh3P0JESSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e5OYp+6w; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iC
	nNoDLQBrrxJ+PEef0TIPaw8E9VJArDrJ/szk9uvO0=; b=e5OYp+6wnYWBaoBRNP
	I3J4fyJhiIimI0QtcEzgDR9K9/zfnGzPhGPfk26G1CGYzROyZjQU/AQxetqbXI9S
	SJn+sYtj86Y0VXs3VQmSWlkEDSUpUWI4ekTVbvbxoV2xTXumRxakZJFLUBpdzShi
	9NXmKH30zNQjUk2ByjjQ2gbZM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S12;
	Thu, 08 Jan 2026 15:50:09 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 10/13] exfat: support multi-cluster for exfat_map_cluster
Date: Thu,  8 Jan 2026 15:49:26 +0800
Message-ID: <20260108074929.356683-11-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108074929.356683-1-chizhiling@163.com>
References: <20260108074929.356683-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1rZr47urWftw43ury8Krg_yoW5tFWrpr
	s7Ga4rtr13JFyDGa1xJr4kZryS9wn7GFy5JayxWryUGr90qF1FqFWqyr9xC3W8Gan5uFs0
	q3WrGw1UuwsrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BG2VGlfYbEA2gAA3T

From: Chi Zhiling <chizhiling@kylinos.cn>

This patch introduces a parameter 'count' to support fetching multiple
clusters in exfat_map_cluster. The returned 'count' indicates the number
of consecutive clusters, or 0 when the input cluster offset is past EOF.

And the 'count' is also an input parameter for the caller to specify the
required number of clusters.

Only NO_FAT_CHAIN files enable multi-cluster fetching in this patch.

After this patch, the time proportion of exfat_get_block has decreased,
The performance data is as follows:

Cluster size: 512 bytes
Sequential read of a 30GB NO_FAT_CHAIN file:
2.4GB/s -> 2.5 GB/s
proportion of exfat_get_block:
10.8% -> 0.02%

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/inode.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index b714d242b238..00ff6c7ed935 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -124,7 +124,7 @@ void exfat_sync_inode(struct inode *inode)
  * *clu = (~0), if it's unable to allocate a new cluster
  */
 static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
-		unsigned int *clu, int create)
+		unsigned int *clu, unsigned int *count, int create)
 {
 	int ret;
 	unsigned int last_clu;
@@ -147,20 +147,23 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 
 	*clu = last_clu = ei->start_clu;
 
-	if (ei->flags == ALLOC_NO_FAT_CHAIN) {
-		if (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
-			last_clu += clu_offset - 1;
-
-			if (clu_offset == num_clusters)
-				*clu = EXFAT_EOF_CLUSTER;
-			else
-				*clu += clu_offset;
+	if (*clu == EXFAT_EOF_CLUSTER) {
+		*count = 0;
+	} else if (ei->flags == ALLOC_NO_FAT_CHAIN) {
+		last_clu += num_clusters - 1;
+		if (clu_offset < num_clusters) {
+			*clu += clu_offset;
+			*count = num_clusters - clu_offset;
+		} else {
+			*clu = EXFAT_EOF_CLUSTER;
+			*count = 0;
 		}
 	} else {
 		int err = exfat_get_cluster(inode, clu_offset,
 				clu, &last_clu);
 		if (err)
 			return -EIO;
+		*count = (*clu == EXFAT_EOF_CLUSTER) ? 0 : 1;
 	}
 
 	if (*clu == EXFAT_EOF_CLUSTER) {
@@ -232,7 +235,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				num_to_be_allocated--;
 			}
 		}
-
+		*count = 1;
 	}
 
 	/* hint information */
@@ -251,7 +254,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err = 0;
 	unsigned long mapped_blocks = 0;
-	unsigned int cluster, sec_offset;
+	unsigned int cluster, sec_offset, count;
 	sector_t last_block;
 	sector_t phys = 0;
 	sector_t valid_blks;
@@ -264,8 +267,9 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 		goto done;
 
 	/* Is this block already allocated? */
+	count = EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
 	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
-			&cluster, create);
+			&cluster, &count, create);
 	if (err) {
 		if (err != -ENOSPC)
 			exfat_fs_error_ratelimit(sb,
@@ -281,7 +285,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	sec_offset = iblock & (sbi->sect_per_clus - 1);
 
 	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
-	mapped_blocks = sbi->sect_per_clus - sec_offset;
+	mapped_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
 	max_blocks = min(mapped_blocks, max_blocks);
 
 	map_bh(bh_result, sb, phys);
-- 
2.43.0


