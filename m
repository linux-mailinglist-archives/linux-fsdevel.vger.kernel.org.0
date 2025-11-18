Return-Path: <linux-fsdevel+bounces-68912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBBC68330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22654EFF21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04330F7FE;
	Tue, 18 Nov 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YAA7K6Q+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06430E855;
	Tue, 18 Nov 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454405; cv=none; b=T8AiZlOKEGVU0p3vI7RKeSJi81DdvkMwh5c5Et0OOA8n+yMvjNAViCuOj+eqAuokQph4yWypri1LRFYvLmcK7EJbncG1OAFE8r6DFMfRD1eivzMJa88lv/xEqWHFoMR1lj07cirwiu2rP5dSngH9rSQN4TXEK36npUQOkwGrlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454405; c=relaxed/simple;
	bh=SWHI6+KQNwTARRsMofGlnQxP3zRdoyS5+c3T1zuIi/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGMzw6uF00Pn2tG+TRCtCEwmqRUm91UYP96bPeukkcs5uYzR2muJjryieYLESKTEt8e1Rq3w9rgel87C1+XcTuOTBMKXkJSDD5k8gMUw8DYIPhktEtNg4L/+Ecxk4oLrFSQK7hFZwIWDMiE0hCHyT0JIF41j06ppLtAlxQo8rQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YAA7K6Q+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bi
	LtkTp8vGas+r+wZ19/Ti3OnkocVUM3pHmHDrrYUwg=; b=YAA7K6Q+IKmnft3eNs
	v7QkwS/6scqBY6mk95zhrCd5rJ2R4KR+/dgDHahAgVf6kTXjAi6nM/dBfsd91nc/
	E23IuS0+gh7NmfdSHlSbOGY1R6fxhMdpOrUp3Kq/dBf+XdM8orLnywCP/fYuGgYF
	Cq9JvoXTCXvAuPl9BscWQnCNM=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S9;
	Tue, 18 Nov 2025 16:25:46 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 7/7] exfat: get mutil-clusters in exfat_get_block
Date: Tue, 18 Nov 2025 16:22:08 +0800
Message-ID: <20251118082208.1034186-8-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43Kw15KF43WFyfZF17GFg_yoW8Zry5p3
	ykGa4rGw45W3srWa1xtrs5WF1S93ykGFy8Jr4xXF1Ykr9YqrnavFWqyr9xA3Wrt3Z5Xrn0
	q3WrKr1j9wnrG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmApOUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFA4KnWkcJbfc6AAAse

From: Chi Zhiling <chizhiling@kylinos.cn>

mpage uses the get_block of the file system to obtain the mapping of a
file or allocate blocks for writes. Currently exfat only supports
obtaining one cluster in each get_block call.

Since exfat_count_contig_clusters can obtain multiple consecutive clusters,
it can be used to improve exfat_get_block when page size is larger than
cluster size.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f9501c3a3666..256ba2af34eb 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -264,13 +264,14 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 static int exfat_get_block(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh_result, int create)
 {
+	struct exfat_chain chain;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err = 0;
 	unsigned long mapped_blocks = 0;
-	unsigned int cluster, sec_offset;
+	unsigned int cluster, sec_offset, count;
 	sector_t last_block;
 	sector_t phys = 0;
 	sector_t valid_blks;
@@ -301,6 +302,17 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 
 	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
 	mapped_blocks = sbi->sect_per_clus - sec_offset;
+
+	if (max_blocks > mapped_blocks && !create) {
+		chain.dir = cluster;
+		chain.size = (max_blocks >> sbi->sect_per_clus_bits) + 1;
+		chain.flags = ei->flags;
+
+		err = exfat_count_contig_clusters(sb, &chain, &count);
+		if (err)
+			return err;
+		max_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
+	}
 	max_blocks = min(mapped_blocks, max_blocks);
 
 	map_bh(bh_result, sb, phys);
-- 
2.43.0


