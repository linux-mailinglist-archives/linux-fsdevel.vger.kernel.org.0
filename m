Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3445621F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhKRSQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhKRSQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:16:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B964C061574;
        Thu, 18 Nov 2021 10:13:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so30853120eda.12;
        Thu, 18 Nov 2021 10:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6mwuE2ioP3zIf0NEAQqDxkNdeNXnzy/i4Fsz7rpYK4=;
        b=Xt7JdXLB0T9hexi4YCte00Q3Ru73DwwHKLjglGmUr9LeS7IQb5SHQNUlpKdirYFXve
         mwAY9mWkBeCa2ry6W4jPLmF+4AkfWbxH6XDeP5RhybPjSoKyWXWkPN/DLFmu/ORRyoq+
         7DQVDh8BeSjLFStTgc6y+ast4/ObSw0lA0ae6xWMtHGkqUPFlHcTpoQPAhStLs1qK/qn
         0hgbo6qzA47oBANb8TrmvkJbyCNNYC+BLQKsMW9sFPYUtX02WEs7MnbG6OW0hwXlSUzQ
         054AdyX85+lRmCotJy2T8EwjNws9FVFcHE5N2CbzQL0ANYQ3VldMNziemMYMsRBnXDc9
         NaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6mwuE2ioP3zIf0NEAQqDxkNdeNXnzy/i4Fsz7rpYK4=;
        b=OWjcXXg+qHyJ43k8AqL1NLvEEKuMi4SYMSzzv94JSmVkF/YCbrUkOLz38E6//Hibq4
         mpm5/pFWg+zj+9QxjlfEqYUkytyPZdZKG3nIHffiqDAmV8qMnjVdcef/JSiAFEMjbxsZ
         3Hn3/NWz83vRic+NTeX6ETkElB9ugBBcIOD/sueOknx7a+fmMB1Zn7rOOhSNfJ1qAtCH
         lS8OQ41xqFTY6iQPs4m94eYR/WEX6Ud9TG1uo64PPNCptzNBdYOUhqYMfpDaPwjbneqb
         2AJwmNE8kLoX1CdVKUJ6pN/EPpV7Der5nPrrXGw2nWf/FLM1HRp+0vmlYubLfYFtXV4p
         lVwQ==
X-Gm-Message-State: AOAM5302mLWYFIFAOjpQ3drhpiK2jcC6yPdCT2JqVDhqWIyGSsduYr1m
        4vU9Vp76mdIzGS/uvQw8TI/VjIGPDa4=
X-Google-Smtp-Source: ABdhPJwXTqudvE9ZFphI3X7QeIfodRKvwJBdw9UDlOWvDVFV9zF+9q2yDsW8vsnBkn5FlEeqlMPhJQ==
X-Received: by 2002:a17:906:c14b:: with SMTP id dp11mr1462787ejc.294.1637259192969;
        Thu, 18 Nov 2021 10:13:12 -0800 (PST)
Received: from crow.. ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id d10sm224135eja.4.2021.11.18.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:13:12 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 4/4] namespacefs: Couple namespacefs to the UTS namespace
Date:   Thu, 18 Nov 2021 20:12:10 +0200
Message-Id: <20211118181210.281359-5-y.karadz@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the UTS namespace gets initialized, a directory called 'uts'
is added to namespacesfs. This directory represents the main UTS
namespace and also serves as a trunk (parent) of all other UTS
namespaces. Every time when a new UTS namespace is created a
corresponding directory is added to 'namespacefs/uts/'. The 'inum'
of the new namespace gives the name of its directory. When a UTS
namespace is destroyed the corresponding directory is removed. Each
directory contains a file called 'uname' that can be used to get the
unique data fields of the uts namespaces(sysname, nodename, ...).

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 fs/namespacefs/inode.c      | 57 +++++++++++++++++++++++++++++++++++++
 include/linux/namespacefs.h | 13 +++++++++
 kernel/utsname.c            |  9 ++++++
 3 files changed, 79 insertions(+)

diff --git a/fs/namespacefs/inode.c b/fs/namespacefs/inode.c
index 55d71733164c..4b661bdd4d9c 100644
--- a/fs/namespacefs/inode.c
+++ b/fs/namespacefs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/seq_file.h>
 #include <linux/pid_namespace.h>
