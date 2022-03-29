Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747454EA8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiC2HvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiC2HvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B081E5221
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m30so23544865wrb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XoWmjl6KVYrZaYzowYJtOxfIHq+80q2tmcN4NfcC50=;
        b=bXPIXfMW9QM+ElhDNsNwA0ksXwkmCqcQVk0eC5Ozsfu6jB4W7eLH60nU869gjIAh2C
         rn7cgWYg8PP7TNtXuP5YmRTJWrNGftwKCeZZXrv17uhMLzG47ecgG0xuqwP0wZt19PiJ
         Ve1YKKOJ7wuGUskAn57w1Rcesm5GyYOpwWOjyqn9FIV8zepR7U+5j4LpjEhJ4/qOnc8D
         0K9lryjqgzxNXuCfZKqw8Z6UqqRtpfVi9oVy6/hCXPzXJHvFn2x6BO9j8gAoOFJNF648
         L9QEIsAW8ThU6HhUU+vJuWuOhJMNHLkxJkY2c++d4moQ3h65rghW/kGnvDUYcUuaB0Y8
         Mdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XoWmjl6KVYrZaYzowYJtOxfIHq+80q2tmcN4NfcC50=;
        b=FRHiX0dYWpBySBL71gfU9vIc8bZwLvaaDMYdcf7Lqa1vrIVcHOnCkA6sdNXS3oOUqi
         LflNrPpsM5Meewb80B/enHi9o5U2ZUt8Dz7FGHFA52DlwrFIyTmW+JdD4CqEFaJAf/4h
         Sh+nHurrdEPyZbTAl7fImlbT58eymTRrFrHa607bJuK18GMC2AcH9e/IZkeFO+shZ4R8
         7xvyZmgexgBD0EIJATylD2s3wkWw6BrKbzkfz4k+RQWZfLqcy//PUVD8RYLvJp7Dxu6Y
         k+QonlACW0UJpJ+POBlPSPI7G4Vjq0f1Fo62VgYSEJCTmj18BeNt7RHYHK4iaxyfLcn8
         oRMA==
X-Gm-Message-State: AOAM530FGERm0LO/lDlCSnZ589vTBmxHpBcu85ijbqiaNWmvRlAwxLpm
        lE59IfFp+w43Y6g5Gx87qg9bbdM5uJI=
X-Google-Smtp-Source: ABdhPJw25aSwc/I1xS/H7f0Jz0nfo97PGe5DBf7JfusGg5lWW/Yd+e5f1uc5ZZmzI2aZLEiuY6Bacg==
X-Received: by 2002:a5d:59a2:0:b0:204:19bc:42ff with SMTP id p2-20020a5d59a2000000b0020419bc42ffmr28958713wrr.687.1648540157102;
        Tue, 29 Mar 2022 00:49:17 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/16] fsnotify: fix wrong lockdep annotations
Date:   Tue, 29 Mar 2022 10:48:53 +0300
Message-Id: <20220329074904.2980320-6-amir73il@gmail.com>
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

Commit 6960b0d909cd ("fsnotify: change locking order") changed some
of the mark_mutex locks in direct reclaim path to use:
  mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);

This change is explained:
 "...It uses nested locking to avoid deadlock in case we do the final
  iput() on an inode which still holds marks and thus would take the
  mutex again when calling fsnotify_inode_delete() in destroy_inode()."

The problem is that the mutex_lock_nested() is not a nested lock at
all. In fact, it has the opposite effect of preventing lockdep from
warning about a very possible deadlock.

Due to these wrong annotations, a deadlock that was introduced with
nfsd filecache in kernel v5.4 went unnoticed in v5.4.y for over two
years until it was reported recently by Khazhismel Kumykov, only to
find out that the deadlock was already fixed in kernel v5.5.

Fix the wrong lockdep annotations.

Cc: Khazhismel Kumykov <khazhy@google.com>
Fixes: 6960b0d909cd ("fsnotify: change locking order")
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 698ed0a1a47e..3faf47def7d8 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -437,7 +437,7 @@ void fsnotify_free_mark(struct fsnotify_mark *mark)
 void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 			   struct fsnotify_group *group)
 {
-	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&group->mark_mutex);
 	fsnotify_detach_mark(mark);
 	mutex_unlock(&group->mark_mutex);
 	fsnotify_free_mark(mark);
@@ -754,7 +754,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 * move marks to free to to_free list in one go and then free marks in
 	 * to_free list one by one.
 	 */
-	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&group->mark_mutex);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
 		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
@@ -763,7 +763,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 
 clear:
 	while (1) {
-		mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+		mutex_lock(&group->mark_mutex);
 		if (list_empty(head)) {
 			mutex_unlock(&group->mark_mutex);
 			break;
-- 
2.25.1

