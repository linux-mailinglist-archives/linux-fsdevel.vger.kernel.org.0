Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40D6E0913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDMIl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDMIlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC283F8;
        Thu, 13 Apr 2023 01:41:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517c0b93cedso766065a12.3;
        Thu, 13 Apr 2023 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375279; x=1683967279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=KMTTXSOXANgebirgVt+wchHwZzkayTSw3BuFu4iXn6HzRKkCIzB+3I/YWQgNBoFh1Q
         Wq8cdjBgZgcQV09d6Be/doiy6BrA6Apqqw1BL+pA1lCJFQ+fyBGb3QTzaqyfItyeep+S
         tN+9AVqSm7n6BHODomUwIkfg0wGbERKVEeNL1i8vLVFj8TQ1g6BXxVNL/BV0kF7rF6mc
         2CBNQRaAQEjbAwaYheCR6i/2KzCpg/a2ulQ8tX1A93sGl4U3saeemfudLrr8fqtuWnrJ
         /mo4bR/rfqnZC1cW9uEwm9GCiq6xDneX+YJlhcLRbZgKmp+9MxDrAVTR0kjHtEA4m0D6
         CL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375279; x=1683967279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vOY0HWRCluzQ1SEYQtrOup46nyHU1j9BhalfWc1/Wc=;
        b=DA6Tm3N1yye+1hg5Rl5epSQL9g7HTwufHpi3maUYTKpOFPwvnwKpmPsbfcPNdRH86v
         ia2QUAR73dCMhlbr2OI3CYgus2Dxq7+9eoLUktv6kdOd6tASV2rHB8R6nywUTheD4CEG
         moNLMW4q4OAm2gx5ubSBgVrCn0qO7PKS0GVGv1T+HzXqrUJNd1z/O/zpLEFmZ7AfesQY
         4PMn8QOBVf9wE+KfjRD8ItEfzhJTqZGL5VAcIyvb1uqgF2SV5bv+yGt+QTUp0TmkMreV
         8Jb3cVTH5jfrCXi9dFXewMEwlyzakDhz00rxwnejboBSzwxKkqsGtVULO04rIV3EApNb
         p1oQ==
X-Gm-Message-State: AAQBX9ff3pREx6SfL6V31N5aEj6lPOO6uZrgWxztc/a6uJPj5GD0a4xg
        lHwfaoVsAqVvNeDvzeevP2hMiAbXQ6U=
X-Google-Smtp-Source: AKy350b1aDn9aZOqquu4Oqle5qRZfHCedReJ/PdeFWRUHA7Dv0t8YcYgEjboqT/8t4M71aeg40sExw==
X-Received: by 2002:a05:6a00:b84:b0:63b:4a65:e183 with SMTP id g4-20020a056a000b8400b0063b4a65e183mr1779438pfj.3.1681375279113;
        Thu, 13 Apr 2023 01:41:19 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:18 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 01/10] ext2/dax: Fix ext2_setsize when len is page aligned
Date:   Thu, 13 Apr 2023 14:10:23 +0530
Message-Id: <895d3405f4831be6936f3df280792bff8cc2d401.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
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

