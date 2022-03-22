Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67984E3684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiCVCQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiCVCQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:16:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59A1FA74
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:13:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso897461pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+Etw8VzkHvB0XGp2BLvIiu+KkhpgXSziJXN6unMt0Y=;
        b=XSjQ3OX2Yu4PDXuHln08O6L+P6hdJxYJPF4/YbDUMZ1ytaqeBi7NxFC7HAWD/G5zWx
         eeveQp9OBaugjgn8S/weyVk7m3q558adgX8n+4+DG+Y3R4+X9oqssjJ1vE4laHDR58TX
         49I2u2WSti1EuVrU8TU1tgpZvFyVxdCCaJw7/lX1cZH4bgfeQfRTNCmB5vh4qpaTmut4
         XpvJWV/fvvC3Wlt0C0DqK7pFz+iySb4kdDtEzCOdcxbKSJLwL6kYIySY0pRrdmCKfhvE
         OxMRGmwtzmc2HmOfbDzPhw8z7l8KzpsLHkpLDuRUf/Clv9zREsTRT5kyI7oq2sGVC8pz
         rI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o+Etw8VzkHvB0XGp2BLvIiu+KkhpgXSziJXN6unMt0Y=;
        b=vhT6dRrthqtdavWAiosblDl2TB9kNTWtbi4NWiXE4XfCZoiebC0xq0PjcOo85WDO0T
         lLKlIuVk1grHKMV8bV25f3YrbBkAZzw70YWJIp0TKHkeJEJJexGWjmkqWxq2h542G3E0
         P5uWu4R2mtOhjnxBxFSXln5KpEjh8xEKUk4laGOSNSIkRnlzwZJuLjImHjY7WGHGMIUz
         qKmV6M+cB2JgV69dOBCDhwb89nuQdarOaBzGwn1WZk+qp9hsDrJWNuKfyDH4E/vUNOPU
         yIN7Um+Dy2/fPC/TD3aQ4XiWZ4xK3KgGZOCDX0R3Wj+8WVrr+UaT4shSUqraohojMB+w
         byuw==
X-Gm-Message-State: AOAM531iV9R4coe17BX2SdGzoOeoLLu+DuOig9L+P5RvVAFyvOsiaeZ+
        XoyG9611d3zGNrj1cpLyn9A=
X-Google-Smtp-Source: ABdhPJwR9zww/Uzz2mOYtUc1jlVG6lOnR3eS98+qEUBSciiPaFWkdITJd5pA3G7Gv7kj3gn1mLGnJg==
X-Received: by 2002:a17:90a:4882:b0:1c5:f4e2:989a with SMTP id b2-20020a17090a488200b001c5f4e2989amr2311342pjh.160.1647915223464;
        Mon, 21 Mar 2022 19:13:43 -0700 (PDT)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090a2a0900b001c6e540fb6asm691786pjd.13.2022.03.21.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:13:43 -0700 (PDT)
From:   Haimin Zhang <tcs.kernel@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH] fhandle: add __GFP_ZERO flag for kmalloc in function do_sys_name_to_handle
Date:   Tue, 22 Mar 2022 10:13:26 +0800
Message-Id: <20220322021326.20162-1-tcs.kernel@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

