Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1531F51ACFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356503AbiEDSjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbiEDSit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 14:38:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2637B39
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 11:30:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so5911052pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kkbuUWDKiR0JS6c01bssOt6f0x6Cx85B9ak/QBM+2Xs=;
        b=ouRqF7ho6uIHDNDm3Rm53hLNn21Ntyr0Q1giOYBqm7MpMEJFo592I8P1fn0PQn9xxe
         JZBaA28rRL6CqIk6PtX/5KX1ZeyP0KpkM/OMSW7u/ECJDas8t2vCFWmlXcw+1YQHrJIJ
         oVWVIMjuuVskLDueoKT4oeEMMG2EmNl4JZLKCCC5/bDbZbOMFAR4JH0z0FBBJmmI9Od3
         D1dBWiV/oMFRKy3yV2vXZJKrUZ88WGDM9LZ7JhijHvGvPcNh3FNKm1k4pbC+9sUG0xC+
         ovrCRWz9lszmO67wMfsiNQQFCaZT+/bSdyCitxgzESan+4sbFIFgymdv/DjK3+AXOb/L
         iC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kkbuUWDKiR0JS6c01bssOt6f0x6Cx85B9ak/QBM+2Xs=;
        b=Ctl57ZDcxuWwLXjmjSymQ049kGdru4ZFOq47JwkEk1fotDqGcKhxlinUuAy6vShBz1
         6uv6KhW54q7jvoaIATLKn38zIE/8HyZrVWbL0zahGvSe/PlAJYPFksv9ezNQWdeXkgzb
         xRqiOIcsDowpGjMlgfCCQEuEe5CTd1RiIshdx2rQRGtwpOfHEbC/aZfD5WLBqoW54cGh
         GbwWKlPQWtd73CpkoyRJ1jzrkokXKn2qEEjnvzBxvJAHtiKY9SzK4LNdny+RQnr1OBYe
         Fn0OdCs+KYyXXSUnT73bpfFN5IRu+RbcEWXFxZI0/5ofH5O4xt0sT+FptY8bo1c6Qkvy
         m9JA==
X-Gm-Message-State: AOAM5309ign1lYnefT4FWb5mBpZU481qN7KtgZloGZx4IzqGLg099qAN
        n4WO5Myx3JqqJed32OtmVvg=
X-Google-Smtp-Source: ABdhPJyQtvtm6IcKz7v55pfueH5JybVgEVJP9Y2zqN4cbES+T+IOziYp2j0niyUvqtkervK4yJZ6gQ==
X-Received: by 2002:a17:90b:393:b0:1dc:4dfe:9b10 with SMTP id ga19-20020a17090b039300b001dc4dfe9b10mr870577pjb.235.1651689013113;
        Wed, 04 May 2022 11:30:13 -0700 (PDT)
Received: from localhost ([101.224.171.160])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090b018c00b001d92e2e5694sm3700207pjs.1.2022.05.04.11.30.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 May 2022 11:30:12 -0700 (PDT)
From:   Jchao Sun <sunjunchao2870@gmail.com>
To:     jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, sunjunchao2870@gmail.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3] writeback: Fix inode->i_io_list not be protected by inode->i_lock error
Date:   Wed,  4 May 2022 11:25:14 -0700
Message-Id: <20220504182514.25347-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
References: <20220504143924.ix2m3azbxdmx67u6@quack3.lan>
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
wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
was missed. Add lock there and also update comment describing things
protected by inode->i_lock.

Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
---
Thank you very much for your patient and detailed explanation.

 fs/fs-writeback.c | 17 +++++++++++------
 fs/inode.c        |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..c879bcc41d28 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 				      struct list_head *head)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
 	list_move(&inode->i_io_list, head);
 
@@ -2351,6 +2352,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	int dirtytime = 0;
+	struct bdi_writeback *wb;
 
 	trace_writeback_mark_inode_dirty(inode, flags);
 
@@ -2402,6 +2404,9 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			inode->i_state &= ~I_DIRTY_TIME;
 		inode->i_state |= flags;
 
+		wb = locked_inode_to_wb_and_lock_list(inode);
+		spin_lock(&inode->i_lock);
+
 		/*
 		 * If the inode is queued for writeback by flush worker, just
 		 * update its dirty state. Once the flush worker is done with
@@ -2409,7 +2414,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 * list, based upon its state.
 		 */
 		if (inode->i_state & I_SYNC_QUEUED)
-			goto out_unlock_inode;
+			goto out_unlock;
 
 		/*
 		 * Only add valid (hashed) inodes to the superblock's
@@ -2417,22 +2422,19 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 		 */
 		if (!S_ISBLK(inode->i_mode)) {
 			if (inode_unhashed(inode))
-				goto out_unlock_inode;
+				goto out_unlock;
 		}
 		if (inode->i_state & I_FREEING)
-			goto out_unlock_inode;
+			goto out_unlock;
 
 		/*
 		 * If the inode was already on b_dirty/b_io/b_more_io, don't
 		 * reposition it (that would break b_dirty time-ordering).
 		 */
 		if (!was_dirty) {
-			struct bdi_writeback *wb;
 			struct list_head *dirty_list;
 			bool wakeup_bdi = false;
 
-			wb = locked_inode_to_wb_and_lock_list(inode);
-
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
@@ -2446,6 +2448,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 							       dirty_list);
 
 			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
 			trace_writeback_dirty_inode_enqueue(inode);
 
 			/*
@@ -2460,6 +2463,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			return;
 		}
 	}
+out_unlock:
+	spin_unlock(&wb->list_lock);
 out_unlock_inode:
 	spin_unlock(&inode->i_lock);
 }
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
2.17.1

