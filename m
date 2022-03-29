Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC24EA8C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiC2Hvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiC2HvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778281EB82D
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 125-20020a1c0283000000b0038d043aac51so807257wmc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d43EZ7u0/J+yBXaYIqN+17PXgNgwdii5Sde1yDCMQz0=;
        b=qT9aMX3z00ZAGJL8NwcxMb4R/ejNHxDYNDYtdGK+gHBf+DEA0jQJCuYn0X+aG9rOxP
         FVcCqayWsagIaN/yXKZjsCJEbaB6kUPWd9ihCJC/2PH7WIUmgQXBCzys5HZ3iyhrNW38
         9ShZdOk74cq5x6I9ElEcukqX8zpF5Tf8mF1cx2kR0+uo09IlVqbqPo54lpBLKpwyv2a5
         jK9Y6yAmDcz5dmL9HFtWVkHqBvNv+jXk7T/WEMxIzApTibeooxw2bgk7ZeAqpibg48gg
         uk5wWl47Jz4YF7jCDqijhh1yqNtPB7+Qsx20qhFWd7eXgVyuXsyxcffV3szuLqXo3bBG
         ssaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d43EZ7u0/J+yBXaYIqN+17PXgNgwdii5Sde1yDCMQz0=;
        b=zuR6zceL8LlvzQT08qaWUFdgmZ8Ue0u53q+eJZ/ltJE9SDYtRhzUkbyGwtJCjxfnJC
         iiBztmOIimxHkMPJr71hA7o0C03ddkADhkGDsVo3eyw1Y1ZsOX62Z1Tw6VxziIn+9zds
         DaEzvUTkJ1KgQ8LgBCY4GwZxryeyNy+dpk2AJEss0Ev7wl619yS6Hd8PfX+Oz+d752Gb
         yY0ZY8TnocoNgZLQ9KyGzjJBSr/aXanvojlU5N5CeXfR37loeCyQWPQPsLap1rVoJzvh
         P2QoEsLEQ/NPD49yK6kKmGkCATnCY1vled5vKZ3QcqfgsYjCzadCc5Mc7cVbygua5WfQ
         gxaQ==
X-Gm-Message-State: AOAM5310Th/GrS+zlFEFwU9nRzMMe8uOCRrGEjdWpNTq24h1S4Wbg1If
        3p5343divDQwmT9zaIPj0/8=
X-Google-Smtp-Source: ABdhPJz+3moLq8ywzrHKPHGNFgd6YV2v0QJASvBmdywKaMmlzWeg7uDkg6G2kn07voLk5GZMXnJnZQ==
X-Received: by 2002:a05:600c:240b:b0:38c:eb99:8276 with SMTP id 11-20020a05600c240b00b0038ceb998276mr5132601wmp.82.1648540170057;
        Tue, 29 Mar 2022 00:49:30 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/16] fanotify: use fsnotify group lock helpers
Date:   Tue, 29 Mar 2022 10:49:03 +0300
Message-Id: <20220329074904.2980320-16-amir73il@gmail.com>
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
from allocations under fanotify group lock and use the nofs group lock
helpers.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  1 +
 fs/notify/fanotify/fanotify_user.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 02990a6b1b65..c7bcada371cb 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1082,6 +1082,7 @@ static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
+	.group_flags = FSNOTIFY_GROUP_NOFS,
 	.handle_event = fanotify_handle_event,
 	.free_group_priv = fanotify_free_group_priv,
 	.free_event = fanotify_free_event,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a3539bd8e443..5c857bfe8c3e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -931,12 +931,12 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	case FAN_IOC_SET_MARK_PAGE_ORDER:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		mutex_lock(&group->mark_mutex);
+		fsnotify_group_lock(group);
 		group->fanotify_data.mark_page_order = (unsigned int)arg;
 		pr_info("fanotify: set mark size page order to %u",
 			group->fanotify_data.mark_page_order);
 		ret = 0;
-		mutex_unlock(&group->mark_mutex);
+		fsnotify_group_unlock(group);
 		break;
 	}
 
@@ -1044,11 +1044,12 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	struct fsnotify_mark *fsn_mark = NULL;
 	__u32 removed;
 	int destroy_mark;
+	unsigned int nofs;
 
-	mutex_lock(&group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(group);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		mutex_unlock(&group->mark_mutex);
+		fsnotify_group_nofs_unlock(group, nofs);
 		return -ENOENT;
 	}
 
@@ -1058,7 +1059,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 		fsnotify_recalc_mask(fsn_mark->connector);
 	if (destroy_mark)
 		fsnotify_detach_mark(fsn_mark);
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 	if (destroy_mark)
 		fsnotify_free_mark(fsn_mark);
 
@@ -1236,9 +1237,10 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 			     __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *fsn_mark = NULL;
+	unsigned int nofs;
 	int ret = 0;
 
-	mutex_lock(&group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(group);
 	/* Allow adding multiple large marks per object for testing */
 	if (!group->fanotify_data.mark_page_order)
 		fsn_mark = fsnotify_find_mark(connp, group);
@@ -1246,7 +1248,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
 						 fsid);
 		if (IS_ERR(fsn_mark)) {
-			mutex_unlock(&group->mark_mutex);
+			fsnotify_group_nofs_unlock(group, nofs);
 			return PTR_ERR(fsn_mark);
 		}
 	}
@@ -1264,7 +1266,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	ret = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
 
 out:
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_nofs_unlock(group, nofs);
 
 	fsnotify_put_mark(fsn_mark);
 	return ret;
-- 
2.25.1

