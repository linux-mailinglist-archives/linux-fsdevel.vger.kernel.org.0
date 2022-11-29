Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF163B771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 02:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiK2Bwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 20:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiK2Bwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:52:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C595BB
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:52:49 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLlh974XRzRpMB;
        Tue, 29 Nov 2022 09:52:09 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 09:52:48 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 29 Nov
 2022 09:52:47 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ting-Chang Hou <tchou@synology.com>
CC:     <linux-fsdevel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] hfsplus: fix OOB of hfsplus_unistr in hfsplus_uni2asc()
Date:   Tue, 29 Nov 2022 10:39:49 +0800
Message-ID: <20221129023949.4186612-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot found a slab-out-of-bounds Read in hfsplus_uni2asc:

 BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
 Read of size 2 at addr ffff88801887a40c by task syz-executor412/3632

 CPU: 1 PID: 3632 Comm: syz-executor412 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
  print_address_description+0x74/0x340 mm/kasan/report.c:284
  print_report+0x107/0x1f0 mm/kasan/report.c:395
  kasan_report+0xcd/0x100 mm/kasan/report.c:495
  hfsplus_uni2asc+0x683/0x1290 fs/hfsplus/unicode.c:179
  hfsplus_readdir+0x8be/0x1230 fs/hfsplus/dir.c:207
  iterate_dir+0x257/0x5f0
  __do_sys_getdents64 fs/readdir.c:369 [inline]
  __se_sys_getdents64+0x1db/0x4c0 fs/readdir.c:354
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

The length of arrags ustr->unicode is HFSPLUS_MAX_STRLEN. Limit the value
of ustr->length to no more than HFSPLUS_MAX_STRLEN.

Reported-by: syzbot+076d963e115823c4b9be@syzkaller.appspotmail.com
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/hfsplus/unicode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..3df43a176acb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -133,6 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 	op = astr;
 	ip = ustr->unicode;
 	ustrlen = be16_to_cpu(ustr->length);
+	if (ustrlen > HFSPLUS_MAX_STRLEN)
+		ustrlen = HFSPLUS_MAX_STRLEN;
 	len = *len_p;
 	ce1 = NULL;
 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
-- 
2.25.1

