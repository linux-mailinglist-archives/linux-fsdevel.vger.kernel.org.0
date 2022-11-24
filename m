Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D268637B50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 15:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKXOUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 09:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKXOTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:19:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670A2FFD3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 06:18:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA3C5219B7;
        Thu, 24 Nov 2022 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669299488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F2kmC55ojVDkT8du+sJBwaU2zVEFhPQ9vhgzCn24QvQ=;
        b=hAg6XB5fxWgfLvjO/Ydujtrpln2Kj0cKXu/NK5kkJ79wJhMYXiGNjiUJbEu5gpxqBICe5/
        aA9YwI6XoKygT7tA71w6kKXBCgnmitjiEnb0re3Ytw+DYoqTRNvVqawVjqcSAXZVoPv24a
        knjS+PmhttrW5cEmXS4Ifa4ErUkBl5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669299488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F2kmC55ojVDkT8du+sJBwaU2zVEFhPQ9vhgzCn24QvQ=;
        b=G85wenL3CXvPg/fghYrSId9S62jgHJvZkO82IBHyss/IAjTxNzms+f+iuDjbzSkxwfEjgU
        D5kpMwRfDCHLqzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD26C13B4F;
        Thu, 24 Nov 2022 14:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n9IiLiB9f2NpQgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Nov 2022 14:18:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 481E0A0715; Thu, 24 Nov 2022 15:18:08 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Svyatoslav Feldsherov <feldsherov@google.com>
Subject: [PATCH] writeback: Add asserts for adding freed inode to lists
Date:   Thu, 24 Nov 2022 15:18:06 +0100
Message-Id: <20221124141806.6194-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=jack@suse.cz; h=from:subject; bh=uuqc8lkEOtg7UO1snGNCrpdIrtlZnw6e13K/rg23R5Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjf30XP5MNmCIxhcNe3iODz9peeuEFuGvfhSMnmRGd im2VndWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY399FwAKCRCcnaoHP2RA2T1XB/ 99MwS6NAR2abLfCfa7OdqsWHQljkXcBi7OW8Dun41waIbhhlBv6DUS0v8NRwBgNdN0MNTg9Yqv3zsy E/fPkInWqJnvpJefnn8vC9JjsmNX6F/zk17QitueWasBOtA9fE9HZBG/ww8A5AC6cEvXDARhXV8uHP SHeYl0Lk8nrG2MBhmcyDVO8yMnp6GwQLcNSmT2gu+Ot1IExHSVyrNan/XRz8G4udfJ0s+efYKGAcNZ 7s5YuB9TqqO7EJUZ/yJxDKaxdy+Vi4OfwkIXw7DFOKvwjHxhlNGO6q+U2NZdKTR3h/rJmqYE9NJgZy y50RBPHOCzelWTyBgU+LI0CI0/j9By
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the past we had several use-after-free issues with inodes getting
added to writeback lists after evict() removed them. These are painful
to debug so add some asserts to catch the problem earlier.

CC: Svyatoslav Feldsherov <feldsherov@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

As we discussed with Svyatoslav who was debugging latest incarnation of this
use-after-free issue, let's add some safety WARN_ONs. Jens, would you take
care of merging this please?

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..49f045f2e458 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -121,6 +121,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
+	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	list_move(&inode->i_io_list, head);
 
@@ -280,6 +281,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
+	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	if (wb != &wb->bdi->wb)
@@ -1129,6 +1131,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
+	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	list_del_init(&inode->i_io_list);
@@ -1294,6 +1297,12 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 {
 	assert_spin_locked(&inode->i_lock);
 
+	inode->i_state &= ~I_SYNC_QUEUED;
+	if (inode->i_state & I_FREEING) {
+		list_del_init(&inode->i_io_list);
+		wb_io_lists_depopulated(wb);
+		return;
+	}
 	if (!list_empty(&wb->b_dirty)) {
 		struct inode *tail;
 
@@ -1302,7 +1311,6 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 			inode->dirtied_when = jiffies;
 	}
 	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
-	inode->i_state &= ~I_SYNC_QUEUED;
 }
 
 static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
-- 
2.35.3

