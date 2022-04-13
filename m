Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551964FF309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiDMJMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiDMJML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89549205E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m14so1647807wrb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbF/maklFafxqoydmIIFrPLNRnOTGTA99hRz5s5qH48=;
        b=XER5PI0Ozt7s55M9F9+E299ErMUHdxKVbdhMeTSoQSdFswCOvSgvVkbHulm9KhCAUX
         OdGOPj5tHMit4vnXOPzF815KW5m4JOaWmbUkH18Q5uK9WfbKr9tfwv70Q6XqfMbZqgP6
         HKWbL8SdZOf+L+y1BNl2dc2qDcxhp2BuiQ3Lb7V0PbAlPVkKqJsekVPlgGVlNj/3WngR
         W2aKzY00A4iANce7J1FLJpI0KzI6ZnYyiMyUadH7b2qwKby3v9ojFM4HDtBD3FC9j+W+
         OlXkvhtOtSQHNSwnMlfTDihUwBxG+KHZikS6v4flQjpvT6hrFlrQ7vTF/ZaYt+bcItGb
         NuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbF/maklFafxqoydmIIFrPLNRnOTGTA99hRz5s5qH48=;
        b=oAznzLbF4F1TZPSwt4PFWjP7qb7FMUqDRr2lQuYxx7INb4j559wfMQCfWmEQNBWkW9
         0wZVgUM2HYszxSL6+sl+pf03RoCg2jy2AQCvYdHDsS00KBZmzdc9WalrEDjyx9SWAafk
         bZ4RcoQo5nYyt46+paW7Mj57IqrIKdrVf/8x0xBq9n1VG74GL8yHQ/ygna1qvm4fyIE8
         bWn1j8on9IrYynG+5Pxh8olVqHLif1ndtO5DegKzSUQadTJKIcV7OTZSnn8nHRPlhP+c
         jJl0RSo0dJPulvIsNiMtH0Bb0kxdZ3JN5CCuQWYkgGg0undEZ8oK3HDq0wjCcTmxdtPr
         AP4A==
X-Gm-Message-State: AOAM532XvYvDguA6uEootv6rlvxYFV1kPw0pe0sor1TAtedOC7PJnC19
        7eS+2DtWay7ItyLStBwOLXs=
X-Google-Smtp-Source: ABdhPJxVVjJcMwBfsV07wbFtS/alZdnoeAKbZQVvyREd9adzsspDAUeEqNGCmRJqj0cLInAWoGgX5g==
X-Received: by 2002:a5d:46cc:0:b0:207:ad3b:bf2 with SMTP id g12-20020a5d46cc000000b00207ad3b0bf2mr6166696wrs.547.1649840989063;
        Wed, 13 Apr 2022 02:09:49 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/16] audit: use fsnotify group lock helpers
Date:   Wed, 13 Apr 2022 12:09:27 +0300
Message-Id: <20220413090935.3127107-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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

