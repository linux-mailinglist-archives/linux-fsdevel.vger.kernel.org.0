Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25762A603A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKDJH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 04:07:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgKDJHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:07:49 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CR15D2Zclz15Ny8;
        Wed,  4 Nov 2020 17:07:44 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 4 Nov 2020
 17:07:40 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-fsdevel@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2] fs/binfmt_elf: free interpreter in load_elf_binary
Date:   Wed, 4 Nov 2020 17:34:31 +0800
Message-ID: <20201104093431.178880-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5bfc1c45-668d-9070-fddc-d15dbe39d12e@web.de>
References: <5bfc1c45-668d-9070-fddc-d15dbe39d12e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file interpreter is allocated in load_elf_binary, but not freed
in the case interp_elf_ex is NULL.
Add a label “out_allow_write_access” so that the interpreter
will be appropriately released in this case.

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

Fixes: 0693ffebcfe5 ("fs/binfmt_elf.c: allocate less for static executable")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5f..28e75cb45b26 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -907,7 +907,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
 		if (!interp_elf_ex) {
 			retval = -ENOMEM;
-			goto out_free_ph;
+			goto out_allow_write_access;
 		}
 
 		/* Get the exec headers */
@@ -1316,6 +1316,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 out_free_dentry:
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
+out_allow_write_access:
 	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
-- 
2.25.1

