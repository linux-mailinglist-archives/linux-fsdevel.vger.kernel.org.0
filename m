Return-Path: <linux-fsdevel+bounces-53510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17EAEFA29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7DB16E918
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5E27510C;
	Tue,  1 Jul 2025 13:21:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA4273818;
	Tue,  1 Jul 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376062; cv=none; b=tchbOTJN76uFBoA4nhL5E5jrZ7hXbozduggipqmBN7lmfEyVmFWZevXe5+QTGmXazfwtsBdBC+qfW1pVjzPZ+znfj7fumHV+Y3SZ22gEjNhGAW2HgjK7Mx13+f/uN16D4AUDNWHY0KLhpjanycjxZyW9yT7JMzbinO4fBzYq2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376062; c=relaxed/simple;
	bh=iP2TtTvJh15Q8qVcIghGtJuwk7cPJ5blKpE8maiVePY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gETfcAKJSRsnSoFTSjKsV8L1O46X+R0rNoAx8btRyOBI+4JXRzXgR9v9CY9Jx5xXU/UfOpQYZ3yx1eKRjqu1Vb9RN5G+ZLcbaHwEmMPMZDPOuhUb0Djk4VuPYEHn8jH//HS1OUiscMKkdDmBEbdtCWaeOn5wgx+ROpe5IcrxlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDr14bTzKHN5H;
	Tue,  1 Jul 2025 21:21:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8943C1A19D5;
	Tue,  1 Jul 2025 21:20:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S7;
	Tue, 01 Jul 2025 21:20:58 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 03/10] ext4: fix stale data if it bail out of the extents mapping loop
Date: Tue,  1 Jul 2025 21:06:28 +0800
Message-ID: <20250701130635.4079595-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDXr47uFyDGw18GrWfKrg_yoW5CFyDpF
	Wakwn8Gr4kGayag393JanrXr1Fk395JrWUXFW7GrZrZFy5JFyfKr4xt3WYvFW5JrykJFy0
	qr4UKr1UW3W7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUF3kuDUUUU
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

Fix this by submitting the current processing partially mapped folio.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 38db1c186f76..62f1263d05da 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2361,6 +2361,47 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	return 0;
 }
 
+/*
+ * This is used to submit mapped buffers in a single folio that is not fully
+ * mapped for various reasons, such as insufficient space or journal credits.
+ */
+static int mpage_submit_buffers(struct mpage_da_data *mpd)
+{
+	struct inode *inode = mpd->inode;
+	struct folio *folio;
+	loff_t pos;
+	int ret;
+
+	folio = filemap_get_folio(inode->i_mapping,
+				  mpd->start_pos >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	/*
+	 * The mapped position should be within the current processing folio
+	 * but must not be the folio start position.
+	 */
+	pos = mpd->map.m_lblk << inode->i_blkbits;
+	if (WARN_ON_ONCE((folio_pos(folio) == pos) ||
+			 !folio_contains(folio, pos >> PAGE_SHIFT)))
+		return -EINVAL;
+
+	ret = mpage_submit_folio(mpd, folio);
+	if (ret)
+		goto out;
+	/*
+	 * Update start_pos to prevent this folio from being released in
+	 * mpage_release_unused_pages(), it will be reset to the aligned folio
+	 * pos when this folio is written again in the next round. Additionally,
+	 * do not update wbc->nr_to_write here, as it will be updated once the
+	 * entire folio has finished processing.
+	 */
+	mpd->start_pos = pos;
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
 /*
  * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
  *				 mpd->len and submit pages underlying it for IO
@@ -2411,8 +2452,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
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
+					if (mpage_submit_buffers(mpd))
+						goto invalidate_dirty_pages;
 					goto update_disksize;
+				}
 				return err;
 			}
 			ext4_msg(sb, KERN_CRIT,
-- 
2.46.1


