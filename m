Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70F64FF30B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiDMJMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiDMJMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B91DA49
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p18so826415wru.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OAEdHhjLwuYPCqjVFR53AS/kwFMiTKuiUBzvVoBwHmE=;
        b=X+cSrp/Uuv8T7CBKlQ3ugWF/xLISJ2pVoY2itUr8+MGhZaDlFx1Bkf2/Beim5x0mHp
         DMVGmyF7IgjDJhSak1OTy5zwV79QZGcZverFe5ESTPa4RiMQ5bpn1NNIqpUUGkVIA0QT
         /cZelOy5843Z7SFn0jvBEoBSz9xL/qhHoyqswbBv+3NLGIRDSgIn3GwiGnYW7k2yZ0GR
         EGyxRwDst4CghvMdLiWhl4QSqEAK8Nhg+A99cODQ1R2d6m6Y4enPZZb6Bw+/2Tk5NsFH
         /mccUTD0qTc6tc7pxjkJhqHGTqaUGVWRvwulaAbXw7WPvcH70UysOzP3IG1ofx7Ui0yF
         c+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAEdHhjLwuYPCqjVFR53AS/kwFMiTKuiUBzvVoBwHmE=;
        b=6xeQCWuFxwsUK1OsslCAOFdr71PR+laSnitwrSUluV5MjVM49Oiobkblr7kXc+15LK
         BPDzy6d4OleNTjH11/ShLttUGMilMqtkdo31wcB77IjgRhFSiN2P9mGqGe7G2ww5xpJx
         FzspF38Wfo35aBM3VPRZ1hbA/Y1XsVZqAs74uUv4oXov7FJ8aLCGjms485kS6lS77GK4
         IUCdPjV+k2yYIZSnMc4jkTiSKVCoPc1UooAlyiKo4WnLn/3jPQXTe+b3aqgf1mV0wcV2
         CBnndBS9gm7QQ1RhZhuxOvQ3wPsI/BCcfULGqeQSa82cDgPt+txVrOySZZiRmW6Qd5+8
         turg==
X-Gm-Message-State: AOAM5337lWYMKmjMwP8EMPN+gO+KNEar6pClQQWJPnq+dQRwBu2UDk4S
        B6cH0o/YMSB/CboctwoRKsw=
X-Google-Smtp-Source: ABdhPJxlY/B6E4d3kZUO4hPub9C/MZrIkrgq59bUqMvo3K9M+45kuoxxJ9EcKvC9TZBzLnUjwAZPDg==
X-Received: by 2002:adf:f3cc:0:b0:207:ad57:cc53 with SMTP id g12-20020adff3cc000000b00207ad57cc53mr6264776wrp.58.1649840982268;
        Wed, 13 Apr 2022 02:09:42 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/16] fsnotify: fix wrong lockdep annotations
Date:   Wed, 13 Apr 2022 12:09:22 +0300
Message-Id: <20220413090935.3127107-4-amir73il@gmail.com>
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

