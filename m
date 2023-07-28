Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8576761A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjG1TO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 15:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1TO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:14:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2DF19BA;
        Fri, 28 Jul 2023 12:14:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bbc64f9a91so19814575ad.0;
        Fri, 28 Jul 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690571663; x=1691176463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PrFcbWZAF+bV4fXApZK9vGF9RzVc5gnuQ+5rzcxciU=;
        b=PXCCwbah62EH5V8max11GnHCNh5B5UuEB84RlqORPjtqP5IYBO0yYOSdku68fREXkQ
         WipcidqM0FD1IR/u+9Mb2h6wAzo6Yj1DN0elfjBuEpJJURWpoKdu2aNqqh0ajqeS7r88
         jQ9CjvWBLjzCs1IiC09obtWfo8Nkemitw1uj/OjFs8MMdNN51Owecn3OEJTuYQfXMB/d
         7nyX+J2AGXGFyePdmENxnVBleltLU4+X5hKH6D4URBejew/0fZ6ktxgkeA8FrPOPKwTr
         xs5g1lH1LTfKd2/QipjOiqT2wIhaeckAcajzEb76k8p3WHqPTsFvDiRK+tn+tsV1Bp9i
         4WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690571663; x=1691176463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PrFcbWZAF+bV4fXApZK9vGF9RzVc5gnuQ+5rzcxciU=;
        b=Yqn0EETKGi8PHlWCLCndMTpPzk1xTCbxNzDmq9z3anGNqhmxJbs+YAOoyW9x/AaqyW
         NRzpyUjMshPCRkGzZj6EQ4bGaWR1m+Wp7bl/zhXL9EIHUJPM84Mj4ifBKmEpqQVMZU0u
         B8gufNYbjojOMdiItM2Tcj355YpATYnVHst3OFpK+6nPoWjQUzzfQwXqYJR7zRBPZG6n
         vUTWLQzVi7Dc+8cUcG0O96iznJ3WqdX1AK4qRTUU/kakv2PkbC/EKUCs/wAR9wzePfSZ
         mT2cUFVtQVcV8+EKrD5x3tWr+b1wSBTE2eHnOXddc130y/rxdR2cQLxa69sfYVAgw8cH
         d3PQ==
X-Gm-Message-State: ABy/qLZnyGmhLHLBRgb3FG1J5Myl4QtqZF4QaQLgp5kcinMsFWZIDxJ9
        mNg06U9y1Ml1SAtI5W3ZcAxSPYlPqf8=
X-Google-Smtp-Source: APBJJlFLE0X1wu01TdaD7EK/bB3X1ofNW4q3dkrVOt6kyWbyeD0ZKOSrqSz8U6JZcYdmgxP8vFxMlA==
X-Received: by 2002:a17:902:b784:b0:1bb:8c42:79ef with SMTP id e4-20020a170902b78400b001bb8c4279efmr2786355pls.46.1690571662547;
        Fri, 28 Jul 2023 12:14:22 -0700 (PDT)
Received: from carrot.. (i220-108-176-83.s42.a014.ap.plala.or.jp. [220.108.176.83])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001b86f1b5797sm3893098plk.302.2023.07.28.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:14:21 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
Date:   Sat, 29 Jul 2023 04:13:18 +0900
Message-Id: <20230728191318.33047-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000b4e906060113fd63@google.com>
References: <000000000000b4e906060113fd63@google.com>
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

