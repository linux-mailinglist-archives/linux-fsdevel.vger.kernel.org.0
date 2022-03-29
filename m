Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A64EA8BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiC2HvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiC2HvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075661E8CC5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p189so9727185wmp.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgYXuFaXAE2oHVSuPm5rYzIav77e+tMyW29cgBh+Tss=;
        b=DtBY7KmdeHjMq9p+du9SYA2ulY2G268Sci+509iBb758MFMAFrIa8e2uM+gaicXwhb
         WVE0wmgmJ+Iw5zi/HfHGMCxo5kAELKGZ7wd+BmPmZNDOHTOoap4HKoy884M9Am1gwiMU
         OzLFinB6X7vywyGLi/8zux86xAfSq97CfH3TnrhqCGKJzB0z1eIQpOmJ9t0CsbY9rJw/
         hxKcMX2xNjFR1bLQI1ZUBcQ7Oa2VcmoGcyMEysJeY4hhEq8k5KPuIjRy3msnbu0WLcYf
         iLoLkdBDWdSJQC4MFzqW4VYHdT9r/2jk8TW9HuM0jUJULqhz6CQjAaL5XJ6k0qQ/Izgj
         X22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgYXuFaXAE2oHVSuPm5rYzIav77e+tMyW29cgBh+Tss=;
        b=oSF5EgI1Fvydf0OxLgoz78oChJA3zCow2Gjw5fdz8QB+y9D4oKWlIpHEONcKFqFavU
         2FFpbtJ7jgqv2Fvn6gEUvyRjLpQfwK/QeQ+wEjqctDyeTQ7RrpsggtU91lY41uCjpzVq
         zFNabCf1gvZPUpA18Z1EAxeEoPZAebynuqxcwYU0BuVzMhXYNw+CyEmgNs0h7xsnlPyk
         cmuFQ3KI8VaCfweSx6bTfOkdNXM25KNOsPE+G6MYfLRaXoODnusESMB0Opx60bKrC32V
         eUEk8l8K5aOnxxXvJsBJuxcL0sbmS7JR0Gt5hVb6HQQNIyoEgZrzcjWtS7wwvu9Ctf64
         vKyw==
X-Gm-Message-State: AOAM533X8fixdkorHQfu0NLuXTfqzSQIG5/Hq65xDNKDy4zmLcqiLQTc
        TByrjQX+quMWMjgNfdDB2Oo=
X-Google-Smtp-Source: ABdhPJx72uWSZvZ796rsfK8DIG5F4KCuTRo3XCTgShZO9yMbR/BV/NSKGi5Xq2eQM4btG4vYtfUDJA==
X-Received: by 2002:a7b:c14c:0:b0:381:32fb:a128 with SMTP id z12-20020a7bc14c000000b0038132fba128mr5142335wmi.116.1648540163597;
        Tue, 29 Mar 2022 00:49:23 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/16] dnotify: use fsnotify group lock helpers
Date:   Tue, 29 Mar 2022 10:48:58 +0300
Message-Id: <20220329074904.2980320-11-amir73il@gmail.com>
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
from allocations under dnotify group lock and use the nofs group lock
helpers.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 829dd4a61b66..b291141104ea 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -139,6 +139,7 @@ static void dnotify_free_mark(struct fsnotify_mark *fsn_mark)
 }
 
 static const struct fsnotify_ops dnotify_fsnotify_ops = {
+	.group_flags = FSNOTIFY_GROUP_NOFS,
 	.handle_inode_event = dnotify_handle_event,
 	.free_mark = dnotify_free_mark,
 };
@@ -158,6 +159,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 	struct dnotify_struct **prev;
 	struct inode *inode;
 	bool free = false;
+	unsigned int nofs;
 
 	inode = file_inode(filp);
 	if (!S_ISDIR(inode->i_mode))
@@ -168,7 +170,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 		return;
 	dn_mark = container_of(fsn_mark, struct dnotify_mark, fsn_mark);
 
-	mutex_lock(&dnotify_group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(dnotify_group);
 
 	spin_lock(&fsn_mark->lock);
 	prev = &dn_mark->dn;
@@ -191,7 +193,7 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 		free = true;
 	}
 
-	mutex_unlock(&dnotify_group->mark_mutex);
+	fsnotify_group_nofs_unlock(dnotify_group, nofs);
 
 	if (free)
 		fsnotify_free_mark(fsn_mark);
@@ -267,6 +269,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	fl_owner_t id = current->files;
 	struct file *f;
 	int destroy = 0, error = 0;
+	unsigned int nofs;
 	__u32 mask;
 
 	/* we use these to tell if we need to kfree */
@@ -324,7 +327,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	new_dn_mark->dn = NULL;
 
 	/* this is needed to prevent the fcntl/close race described below */
-	mutex_lock(&dnotify_group->mark_mutex);
+	nofs = fsnotify_group_nofs_lock(dnotify_group);
 
 	/* add the new_fsn_mark or find an old one. */
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, dnotify_group);
@@ -334,7 +337,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 	} else {
 		error = fsnotify_add_inode_mark_locked(new_fsn_mark, inode, 0);
 		if (error) {
-			mutex_unlock(&dnotify_group->mark_mutex);
+			fsnotify_group_nofs_unlock(dnotify_group, nofs);
 			goto out_err;
 		}
 		spin_lock(&new_fsn_mark->lock);
@@ -383,7 +386,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 
 	if (destroy)
 		fsnotify_detach_mark(fsn_mark);
-	mutex_unlock(&dnotify_group->mark_mutex);
+	fsnotify_group_nofs_unlock(dnotify_group, nofs);
 	if (destroy)
 		fsnotify_free_mark(fsn_mark);
 	fsnotify_put_mark(fsn_mark);
-- 
2.25.1

