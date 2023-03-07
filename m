Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128386AD9A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCGIzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCGIzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:55:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707F1231D6;
        Tue,  7 Mar 2023 00:55:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so15835233pjg.4;
        Tue, 07 Mar 2023 00:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678179349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImZIUnjHmWZ61AUl7EQPcyNMNKjjE5EWwslBdnmGov0=;
        b=SgtCPQOkavqX+SBvioxmaURb4Km1AY2R8AW5U4vSda+AC/SpuW1VlTHGyP70Ytx+dK
         Ayqg7je+tRBqJgKKk3xbtLurdcXlYw7hY3sBDSNIsbqQaTaWlTIUJTIYgsMbE1qBnKWg
         /hROrhlTfzg3xPNGrquDfsSGiwb0TXzQaLrdv6qEZpVcvM7b1WzNHXSgRk3aFnEGnlOS
         pWwK1QeBx+FxcTN4I5U3/9k5Yj3rpU8Ih3evW7wRHjji5kdcAhxLf3NbbaUegC1gepj2
         7a5RjDaKtVujCChtlIFUvuthDcTm7IdCxR8tO87EfAs7qwzDXDhuaRoejK8v9buentv2
         88iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImZIUnjHmWZ61AUl7EQPcyNMNKjjE5EWwslBdnmGov0=;
        b=UpVX4L6+uhd9WRQN43C/hOST1TWs4Fkzje/S4ypQuat/k953JuyEkGzL2eQix5q2lE
         FA7QnP6Lq38G3Ryl4yJbLraasRtVTmO+A1PM2JIIGh0hROSbrDUioW9t1RdAtj9cSbqw
         TPmOizo7ETcu7xp11VXCk4Bf/qVZW1A/wswy5JlH5VgMgrD4/u0v4pPpEGJTBDY5ssl4
         42bk+z3lGKNZRcZf90rAZF58A0GyTJ9ah3GS+PkOPMQucRKDTWABfJUogGMUIWd880Ip
         ZudZpUAFNJQiJlXtdTJ7HdKgMsB3DXGYvnyFtH12HH1FGwJ4YEds9I+hPvI1FVQIjPUF
         Pzhg==
X-Gm-Message-State: AO0yUKVXbJEGoLc+Ch5OQFlJnbz/hGBCl7tPVF3PyEdqFIaxEH1ZKjD7
        uEDK4+4zSwQGDTmmzrzYxmg=
X-Google-Smtp-Source: AK7set+n/zlRJOeNQP8M0xg3+cjUmJoxvSXtbUWiJcG+ExUBSsH7mIN1Yeehxsqw3k185LjLKRmDAg==
X-Received: by 2002:a17:902:ab07:b0:19c:e7ee:52ad with SMTP id ik7-20020a170902ab0700b0019ce7ee52admr12501058plb.28.1678179348695;
        Tue, 07 Mar 2023 00:55:48 -0800 (PST)
Received: from carrot.. (i219-164-39-244.s42.a014.ap.plala.or.jp. [219.164.39.244])
        by smtp.gmail.com with ESMTPSA id z9-20020a63e109000000b004fbd91d9716sm7377100pgh.15.2023.03.07.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:55:47 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, glider@google.com
Subject: [PATCH] nilfs2: fix kernel-infoleak in nilfs_ioctl_wrap_copy()
Date:   Tue,  7 Mar 2023 17:55:48 +0900
Message-Id: <20230307085548.6290-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000a5bd2d05f63f04ae@google.com>
References: <000000000000a5bd2d05f63f04ae@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ioctl helper function nilfs_ioctl_wrap_copy, which exchanges a
metadata array to/from user space, may copy uninitialized buffer regions
to user space memory for read-only ioctl commands NILFS_IOCTL_GET_SUINFO
and NILFS_IOCTL_GET_CPINFO.

This can occur when the element size of the user space metadata given
by the v_size member of the argument nilfs_argv structure is larger than
the size of the metadata element (nilfs_suinfo structure or nilfs_cpinfo
structure) on the file system side.

KMSAN-enabled kernels detect this issue as follows:

 BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
 include/linux/instrumented.h:121 [inline]
 BUG: KMSAN: kernel-infoleak in _copy_to_user+0xc0/0x100 lib/usercopy.c:33
  instrument_copy_to_user include/linux/instrumented.h:121 [inline]
  _copy_to_user+0xc0/0x100 lib/usercopy.c:33
  copy_to_user include/linux/uaccess.h:169 [inline]
  nilfs_ioctl_wrap_copy+0x6fa/0xc10 fs/nilfs2/ioctl.c:99
  nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
  nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
  nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
  __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
  __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
  __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
  do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
  entry_SYSENTER_compat_after_hwframe+0x70/0x82

 Uninit was created at:
  __alloc_pages+0x9f6/0xe90 mm/page_alloc.c:5572
  alloc_pages+0xab0/0xd80 mm/mempolicy.c:2287
  __get_free_pages+0x34/0xc0 mm/page_alloc.c:5599
  nilfs_ioctl_wrap_copy+0x223/0xc10 fs/nilfs2/ioctl.c:74
  nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
  nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
  nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
  __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
  __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
  __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
  do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
  entry_SYSENTER_compat_after_hwframe+0x70/0x82

 Bytes 16-127 of 3968 are uninitialized
 ...

This eliminates the leak issue by initializing the page allocated as
buffer using get_zeroed_page().

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/000000000000a5bd2d05f63f04ae@google.com
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 5ccc638ae92f..1dfbc0c34513 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -71,7 +71,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_index > ~(__u64)0 - argv->v_nmembs)
 		return -EINVAL;
 
-	buf = (void *)__get_free_pages(GFP_NOFS, 0);
+	buf = (void *)get_zeroed_page(GFP_NOFS);
 	if (unlikely(!buf))
 		return -ENOMEM;
 	maxmembs = PAGE_SIZE / argv->v_size;
-- 
2.34.1

