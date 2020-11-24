Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451DB2C27C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgKXN3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbgKXN3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFBC0613D6;
        Tue, 24 Nov 2020 05:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0FpgDSjKIA8EJjMg/TQX03TXjJ1cPgViOyNw/xtQguo=; b=k7za8bhRgbJdBtuBRZkCatmJVt
        3javttSHXWCw3XYzxw1o5tiPDrIFOs8SOQHpPYQPM2MAnrcw7t136QgN7NdQQauuL3OWcSsN4we67
        Xkv82VHwyV+CBFF6AscMEzGPQB6JFJp1KZXSEFG2wKJkQTTE6vD5T2dDADC4jSevL6+ANGl460lQd
        zZHc5qMxeXpYKJ09TzlSIx2c1dD7VxWlqCNAxqUCX7UI9CS+1JMTIOE67cnMC0Vt2j4MJy/OIqz0n
        xvf9q5qYOIF6oiTk6b2ZnbNdBsTuUHnzdKE/wa1IuK3gIVfKhY/sG8+i7LRqRDPSs+fqgPSACvntx
        QGXr7dow==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNX-0006j2-Fz; Tue, 24 Nov 2020 13:29:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 43/45] f2fs: remove a few bd_part checks
Date:   Tue, 24 Nov 2020 14:27:49 +0100
Message-Id: <20201124132751.3747337-44-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bd_part is never NULL for a block device in use by a file system, so
remove the checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/checkpoint.c | 5 +----
 fs/f2fs/sysfs.c      | 9 ---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 023462e80e58d5..54a1905af052cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1395,7 +1395,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__u32 crc32 = 0;
 	int i;
 	int cp_payload_blks = __cp_payload(sbi);
-	struct super_block *sb = sbi->sb;
 	struct curseg_info *seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	u64 kbytes_written;
 	int err;
@@ -1489,9 +1488,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	start_blk += data_sum_blocks;
 
 	/* Record write statistics in the hot node summary */
-	kbytes_written = sbi->kbytes_written;
-	if (sb->s_bdev->bd_part)
-		kbytes_written += BD_PART_WRITTEN(sbi);
+	kbytes_written = sbi->kbytes_written + BD_PART_WRITTEN(sbi);
 
 	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ec77ccfea923dc..24e876e849c512 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -90,11 +90,6 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
 static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->sb;
-
-	if (!sb->s_bdev->bd_part)
-		return sprintf(buf, "0\n");
-
 	return sprintf(buf, "%llu\n",
 			(unsigned long long)(sbi->kbytes_written +
 			BD_PART_WRITTEN(sbi)));
@@ -103,12 +98,8 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
 static ssize_t features_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->sb;
 	int len = 0;
 
-	if (!sb->s_bdev->bd_part)
-		return sprintf(buf, "0\n");
-
 	if (f2fs_sb_has_encrypt(sbi))
 		len += scnprintf(buf, PAGE_SIZE - len, "%s",
 						"encryption");
-- 
2.29.2

