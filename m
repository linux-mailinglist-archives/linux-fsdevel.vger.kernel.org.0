Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B160B682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJXTCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJXTCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:02:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71552413E8;
        Mon, 24 Oct 2022 10:41:22 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mwyjc5gFkzJn76;
        Mon, 24 Oct 2022 22:52:52 +0800 (CST)
Received: from huawei.com (10.67.175.21) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 22:55:37 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>, <akpm@linux-foundation.org>,
        <adobriyan@gmail.com>
CC:     <lizetao1@huawei.com>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/binfmt_elf: Fix memory leak in load_elf_binary()
Date:   Mon, 24 Oct 2022 23:44:21 +0800
Message-ID: <20221024154421.982230-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.21]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a memory leak reported by kmemleak:

  unreferenced object 0xffff88817104ef80 (size 224):
    comm "xfs_admin", pid 47165, jiffies 4298708825 (age 1333.476s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      60 a8 b3 00 81 88 ff ff a8 10 5a 00 81 88 ff ff  `.........Z.....
    backtrace:
      [<ffffffff819171e1>] __alloc_file+0x21/0x250
      [<ffffffff81918061>] alloc_empty_file+0x41/0xf0
      [<ffffffff81948cda>] path_openat+0xea/0x3d30
      [<ffffffff8194ec89>] do_filp_open+0x1b9/0x290
      [<ffffffff8192660e>] do_open_execat+0xce/0x5b0
      [<ffffffff81926b17>] open_exec+0x27/0x50
      [<ffffffff81a69250>] load_elf_binary+0x510/0x3ed0
      [<ffffffff81927759>] bprm_execve+0x599/0x1240
      [<ffffffff8192a997>] do_execveat_common.isra.0+0x4c7/0x680
      [<ffffffff8192b078>] __x64_sys_execve+0x88/0xb0
      [<ffffffff83bbf0a5>] do_syscall_64+0x35/0x80

If "interp_elf_ex" fails to allocate memory in load_elf_binary(),
the program will take the "out_free_ph" error handing path,
resulting in "interpreter" file resource is not released.

Fix it by adding an error handing path "out_free_file", which will
release the file resource when "interp_elf_ex" failed to allocate
memory.

Fixes: 0693ffebcfe5 ("fs/binfmt_elf.c: allocate less for static executable")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..6a11025e5850 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -911,7 +911,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
 		if (!interp_elf_ex) {
 			retval = -ENOMEM;
-			goto out_free_ph;
+			goto out_free_file;
 		}
 
 		/* Get the exec headers */
@@ -1354,6 +1354,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 out_free_dentry:
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
+out_free_file:
 	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
-- 
2.25.1

