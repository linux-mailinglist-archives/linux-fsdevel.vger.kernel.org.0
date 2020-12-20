Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0662DF391
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 05:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgLTErE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 23:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgLTErE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 23:47:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C72C0617B0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 20:46:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r29so4367739pga.20
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Dec 2020 20:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=E+KTnvzcs5JsFh57zt07bVvSESBSRodeL+PTYDq6f7o=;
        b=qj8HlWI6tZdIhw+rewCG3QHQBdMh6oLbeBtQ+FixjcusoK13IpGxkq1c5YE1l0+eed
         zVbZJyKTvERT2TmdB6CoDbR2axOfXqPV+x+SH9aRLg97bazsi7cmiq3eFZ0yQhqWHZEy
         jgTHQcQ6a/mSLbMqdCnl27zxAAxByeE4hwS28Z2Li9884mzx+AjeLqF0yib0RXZ3UI2u
         yr1M5kJApUa7IIcCezfZgD/w0duGJqFLvVYPyzuImbmnY+45dm2nvZ93Jo7PYFiInYCP
         DlUNzl8HjhbvqG9YQoZDbPUkKthc31dhOEb1TcZwuILm8RNXEho31q5o839xZWh11zgW
         ASpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=E+KTnvzcs5JsFh57zt07bVvSESBSRodeL+PTYDq6f7o=;
        b=tB9L+jT2Rij4jzRGnBR9oUod9FqNVdmSYBulEyuU5ceHCTbAspe9+UyDw+G4sdvU8J
         Ayc76jPAPO9vYJXYSfZqYoOWMmMmmlP9UFaConEwx1Laz9nHxcpSwRo6DT5bcYVYq6KK
         MT/Zf2TqjXA1uWY9MHjqI2GEVVy9+EwQXRTHh9hQY3RboIRzpxkBNG0cR4me18OMpxZ+
         gTF14WpjF954bmhDjhPYs9KjRgB/O91EZpWdpziNc7HLOhhUd2Qe+ug13AeXDzAUk7Sy
         VtsGNCgmNjqN/VTSp22T8SgMTqnh3DZ52eEr9+NP5ExkQg9pGwJyiupQxBHn6iz04zp6
         nx4A==
X-Gm-Message-State: AOAM530S7FmK64pLB2l/7bolWPKsjBQU5s1riqPVYdUzua8cYONYLbIi
        WyCX9RGt+znFeIWkYl5tXKESguwfOBQpAg==
X-Google-Smtp-Source: ABdhPJwVJYVnWO4MvhahOTUFhh8SBrFUbCSc2epgLCW/93Vp5fokqG7+kT7R9YX7Y71yLo815QdY7cUMMVgCmQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a17:90b:3011:: with SMTP id hg17mr11851579pjb.22.1608439583347;
 Sat, 19 Dec 2020 20:46:23 -0800 (PST)
Date:   Sat, 19 Dec 2020 20:46:08 -0800
Message-Id: <20201220044608.1258123-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2] inotify, memcg: account inotify instances to kmemcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the fs sysctl inotify/max_user_instances is used to limit the
number of inotify instances on the system. For systems running multiple
workloads, the per-user namespace sysctl max_inotify_instances can be
used to further partition inotify instances. However there is no easy
way to set a sensible system level max limit on inotify instances and
further partition it between the workloads. It is much easier to charge
the underlying resource (i.e. memory) behind the inotify instances to
the memcg of the workload and let their memory limits limit the number
of inotify instances they can create.

With inotify instances charged to memcg, the admin can simply set
max_user_instances to INT_MAX and let the memcg limits of the jobs limit
their inotify instances.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- introduce fsnotify_alloc_user_group() and convert fanotify in addition
  to inotify to use that function. [suggested by Amir]

 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/group.c                  | 25 ++++++++++++++++++++-----
 fs/notify/inotify/inotify_user.c   |  4 ++--
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..7e7afc2b62e1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -976,7 +976,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
-	group = fsnotify_alloc_group(&fanotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(&fanotify_fsnotify_ops);
 	if (IS_ERR(group)) {
 		free_uid(user);
 		return PTR_ERR(group);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index a4a4b1c64d32..ffd723ffe46d 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -111,14 +111,12 @@ void fsnotify_put_group(struct fsnotify_group *group)
 }
 EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
-/*
- * Create a new fsnotify_group and hold a reference for the group returned.
- */
-struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+static struct fsnotify_group *__fsnotify_alloc_group(
+				const struct fsnotify_ops *ops, gfp_t gfp)
 {
 	struct fsnotify_group *group;
 
-	group = kzalloc(sizeof(struct fsnotify_group), GFP_KERNEL);
+	group = kzalloc(sizeof(struct fsnotify_group), gfp);
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
@@ -139,8 +137,25 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
 
 	return group;
 }
+
+/*
+ * Create a new fsnotify_group and hold a reference for the group returned.
+ */
+struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
+{
+	return __fsnotify_alloc_group(ops, GFP_KERNEL);
+}
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
+/*
+ * Create a new fsnotify_group and hold a reference for the group returned.
+ */
+struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops)
+{
+	return __fsnotify_alloc_group(ops, GFP_KERNEL_ACCOUNT);
+}
+EXPORT_SYMBOL_GPL(fsnotify_alloc_user_group);
+
 int fsnotify_fasync(int fd, struct file *file, int on)
 {
 	struct fsnotify_group *group = file->private_data;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 59c177011a0f..266d17e8ecb9 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -632,11 +632,11 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct fsnotify_group *group;
 	struct inotify_event_info *oevent;
 
-	group = fsnotify_alloc_group(&inotify_fsnotify_ops);
+	group = fsnotify_alloc_user_group(&inotify_fsnotify_ops);
 	if (IS_ERR(group))
 		return group;
 
-	oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL);
+	oevent = kmalloc(sizeof(struct inotify_event_info), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!oevent)) {
 		fsnotify_destroy_group(group);
 		return ERR_PTR(-ENOMEM);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a2e42d3cd87c..e5409b83e731 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -470,6 +470,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 
 /* create a new group */
 extern struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops);
+extern struct fsnotify_group *fsnotify_alloc_user_group(const struct fsnotify_ops *ops);
 /* get reference to a group */
 extern void fsnotify_get_group(struct fsnotify_group *group);
 /* drop reference on a group from fsnotify_alloc_group */
-- 
2.29.2.684.gfbc64c5ab5-goog

