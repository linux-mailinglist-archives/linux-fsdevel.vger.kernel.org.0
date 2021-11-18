Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D245621D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhKRSQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKRSQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:16:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E336C061574;
        Thu, 18 Nov 2021 10:13:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so30852866eda.12;
        Thu, 18 Nov 2021 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKnWX0ZLoyWlJhFzhfI83DlGZlwNKN51LUBOfXmS26o=;
        b=XxXLFzb6AFcl6r9RQ9RpksJZBF0NkFRDZI0WXOtEP+yXCt3xAk0HgMaeibQ0DFCVez
         F/Q9lQpkw7gJciVxPn8gpx3NdXeAQMxy7+ajGO86JOBAhfD6moOUHLUnK4G0XLDgBd6/
         d2nrH3/FgkWoJ562raeK7P/l1Q6Ml+EQVCZd6R4Y/zEaeZ8GbclpwmJsAxiGXlRhpQMe
         O6mpvXdBwQ5spwiGyOg2sDMBum0Gnc7UpQU7OZqkNlCCrTnQC8wzRfXz364OTDaRjwOA
         SzsgJEgxtX6s4qn8gTeojcnaXmbLk7c2g6JNo0ZCtOVU6qWJJH/M9CkwBI6U6aBx5P/r
         vqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKnWX0ZLoyWlJhFzhfI83DlGZlwNKN51LUBOfXmS26o=;
        b=INCh5Io7vXW66gwOrHD+PVAQPibk7bY1dsWATt9/hAxgtVatxYt8xZDKLV+oJstr5l
         sFMXYgutrms0c6FwhB3iHukOvuJ1nR5Dy23Dmc5PIV5p5YnAw32wLjMQoskesdAnEMQE
         K8I/e4Ea+OmNATWlIkbIrPneQC7RG+4zmer+Vmbu8/okaIjRuX0JZbc7aZrS0RlQ0zxT
         ZZbmwdk9Tf20UfmHD8lzIRG2IX/eIkrfPTGb5dkSkfUMEYu0GJxQ2/HAY1Hj9xulaoK0
         Vv7XlM1I/XNGDMCxw/AZw7rfkTW66YBnNDCOGFBOvadqlRcGJAFS6ekpEU+vqshYigUA
         vJXw==
X-Gm-Message-State: AOAM531o8A3pcSwWGdkewngBvHmoY+GG/vIuI3AoArY6Z8CC7NH8VJsB
        CpGzfNP66vJG9TTpide84m5MmHnX4B0=
X-Google-Smtp-Source: ABdhPJwN9fe6LLKcDjWT1eKnJeuKh0DuYJig1dHYHednYmg2/O9lEToyK2dNf9z5IIRPCgneh6V/uA==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr14412515ede.57.1637259191574;
        Thu, 18 Nov 2021 10:13:11 -0800 (PST)
Received: from crow.. ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id d10sm224135eja.4.2021.11.18.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:13:11 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 3/4] namespacefs: Couple namespacefs to the PID namespace
Date:   Thu, 18 Nov 2021 20:12:09 +0200
Message-Id: <20211118181210.281359-4-y.karadz@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the PID namespace gets initialized, a directory called 'pid' is
added to 'namespacesfs'. This directory represents the main PID namespace
and also serves as a trunk (parent) of all child PID namespaces. Every
time when a new PID namespace is created a corresponding directory is
added to 'namespacefs/pid/parent/hierarchy/'. The 'inum' of the new
namespace gives the name of its directory. When the PID namespace is
destroyed the corresponding directory is removed.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 fs/namespacefs/inode.c | 21 +++++++++++++++++++++
 kernel/pid_namespace.c |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/namespacefs/inode.c b/fs/namespacefs/inode.c
index 012c1c43b44d..55d71733164c 100644
--- a/fs/namespacefs/inode.c
+++ b/fs/namespacefs/inode.c
@@ -11,7 +11,9 @@
 #include <linux/fsnotify.h>
 #include <linux/magic.h>
 #include <linux/idr.h>
+#include <linux/proc_ns.h>
 #include <linux/seq_file.h>
+#include <linux/pid_namespace.h>
 
 static struct vfsmount *namespacefs_mount;
 static int namespacefs_mount_count;
@@ -307,6 +309,19 @@ void namespacefs_remove_pid_ns_dir(struct pid_namespace *ns)
 	namespacefs_remove_dir(ns->ns.dentry);
 }
 
+static int add_ns_dentry(struct ns_common *ns)
+{
+	struct dentry *dentry =
+		namespacefs_create_dir(ns->ops->name, NULL, &init_user_ns);
+
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	ns->dentry = dentry;
+
+	return 0;
+}
+
 #define _NS_MOUNT_DIR	"namespaces"
 
 static int __init namespacefs_init(void)
@@ -321,8 +336,14 @@ static int __init namespacefs_init(void)
 	if (err)
 		goto rm_mount;
 
+	err = add_ns_dentry(&init_pid_ns.ns);
+	if (err)
+		goto unreg;
+
 	return 0;
 
+ unreg:
+	unregister_filesystem(&namespacefs_fs_type);
  rm_mount:
 	sysfs_remove_mount_point(fs_kobj, _NS_MOUNT_DIR);
  fail:
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a3723bc66..1690b2c87661 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -12,6 +12,7 @@
 #include <linux/pid.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/namespacefs.h>
 #include <linux/syscalls.h>
 #include <linux/cred.h>
 #include <linux/err.h>
@@ -101,6 +102,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
 		goto out_free_idr;
+
 	ns->ns.ops = &pidns_operations;
 
 	refcount_set(&ns->ns.count, 1);
@@ -110,8 +112,14 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
 
+	err = namespacefs_create_pid_ns_dir(ns);
+	if (err)
+		goto out_free_inum;
+
 	return ns;
 
+out_free_inum:
+	ns_free_inum(&ns->ns);
 out_free_idr:
 	idr_destroy(&ns->idr);
 	kmem_cache_free(pid_ns_cachep, ns);
@@ -133,6 +141,7 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
+	namespacefs_remove_pid_ns_dir(ns);
 	ns_free_inum(&ns->ns);
 
 	idr_destroy(&ns->idr);
-- 
2.33.1

