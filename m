Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353CF50B6CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447291AbiDVMIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447319AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174E56771
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so15896566ejf.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAEdHhjLwuYPCqjVFR53AS/kwFMiTKuiUBzvVoBwHmE=;
        b=eWrrjgfIYXUIdHYP50rjye6BxHRaCP/bWRVTfejUXV8hC6NQPm84IlyhpVeCY0e2++
         PkaaIUFietNRCSbpcFRafMRNISZDamXRExJRZU1KVqXBmKVCaoFPoGxK4i1fmOcN5G8R
         4K6Otgp20CULzW47UgN2sGn4dGVMMi6XCh/oNeBpaqn8zHalvWLx1J9f7fnNSEG3QVYQ
         jrWVoF8V4UQBUZHqVyDJgc58h09ZjeZBnMIM/K3NJccEn+E2BijJIbTjYqpjUlWqPhrO
         qMJJH8HkGRXHAAjzkPkoWOUS1Wkl++m9BtHkkl3FWH0u7jtioOnV9o/L2VU6LeNx21T5
         3OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAEdHhjLwuYPCqjVFR53AS/kwFMiTKuiUBzvVoBwHmE=;
        b=6k55Ie4zRkJY7xyup2QRHSmxk+Ekm0dM4AY6wSzdRBMdIxGV7CmNUG7nvZESGmdTk4
         TgVTDy76GFK938gy4u0pgVKXDmFF1tE9OR5G/fQT//q+nL05bU3mPFFtwA3EuSl7PgZU
         BbJ1P34cOuInH05ZtW1/Ht9bhWN3ZyH7uCG+dHoAyTTi7jXk4ijKqtY0xn4UCUbN1BeJ
         jAOACl3T2tvyUInK4/+0dC3LhwgDuKLbVDg1Hzh79wmvOFo+47PTcHiYBxG+C9MRih7F
         czAlAaClzObdTZaNIbXGvV0N0RKt7DKUkBLzpL7HTh9/5+qgokmHTXoDzZJC6kilPrY5
         hxDg==
X-Gm-Message-State: AOAM5330GYo5osmfR9F9EmamkEor1xb0d2dMlakPqnXNsCjrRu5MQ6R8
        s40y7W8klCJPUgLb0wjgNLI=
X-Google-Smtp-Source: ABdhPJzP6Hpjv8BlzvKEw0jvUyutzyCm8wG3A3XQCu+NLpEYDsL18uiFZMLdrJlOk28iGcxMDBdRpA==
X-Received: by 2002:a17:906:9b8f:b0:6e0:6bcb:fc59 with SMTP id dd15-20020a1709069b8f00b006e06bcbfc59mr3885699ejc.624.1650629017572;
        Fri, 22 Apr 2022 05:03:37 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:36 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 03/16] fsnotify: fix wrong lockdep annotations
Date:   Fri, 22 Apr 2022 15:03:14 +0300
Message-Id: <20220422120327.3459282-4-amir73il@gmail.com>
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
index 4853184f7dde..c86982be2d50 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -452,7 +452,7 @@ void fsnotify_free_mark(struct fsnotify_mark *mark)
 void fsnotify_destroy_mark(struct fsnotify_mark *mark,
 			   struct fsnotify_group *group)
 {
-	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&group->mark_mutex);
 	fsnotify_detach_mark(mark);
 	mutex_unlock(&group->mark_mutex);
 	fsnotify_free_mark(mark);
@@ -770,7 +770,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 * move marks to free to to_free list in one go and then free marks in
 	 * to_free list one by one.
 	 */
-	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&group->mark_mutex);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
 		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
@@ -779,7 +779,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 
 clear:
 	while (1) {
-		mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
+		mutex_lock(&group->mark_mutex);
 		if (list_empty(head)) {
 			mutex_unlock(&group->mark_mutex);
 			break;
-- 
2.35.1

