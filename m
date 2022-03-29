Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD84EA8C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiC2HvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiC2HvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CBE1E6E9A
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m30so23545036wrb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=341wtVBQDtCet8LPmHDdO5FfeOX27BaJxnIAMj6yiZk=;
        b=Tk2MCtxx7gNl4lN1UR6B8ooyr+L9r8EVDrOhO9fI+/7bf9a4PHpAbOGSQx9bJNGNaj
         VsZmBw4rv9IroDUbaAOlNCZMqWHnzAF/GCFg+BRwZLVMvSE6eupmwdDALo060Larug5q
         1ICw2nQKa3rmo7FDWAGaf60kP+qXfMicA9CAs3SeMGVowlTZGPpi6+5ApgC4cWrfyk4w
         4FtQYh+vkwK11KR+oH2PKRtGjX1oXodVprE6PdPyZtDTLvrkPh8kBMBWx9p6qwlpW1Wp
         PWmmQGSbZ7EsHIiHWAsIgU5PhIPhW1Wh0CIYHEHWm/lN+tAm6cCxrEoL/COWnsTPgJLR
         c9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=341wtVBQDtCet8LPmHDdO5FfeOX27BaJxnIAMj6yiZk=;
        b=Ak3QsHw+evZ/08PFF7A5GTR2VWxMdDgqa/0hgF81qlrITF8ZZ3o64/MxZ9lTKq+VJX
         +YhjkNuqx64L2/pGnwtqVxIfD2obteeoD8JUIz330Ry9g2J8cSKzwxrgC0bj8lUJVu8A
         Gyn6NIY25pJEHB82DV+/hQOtwJXQwKWhHM7fHVX+fBM/XSNSGrTnambIltx4lyLWKu0f
         CJZlrAQI6TCSMsrgM/QVl/4g3tfdmzgQzIuWgWOj/tw7vewKmL+bTei+4zEnWbUT2Cd9
         PbJEfKHuFF7+jkSPprEwUoCbOhnSUcR0JcK5HXRf/rYhkqtLC/AdTuHN5aN2uVdLKHP5
         Pk5Q==
X-Gm-Message-State: AOAM531cQ1d8uECdhsgbqcMzsarxycp6oeSHXbwS83g9Oxh0ul7hTheW
        EYlffrW9V+fs/FQNwCHYOms=
X-Google-Smtp-Source: ABdhPJz39UmsWqFC1yYgWjfulCAQxGzrE0I96Lv1IDpEQ/QIk8S23fIhymRm461JJh440bUysO4LhQ==
X-Received: by 2002:a05:6000:178f:b0:204:16f0:8e2c with SMTP id e15-20020a056000178f00b0020416f08e2cmr30356180wrg.127.1648540160693;
        Tue, 29 Mar 2022 00:49:20 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/16] audit: use fsnotify group lock helpers
Date:   Tue, 29 Mar 2022 10:48:56 +0300
Message-Id: <20220329074904.2980320-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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

audit inode marks pin the inode so there is no need to use the nofs
lock variants.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kernel/audit_tree.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e7315d487163..eaef9c0f1c10 100644
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
2.25.1

