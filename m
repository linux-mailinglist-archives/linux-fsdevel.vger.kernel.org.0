Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE150B6C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447276AbiDVMIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447341AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543256C0B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d6so5057924ede.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vtr5pyBasxSToiXWwCcaDeyWbLzuF18LebaN1QarL1U=;
        b=BPxVT4Rp1DeNqxF/ai3oEjkX+vUhmnRlLd9Z5EsuIpQmTh5sLdtKr6ZG8mCr8KqX1P
         rusi+7TlJpJr0ksK1RhiCb9BdBYjtt/S9d7FT001cAH+s7n4/MM4Hj/p5vaHIyvSbm99
         S7oVmcfgB5DRJsOo+1i5d1aQpJwxMnuHpZy+WogcNLL/rNtLFEI/N/d5fCuRzyPX+ZZx
         IiCmNS7LPVCVDGJLrXFnZdkhC/YXw2haFFpaUCz9N9Tq8ioDFqTQSqDpC6n4Xm78wy8v
         Am+O0SKOgdQCJbxMOTdJDZZvtdsmp/WcbJROVKqEfFP5D0nkfjrljp+R1isZE+SS2BJX
         Oirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vtr5pyBasxSToiXWwCcaDeyWbLzuF18LebaN1QarL1U=;
        b=nKeSEuZOEFuhfumITksUktsWEuA51jc2gk8aO4l2cme4dRVryg/iWs5EXUaJaBoX+x
         /X1UIxppPDpIy7mLLkxNbxVlWKn4PwNrfVIA79c073btyXrF78OfqufRGCnQU9O1TaHs
         z0nw/kr7+6kk+y25DxnZEAl5c0AliKzXrxbzj+NpPE4EJ5LdTD+EqsKZELzJF3/Q9D/7
         lMncTgAXhZE4XtzM+hBiTaa5eLLwmR07BHBSDR43VEJZA+rH6vFjtGuUORtBhfCwnR43
         GIceGw2NlrJKY54AEOxYPLr0bPvTvA1CiBKPTVRzC+dJrEZyxyualRV/1eJ6HaPgPyPD
         ALWQ==
X-Gm-Message-State: AOAM531bKqw5ytKYJ4wiBld/4YcIozwwZSeKHGcL9C4p3cGaB2mpKs8U
        P3kSGTAm4xe9VCw1wparmTfayKtbOBE=
X-Google-Smtp-Source: ABdhPJx3rYYNV5RvZDTv1DPc24Hle5zKszj3ceekJkbgwJKGNUoZK8Zf5WRMGh/0OBDO08YtuxwATw==
X-Received: by 2002:a05:6402:268f:b0:423:e68b:1942 with SMTP id w15-20020a056402268f00b00423e68b1942mr4550340edd.73.1650629029053;
        Fri, 22 Apr 2022 05:03:49 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 10/16] dnotify: use fsnotify group lock helpers
Date:   Fri, 22 Apr 2022 15:03:21 +0300
Message-Id: <20220422120327.3459282-11-amir73il@gmail.com>
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

Before commit 9542e6a643fc6 ("nfsd: Containerise filecache laundrette")
nfsd would close open files in direct reclaim context.  There is no
guarantee that others memory shrinkers don't do the same and no
guarantee that future shrinkers won't do that.

For example, if overlayfs implements inode cache of fscache would
keep open files to cached objects, inode shrinkers could end up closing
open files to underlying fs.

Direct reclaim from dnotify mark allocation context may try to close
open files that have dnotify marks of the same group and hit a deadlock
on mark_mutex.

Set the FSNOTIFY_GROUP_NOFS flag to prevent going into direct reclaim
from allocations under dnotify group lock and use the safe group lock
helpers.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e4779926edf4..190aa717fa32 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -168,7 +168,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 		return;
 	dn_mark = container_of(fsn_mark, struct dnotify_mark, fsn_mark);
 
-	mutex_lock(&dnotify_group->mark_mutex);
+	fsnotify_group_lock(dnotify_group);
 
 	spin_lock(&fsn_mark->lock);
 	prev = &dn_mark->dn;
@@ -191,7 +191,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 		free = true;
 	}
 
-	mutex_unlock(&dnotify_group->mark_mutex);
+	fsnotify_group_unlock(dnotify_group);
 
 	if (free)
 		fsnotify_free_mark(fsn_mark);
@@ -324,7 +324,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	new_dn_mark->dn = NULL;
 
 	/* this is needed to prevent the fcntl/close race described below */
-	mutex_lock(&dnotify_group->mark_mutex);
+	fsnotify_group_lock(dnotify_group);
 
 	/* add the new_fsn_mark or find an old one. */
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, dnotify_group);
@@ -334,7 +334,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	} else {
 		error = fsnotify_add_inode_mark_locked(new_fsn_mark, inode, 0);
 		if (error) {
-			mutex_unlock(&dnotify_group->mark_mutex);
+			fsnotify_group_unlock(dnotify_group);
 			goto out_err;
 		}
 		spin_lock(&new_fsn_mark->lock);
@@ -383,7 +383,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 
 	if (destroy)
 		fsnotify_detach_mark(fsn_mark);
-	mutex_unlock(&dnotify_group->mark_mutex);
+	fsnotify_group_unlock(dnotify_group);
 	if (destroy)
 		fsnotify_free_mark(fsn_mark);
 	fsnotify_put_mark(fsn_mark);
@@ -401,7 +401,8 @@ static int __init dnotify_init(void)
 					  SLAB_PANIC|SLAB_ACCOUNT);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
 
-	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
+	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops,
+					     FSNOTIFY_GROUP_NOFS);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
 	dnotify_sysctl_init();
-- 
2.35.1

