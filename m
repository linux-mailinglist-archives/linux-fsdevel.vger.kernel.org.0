Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009685026C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 10:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351421AbiDOIls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbiDOIlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:41:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929BBB6E4F;
        Fri, 15 Apr 2022 01:39:15 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KfqVM3Nz9z1HC3D;
        Fri, 15 Apr 2022 16:38:35 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 16:39:13 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 16:39:12 +0800
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
To:     Christoph Hellwig <hch@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com>
 <20220415063920.GB24262@lst.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
Date:   Fri, 15 Apr 2022 16:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220415063920.GB24262@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2022/4/15 14:39, Christoph Hellwig Ð´µÀ:
Hi, Christoph
> This basically removes plugging entirely, so we might as well stop
> adding the plug if we can't solve it any other way.  But it seems
> like that fake progress needs to be fixed instead.
> 
Maybe there is a more ideal solution:
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e524c0a1749c..9723f77841f8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1855,7 +1855,7 @@ static long writeback_sb_inodes(struct super_block 
*sb,

                 wbc_detach_inode(&wbc);
                 work->nr_pages -= write_chunk - wbc.nr_to_write;
-               wrote += write_chunk - wbc.nr_to_write;
+               wrote += write_chunk - wbc.nr_to_write - wbc.pages_skipped;

                 if (need_resched()) {
                         /*

, or following is better(It looks awkward.):

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e524c0a1749c..5f310e53bf1e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1780,6 +1780,7 @@ static long writeback_sb_inodes(struct super_block 
*sb,
         while (!list_empty(&wb->b_io)) {
                 struct inode *inode = wb_inode(wb->b_io.prev);
                 struct bdi_writeback *tmp_wb;
+               long tmp_wrote;

                 if (inode->i_sb != sb) {
                         if (work->sb) {
@@ -1854,8 +1855,11 @@ static long writeback_sb_inodes(struct 
super_block *sb,
                 __writeback_single_inode(inode, &wbc);

                 wbc_detach_inode(&wbc);
-               work->nr_pages -= write_chunk - wbc.nr_to_write;
-               wrote += write_chunk - wbc.nr_to_write;
+               tmp_wrote = write_chunk - wbc.nr_to_write >= 
wbc.pages_skipped ?
+                           write_chunk - wbc.nr_to_write - 
wbc.pages_skipped :
+                           write_chunk - wbc.nr_to_write;workaround
+               work->nr_pages -= tmp_wrote;
+               wrote += tmp_wrote;

                 if (need_resched()) {
                         /*

It depends on how specific filesystem behaves after invoking 
redirty_page_for_writepage(). Most filesystems return 
AOP_WRITEPAGE_ACTIVATE or 0 after invoking redirty_page_for_writepage() 
in writepage, but there still exist accidential examples:
1. metapage_writepage() could returns -EIO after 
redirty_page_for_writepage()
2. ext4_writepage() could returns -ENOMEM after redirty_page_for_writepage()

write_cache_pages
   error = (*writepage)(page, wbc, data);
   if (unlikely(error)) {
     ...
     break;
   }
   --wbc->nr_to_write   // Skip if 'error < 0'. And if writepage invokes 
redirty_page_for_writepage(), wrote could be negative.


I think the root cause is fsync gets buffer head's lock without locking 
corresponding page, fixing 'progess' and flushing plug are both workarounds.
