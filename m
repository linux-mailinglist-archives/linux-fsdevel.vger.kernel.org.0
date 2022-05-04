Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F05519907
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbiEDH6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 03:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345959AbiEDH6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 03:58:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639B1A06B
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 00:54:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so547783pjt.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9z4nCQfgy04pZCBhCxZ/eRhSIOLjF7WbMm7lFuqyQY=;
        b=KRDDYkR62OjEW8LU+DaVuqOdbSAWaMM6pnwoaKCnku5OLD4zkJQ0EMtudcQqi0vLdW
         oV6lm9REzkZb6FRTb4bUUP7NL43yUmGvBKfMmqpXGaWkSpG5Z4ZJi6psHigz+8GLjhn8
         vGDZLEEB73EQrj035CEjj75+3k9jG3q/lKb9t7QkdA+LMTvAZcPdHrF+Zx+8E5lxQ3jO
         8sQZ+LLOugCOAZLpYp7TVBPhOGqTvcBBLVHlMU2WgHyo/Ry/3oEd0onzeyjkR/Z4Z7q5
         ajCVtbaUwfUUZcoHDREK2QO1nbtkV8ClvUWxZTAe//DclirfgZeSD+ryFJxzeLJG0B8H
         5YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9z4nCQfgy04pZCBhCxZ/eRhSIOLjF7WbMm7lFuqyQY=;
        b=emGn0C/QwUhxSf+ZclEf03NXGwlNLguq2zKvFWi0luw1I3UXvcIYDlKN4xw1kZxNv0
         p0e36OrBhGUr/s9OYeeQmA3crRttLUEuRSBRSh6oc4lSq9uoaUqwinDjUkP+Hj53bYU1
         M/gx/7hAtJVSnprOTDfMQ82/BiRNC5QU0SQ6Cq/ZrtM0lyEKhrL431/c1f3/7vfaWzZf
         jQYWfrg/q0hfDcfq0DCAT4TpnXU4XkWnWdAi6v8kwsUiMjvxgPZk/NPCjH5TuWaUoURi
         euieaTDPVmDlELfAA1EZ+/+c6SK0yvl6Zr9X4NufqNXepEPNeKc57eh/AU4hZjqlwmUT
         NthQ==
X-Gm-Message-State: AOAM532EWYbYVN7Mdb+VaboiGPDS93zRraVwtNYeWoixdDowZIMNChww
        +VWI/EuON0JjaSslHF2JyGz5Zq3M9UJvp8bK
X-Google-Smtp-Source: ABdhPJwFqDS5jY4t9Xb+j2EnfViiZxvZVTZMH1JZ34SkMyHrWt22X/WxWmM1qTAa5F/p+LLiSaQmfQ==
X-Received: by 2002:a17:902:f64c:b0:156:7ceb:b579 with SMTP id m12-20020a170902f64c00b001567cebb579mr19886408plg.73.1651650895841;
        Wed, 04 May 2022 00:54:55 -0700 (PDT)
Received: from localhost ([101.224.171.160])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090ab01100b001d97f7fca06sm2621176pjq.24.2022.05.04.00.54.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 May 2022 00:54:55 -0700 (PDT)
From:   Jchao Sun <sunjunchao2870@gmail.com>
To:     jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, sunjunchao2870@gmail.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] writeback: Fix inode->i_io_list not be protected by inode->i_lock error
Date:   Wed,  4 May 2022 00:54:21 -0700
Message-Id: <20220504075421.105494-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503174958.ynxbvt7xsj7v72dg@quack3.lan>
References: <20220503174958.ynxbvt7xsj7v72dg@quack3.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b35250c0816c ("writeback: Protect inode->i_io_list with
inode->i_lock") made inode->i_io_list not only protected by
wb->list_lock but also inode->i_lock, but
inode_io_list_move_locked() was missed. Add lock there and also
update comment describing things protected by inode->i_lock.

Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
---
 fs/fs-writeback.c | 11 +++++------
 fs/inode.c        |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..30f9698e7c2c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 				      struct list_head *head)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
 	list_move(&inode->i_io_list, head);
 
@@ -293,8 +294,8 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
  * @inode: inode of interest with i_lock held
  *
  * Returns @inode's wb with its list_lock held.  @inode->i_lock must be
- * held on entry and is released on return.  The returned wb is guaranteed
- * to stay @inode's associated wb until its list_lock is released.
+ * held on entry.  The returned wb is guaranteed to stay @inode's associated
+ * wb until its list_lock is released.
  */
 static struct bdi_writeback *
 locked_inode_to_wb_and_lock_list(struct inode *inode)
@@ -317,6 +318,7 @@ locked_inode_to_wb_and_lock_list(struct inode *inode)
 		/* i_wb may have changed inbetween, can't use inode_to_wb() */
 		if (likely(wb == inode->i_wb)) {
 			wb_put(wb);	/* @inode already has ref */
+			spin_lock(&inode->i_lock);
 			return wb;
 		}
 
@@ -1141,7 +1143,6 @@ locked_inode_to_wb_and_lock_list(struct inode *inode)
 {
 	struct bdi_writeback *wb = inode_to_wb(inode);
 
-	spin_unlock(&inode->i_lock);
 	spin_lock(&wb->list_lock);
 	return wb;
 }
@@ -1152,6 +1153,7 @@ static struct bdi_writeback *inode_to_wb_and_lock_list(struct inode *inode)
 	struct bdi_writeback *wb = inode_to_wb(inode);
 
 	spin_lock(&wb->list_lock);
+	spin_lock(&inode->i_lock);
 	return wb;
 }
 
@@ -1233,7 +1235,6 @@ void inode_io_list_del(struct inode *inode)
 	struct bdi_writeback *wb;
 
 	wb = inode_to_wb_and_lock_list(inode);
-	spin_lock(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	list_del_init(&inode->i_io_list);
@@ -1704,7 +1705,6 @@ static int writeback_single_inode(struct inode *inode,
 	wbc_detach_inode(wbc);
 
 	wb = inode_to_wb_and_lock_list(inode);
-	spin_lock(&inode->i_lock);
 	/*
 	 * If the inode is now fully clean, then it can be safely removed from
 	 * its writeback list (if any).  Otherwise the flusher threads are
@@ -1875,7 +1875,6 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * have been switched to another wb in the meantime.
 		 */
 		tmp_wb = inode_to_wb_and_lock_list(inode);
-		spin_lock(&inode->i_lock);
 		if (!(inode->i_state & I_DIRTY_ALL))
 			wrote++;
 		requeue_inode(inode, tmp_wb, &wbc);
diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..bd4da9c5207e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -27,7 +27,7 @@
  * Inode locking rules:
  *
  * inode->i_lock protects:
- *   inode->i_state, inode->i_hash, __iget()
+ *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
  * Inode LRU list locks protect:
  *   inode->i_sb->s_inode_lru, inode->i_lru
  * inode->i_sb->s_inode_list_lock protects:
-- 

Sry for my insufficient tests and any inconvenience in lauguage, because
my mother tongue is not english. It's my first commit to linux kernel
community, some strage for me...

Thanks a lot for your review and suggestion.
2.17.1

