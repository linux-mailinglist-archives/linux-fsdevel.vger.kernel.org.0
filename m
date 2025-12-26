Return-Path: <linux-fsdevel+bounces-72104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D80CDE8FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52889303373E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6A318136;
	Fri, 26 Dec 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AJe/IXnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F82877F7;
	Fri, 26 Dec 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742341; cv=none; b=dpCoBHFfwodF7aOvfPSKD/zpTKHoQAZQwDTVH1hmzkMAjr0Lccke9okv6B/6BB5OV9DvnbuCrWXSgkIX/+hg96kyUtYcL3vOVNU9M/ChppSjysThcORr4cSL7/S2U5HIfwNsig+lK8hXCFoWO3Y5RLPSudpivpTualEWwnHN9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742341; c=relaxed/simple;
	bh=Y+4+V+3jL+/gW4a5GlQGShJ3qbIiu4tlcmV+HCtNyTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0zrMFacRi/y1iP0t945Shx6ESraT+Rum9rfqEcBaxFo64DBteJ619JSoaIX0Yq0Kk5qG3yAO4h3eaAqBGOAXwEcGr6HFoOHFWioa+j7heNqKnffyDPhi7zVsjjZlfTXiL8nJSn98qglXsTA8BaA8ueG116woZoydhNHgF89Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AJe/IXnY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sr
	fBXNxGCh5Rq4nSeVRnEtAkghTflmqeu00QEdkWvkI=; b=AJe/IXnYVX8DqQzc94
	wiMInhkOQ4tSzQYCU7M5sOUeakBBchqlgXhzYokxOW8acFEdfqGX7ozAM5KjiJzO
	uDWryjJ34Xix2LIhGnmYlxx+JBXeEtEM8QSr8DM7okMo1iyT+P8fFiqsMJMHGDd8
	JcJf+kk7AV1LbXwVC78bOyifM=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S10;
	Fri, 26 Dec 2025 17:44:54 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 8/9] exfat: support multi-cluster for exfat_map_cluster
Date: Fri, 26 Dec 2025 17:44:39 +0800
Message-ID: <20251226094440.455563-9-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226094440.455563-1-chizhiling@163.com>
References: <20251226094440.455563-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1rZr47urWftw43ury8Krg_yoWrGFW3pr
	s7Ka4rtr13Ja4DGa1xJr4kZryS93Z7GFy5JayxWryUGr90qF1FgFWqyr9xC3W8Ga1ruF4q
	q3WrGw1UursxJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um2NNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xZJ5mlOWRaHQwAA3i

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
 fs/exfat/inode.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1062ce470cb1..8c49ab15eafe 100644
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
 	} else if (ei->type == TYPE_FILE) {
 		int err = exfat_get_cluster(inode, clu_offset,
 				clu, &last_clu);
 		if (err)
 			return -EIO;
+		*count = (*clu == EXFAT_EOF_CLUSTER) ? 0 : 1;
 	} else {
 		unsigned int fclus = 0;
 		/* hint information */
@@ -178,6 +181,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				return -EIO;
 			fclus++;
 		}
+		*count = (*clu == EXFAT_EOF_CLUSTER) ? 0 : 1;
 	}
 
 	if (*clu == EXFAT_EOF_CLUSTER) {
@@ -249,7 +253,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				num_to_be_allocated--;
 			}
 		}
-
+		*count = 1;
 	}
 
 	/* hint information */
@@ -268,7 +272,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err = 0;
 	unsigned long mapped_blocks = 0;
-	unsigned int cluster, sec_offset;
+	unsigned int cluster, sec_offset, count;
 	sector_t last_block;
 	sector_t phys = 0;
 	sector_t valid_blks;
@@ -281,8 +285,9 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 		goto done;
 
 	/* Is this block already allocated? */
+	count = EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
 	err = exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bits,
-			&cluster, create);
+			&cluster, &count, create);
 	if (err) {
 		if (err != -ENOSPC)
 			exfat_fs_error_ratelimit(sb,
@@ -293,12 +298,14 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 
 	if (cluster == EXFAT_EOF_CLUSTER)
 		goto done;
+	if (WARN_ON_ONCE(!count))
+		count = 1;
 
 	/* sector offset in cluster */
 	sec_offset = iblock & (sbi->sect_per_clus - 1);
 
 	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
-	mapped_blocks = sbi->sect_per_clus - sec_offset;
+	mapped_blocks = count * sbi->sect_per_clus - sec_offset;
 	max_blocks = min(mapped_blocks, max_blocks);
 
 	map_bh(bh_result, sb, phys);
-- 
2.43.0


