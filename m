Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA663BC85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiK2JHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 04:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiK2JHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:07:33 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114426ADC;
        Tue, 29 Nov 2022 01:07:30 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLxKj5zsvz15MSg;
        Tue, 29 Nov 2022 17:06:49 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 17:07:28 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 17:07:27 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <zippel@linux-m68k.org>, <akpm@osdl.org>, <slava@dubeyko.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>,
        <syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com>
Subject: [PATCH v2] hfs: Fix OOB Write in hfs_asc2mac
Date:   Tue, 29 Nov 2022 09:07:06 +0000
Message-ID: <20221129090706.2336748-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Syzbot reported a OOB Write bug:

loop0: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: slab-out-of-bounds in hfs_asc2mac+0x467/0x9a0
fs/hfs/trans.c:133
Write of size 1 at addr ffff88801848314e by task syz-executor391/3632

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfs_asc2mac+0x467/0x9a0 fs/hfs/trans.c:133
 hfs_cat_build_key+0x92/0x170 fs/hfs/catalog.c:28
 hfs_lookup+0x1ab/0x2c0 fs/hfs/dir.c:31
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740

If in->len is much larger than HFS_NAMELEN(31) which is the maximum
length of an HFS filename, a OOB write could occur in hfs_asc2mac(). In
that case, when the dst reaches the boundary, the srclen is still
greater than 0, which causes a OOB write.
Fix this by adding a check on dstlen in while() before writing to dst
address.

Fixes: 328b92278650 ("[PATCH] hfs: NLS support")
Reported-by: syzbot+dc3b1cf9111ab5fe98e7@syzkaller.appspotmail.com
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
v2:
- Change the location of the check for dstlen
---
 fs/hfs/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
index 39f5e343bf4d..fdb0edb8a607 100644
--- a/fs/hfs/trans.c
+++ b/fs/hfs/trans.c
@@ -109,7 +109,7 @@ void hfs_asc2mac(struct super_block *sb, struct hfs_name *out, const struct qstr
 	if (nls_io) {
 		wchar_t ch;
 
-		while (srclen > 0) {
+		while (srclen > 0 && dstlen > 0) {
 			size = nls_io->char2uni(src, srclen, &ch);
 			if (size < 0) {
 				ch = '?';
-- 
2.25.1

