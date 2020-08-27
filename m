Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D68254488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgH0LtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:49:17 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:41528 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbgH0LrH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:47:07 -0400
Received: from localhost.localdomain (unknown [210.32.144.184])
        by mail-app2 (Coremail) with SMTP id by_KCgBnN7wgnUdfn0o9Ag--.10943S4;
        Thu, 27 Aug 2020 19:46:43 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf: Fix memleak in load_elf_binary
Date:   Thu, 27 Aug 2020 19:46:39 +0800
Message-Id: <20200827114639.31298-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBnN7wgnUdfn0o9Ag--.10943S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1ftF1rZr18Zr47GFWktFb_yoWktrX_Ca
        4xXrnYvFyDJF1jgr1qkw43Ary8WFs5Xw4fAr1IkFy7C342qan0k3ykXas7Z34rJa12qr15
        Wrs3trySgryakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbeT5PUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAAesb
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When arch_setup_additional_pages() fails, interp_elf_ex may
not have been freed, which leads to memleak.  It's the same
when create_elf_tables() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 fs/binfmt_elf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd7..984c30684e49 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1204,6 +1204,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
+		interp_elf_ex = NULL;
 		kfree(interp_elf_phdata);
 	} else {
 		elf_entry = e_entry;
@@ -1219,14 +1220,18 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = arch_setup_additional_pages(bprm, !!interpreter);
-	if (retval < 0)
+	if (retval < 0) {
+		kfree(interp_elf_ex);
 		goto out;
+	}
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
 	retval = create_elf_tables(bprm, elf_ex,
 			  load_addr, interp_load_addr, e_entry);
-	if (retval < 0)
+	if (retval < 0) {
+		kfree(interp_elf_ex);
 		goto out;
+	}
 
 	mm = current->mm;
 	mm->end_code = end_code;
-- 
2.17.1

