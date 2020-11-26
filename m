Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740212C54FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbgKZNHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390026AbgKZNHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B7C0617A7;
        Thu, 26 Nov 2020 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3s9ZV7/S/AMqijy+96nJeQSoiw9kLp/J9AYboOAYnhs=; b=lbuMqndrB4unGfBY2q8G5+moxM
        EuvFsvmmVuvx5mPiC+nnsGzQIcFdzQZi6ZsjodsHPBp7chjmprxWF707wat01mujb4rRcWkYVzfvJ
        xkcBoyNStiLpMrLVijQtl3GaDDdfzaLRmIQ4oVKAYpKq0DaqJcQ5JC+WwUL/Mgcst3eINsPBfyGRO
        c36pao99EtbARVjFs15yxmbrCl+aO/l1YeA9iQ7erqMEAllqKRsfSw0I8L0TUSp7OZzJ7+sx9bfcl
        WMhzpiY6mnI4jLPyIiCgWrzFmAUSNPMcmi1/TUxKLQ0+Bb42oiUEu3V3u861W9swvmCZiLxDAucig
        OsvEoqAg==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGzm-0004Ci-Ls; Thu, 26 Nov 2020 13:07:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 42/44] f2fs: remove a few bd_part checks
Date:   Thu, 26 Nov 2020 14:04:20 +0100
Message-Id: <20201126130422.92945-43-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bd_part is never NULL for a block device in use by a file system, so
remove the checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
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

