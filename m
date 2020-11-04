Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6822A5C0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 02:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgKDBj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 20:39:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7044 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgKDBj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:39:57 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQq8R6N6pzhgNS;
        Wed,  4 Nov 2020 09:39:51 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 4 Nov 2020
 09:39:44 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH] fs/binfmt_elf: free interpreter in load_elf_binary
Date:   Wed, 4 Nov 2020 10:06:35 +0800
Message-ID: <20201104020635.1906023-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file interpreter is allocated in load_elf_binary, but not freed
in the case interp_elf_ex is NULL.
We add a new mark out_free_file for this case to free interpreter.

This memory leak is catched when kmemleak is enabled in kernel,
the report looks like below:

unreferenced object 0xffff8b6e9fd41400 (size 488):
  comm "service", pid 4095, jiffies 4300970844 (age 49.618s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    e0 08 be b9 6e 8b ff ff 00 13 04 b7 6e 8b ff ff  ....n.......n...
  backtrace:
    [<00000000eacadaa2>] kmem_cache_alloc+0x164/0x320
    [<0000000090fb7bf2>] __alloc_file+0x2a/0x140
    [<00000000ff8fab86>] alloc_empty_file+0x4b/0x100
    [<000000003ab9b00d>] path_openat+0x4a/0xe20
    [<0000000027e3a067>] do_filp_open+0xb9/0x150
    [<000000000edebcac>] do_open_execat+0xa6/0x250
    [<000000008845564e>] open_exec+0x31/0x60
    [<00000000e6e6e1ca>] load_elf_binary+0x1dd/0x1b60
    [<000000004515d8f0>] do_execveat_common.isra.39+0xaa0/0x1000
    [<000000002ca5e83f>] __x64_sys_execve+0x37/0x40
    [<00000000beb519e4>] do_syscall_64+0x56/0xa0
    [<000000009cf54d51>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5f..e223d798e5d8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -907,7 +907,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
 		if (!interp_elf_ex) {
 			retval = -ENOMEM;
-			goto out_free_ph;
+			goto out_free_file;
 		}
 
 		/* Get the exec headers */
@@ -1316,6 +1316,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 out_free_dentry:
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
+out_free_file:
 	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
-- 
2.25.1

