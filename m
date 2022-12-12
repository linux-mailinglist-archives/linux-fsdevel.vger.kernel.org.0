Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9682649E13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiLLLmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiLLLlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:41:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB92BC20
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 03:36:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6AFD1F8BF;
        Mon, 12 Dec 2022 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670844998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aiXFmt/kIABGJt8P0LoRiFvJxR7SQ+LdhoWOaHbwDAY=;
        b=hlJVzfNt+EmZokzDWSYXl56+wvrAf8C3Uqot2yN3fe1f2WpFaM4+lHZebIySBpFRqcD29n
        nYAJEu8BwQMmKAD7cjXjNo6whO0wFkiv5P4VZUmz1IqRXu2QpfG+Cn40gLeA3vSXeX7Rmq
        xFL12C3AWxBNIlzUw1aL5akRvcrOyZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670844998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aiXFmt/kIABGJt8P0LoRiFvJxR7SQ+LdhoWOaHbwDAY=;
        b=pk+X2My/jQob9b7TKoGFjBtW8VEWLABDaD2b7cWQkGt8hUoMJK40Z+I57UW9L9rGFf/lKv
        JkvMn7Zt0+pX0tDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83BA113456;
        Mon, 12 Dec 2022 11:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /kclIEYSl2NvZAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Dec 2022 11:36:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57102A0728; Mon, 12 Dec 2022 12:36:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] writeback: Add asserts for adding freed inode to lists
Date:   Mon, 12 Dec 2022 12:36:33 +0100
Message-Id: <20221212113633.29181-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466; i=jack@suse.cz; h=from:subject; bh=bsTT5AMTY3Y5WYeOIeXWRGJ1w0BRPqpiN/mJHH6NAYA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjlxIvqnNkhEDoE1Fss9ilhKdTTlywPtAefvp6rdk6 w6hlaXuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5cSLwAKCRCcnaoHP2RA2eikCA CasVB5m4PZSjHrKSq7DVpe5YGymC34ADXPC+yv60ZQfqJwMQ/dRV50yZn9QtITFjOzRn5ajLefXwvV ZyxXEd4FJDPKkiKFeLY967MkhGr9vBZL049nKbmh1OEy3klWnk6Y11kNPJ2tudDNsRrFQ55GSyYGm2 BWGlgRe1bBgztZ8Z48LGywMCZeIsE9cns6X/PHHpf+YIA+mWD5Ag9uRQq2g1BARO8YNkT2XGiQ2DO7 svu6dfwG7fSNhmKecgvY0vVuEZCK/IMNJZqTOJ4+FBnhP0LpspksUi5h7NcGNMaRbhiFX+0uNtBktK zeulk0h3RqsQ9Jxkg3Z3+v5gjEzpr9
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
to debug so add some asserts to catch the problem earlier. The only
non-obvious change in the commit is that we need to tweak
redirty_tail_locked() to avoid triggering assertion in
inode_io_list_move_locked().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

New version of the patch with improved changelog and added comment to
redirty_tail_locked().

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..6cd172c4cb3e 100644
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
@@ -1294,6 +1297,17 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 {
 	assert_spin_locked(&inode->i_lock);
 
+	inode->i_state &= ~I_SYNC_QUEUED;
+	/*
+	 * When the inode is being freed just don't bother with dirty list
+	 * tracking. Flush worker will ignore this inode anyway and it will
+	 * trigger assertions in inode_io_list_move_locked().
+	 */
+	if (inode->i_state & I_FREEING) {
+		list_del_init(&inode->i_io_list);
+		wb_io_lists_depopulated(wb);
+		return;
+	}
 	if (!list_empty(&wb->b_dirty)) {
 		struct inode *tail;
 
@@ -1302,7 +1316,6 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 			inode->dirtied_when = jiffies;
 	}
 	inode_io_list_move_locked(inode, wb, &wb->b_dirty);
-	inode->i_state &= ~I_SYNC_QUEUED;
 }
 
 static void redirty_tail(struct inode *inode, struct bdi_writeback *wb)
-- 
2.35.3

