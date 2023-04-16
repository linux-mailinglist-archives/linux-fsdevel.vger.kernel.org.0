Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0916E36EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDPKJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjDPKJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADADE;
        Sun, 16 Apr 2023 03:08:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso1138448b3a.1;
        Sun, 16 Apr 2023 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639739; x=1684231739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=kCQh83LLX8Gqsuw9bPEygmLr8H4lqx0/d87eZImoa3MiKKQEiQ+xogaUXQX1myqGnT
         YKDPS0yvRjBm/Ye6L7LVL3d+2QbkUhFjW3DWScnFIH9RSSz7LjjuyWdBls7fPcmxvAB7
         pTZE7Hd0yDT4rXpiiAR+6Gr2HtD4qu/+yuwqKrtL5tWs4J0pPu5h2CHWeeJmUX4nj0g9
         zgWwva9v8+ysU73ibb6SrI1ZrHGPePbYPPbYM8dR5OKzP4+P2iUILe5sDvPXChV0OU5h
         m6esi/nSyCV+iSq1B7kC2xSR/VhK+V2F+Gx4l/fyIpgUYrg27vXzYwXhdf3xgUcbgsv5
         9izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639739; x=1684231739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=PHA5ElrlUfjuj5ttVQLAYXWLujM2c7bs0WlxpjKo6/s78zTrwJAJDJ538aujcDSbYF
         ligrUhpFY4DnwaKi4m7jd4aJ3nDNLUUj6194S0cCA8XQs6laLHd6YlLUK3TCji6YffoD
         BJM5OoHx0Yd3ZUhzzSDv9In/kwDK7J8uA60T4QyLRMPN2ugTOVuV3+h4RTlZvMiBiQJm
         nkgGP/dTdcwNnu2KsJ8UHCrXcR83ORz2DdNL1aU9OvG4ldMaQ619UCnGAM4dD2TMFzuG
         GW1FYFH/0Wxol3VJopDDHmXPMva7rhThi6iiLSE6R7gOxQQi//shriIK0cr/QbV/6NmM
         qO4g==
X-Gm-Message-State: AAQBX9f4PCC5JlDctxSJgeJ3gobTPm91KiPRbgEWZMpBNDtZig0lcPUv
        0E7ZPovWWknafTUYFbHtEhUzEDa1s+0=
X-Google-Smtp-Source: AKy350bQ14ZR4DBQ+wvcuaj1c+QaXOLWYWVgbH2lRIwOq+5ZXfRbfY1JK6y+jLdo8EjJ8aa3Snl0yA==
X-Received: by 2002:a05:6a00:1411:b0:63b:599b:a2ec with SMTP id l17-20020a056a00141100b0063b599ba2ecmr15450153pfu.27.1681639739117;
        Sun, 16 Apr 2023 03:08:59 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:08:58 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv5 1/9] ext2/dax: Fix ext2_setsize when len is page aligned
Date:   Sun, 16 Apr 2023 15:38:36 +0530
Message-Id: <240087488bd3e6ef4eb253c1e39d07a4a309b3a0.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
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

