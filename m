Return-Path: <linux-fsdevel+bounces-54119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4936FAFB5D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4147A75C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741612DA775;
	Mon,  7 Jul 2025 14:23:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9E2D8DA8;
	Mon,  7 Jul 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898182; cv=none; b=D5NEkk1hz3GIqT0S6hCMZj7BDxM0uMv57RbB3e7xJqfBCgintvwwGeh8H2mlq3Nys+RmTR5dq5zsSML4E/oUCoH7zHeM3oLWLyZ5/mKBqzADjOi7iwzO/o7yAoxxeltlHbOGXE7YKPBflhBrgj0d7lzmXWxqkbpjTdT7sQrFdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898182; c=relaxed/simple;
	bh=/8a14RKx+/vu23OotjhAuMT/bhp+m/jgRNfnpIWwJx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGOmN01ep6a8h8x22UZflmhT9V5cS6RQsAHYIfjY8uZcCx8xIeFUzredwbPSiZtvscKp/iOeSHfZTu5vT6+6BIqNyzjASP+juEil2GAC6kbl6pPkyYnr845aJnHcRvN0XnMZDlwlFLKIVnK7MPn9XIhn6sZJXriMdWUIz/d3WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKZ5KWZzKHMhd;
	Mon,  7 Jul 2025 22:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 34D9F1A018C;
	Mon,  7 Jul 2025 22:22:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S7;
	Mon, 07 Jul 2025 22:22:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 03/11] ext4: fix stale data if it bail out of the extents mapping loop
Date: Mon,  7 Jul 2025 22:08:06 +0800
Message-ID: <20250707140814.542883-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDXr47uFyDGw18GrWfKrg_yoW5ZryrpF
	Wakwn8Gr4kGayak393JFs7Zr1Fk395JrWUXFW7GrZrZFy5tFySkr4xt3WYvFW5JrykAFy0
	qr45Kr1UW3WUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a88ed7f51afc..a59d148b9185 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2361,6 +2361,47 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	return 0;
 }
 
+/*
+ * This is used to submit mapped buffers in a single folio that is not fully
+ * mapped for various reasons, such as insufficient space or journal credits.
+ */
+static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
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
+	pos = ((loff_t)mpd->map.m_lblk) << inode->i_blkbits;
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
+					if (mpage_submit_partial_folio(mpd))
+						goto invalidate_dirty_pages;
 					goto update_disksize;
+				}
 				return err;
 			}
 			ext4_msg(sb, KERN_CRIT,
-- 
2.46.1