Add __GFP_ZERO flag for kmalloc in function do_sys_name_to_handle to
initialize the buffer of a file_handle variable.

Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
---
This can cause a two-bytes-size kernel-info-leak problem.
1. do_sys_name_to_handle calls kmalloc to allocate the buffer of a file_handle variable, but doesn't zero it properly.
```
kmalloc build/../include/linux/slab.h:586 [inline]
 do_sys_name_to_handle build/../fs/fhandle.c:40 [inline]
 __do_sys_name_to_handle_at build/../fs/fhandle.c:109 [inline]
 __se_sys_name_to_handle_at+0x470/0x990 build/../fs/fhandle.c:93
 __x64_sys_name_to_handle_at+0x15d/0x1b0 build/../fs/fhandle.c:93
 do_syscall_x64 build/../arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 build/../arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
```
2. do_sys_name_to_handle calls exportfs_encode_fh to fill the content of the variable.
3. If the inode is a fat node, exportfs_encode_fh will call fat_encode_fh_nostale to further process.
```
#0  fat_encode_fh_nostale (inode=inode@entry=0xffff88815d9286a8, fh=fh@entry=0xffff88815ce7f008, lenp=lenp@entry=0xffff88814f5c3e4c,
    parent=parent@entry=0x0 <fixed_percpu_data>) at ../fs/fat/nfs.c:102
#1  0xffffffff8375cbe1 in exportfs_encode_inode_fh (inode=0xffff88815d9286a8, fid=0xffff88815ce7f008, max_len=0xffff88814f5c3e4c,
    parent=0x0 <fixed_percpu_data>) at ../fs/exportfs/expfs.c:391
#2  exportfs_encode_fh (dentry=0x0 <fixed_percpu_data>, dentry@entry=0xffff8881255cf480, fid=fid@entry=0xffff88815ce7f008,
    max_len=max_len@entry=0xffff88814f5c3e4c, connectable=connectable@entry=0x0) at ../fs/exportfs/expfs.c:413
#3  0xffffffff82a88c9b in do_sys_name_to_handle (path=0xffff88814f5c3e38, ufh=0x20000500, mnt_id=0x20000540) at ../fs/fhandle.c:49
#4  __do_sys_name_to_handle_at (dfd=<optimized out>, name=0x0 <fixed_percpu_data>, flag=<optimized out>, handle=<optimized out>, mnt_id=<optimized out>)
    at ../fs/fhandle.c:109
#5  __se_sys_name_to_handle_at (dfd=0xffff88815ce7f000, dfd@entry=0xffffff9c, name=0x0, name@entry=0x200004c0, handle=handle@entry=0x20000500,
    mnt_id=mnt_id@entry=0x20000540, flag=flag@entry=0x1000) at ../fs/fhandle.c:93
#6  0xffffffff82a8870d in __x64_sys_name_to_handle_at (regs=<optimized out>) at ../fs/fhandle.c:93
#7  0xffffffff8fb1c264 in do_syscall_x64 (regs=0xffff88814f5c3f58, nr=0x12f) at ../arch/x86/entry/common.c:51
#8  do_syscall_64 (regs=0xffff88814f5c3f58, nr=0x12f) at ../arch/x86/entry/common.c:82
#9  0xffffffff8fc00068 in entry_SYSCALL_64 () at ../net/unix/af_unix.c:3364
#10 0x0000000000000000 in ?? ()
```
4. If the argument parent is NULL, the lenp will be 3, it means that fat_encode_fh_nostale modifies 12 bytes of the buffer. But actually it just modifies 10 bytes.
```
struct fat_fid {
	u32 i_gen;
	u32 i_pos_low;
	u16 i_pos_hi;
	// The following fields will be assigned on if parent isn't NULL, 
	u16 parent_i_pos_hi;
	u32 parent_i_pos_low;
	u32 parent_i_gen;
};
```
5. When it returns to do_sys_name_to_handle, the whole 12 bytes will be copied to user space.
```
 copy_to_user build/../include/linux/uaccess.h:209 [inline]
 do_sys_name_to_handle build/../fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at build/../fs/fhandle.c:109 [inline]
 __se_sys_name_to_handle_at+0x86b/0x990 build/../fs/fhandle.c:93
 __x64_sys_name_to_handle_at+0x15d/0x1b0 build/../fs/fhandle.c:93
 do_syscall_x64 build/../arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 build/../arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
```
6. The following is debug information:
Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff88815e77a1e0
Data copied to user address 0000000020000500

 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6630c69c23a2..be6b9ed12dfd 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -38,7 +38,7 @@ static long do_sys_name_to_handle(struct path *path,
 		return -EINVAL;
 
 	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
-			 GFP_KERNEL);
+			 GFP_KERNEL | __GFP_ZERO);
 	if (!handle)
 		return -ENOMEM;
 
-- 
2.32.0 (Apple Git-132)