During unmount process of nilfs2, nothing holds nilfs_root structure after
nilfs2 detaches its writer in nilfs_detach_log_writer().  Previously,
nilfs_evict_inode() could cause use-after-free read for nilfs_root if
inodes are left in "garbage_list" and released by nilfs_dispose_list at
the end of nilfs_detach_log_writer(), and this bug was fixed by
commit 9b5a04ac3ad9 ("nilfs2: fix use-after-free bug of nilfs_root in
nilfs_evict_inode()").

However, it turned out that there is another possibility of UAF in the
call path where mark_inode_dirty_sync() is called from iput():

nilfs_detach_log_writer()
  nilfs_dispose_list()
    iput()
      mark_inode_dirty_sync()
        __mark_inode_dirty()
          nilfs_dirty_inode()
            __nilfs_mark_inode_dirty()
              nilfs_load_inode_block() --> causes UAF of nilfs_root struct

This can happen after commit 0ae45f63d4ef ("vfs: add support for a
lazytime mount option"), which changed iput() to call
mark_inode_dirty_sync() on its final reference if i_state has I_DIRTY_TIME
flag and i_nlink is non-zero.

This issue appears after commit 28a65b49eb53 ("nilfs2: do not write dirty
data after degenerating to read-only") when using the syzbot reproducer,
but the issue has potentially existed before.

Fix this issue by adding a "purging flag" to the nilfs structure, setting
that flag while disposing the "garbage_list" and checking it in
__nilfs_mark_inode_dirty().

Unlike commit 9b5a04ac3ad9 ("nilfs2: fix use-after-free bug of nilfs_root
in nilfs_evict_inode()"), this patch does not rely on ns_writer to
determine whether to skip operations, so as not to break recovery on
mount.  The nilfs_salvage_orphan_logs routine dirties the buffer of
salvaged data before attaching the log writer, so changing
__nilfs_mark_inode_dirty() to skip the operation when ns_writer is NULL
will cause recovery write to fail.  The purpose of using the cleanup-only
flag is to allow for narrowing of such conditions.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+74db8b3087f293d3a13a@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/000000000000b4e906060113fd63@google.com
Fixes: 0ae45f63d4ef ("vfs: add support for a lazytime mount option")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org> # 4.0+
---
 fs/nilfs2/inode.c     | 8 ++++++++
 fs/nilfs2/segment.c   | 2 ++
 fs/nilfs2/the_nilfs.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a8ce522ac747..35bc79305318 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1101,9 +1101,17 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 
 int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 {
+	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 	struct buffer_head *ibh;
 	int err;
 
+	/*
+	 * Do not dirty inodes after the log writer has been detached
+	 * and its nilfs_root struct has been freed.
+	 */
+	if (unlikely(nilfs_purging(nilfs)))
+		return 0;
+
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
 		nilfs_warn(inode->i_sb,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index c2553024bd25..581691e4be49 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2845,6 +2845,7 @@ void nilfs_detach_log_writer(struct super_block *sb)
 		nilfs_segctor_destroy(nilfs->ns_writer);
 		nilfs->ns_writer = NULL;
 	}
+	set_nilfs_purging(nilfs);
 
 	/* Force to free the list of dirty files */
 	spin_lock(&nilfs->ns_inode_lock);
@@ -2857,4 +2858,5 @@ void nilfs_detach_log_writer(struct super_block *sb)
 	up_write(&nilfs->ns_segctor_sem);
 
 	nilfs_dispose_list(nilfs, &garbage_list, 1);
+	clear_nilfs_purging(nilfs);
 }
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index 47c7dfbb7ea5..cd4ae1b8ae16 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -29,6 +29,7 @@ enum {
 	THE_NILFS_DISCONTINUED,	/* 'next' pointer chain has broken */
 	THE_NILFS_GC_RUNNING,	/* gc process is running */
 	THE_NILFS_SB_DIRTY,	/* super block is dirty */
+	THE_NILFS_PURGING,	/* disposing dirty files for cleanup */
 };
 
 /**
@@ -208,6 +209,7 @@ THE_NILFS_FNS(INIT, init)
 THE_NILFS_FNS(DISCONTINUED, discontinued)
 THE_NILFS_FNS(GC_RUNNING, gc_running)
 THE_NILFS_FNS(SB_DIRTY, sb_dirty)
+THE_NILFS_FNS(PURGING, purging)
 
 /*
  * Mount option operations
-- 
2.34.1

