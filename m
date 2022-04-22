Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788A50B6C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447265AbiDVMHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447335AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF28A56C06
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t25so10142302edt.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbF/maklFafxqoydmIIFrPLNRnOTGTA99hRz5s5qH48=;
        b=SvTqH3AkLiGZE0zhkIU4zu0HdZ81waL8nvWjdIwxNtl0mO04NKd/qELbgeeZfXmVTw
         OoGwJ9BAbfK8SVbYSSYCKq80pxXf63hP9TuOyfjhiUofbVL1IRjCyON94V9O7HGp2n0h
         sTH93sSzuXaFJy8VPSZ97d5ssSMuC+SALwOnO7El37oG+jvWZeG6h41YakrGEA73OZLw
         1VpTwCpLr4uKGadizZhTMGBw5Nl5IzbPD5HcyjU/auoYt6Pwua9BrtA4AIT4HWnwAaDs
         AdpsNsBaLr2Pk0OBfzHH8LmZnU1WAzoLSTOkvbo2RB+nNfHaIkjOP7Bv1iX66YhTG36e
         iJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbF/maklFafxqoydmIIFrPLNRnOTGTA99hRz5s5qH48=;
        b=XBPdEvIrHoLxA5gtoY1Wp9ORdALpcyAsnyYjBIsq1F4zoJKcHTuX4ZiW6cKiQ6+J6e
         Xn4AW/EFdXop08OgabMrxB4YDBJT304f8EaMRxslh42rCB3qtCRjcjaLNDCMGbp+w1CN
         XgBt7PSK0QyCyg6kYSQhCBp6UOO4pqawMlpN3du8Oy4nnQ3gCK5eT3wkeR3PlsSicb92
         peQbdowC2lK1msBbfl8lN76dz1EF5YtJ0TFhdPFr/rp9Q6tTLmPW3cvgVOFsVUzukW9P
         APcdhbADa2B5fAOH9IDs+PxL6cxjC+vGfG5Q/kWxrGBh7OOH/X7j/x0odwh7lmPvV9zh
         gZ/A==
X-Gm-Message-State: AOAM532KzaTlT+wTOHOyN4ojhBPLTeHPIqg3B/79R6MUFxdfhk/Uo3Kk
        lfSXi67s2a4UmsHNcTVZcqFx9CqK/V8=
X-Google-Smtp-Source: ABdhPJwWTRd1c2KeMwqBvm2CAd/c4WSsJYd4W0vQw3mrTHV4qNd2TpUMgnJ5G1kX56AliqqWONfcJA==
X-Received: by 2002:aa7:d3c7:0:b0:41d:805a:153a with SMTP id o7-20020aa7d3c7000000b0041d805a153amr4500214edr.316.1650629026253;
        Fri, 22 Apr 2022 05:03:46 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 08/16] audit: use fsnotify group lock helpers
Date:   Fri, 22 Apr 2022 15:03:19 +0300
Message-Id: <20220422120327.3459282-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
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

audit inode marks pin the inode so there is no need to set the
FSNOTIFY_GROUP_NOFS flag.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kernel/audit_tree.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b5c02f8573fe..e867c17d3f84 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -351,7 +351,7 @@ static void untag_chunk(struct audit_chunk *chunk, struct fsnotify_mark *mark)
 	struct audit_chunk *new;
 	int size;
 
-	mutex_lock(&audit_tree_group->mark_mutex);
+	fsnotify_group_lock(audit_tree_group);
 	/*
 	 * mark_mutex stabilizes chunk attached to the mark so we can check
 	 * whether it didn't change while we've dropped hash_lock.
@@ -368,7 +368,7 @@ static void untag_chunk(struct audit_chunk *chunk, struct fsnotify_mark *mark)
 		replace_mark_chunk(mark, NULL);
 		spin_unlock(&hash_lock);
 		fsnotify_detach_mark(mark);
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		audit_mark_put_chunk(chunk);
 		fsnotify_free_mark(mark);
 		return;
@@ -385,12 +385,12 @@ static void untag_chunk(struct audit_chunk *chunk, struct fsnotify_mark *mark)
 	 */
 	replace_chunk(new, chunk);
 	spin_unlock(&hash_lock);
