Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3424FF317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiDMJNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiDMJMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB219281
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g18so1626616wrb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vtr5pyBasxSToiXWwCcaDeyWbLzuF18LebaN1QarL1U=;
        b=Vi266M5Sy4e/XP45T8P7eW0N2/NgVjiTnWl9BCM+ZClmZsZstFlLe8Zqad32g5lLzL
         7miNpu3/X0ttiyx9rQhFD8BIiWYKzS7HKsAWXpiOPQNzxTX1yzk2E/2giSRZt+zVfp/l
         z8l/Ei0HU9szIdu54FUdZ6h4DNa+p2Q/5J2h2bKa68+VBr5441xkBpzIEWl+hVjJe3ru
         ZevM0KBzdEquBgiwAUjpSTcPCJyPb90V3mHpiIDEylzNsxQFzSCzPbIIFa0yNHUJZTZX
         uijj7DQOmjd8sRViF9JfgIs27JsCPPlt6Bh6Nc5C95E9j1T1an4P60ZBxq2+ik+HMQDP
         Ij9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vtr5pyBasxSToiXWwCcaDeyWbLzuF18LebaN1QarL1U=;
        b=kEJJzWlSoaYTY3ZabjSpRmGNT457o9kHgvoPTnBzuQ1JOu2/gwqDtCp8n1/9LWDfrl
         09BCLiRDpqXKnHlycknfFXNdrlEbjqkpKRn6SOqeSQPr++GKf34fnfa5166gGxAnz2Bp
         BPUAOwDi+ABM5qpWnw0wc6tcFaonyJobSdeUaVmF+tz2cbycr+vTREyazudSObwcW0YK
         HZhkwRlTgmhG43c7AHkbOswNvGpuHX6aU+phnodDlWQI4a80ZpqHu2i9PRKC59+x1Rth
         ZcBcVlNQ0vWddrXY6SoUpuK9rRomVkgcTTQEfV+ADZGFXcb7pyqKxGS7DOok6+YEA/TX
         NX/Q==
X-Gm-Message-State: AOAM530hhZ5tcbVaqD7PmYowFfbNsAKtdI9tstxpIlzSwhJC+hD57fmi
        OuQHv6TQch03zUiHxNgeRng=
X-Google-Smtp-Source: ABdhPJwnSUrjrSAuV1FSir2prfMlt0m/SpmZiqFUP/+DT5xgvRubXisbIVrtV80/guFnaRNlampNzw==
X-Received: by 2002:a05:6000:703:b0:207:a34c:e07 with SMTP id bs3-20020a056000070300b00207a34c0e07mr13160526wrb.540.1649840991748;
        Wed, 13 Apr 2022 02:09:51 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/16] dnotify: use fsnotify group lock helpers
Date:   Wed, 13 Apr 2022 12:09:29 +0300
Message-Id: <20220413090935.3127107-11-amir73il@gmail.com>
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

