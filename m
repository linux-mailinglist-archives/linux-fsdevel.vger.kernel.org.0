Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6636EA779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjDUJrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjDUJrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB3B465;
        Fri, 21 Apr 2023 02:46:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63d4595d60fso13137541b3a.0;
        Fri, 21 Apr 2023 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070392; x=1684662392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=jkkCS7PuEh3526LzSpWKzpHxZ3Ic465fjv9ZFhiU4j1miKRpf+xMbr7e7iISfr3d6b
         7TL89G86nQDO/9bOXqjJwzwJboEMBtUfp2kRQChl6u/8ZBjDjfuMJyyR913/pWmPc+r6
         h5JvEIcpofmc4QPTmTP3q4RnSYTzgnVpRRSOdGzqAV53Rd9GeHZxzNFd5vX0iPmM67Zx
         amnlaQ+PYGeXQOtKSyngE2Pe7FEGtDJOX0Hy7XBWfDvAFUJCOKZcdtZo/Pz3SHxImBQu
         CrGni7I07kJHdKDDVW5xQZT3JIqaxobfoob6kTBokTwZmTn7rA2tnCS81OQ7bGvxGFvc
         zEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070392; x=1684662392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=O0aDtPOJEVuxKUBPWmK7SWIuBGyAT2rFxcz+rN10gJqq9zX0vRHAaOvXeOO7asTUOV
         3kHlGcZg90AS84jY7ORl8t0gzqTDLOArOEv26aYVGlsUTYFhj7PsluuF8neBp3h9R8B6
         VJU3VEzG4IvD1zCybjcOCAZwJZjlECjup6xzkpHq4pHrmVzQ2dI9rBWRIHN5cUAo6VBW
         /NmM8P0OG8lTdwim6DTOFkwDUjgdSB+KUPV7JlZ97j9n/DMqdKGU0Vak79FnAOPoHa1s
         GiohYLxJ+656cQ11WXxDkhvKTF6xExZRErRoL6O8By/DLtl3P1Cu8+YcZ8m/qURSaWOK
         YfXA==
X-Gm-Message-State: AAQBX9fbAAdbOS0rcZevFk+OsdVSOEHD48Vh/LoAivkSvuuuYnXqAyWc
        NQxOwBdvIhCo6TkJU2i29JdJuEoBGsQ=
X-Google-Smtp-Source: AKy350YMVLdsEXRtMMFWx2K2YW0c5tEwp5xRt/2P9Kr/EhIB0wute1PjXwSQzz69vJcgQRpHGUmV3w==
X-Received: by 2002:a05:6a21:339a:b0:e3:f25b:613f with SMTP id yy26-20020a056a21339a00b000e3f25b613fmr5320280pzb.14.1682070391728;
        Fri, 21 Apr 2023 02:46:31 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:31 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 1/9] ext2/dax: Fix ext2_setsize when len is page aligned
Date:   Fri, 21 Apr 2023 15:16:11 +0530
Message-Id: <046a58317f29d9603d1068b2bbae47c2332c17ae.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
References: <cover.1682069716.git.ritesh.list@gmail.com>
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

PAGE_ALIGN(x) macro gives the next highest value which is multiple of
pagesize. But if x is already page aligned then it simply returns x.
So, if x passed is 0 in dax_zero_range() function, that means the
length gets passed as 0 to ->iomap_begin().

In ext2 it then calls ext2_get_blocks -> max_blocks as 0 and hits bug_on
here in ext2_get_blocks().
	BUG_ON(maxblocks == 0);

Instead we should be calling dax_truncate_page() here which takes
care of it. i.e. it only calls dax_zero_range if the offset is not
page/block aligned.

This can be easily triggered with following on fsdax mounted pmem
device.

dd if=/dev/zero of=file count=1 bs=512
truncate -s 0 file

[79.525838] EXT2-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[79.529376] ext2 filesystem being mounted at /mnt1/test supports timestamps until 2038 (0x7fffffff)
[93.793207] ------------[ cut here ]------------
[93.795102] kernel BUG at fs/ext2/inode.c:637!
[93.796904] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[93.798659] CPU: 0 PID: 1192 Comm: truncate Not tainted 6.3.0-rc2-xfstests-00056-g131086faa369 #139
[93.806459] RIP: 0010:ext2_get_blocks.constprop.0+0x524/0x610
<...>
[93.835298] Call Trace:
[93.836253]  <TASK>
[93.837103]  ? lock_acquire+0xf8/0x110
[93.838479]  ? d_lookup+0x69/0xd0
[93.839779]  ext2_iomap_begin+0xa7/0x1c0
[93.841154]  iomap_iter+0xc7/0x150
[93.842425]  dax_zero_range+0x6e/0xa0
[93.843813]  ext2_setsize+0x176/0x1b0
[93.845164]  ext2_setattr+0x151/0x200
[93.846467]  notify_change+0x341/0x4e0
[93.847805]  ? lock_acquire+0xf8/0x110
[93.849143]  ? do_truncate+0x74/0xe0
[93.850452]  ? do_truncate+0x84/0xe0
[93.851739]  do_truncate+0x84/0xe0
[93.852974]  do_sys_ftruncate+0x2b4/0x2f0
[93.854404]  do_syscall_64+0x3f/0x90
[93.855789]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 26f135e7ffce..dc76147e7b07 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1259,9 +1259,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_zero_range(inode, newsize,
-				       PAGE_ALIGN(newsize) - newsize, NULL,
-				       &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, NULL,
+					  &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
-- 
2.39.2

