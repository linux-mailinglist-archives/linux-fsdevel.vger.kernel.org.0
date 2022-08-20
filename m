Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7159AF65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiHTSNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHTSM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:12:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18594402FA
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=GPd/cKguDcNuKK+1y8cQ7h05NIMO0Bv9h0ujIzXv8pg=; b=XmzFWEEP2ZUshG+QLr8fRg2CAB
        7KbEVkqdFtYYBdxUcWuWdWqhcIwrdQvxkZOydDETDVErARBQB2ZgfCLnQ9xuRqz8KLSrkrtg1tunE
        PIYTdGVwl+VMwWcw2iAcsu2mSubbYtjYgql0mOIg14TOhfGnbEwc/rrC6T3ruNbc7MFbVNvkmVzUe
        gqVLo/8J7XZhl6wLPT3bT1NMS87xUA/8MYhWPMpzDW549zgmBEE58ZAmwFREUw+1sur/3Q9myDTUo
        39IP4bKWu6znxW2D7WtjgadqT9dNCLkU/KiJ5JojUQmJsMQ4avEJ59uO1u+jH3FDalskBmWqrJqGI
        c9jRwNlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxs-006RVm-KS
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] fs/notify: constify path
Date:   Sat, 20 Aug 2022 19:12:49 +0100
Message-Id: <20220820181256.1535714-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/notify/fanotify/fanotify.c      | 2 +-
 fs/notify/fanotify/fanotify.h      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index cd7d09a569ff..a2a15bc4df28 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -18,7 +18,7 @@
 
 #include "fanotify.h"
 
-static bool fanotify_path_equal(struct path *p1, struct path *p2)
+static bool fanotify_path_equal(const struct path *p1, const struct path *p2)
 {
 	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
 }
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 1d9f11255c64..bf6d4d38afa0 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -458,7 +458,7 @@ static inline bool fanotify_event_has_path(struct fanotify_event *event)
 		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
 }
 
-static inline struct path *fanotify_event_path(struct fanotify_event *event)
+static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
 		return &FANOTIFY_PE(event)->path;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index f0e49a406ffa..4546da4a54f9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -249,7 +249,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	return event;
 }
 
-static int create_fd(struct fsnotify_group *group, struct path *path,
+static int create_fd(struct fsnotify_group *group, const struct path *path,
 		     struct file **file)
 {
 	int client_fd;
@@ -619,7 +619,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  char __user *buf, size_t count)
 {
 	struct fanotify_event_metadata metadata;
-	struct path *path = fanotify_event_path(event);
+	const struct path *path = fanotify_event_path(event);
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
@@ -1553,7 +1553,7 @@ static int fanotify_test_fid(struct dentry *dentry)
 }
 
 static int fanotify_events_supported(struct fsnotify_group *group,
-				     struct path *path, __u64 mask,
+				     const struct path *path, __u64 mask,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-- 
2.30.2

