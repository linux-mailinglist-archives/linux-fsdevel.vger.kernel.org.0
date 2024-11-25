Return-Path: <linux-fsdevel+bounces-35777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173F9D84DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60933B3018D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE17194AE6;
	Mon, 25 Nov 2024 11:46:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEB186E59;
	Mon, 25 Nov 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535193; cv=none; b=B8wd1HZ13lPBLP+W3rrv2f1kDTk4rz/KnFprInPYCjA3zSTK4VYAbALbuxIrcuKSsLWH5aDmdwerRRatGxnm3uaF6Ud/G+Kh8Dz61a+eO903/4ATptdd62aMLB8its534fWRhnMNVUxrQyQrduXQPx/Ucr7b3Ylbgv1xMvwvEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535193; c=relaxed/simple;
	bh=vCTOertUZohQPhm3R+Ud9igr5aOQGYz3iB1Z+xenxoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvY4fNb3tIhvVGf/fCZfsdWAAodFay8Fv1ivOx8e/K4oAjcZB0u6dIudSy6/f2/ZUHO/m9mHiEsFvwEI/xFLn9mMHOShEO/eskbHaPGN93MSeOxjK5n+pdxOymL8JexNxv4554rniMUiMGcstpZvpeENzcrXpPJEMp259pXRtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkS56J0Pz4f3kk9;
	Mon, 25 Nov 2024 19:46:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 813541A018C;
	Mon, 25 Nov 2024 19:46:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S5;
	Mon, 25 Nov 2024 19:46:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/9] fs: make block_read_full_folio() support large folio
Date: Mon, 25 Nov 2024 19:44:11 +0800
Message-ID: <20241125114419.903270-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15tFy3XrW7tr15Aw43Jrb_yoW5Gw45pF
	y3KFZ8Kr4kWr42gFnFyr13Zw1ftas7XF4UCayfJw13ZF98Awn0gryktw1DJFW0qr9xXr95
	XF15WryrWF18XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUfKs8UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

block_read_full_folio() uses an on-stack array to save the un-uptodated
buffers. This approach is acceptable for small folios, as there are not
too many buffers in a single folio. However, if the folio is a large
folio, the number of buffers could reach up to 2,000 for a 2MB folio
size with a 1KB block size. Therefore, we cannot use the 'arr' array for
large folios, instead, we should iterate through the buffers using 'bh =
bh->b_this_page'.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/buffer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..54e608c8912e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2366,7 +2366,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 {
 	struct inode *inode = folio->mapping->host;
 	sector_t iblock, lblock;
-	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
+	struct buffer_head *bh, *head;
 	size_t blocksize;
 	int nr, i;
 	int fully_mapped = 1;
@@ -2377,8 +2377,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
 		limit = inode->i_sb->s_maxbytes;
 
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	head = folio_create_buffers(folio, inode, 0);
 	blocksize = head->b_size;
 
@@ -2416,7 +2414,10 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 			if (buffer_uptodate(bh))
 				continue;
 		}
-		arr[nr++] = bh;
+		/* lock the buffer */
+		lock_buffer(bh);
+		mark_buffer_async_read(bh);
+		nr++;
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	if (fully_mapped)
@@ -2431,25 +2432,24 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 		return 0;
 	}
 
-	/* Stage two: lock the buffers */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
-		lock_buffer(bh);
-		mark_buffer_async_read(bh);
-	}
-
 	/*
-	 * Stage 3: start the IO.  Check for uptodateness
-	 * inside the buffer lock in case another process reading
-	 * the underlying blockdev brought it uptodate (the sct fix).
+	 * Start the IO.  Check for uptodateness inside the buffer lock
+	 * in case another process reading the underlying blockdev brought
+	 * it uptodate (the sct fix).
 	 */
-	for (i = 0; i < nr; i++) {
-		bh = arr[i];
+	bh = head;
+	do {
+		if (!buffer_async_read(bh))
+			continue;
+
 		if (buffer_uptodate(bh))
 			end_buffer_async_read(bh, 1);
 		else
 			submit_bh(REQ_OP_READ, bh);
-	}
+
+		nr--;
+	} while (nr && (bh = bh->b_this_page) != head);
+
 	return 0;
 }
 EXPORT_SYMBOL(block_read_full_folio);
-- 
2.46.1


