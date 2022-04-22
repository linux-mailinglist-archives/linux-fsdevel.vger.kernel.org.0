Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016050B6C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447281AbiDVMIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447349AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C556C14
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so10167667edv.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L93WxvqHz29c/rmoHema7YmVwi6Brmln6rC6CF3ndfw=;
        b=QkLtGIFV16f1/E7XJzRlvDDanUYCSfXAV74OblwBQqqxCHRVboIzsmFIQ1dRB7EqwT
         mn6y3e6Y/FwtdEMiZmvL6kTKGvMtvymztwFmuB2WKgWWRGBhan8I3IF4LXlXgdvG6bL7
         fafi8FLR6w28r1t2h7NYVkImYTeE3JPyRnBaMtifn4zoESMbhSXijhM9DnrXHBfTKAmW
         KX7g0eEtyMfdNaU0zBgAde+BSACpcLqSMvTyawgO53N6iC0ZhGr70xa08blhQe/TTPeq
         2TZy36NECfqpW1rp48ci1G8aTkqNGcvNUA68fCODd684w3tDUlBNna49YdzM2yHscxdJ
         H33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L93WxvqHz29c/rmoHema7YmVwi6Brmln6rC6CF3ndfw=;
        b=QKUsc9fRlfngZQKJcUKlVJChNk++Z2YPq3VIAmNfBYEwcIL8V9DSY8FX3Fw9xIEIIK
         Qe0ZRFd1OcAihLDyLTtZeU5bqHQ3R7zToIOdxWGApxr2uFxh8N/2NxdH+XxmOG7yp+uK
         fzceEn6xSHOE/CBS4K8b8MgcFP6tjxqhgL1vCtMFyxm4IGExGciKLvMSBDxb77dqpj2S
         yhY8bTAcgAm+9r6fCiU26dl4ZgI+P/aSjCjSaYjfRPEMdrkJU/hoeCiN5egs06SMrxpN
         +sU2St+aNYn6j44H3+4BAHGocnzavMn8Hg3PVYHthGoojdFou8/P7tHkr2+JmDsUmbDU
         +oYw==
X-Gm-Message-State: AOAM532xNTT1tcS5Xl8iCZ8lbz5oOf6ImFPUwDI01x6NMIpkDHKrdN1b
        AgkQYIXtuk2NjgHpCnAbAjYTxsWuBok=
X-Google-Smtp-Source: ABdhPJyDZxRVtH3OzjzkNjiyJdfGFInQpz+DI3yNmkSVbo8oBGVtgwHMR8MjKS1f0Q29fUVtQ3DmjA==
X-Received: by 2002:a50:eb89:0:b0:425:c2de:7c01 with SMTP id y9-20020a50eb89000000b00425c2de7c01mr1338584edr.282.1650629036340;
        Fri, 22 Apr 2022 05:03:56 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 15/16] fanotify: use fsnotify group lock helpers
Date:   Fri, 22 Apr 2022 15:03:26 +0300
Message-Id: <20220422120327.3459282-16-amir73il@gmail.com>
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
index ae36138afead..228cf25e9230 100644
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
 
@@ -1196,13 +1196,13 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	bool recalc;
 	int ret = 0;
 
-	mutex_lock(&group->mark_mutex);
+	fsnotify_group_lock(group);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
 		fsn_mark = fanotify_add_new_mark(group, connp, obj_type,
 						 fan_flags, fsid);
 		if (IS_ERR(fsn_mark)) {
-			mutex_unlock(&group->mark_mutex);
+			fsnotify_group_unlock(group);
 			return PTR_ERR(fsn_mark);
 		}
 	}
@@ -1231,7 +1231,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 		fsnotify_recalc_mask(fsn_mark->connector);
 
 out:
-	mutex_unlock(&group->mark_mutex);
+	fsnotify_group_unlock(group);
 
 	fsnotify_put_mark(fsn_mark);
 	return ret;
@@ -1385,7 +1385,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_USER | FSNOTIFY_GROUP_NOFS);
 	if (IS_ERR(group)) {
 		return PTR_ERR(group);
 	}
-- 
2.35.1

