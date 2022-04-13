Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D004FF316
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiDMJNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDMJMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526A2ED6B
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q3so1011281wrj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSJ0rqC4gIfg/vNqPrVZaeJuRUg8aA2BJvhi9wYEDeQ=;
        b=K9FzpRFLC3iF4sLwyAebNr1wbK7EmRWPzMcyQgvjpb1ckuZRUkRm15wb1xc2Uk86v/
         d63vrlUlglK8EntW652mgL+E7LbaDqiSa+48tyzZt28j+kp0aTXOV6eCqSm83SJBYqu4
         2Glm8LcRgQnzEu0RDhB3DaC+d7WDSrCgH8aealuy8tx3bp7tkzt4JFrDeEK3PwzdDNLP
         qOlYl33+3uohobLDIN4xXPQd65FGIrCsN4oNJra+yQR92qjDEY/G8xSrTbxqx/W0ObEy
         6U77MRd9htvrdEoQ2VdONt0YiRAibQX27Plq6yQRNcJnUuq+Wf/9rF+A3jLRHy0/u1je
         GfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSJ0rqC4gIfg/vNqPrVZaeJuRUg8aA2BJvhi9wYEDeQ=;
        b=H1H4m2Vxr8NC4I6ERUbgkRCRWiUV99wGbsE48zjlVAriP3CrE/r5WL7SkMVN0JbTkK
         BOaUIWVwiPIB1DJrQAKmzlTWJoVaDnHnL5LyJ1xlFsjQuea+cArOZW1YW+TLyudsE/p1
         AXOHbxhFidk9NC208MdWFJTubM/ggKkpjfkQ/CZUmoSx8RywqKt8a46Wf0uIucxti3z/
         3/wS66ygDXgNxibdZ98YTabXXacHtZZ/Y6cdXIQzO+HlizjPQQj6xdehBTNRbgUmxG6l
         Rd0V5HfNleg/h64ghCHb48fdQH/dpuXbo4fa6XNlRVlBXxyDP200x4lXp9Kh/O7MfTzD
         lVNA==
X-Gm-Message-State: AOAM532vwTeQarry6hsOUJcNNtfp3PW72o7jvHA0WsF+TQUyS653kOxc
        hQkqfhozdNoq389d8loEbiw=
X-Google-Smtp-Source: ABdhPJxUXHaEdWjrNTyUzAl7+0FChgk9iohtl+sgnittC9SL5S8NVIpFZqnj8kZLm8WLq5Q7spZivA==
X-Received: by 2002:a05:6000:1842:b0:207:9b57:6bbf with SMTP id c2-20020a056000184200b002079b576bbfmr17131063wri.336.1649840998059;
        Wed, 13 Apr 2022 02:09:58 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:57 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 15/16] fanotify: use fsnotify group lock helpers
Date:   Wed, 13 Apr 2022 12:09:34 +0300
Message-Id: <20220413090935.3127107-16-amir73il@gmail.com>
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

Direct reclaim from fanotify mark allocation context may try to evict
inodes with evictable marks of the same group and hit this deadlock:

[<0>] fsnotify_destroy_mark+0x1f/0x3a
[<0>] fsnotify_destroy_marks+0x71/0xd9
[<0>] __destroy_inode+0x24/0x7e
[<0>] destroy_inode+0x2c/0x67
[<0>] dispose_list+0x49/0x68
[<0>] prune_icache_sb+0x5b/0x79
[<0>] super_cache_scan+0x11c/0x16f
[<0>] shrink_slab.constprop.0+0x23e/0x40f
[<0>] shrink_node+0x218/0x3e7
[<0>] do_try_to_free_pages+0x12a/0x2d2
[<0>] try_to_free_pages+0x166/0x242
[<0>] __alloc_pages_slowpath.constprop.0+0x30c/0x903
[<0>] __alloc_pages+0xeb/0x1c7
[<0>] cache_grow_begin+0x6f/0x31e
[<0>] fallback_alloc+0xe0/0x12d
[<0>] ____cache_alloc_node+0x15a/0x17e
[<0>] kmem_cache_alloc_trace+0xa1/0x143
[<0>] fanotify_add_mark+0xd5/0x2b2
[<0>] do_fanotify_mark+0x566/0x5eb
[<0>] __x64_sys_fanotify_mark+0x21/0x24
[<0>] do_syscall_64+0x6d/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Set the FSNOTIFY_GROUP_NOFS flag to prevent going into direct reclaim
from allocations under fanotify group lock and use the safe group lock
helpers.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0b4beba95fa8..fe2534043c17 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1035,10 +1035,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	__u32 removed;
 	int destroy_mark;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		mutex_unlock(&group->mark_mutex);
+		fsnotify_group_unlock(group);
 		return -ENOENT;
 	}
 
@@ -1048,7 +1048,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 		fsnotify_recalc_mask(fsn_mark->connector);
 	if (destroy_mark)
 		fsnotify_detach_mark(fsn_mark);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 	if (destroy_mark)
 		fsnotify_free_mark(fsn_mark);
 
@@ -1200,13 +1200,13 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	struct fsnotify_mark *fsn_mark;
 	int ret;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
 		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
 						 fsid);
 		if (IS_ERR(fsn_mark)) {
-			mutex_unlock(&group->mark_mutex);
+			fsnotify_group_unlock(group);
 			return PTR_ERR(fsn_mark);
 		}
 	}
@@ -1232,7 +1232,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 
 out:
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 
 	fsnotify_put_mark(fsn_mark);
 	return ret;
@@ -1386,7 +1386,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_USER | FSNOTIFY_GROUP_NOFS);
 	if (IS_ERR(group)) {
 		return PTR_ERR(group);
 	}
-- 
2.35.1