-	mutex_unlock(&audit_tree_group->mark_mutex);
+	fsnotify_group_unlock(audit_tree_group);
 	audit_mark_put_chunk(chunk);
 	return;
 
 out_mutex:
-	mutex_unlock(&audit_tree_group->mark_mutex);
+	fsnotify_group_unlock(audit_tree_group);
 }
 
 /* Call with group->mark_mutex held, releases it */
@@ -400,19 +400,19 @@ static int create_chunk(struct inode *inode, struct audit_tree *tree)
 	struct audit_chunk *chunk = alloc_chunk(1);
 
 	if (!chunk) {
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		return -ENOMEM;
 	}
 
 	mark = alloc_mark();
 	if (!mark) {
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		kfree(chunk);
 		return -ENOMEM;
 	}
 
 	if (fsnotify_add_inode_mark_locked(mark, inode, 0)) {
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		fsnotify_put_mark(mark);
 		kfree(chunk);
 		return -ENOSPC;
@@ -422,7 +422,7 @@ static int create_chunk(struct inode *inode, struct audit_tree *tree)
 	if (tree->goner) {
 		spin_unlock(&hash_lock);
 		fsnotify_detach_mark(mark);
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		fsnotify_free_mark(mark);
 		fsnotify_put_mark(mark);
 		kfree(chunk);
@@ -444,7 +444,7 @@ static int create_chunk(struct inode *inode, struct audit_tree *tree)
 	 */
 	insert_hash(chunk);
 	spin_unlock(&hash_lock);
-	mutex_unlock(&audit_tree_group->mark_mutex);
+	fsnotify_group_unlock(audit_tree_group);
 	/*
 	 * Drop our initial reference. When mark we point to is getting freed,
 	 * we get notification through ->freeing_mark callback and cleanup
@@ -462,7 +462,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	struct audit_node *p;
 	int n;
 
-	mutex_lock(&audit_tree_group->mark_mutex);
+	fsnotify_group_lock(audit_tree_group);
 	mark = fsnotify_find_mark(&inode->i_fsnotify_marks, audit_tree_group);
 	if (!mark)
 		return create_chunk(inode, tree);
@@ -478,7 +478,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	for (n = 0; n < old->count; n++) {
 		if (old->owners[n].owner == tree) {
 			spin_unlock(&hash_lock);
-			mutex_unlock(&audit_tree_group->mark_mutex);
+			fsnotify_group_unlock(audit_tree_group);
 			fsnotify_put_mark(mark);
 			return 0;
 		}
@@ -487,7 +487,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 
 	chunk = alloc_chunk(old->count + 1);
 	if (!chunk) {
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		fsnotify_put_mark(mark);
 		return -ENOMEM;
 	}
@@ -495,7 +495,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	spin_lock(&hash_lock);
 	if (tree->goner) {
 		spin_unlock(&hash_lock);
-		mutex_unlock(&audit_tree_group->mark_mutex);
+		fsnotify_group_unlock(audit_tree_group);
 		fsnotify_put_mark(mark);
 		kfree(chunk);
 		return 0;
@@ -515,7 +515,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
 	 */
 	replace_chunk(chunk, old);
 	spin_unlock(&hash_lock);
-	mutex_unlock(&audit_tree_group->mark_mutex);
+	fsnotify_group_unlock(audit_tree_group);
 	fsnotify_put_mark(mark); /* pair to fsnotify_find_mark */
 	audit_mark_put_chunk(old);
 
@@ -1044,12 +1044,12 @@ static void audit_tree_freeing_mark(struct fsnotify_mark *mark,
 {
 	struct audit_chunk *chunk;
 
-	mutex_lock(&mark->group->mark_mutex);
+	fsnotify_group_lock(mark->group);
 	spin_lock(&hash_lock);
 	chunk = mark_chunk(mark);
 	replace_mark_chunk(mark, NULL);
 	spin_unlock(&hash_lock);
-	mutex_unlock(&mark->group->mark_mutex);
+	fsnotify_group_unlock(mark->group);
 	if (chunk) {
 		evict_chunk(chunk);
 		audit_mark_put_chunk(chunk);
-- 
2.35.1

