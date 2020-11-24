Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B262C27B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbgKXN3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbgKXN3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:29:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F26C0617A6;
        Tue, 24 Nov 2020 05:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oCaG9QTti35Co15ZkTmy9WR1wN4N3tzsYJ4o9aP2968=; b=uTjq+lzNK3MRvJUZJe1MFek3QY
        mdTWQqnQ6bq3Bs9Eh1zdFXj1RqnhHFuSzSt0o314aTwb5YooreOfWR4Gmgn/r7VxTMNLuIUI2gBnN
        Ym7inGUKXhKLVn4XEfAdQgHIzdr3jOVC/NgIXZI6iMRHxIF1O+uILzeLIxHG+SnknBLygyZesVlYM
        Uk9wQKOssAMW3w8as2Z6Tn9IvRXZpZfVZZ/c6w4j4Aww1N6913//5WtpNlj6xqJ9Ek4ANTYisQPlM
        +6XnevhikD3blqjEd/gF5Tvp+llNnQOKWfeZVuBaB/9fPWQMHTFcFKvfAGo7ObRXC2Kdd1b9A1KcU
        267uk3bg==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYNJ-0006ft-Oa; Tue, 24 Nov 2020 13:28:54 +0000
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
Subject: [PATCH 35/45] block: move make_it_fail to struct block_device
Date:   Tue, 24 Nov 2020 14:27:41 +0100
Message-Id: <20201124132751.3747337-36-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the make_it_fail flag to struct block_device an turn it into a bool
in preparation of killing struct hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          | 3 ++-
 block/genhd.c             | 4 ++--
 include/linux/blk_types.h | 3 +++
 include/linux/genhd.h     | 3 ---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9a3793d5ce38d4..9121390be97a76 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -668,7 +668,8 @@ __setup("fail_make_request=", setup_fail_make_request);
 
 static bool should_fail_request(struct hd_struct *part, unsigned int bytes)
 {
-	return part->make_it_fail && should_fail(&fail_make_request, bytes);
+	return part->bdev->bd_make_it_fail &&
+		should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
diff --git a/block/genhd.c b/block/genhd.c
index a991f0122e53d8..8c734a4e8ff31c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1276,7 +1276,7 @@ ssize_t part_fail_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%d\n", p->make_it_fail);
+	return sprintf(buf, "%d\n", p->bdev->bd_make_it_fail);
 }
 
 ssize_t part_fail_store(struct device *dev,
@@ -1287,7 +1287,7 @@ ssize_t part_fail_store(struct device *dev,
 	int i;
 
 	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		p->make_it_fail = (i == 0) ? 0 : 1;
+		p->pdev->bd_make_it_fail = (i == 0) ? 0 : 1;
 
 	return count;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c0591e52d7d7ce..b237f1e4081405 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -52,6 +52,9 @@ struct block_device {
 	struct super_block	*bd_fsfreeze_sb;
 
 	struct partition_meta_info *bd_meta_info;
+#ifdef CONFIG_FAIL_MAKE_REQUEST
+	bool			bd_make_it_fail;
+#endif
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c2a8cf12c5cab5..5d46ea7be7e4f0 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -56,9 +56,6 @@ struct hd_struct {
 	struct block_device *bdev;
 	struct device __dev;
 	int policy, partno;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	int make_it_fail;
-#endif
 	struct rcu_work rcu_work;
 };
 
-- 
2.29.2