+#include <linux/utsname.h>
 
 static struct vfsmount *namespacefs_mount;
 static int namespacefs_mount_count;
@@ -309,6 +310,58 @@ void namespacefs_remove_pid_ns_dir(struct pid_namespace *ns)
 	namespacefs_remove_dir(ns->ns.dentry);
 }
 
+#define _UNAME_N_FIELDS		6
+#define _UNAME_MAX_LEN		((__NEW_UTS_LEN + 1) * _UNAME_N_FIELDS)
+
+static ssize_t uts_ns_read(struct file *file, char __user *ubuf,
+			   size_t count, loff_t *pos)
+{
+	struct new_utsname *name = file->private_data;
+	char buff[_UNAME_MAX_LEN + 1];
+	int n;
+
+	n = snprintf(buff, _UNAME_MAX_LEN + 1,
+		     "%s %s %s %s %s %s\n",
+		     name->sysname,
+		     name->nodename,
+		     name->release,
+		     name->version,
+		     name->machine,
+		     name->domainname);
+
+	return simple_read_from_buffer(ubuf, count, pos, buff, n);
+}
+
+static const struct file_operations uts_fops = {
+	.open = simple_open,
+	.read = uts_ns_read,
+	.llseek = default_llseek,
+};
+
+int namespacefs_create_uts_ns_dir(struct uts_namespace *ns)
+{
+	struct dentry *dentry;
+	int err;
+
+	err = create_inode_dir(&ns->ns, init_uts_ns.ns.dentry, ns->user_ns);
+	if (err)
+		return err;
+
+	dentry = namespacefs_create_file("uname", ns->ns.dentry, ns->user_ns,
+					 &uts_fops, &ns->name);
+	if (IS_ERR(dentry)) {
+		dput(ns->ns.dentry);
+		return PTR_ERR(dentry);
+	}
+
+	return 0;
+}
+
+void namespacefs_remove_uts_ns_dir(struct uts_namespace *ns)
+{
+	namespacefs_remove_dir(ns->ns.dentry);
+}
+
 static int add_ns_dentry(struct ns_common *ns)
 {
 	struct dentry *dentry =
@@ -340,6 +393,10 @@ static int __init namespacefs_init(void)
 	if (err)
 		goto unreg;
 
+	err = add_ns_dentry(&init_uts_ns.ns);
+	if (err)
+		goto unreg;
+
 	return 0;
 
  unreg:
diff --git a/include/linux/namespacefs.h b/include/linux/namespacefs.h
index f41499a7635a..3815a7bbeb1c 100644
--- a/include/linux/namespacefs.h
+++ b/include/linux/namespacefs.h
@@ -21,6 +21,8 @@ namespacefs_create_dir(const char *name, struct dentry *parent,
 void namespacefs_remove_dir(struct dentry *dentry);
 int namespacefs_create_pid_ns_dir(struct pid_namespace *ns);
 void namespacefs_remove_pid_ns_dir(struct pid_namespace *ns);
+int namespacefs_create_uts_ns_dir(struct uts_namespace *ns);
+void namespacefs_remove_uts_ns_dir(struct uts_namespace *ns);
 
 #else
 
@@ -55,6 +57,17 @@ namespacefs_remove_pid_ns_dir(struct pid_namespace *ns)
 {
 }
 
+static inline int
+namespacefs_create_uts_ns_dir(struct uts_namespace *ns)
+{
+	return 0;
+}
+
+static inline void
+namespacefs_remove_uts_ns_dir(struct uts_namespace *ns)
+{
+}
+
 #endif /* CONFIG_NAMESPACE_FS */
 
 #endif
diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..d44b307cffdc 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/user_namespace.h>
+#include <linux/namespacefs.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 
@@ -70,8 +71,15 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
 	ns->user_ns = get_user_ns(user_ns);
 	up_read(&uts_sem);
+
+	err = namespacefs_create_uts_ns_dir(ns);
+	if (err)
+		goto fail_free_inum;
+
 	return ns;
 
+fail_free_inum:
+	ns_free_inum(&ns->ns);
 fail_free:
 	kmem_cache_free(uts_ns_cache, ns);
 fail_dec:
@@ -105,6 +113,7 @@ struct uts_namespace *copy_utsname(unsigned long flags,
 
 void free_uts_ns(struct uts_namespace *ns)
 {
+	namespacefs_remove_uts_ns_dir(ns);
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.33.1

