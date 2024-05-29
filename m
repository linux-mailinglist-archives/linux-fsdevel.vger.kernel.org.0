Return-Path: <linux-fsdevel+bounces-20394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FFE8D2A46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED07C1C23BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1415E15AAD3;
	Wed, 29 May 2024 01:59:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850415B133;
	Wed, 29 May 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947966; cv=none; b=erMads7Ne+vnuT437dKvz5x6SCa3cWcP2KK6hcpklOv0CrELLCvyiElMVt7K9RitpJK4k29fjtLIimvrREXb9LsS4uYodxOlRt8CeuR893kWak2OjpRhKKmtl6rmk5yEfFE5KtqtoMinRdWUEyt8moUXo2LajgCSzB5V71xMZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947966; c=relaxed/simple;
	bh=VGPSucUzbA/c3S9u7oVAQpYgV06MZBi1HmmrATX/mE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3MUwbIq0txjRfrOqisLSEW8/9vF3E+qrZ/RKrL6vm/YO0Dj4qq/77C3w/hic2gfGuVWqcx539wMM3ud7fVmLur6/3BBzOf7jhcCnMXPYrVkTR7ReJMWdHSFEcdLwA2sK1MoZ1M/hrrL04aC5vGJINiLY8HQoduesKye5ZF8xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxv0V0Jz4f3m8h;
	Wed, 29 May 2024 09:59:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1EE1B1A01B9;
	Wed, 29 May 2024 09:59:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S12;
	Wed, 29 May 2024 09:59:20 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode with huge extsize
Date: Wed, 29 May 2024 17:52:06 +0800
Message-Id: <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S12
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8AryDtw43JF47urW5trb_yoW5Zr4DpF
	Z7J3WrGr4kG342kayvvF4jqw1akas2kr4UCFWrXr17Zwn8Jr1ftrn7t34rWw4Utr40ga90
	gFn8C3y7Z3W3AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRilksDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

If we truncate down a realtime inode which extsize is too large, zeroing
out the entire aligned EOF extent could be very slow. Fortunately,
__xfs_bunmapi() would align the unmapped range to rtextsize, split and
convert the extra blocks to unwritten state. So, adjust the blocksize to
the filesystem blocksize if the rtextsize is large enough, let
__xfs_bunmapi() to convert the tail blocks to unwritten, this could
improve the truncate performance significantly.

 # mkfs.xfs -f -rrtdev=/dev/pmem1s -f -m reflink=0,rmapbt=0, \
            -d rtinherit=1 -r extsize=1G /dev/pmem2s
 # for i in {1..5}; \
   do dd if=/dev/zero of=/mnt/scratch/$i bs=1M count=1024; done
 # sync
 # time for i in {1..5}; \
   do xfs_io -c "truncate 4k" /mnt/scratch/$i; done

Before:
 real    0m16.762s
 user    0m0.008s
 sys     0m16.750s

After:
 real    0m0.076s
 user    0m0.010s
 sys     0m0.069s

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_inode.c |  2 +-
 fs/xfs/xfs_inode.h | 12 ++++++++++++
 fs/xfs/xfs_iops.c  |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index db35167acef6..c0c1ab310aae 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1513,7 +1513,7 @@ xfs_itruncate_extents_flags(
 	 * the page cache can't scale that far.
 	 */
 	first_unmap_block = XFS_B_TO_FSB(mp, (xfs_ufsize_t)new_size);
-	if (xfs_inode_has_bigrtalloc(ip))
+	if (xfs_inode_has_bigrtalloc(ip) && !xfs_inode_has_hugertalloc(ip))
 		first_unmap_block = xfs_rtb_roundup_rtx(mp, first_unmap_block);
 	if (!xfs_verify_fileoff(mp, first_unmap_block)) {
 		WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 292b90b5f2ac..4eed5b0c57c0 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -320,6 +320,18 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	return XFS_IS_REALTIME_INODE(ip) && ip->i_mount->m_sb.sb_rextsize > 1;
 }
 
+/*
+ * Decide if this file is a realtime file whose data allocation unit is larger
+ * than default.
+ */
+static inline bool xfs_inode_has_hugertalloc(struct xfs_inode *ip)
+{
+	struct xfs_mount *mp = ip->i_mount;
+
+	return XFS_IS_REALTIME_INODE(ip) &&
+	       mp->m_sb.sb_rextsize > XFS_B_TO_FSB(mp, XFS_DFL_RTEXTSIZE);
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index c53de5e6ef66..d5fc84e5a37c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -870,6 +870,15 @@ xfs_setattr_size(
 	if (newsize < oldsize) {
 		unsigned int blocksize = xfs_inode_alloc_unitsize(ip);
 
+		/*
+		 * If the extsize is too large on a realtime inode, zeroing
+		 * out the entire aligned EOF extent could be slow, adjust the
+		 * blocksize to the filesystem blocksize, let __xfs_bunmapi()
+		 * to convert the tail blocks to unwritten.
+		 */
+		if (xfs_inode_has_hugertalloc(ip))
+			blocksize = i_blocksize(inode);
+
 		/*
 		 * Zeroing out the partial EOF block and the rest of the extra
 		 * aligned blocks on a downward truncate.
-- 
2.39.2


