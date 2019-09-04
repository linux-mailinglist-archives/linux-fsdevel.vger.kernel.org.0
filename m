Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F72A7876
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfIDCKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728023AbfIDCKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCE90E5B70EC5FF3B70F;
        Wed,  4 Sep 2019 10:10:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:31 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 23/25] erofs: use read_mapping_page instead of sb_bread
Date:   Wed, 4 Sep 2019 10:09:10 +0800
Message-ID: <20190904020912.63925-24-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph said [1], "This seems to be your only direct
use of buffer heads, which while not deprecated are a bit
of an ugly step child.  So if you can easily avoid creating
a buffer_head dependency in a new filesystem I think you
should avoid it. "

[1] https://lore.kernel.org/r/20190902125109.GA9826@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1d9880195ef0..caf9a95173b0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -98,20 +98,22 @@ static bool check_layout_compatibility(struct super_block *sb,
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
-	struct buffer_head *bh;
+	struct page *page;
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
+	void *data;
 	int ret;
 
-	bh = sb_bread(sb, 0);
-
-	if (!bh) {
+	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
+	if (!page) {
 		erofs_err(sb, "cannot read erofs superblock");
 		return -EIO;
 	}
 
 	sbi = EROFS_SB(sb);
-	dsb = (struct erofs_super_block *)(bh->b_data + EROFS_SUPER_OFFSET);
+
+	data = kmap_atomic(page);
+	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
@@ -153,7 +155,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	ret = 0;
 out:
-	brelse(bh);
+	kunmap_atomic(data);
+	put_page(page);
 	return ret;
 }
 
-- 
2.17.1

