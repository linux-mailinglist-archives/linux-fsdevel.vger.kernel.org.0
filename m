Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082F862702D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiKMPY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 10:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbiKMPYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:24:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440365D0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 07:24:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so87134807b3.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Nov 2022 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wESqFKb7C5s2QIMr5hhjMl9Ig7evvOrmD1dhNzXIW7o=;
        b=oHeNec/6hDQHpPziy+sFHVcQQepLBtNOeV+UpNDq9YuXKjTOI3Y6ngmG3Je5yl55kT
         FgJD2CLza9PiZ9r4XK2zVoFdb/ANe77FPSHUDW5+CkVC2QTH46KjkqH1DNYGAd3ZyXbM
         OwsWSiagrMQfBdwIP7GC7rz2WKxRpfzmviURhryTUq8VrKGB/vIZS6dwwUpSAzhYIDXv
         V5wfuOL2c7fOxxjadOie4ysNlI8wFITKa8iuyJjk9hjoDexlntBADRcwLZGGVCLZffcr
         uePdi5e3c3i8948Jcz2WWluMckOs+cdF45cXtiJ2nK+mjOUHe1lxOrb20yTXtvNy7OHe
         ddRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wESqFKb7C5s2QIMr5hhjMl9Ig7evvOrmD1dhNzXIW7o=;
        b=tOZCzCWuz3o4Z1Z9Am46jUlIp4qXss11nZX55qtlfqbxHj/Og2IGPfmczYel56zJka
         mfackFq1DIWHd9cdcDAuW7PoGlckSdPKl7ck/GFrKVN8E5DOvqz5WdLhHcfWvtDnFFK7
         4zr3cOGSERiOBH9WPKR9RS4xqeQlSaJYoJ+lVqjxpdKefLoAhhiIlp7GxwwjqfomUQYE
         ALCX3HaumOz7qWzc0dj5lrrZHZwFZwivCrkCzaan6gN449Vqb8Vdog60Ok3SfeEBTv97
         P7mC5R5LreHzPLbGobwybyAVGKVovEalnFV9/Cc0wH5vmE70wqhxGwLYIIeU+sU1U59V
         DZPw==
X-Gm-Message-State: ACrzQf1SONiUmpdtxMMmF6qjvY4L6iipVeQ7v6IMJLJ0xCtfOC43PpTy
        fOKq+VevY9WeUFJC1MvfyC4F9kMAkqXKkiYb
X-Google-Smtp-Source: AMsMyM6U7914bEE9NdmqS50DHAsU7/CmOSVNlQ3fW9yfV9JpHfzsUNM8rdhgoCPLeXLaOGx1Vy50NA5yKWmiOM/U
X-Received: from feldsherov-ws1.tlv.corp.google.com ([2620:0:1045:10:7dda:435d:701d:5257])
 (user=feldsherov job=sendgmr) by 2002:a0d:fcc6:0:b0:349:7d12:7255 with SMTP
 id m189-20020a0dfcc6000000b003497d127255mr64188333ywf.427.1668353092929; Sun,
 13 Nov 2022 07:24:52 -0800 (PST)
Date:   Sun, 13 Nov 2022 17:24:39 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221113152439.2821942-1-feldsherov@google.com>
Subject: [PATCH] fs: do not push freeing inode to b_dirty_time list
From:   Svyatoslav Feldsherov <feldsherov@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com,
        oferz@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Svyatoslav Feldsherov <feldsherov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode
already has I_DIRTY_INODE") writeiback_single_inode can push inode with
I_DIRTY_TIME set to b_dirty_time list. In case of freeing inode with
I_DIRTY_TIME set this can happened after deletion of inode io_list at
evict. Stack trace is following.

evict
fat_evict_inode
fat_truncate_blocks
fat_flush_inodes
writeback_inode
sync_inode_metadata
writeback_single_inode

This will lead to use after free in flusher thread.

Fixes: cbfecb927f42 ("fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE")
Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com
Signed-off-by: Svyatoslav Feldsherov <feldsherov@google.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..31c93cbdb3fe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1718,7 +1718,7 @@ static int writeback_single_inode(struct inode *inode,
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
 		inode_cgwb_move_to_attached(inode, wb);
-	else if (!(inode->i_state & I_SYNC_QUEUED)) {
+	else if (!(inode->i_state & (I_SYNC_QUEUED | I_FREEING))) {
 		if ((inode->i_state & I_DIRTY))
 			redirty_tail_locked(inode, wb);
 		else if (inode->i_state & I_DIRTY_TIME) {
-- 
2.38.1.431.g37b22c650d-goog

