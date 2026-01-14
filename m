Return-Path: <linux-fsdevel+bounces-73689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5FD1EB2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAD63083C44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35443396B9A;
	Wed, 14 Jan 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VvBvJhRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E7397AA0;
	Wed, 14 Jan 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392838; cv=none; b=FwcJ/j9WJTHA966qvah21lhEnCki88edztFuzJZh2WBt82iUQXw+lS10uOWMyCfi9v7SfnfmhO9spcFclkry1A4g+AoK1g9w0Z/qgzWIVHgmUIVRxn5WlWA5cF9dUMspTX7NSwhYNjuiJeBgqz2trEXWtpvlgJvjEodsxbDg6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392838; c=relaxed/simple;
	bh=wggpCtCWmNQztcBxjMJh1Djqli2bnF8N8HdZHDOrBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/LpX2lekqmST7qhzPmBYqhyJlBl0m5q48UekI7hftd6jwVjyl0JBNYUWeLCc5UKXYijiJ19wz8J7INQ9PliMIeJTK3CPb6C8KR2X7CJviwksGRUo0NeYK7QVrWHFIfnVRpiD+rY/RDkduG8cT4XC0OawLVcx131xwKCE3NmMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VvBvJhRP; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sd
	u076G6wX8/527/HN6/TjfXwiqNfWXZAhmXWiv3CJ4=; b=VvBvJhRPlo0mxrsgVr
	sHqXOYeUe734KyHJR/ve8c1hmccTRNTSRQ71En/upqY2OEG8mePwcw4JahCwDQ1r
	NDn+UD782SguhHBg/o97Cr4w8QAXX7k+5ObTfQfknGO7MQvKwicC9kr2ZVlosLiO
	2/OtZU8++QbNjBuebBcPlRlow=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S12;
	Wed, 14 Jan 2026 20:13:21 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v3 10/13] exfat: support multi-cluster for exfat_map_cluster
Date: Wed, 14 Jan 2026 20:12:46 +0800
Message-ID: <20260114121250.615064-11-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
References: <20260114121250.615064-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1rZr47urWftw43ury8Krg_yoW5tw4kpr
	s7Ka4rtr13Ja4DGa1xJr4kZryS9wn7GFy5JayxGryUGr90qF1FqFWqyr9xC3W8Ga95uFs0
	q3WrGr1UuwsrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URHqxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9wFuDGlniGF6gQAA3I

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
index b714d242b238..410f9c98b8dc 100644
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
+			*count = min(num_clusters - clu_offset, *count);
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
+	mapped_blocks = ((unsigned long)count << sbi->sect_per_clus_bits) - sec_offset;
 	max_blocks = min(mapped_blocks, max_blocks);
 
 	map_bh(bh_result, sb, phys);
-- 
2.43.0


