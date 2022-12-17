Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98FC64FA63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiLQPiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 10:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiLQPhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:37:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FA25C48;
        Sat, 17 Dec 2022 07:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32CB9B802C7;
        Sat, 17 Dec 2022 15:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A8C433EF;
        Sat, 17 Dec 2022 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671291009;
        bh=bfN1oduN1+2E8UPQqLRFS7LImw7HIQK0zER4VeQedzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrLuGTi73y2uq3b1P8G5Pe/kMrvpsSglfc+pcEc2KgG9HwTCid9UxkBCkNhjcNkLG
         pWZf7dBJwDUg4oqrf0sygHrEN0Tp09ehbazmIizbZB9JnG4pqlExMR7i6WkVGlTdke
         Mpt5/7sIOB1CjJTVgDI12JnDtEptRMe63w39PqOGL5Jhc7JbgruRuUV5gx4onZMqFD
         1uTZSDRiqb4/8R47P+HxP5/o7/VQtd/FefGP5T/W6I/UckuIvvihg5YRUUS3zoak98
         wvJ2s5u8t8k+Z7Pxhhy119Psl0aFoQIcGZ4bKCCu0ISI4lu0YTIZ3tgGCcRFKLmv4a
         he5IEZI3n+8ow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ZhangPeng <zhangpeng362@huawei.com>,
        syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, hannes@cmpxchg.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 9/9] hfs: fix OOB Read in __hfs_brec_find
Date:   Sat, 17 Dec 2022 10:29:47 -0500
Message-Id: <20221217152949.99146-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221217152949.99146-1-sashal@kernel.org>
References: <20221217152949.99146-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

[ Upstream commit 8d824e69d9f3fa3121b2dda25053bae71e2460d2 ]

Syzbot reported a OOB read bug:

==================================================================
BUG: KASAN: slab-out-of-bounds in hfs_strcmp+0x117/0x190
fs/hfs/string.c:84
Read of size 1 at addr ffff88807eb62c4e by task kworker/u4:1/11
CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted
6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfs_strcmp+0x117/0x190 fs/hfs/string.c:84
 __hfs_brec_find+0x213/0x5c0 fs/hfs/bfind.c:75
 hfs_brec_find+0x276/0x520 fs/hfs/bfind.c:138
 hfs_write_inode+0x34c/0xb40 fs/hfs/inode.c:462
 write_inode fs/fs-writeback.c:1440 [inline]

If the input inode of hfs_write_inode() is incorrect:
struct inode
  struct hfs_inode_info
    struct hfs_cat_key
      struct hfs_name
        u8 len # len is greater than HFS_NAMELEN(31) which is the
maximum length of an HFS filename

OOB read occurred:
hfs_write_inode()
  hfs_brec_find()
    __hfs_brec_find()
      hfs_cat_keycmp()
        hfs_strcmp() # OOB read occurred due to len is too large

Fix this by adding a Check on len in hfs_write_inode() before calling
hfs_brec_find().

Link: https://lkml.kernel.org/r/20221130065959.2168236-1-zhangpeng362@huawei.com
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reported-by: <syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index da243c84e93b..9c5badc9db00 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -453,6 +453,8 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		/* panic? */
 		return -EIO;
 
+	if (HFS_I(main_inode)->cat_key.CName.len > HFS_NAMELEN)
+		return -EIO;
 	fd.search_key->cat = HFS_I(main_inode)->cat_key;
 	if (hfs_brec_find(&fd))
 		/* panic? */
-- 
2.35.1

