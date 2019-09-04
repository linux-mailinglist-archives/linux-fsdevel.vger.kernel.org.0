Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA8EA786C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfIDCKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfIDCKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 831EBCBCC46AB636AD74;
        Wed,  4 Sep 2019 10:10:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:20 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 14/25] erofs: kill verbose debug info in erofs_fill_super
Date:   Wed, 4 Sep 2019 10:09:01 +0800
Message-ID: <20190904020912.63925-15-gaoxiang25@huawei.com>
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

As Christoph said [1], "That is some very verbose
debug info.  We usually don't add that and let
people trace the function instead. "

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 63cb17a4073b..b64d69f18270 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -384,9 +384,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	struct erofs_sb_info *sbi;
 	int err;
 
-	infoln("fill_super, device -> %s", sb->s_id);
-	infoln("options -> %s", (char *)data);
-
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
 	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
@@ -419,9 +416,6 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		return err;
 
-	if (!silent)
-		infoln("root inode @ nid %llu", ROOT_NID(sbi));
-
 	if (test_opt(sbi, POSIX_ACL))
 		sb->s_flags |= SB_POSIXACL;
 	else
@@ -454,7 +448,8 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
 		return err;
 
 	if (!silent)
-		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
+		infoln("mounted on %s with opts: %s, root inode @ nid %llu.",
+		       sb->s_id, (char *)data, ROOT_NID(sbi));
 	return 0;
 }
 
-- 
2.17.1

