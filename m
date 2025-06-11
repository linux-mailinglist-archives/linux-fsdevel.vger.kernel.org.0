Return-Path: <linux-fsdevel+bounces-51307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99AAD53F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1268617D009
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9626C3B0;
	Wed, 11 Jun 2025 11:29:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60325BF12;
	Wed, 11 Jun 2025 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641383; cv=none; b=liRDE0VQZfCTxlAq/NiB+2z876bebB2IJGi7rytyE72ulSmgFrgNK8XIeAMpVPCOebl+rbDOhOIvno8bA8M5aas2jtu1PaTxx6vSuOX8ybxBFqzY9v6bGst4hnIiCfQTysaHHV7RIymHRPmrAp28ndnKCM0op59Q3PhtoxDMzx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641383; c=relaxed/simple;
	bh=lVChN0/oMfMsiVquqIy42WwZPKjVduH4hbJF3twoQ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBL1WhJsblGB/cfhyMLtnATWE5VcKLn5Q64iJAnvdNqeKT77LDEzv+9tZd1Udjwos+koffOSRwW6bieeHzsvudyzCKWP7RRWEpQe1BfMMtJAFfleapWNlUlStfGxJQ8jLPXMhLQt8o7cxHU8pzugzERXEo1m5DEyUeBirbsOdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjc4dsxzYQvsb;
	Wed, 11 Jun 2025 19:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9F1661A1669;
	Wed, 11 Jun 2025 19:29:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S6;
	Wed, 11 Jun 2025 19:29:39 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 2/6] ext4: fix stale data if it bail out of the extents mapping loop
Date: Wed, 11 Jun 2025 19:16:21 +0800
Message-ID: <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDXr47uFyDGw18GrWfKrg_yoWrGFykpF
	Wjkwn8Kw4kJaya9rZ3XayDZr1Sy3yrJrW7Jay7GFW2vFy5GryfKr48ta4FvFWrXrWDJFW0
	qF45Kr45u3W7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

During the process of writing back folios, if
mpage_map_and_submit_extent() exits the extent mapping loop due to an
ENOSPC or ENOMEM error, it may result in stale data or filesystem
inconsistency in environments where the block size is smaller than the
folio size.

When mapping a discontinuous folio in mpage_map_and_submit_extent(),
some buffers may have already be mapped. If we exit the mapping loop
prematurely, the folio data within the mapped range will not be written
back, and the file's disk size will not be updated. Once the transaction
that includes this range of extents is committed, this can lead to stale
data or filesystem inconsistency.

Fix this by submitting the current processing partial mapped folio and
update the disk size to the end of the mapped range.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3a086fee7989..d0db6e3bf158 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2362,6 +2362,42 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	return 0;
 }
 
+/*
+ * This is used to submit mapped buffers in a single folio that is not fully
+ * mapped for various reasons, such as insufficient space or journal credits.
+ */
+static int mpage_submit_buffers(struct mpage_da_data *mpd, loff_t pos)
+{
+	struct inode *inode = mpd->inode;
+	struct folio *folio;
+	int ret;
+
+	folio = filemap_get_folio(inode->i_mapping, mpd->first_page);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	ret = mpage_submit_folio(mpd, folio);
+	if (ret)
+		goto out;
+	/*
+	 * Update first_page to prevent this folio from being released in
+	 * mpage_release_unused_pages(), it should not equal to the folio
+	 * index.
+	 *
+	 * The first_page will be reset to the aligned folio index when this
+	 * folio is written again in the next round. Additionally, do not
+	 * update wbc->nr_to_write here, as it will be updated once the
+	 * entire folio has finished processing.
+	 */
+	mpd->first_page = round_up(pos, PAGE_SIZE) >> PAGE_SHIFT;
+	WARN_ON_ONCE((folio->index == mpd->first_page) ||
+		     !folio_contains(folio, pos >> PAGE_SHIFT));
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
 /*
  * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
  *				 mpd->len and submit pages underlying it for IO
@@ -2412,8 +2448,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			 */
 			if ((err == -ENOMEM) ||
 			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
-				if (progress)
+				/*
+				 * We may have already allocated extents for
+				 * some bhs inside the folio, issue the
+				 * corresponding data to prevent stale data.
+				 */
+				if (progress) {
+					if (mpage_submit_buffers(mpd, disksize))
+						goto invalidate_dirty_pages;
 					goto update_disksize;
+				}
 				return err;
 			}
 			ext4_msg(sb, KERN_CRIT,
@@ -2432,6 +2476,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			*give_up_on_write = true;
 			return err;
 		}
+		disksize = ((loff_t)(map->m_lblk + map->m_len)) <<
+				inode->i_blkbits;
 		progress = 1;
 		/*
 		 * Update buffer state, submit mapped pages, and get us new
@@ -2442,12 +2488,12 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			goto update_disksize;
 	} while (map->m_len);
 
+	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
 update_disksize:
 	/*
 	 * Update on-disk size after IO is submitted.  Races with
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
-	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
 	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
-- 
2.46.1


