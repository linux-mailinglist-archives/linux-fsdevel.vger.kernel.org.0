Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D252BE7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiEROnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiEROnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 10:43:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388C18AAA7;
        Wed, 18 May 2022 07:43:51 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3FzB1sntzQkCL;
        Wed, 18 May 2022 22:40:54 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 22:43:48 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 22:43:48 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next] fuse: return the more nuanced writeback error on close()
Date:   Wed, 18 May 2022 22:57:29 +0800
Message-ID: <20220518145729.2488102-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As filemap_check_errors() only report -EIO or -ENOSPC, we return more nuanced
writeback error -(file->f_mapping->wb_err & MAX_ERRNO).

  filemap_write_and_wait
    filemap_write_and_wait_range
      filemap_check_errors
        -ENOSPC or -EIO
  filemap_check_wb_err
    errseq_check
      return -(file->f_mapping->wb_err & MAX_ERRNO)

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f18d14d5fea1..4a0add7f0a17 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -488,8 +488,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	inode_unlock(inode);
 
 	err = filemap_check_errors(file->f_mapping);
+	/* return more nuanced writeback errors */
 	if (err)
-		return err;
+		return filemap_check_wb_err(file->f_mapping, 0);
 
 	err = 0;
 	if (fm->fc->no_flush)
-- 
2.31.1

