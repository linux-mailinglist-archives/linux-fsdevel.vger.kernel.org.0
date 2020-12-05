Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33922CFDCA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLESoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLEQtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:49:46 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0AC02B8F7;
        Sat,  5 Dec 2020 08:09:21 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w206so6629982wma.0;
        Sat, 05 Dec 2020 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIdqtYGUc/O3zuqryXPvn60vNDtb1cQ64k7t/DJ+pB8=;
        b=kR4bV2meb6LES9uLZV8rVWd/WreERg1nAsY1JUUFBMkK7+o1F8WiNImkRwjxSPMYa9
         Pw4jpPqCRt35i08ldfEDjXZcaKTFSkC0jg0OYAn1yM1TdPV6jgzDZyasA4fVw8myRvEs
         Q7vriLdzybjFOj9Icc+94Y9IGvfAroeshvhiAIDnC1D19YXFsdmB27V6r8nlpKQj+06T
         DU6qZL/hpnOSS16AVRKfsuAbMKnJP+aGtYMh3wfBL51jDQMvgPE+gu6z9+uwmtMCPWiZ
         rnDaoV9rd5VaDQDa+FW6uHfeDrM7ybgkwQle60DEGI/1OVFL2SoCTjdgcfUYh/lRGK5R
         NVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIdqtYGUc/O3zuqryXPvn60vNDtb1cQ64k7t/DJ+pB8=;
        b=RjuBeqAQ6ZrlhPF+jNfW04gRvR6p3NDVsXz8HIhOTeUjuE/b0BsqlyWuwvJcaQaCWP
         6cT9n1/S9xr71/Hhw3YfXT/8v5tMfFfaPjL6m3k9bJnJMMGoE//4gZYGIHP7y2d9t9sx
         88ao4q5wJULeVM/BXlza9iO/qltg73X3g7WFgWsxk64OMX74x+GJrRiy1ofLTLmttdju
         oNHZ+sDau7ROl+8Z0Au7a5/OOkOPR3FSHNsLeutNETB5DsHJsYE2Un3HMlGAbOqiJUie
         xNlqpy3GlC4dUL7VRY9HfgpyoOMpIXmVjx/ZE/ET+PsIvHWp46089gJHxhXdui7cKzkW
         SLDQ==
X-Gm-Message-State: AOAM532mHAfkKWOl9mq8VJ2bR0aFHUVkQtMkAXDOQyEbRwI1jaMyPTtG
        gCSMX+Fg8LuOuJ0hh4ulMnWr8hCepQ==
X-Google-Smtp-Source: ABdhPJw7ZyMmN76jsgrTsrBvcCVPiexgv03RsTqsne+IoNWslPVVZc7erE5/o4vHtvgYHTgjVdBFEw==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr9897145wmg.54.1607184560362;
        Sat, 05 Dec 2020 08:09:20 -0800 (PST)
Received: from localhost.localdomain ([46.53.253.193])
        by smtp.gmail.com with ESMTPSA id u66sm7692362wmg.2.2020.12.05.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 08:09:19 -0800 (PST)
Date:   Sat, 5 Dec 2020 19:09:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tommi.t.rantala@nokia.com
Subject: [PATCH] proc: fix lookup in /proc/net subdirectories after setns(2)
Message-ID: <20201205160916.GA109739@localhost.localdomain>
References: <6de04554b27e9573e0a65170916d6acf11285dba.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6de04554b27e9573e0a65170916d6acf11285dba.camel@nokia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	commit 1fde6f21d90f8ba5da3cb9c54ca991ed72696c43
	proc: fix /proc/net/* after setns(2)

only forced revalidation of regular files under /proc/net/

However, /proc/net/ is unusual in the sense of /proc/net/foo handlers
take netns pointer from parent directory which is old netns.

Steps to reproduce:

	(void)open("/proc/net/sctp/snmp", O_RDONLY);
	unshare(CLONE_NEWNET);

	int fd = open("/proc/net/sctp/snmp", O_RDONLY);
	read(fd, &c, 1);

Read will read wrong data from original netns.

Patch forces lookup on every directory under /proc/net .

Fixes: 1da4d377f943 ("proc: revalidate misc dentries")
Reported-by: "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c       |   24 ++++++++++++++++++++++--
 fs/proc/internal.h      |    7 +++++++
 fs/proc/proc_net.c      |   16 ----------------
 include/linux/proc_fs.h |    8 +++++++-
 4 files changed, 36 insertions(+), 19 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -349,6 +349,16 @@ static const struct file_operations proc_dir_operations = {
 	.iterate_shared		= proc_readdir,
 };
 
+static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return 0;
+}
+
+const struct dentry_operations proc_net_dentry_ops = {
+	.d_revalidate	= proc_net_d_revalidate,
+	.d_delete	= always_delete_dentry,
+};
+
 /*
  * proc directories can do almost nothing..
  */
@@ -471,8 +481,8 @@ struct proc_dir_entry *proc_symlink(const char *name,
 }
 EXPORT_SYMBOL(proc_symlink);
 
-struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
-		struct proc_dir_entry *parent, void *data)
+struct proc_dir_entry *_proc_mkdir(const char *name, umode_t mode,
+		struct proc_dir_entry *parent, void *data, bool force_lookup)
 {
 	struct proc_dir_entry *ent;
 
@@ -484,10 +494,20 @@ struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
 		ent->data = data;
 		ent->proc_dir_ops = &proc_dir_operations;
 		ent->proc_iops = &proc_dir_inode_operations;
+		if (force_lookup) {
+			pde_force_lookup(ent);
+		}
 		ent = proc_register(parent, ent);
 	}
 	return ent;
 }
+EXPORT_SYMBOL_GPL(_proc_mkdir);
+
+struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
+		struct proc_dir_entry *parent, void *data)
+{
+	return _proc_mkdir(name, mode, parent, data, false);
+}
 EXPORT_SYMBOL_GPL(proc_mkdir_data);
 
 struct proc_dir_entry *proc_mkdir_mode(const char *name, umode_t mode,
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -310,3 +310,10 @@ extern unsigned long task_statm(struct mm_struct *,
 				unsigned long *, unsigned long *,
 				unsigned long *, unsigned long *);
 extern void task_mem(struct seq_file *, struct mm_struct *);
+
+extern const struct dentry_operations proc_net_dentry_ops;
+static inline void pde_force_lookup(struct proc_dir_entry *pde)
+{
+	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
+	pde->proc_dops = &proc_net_dentry_ops;
+}
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -39,22 +39,6 @@ static struct net *get_proc_net(const struct inode *inode)
 	return maybe_get_net(PDE_NET(PDE(inode)));
 }
 
-static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	return 0;
-}
-
-static const struct dentry_operations proc_net_dentry_ops = {
-	.d_revalidate	= proc_net_d_revalidate,
-	.d_delete	= always_delete_dentry,
-};
-
-static void pde_force_lookup(struct proc_dir_entry *pde)
-{
-	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
-	pde->proc_dops = &proc_net_dentry_ops;
-}
-
 static int seq_open_net(struct inode *inode, struct file *file)
 {
 	unsigned int state_size = PDE(inode)->state_size;
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -80,6 +80,7 @@ extern void proc_flush_pid(struct pid *);
 
 extern struct proc_dir_entry *proc_symlink(const char *,
 		struct proc_dir_entry *, const char *);
+struct proc_dir_entry *_proc_mkdir(const char *, umode_t, struct proc_dir_entry *, void *, bool);
 extern struct proc_dir_entry *proc_mkdir(const char *, struct proc_dir_entry *);
 extern struct proc_dir_entry *proc_mkdir_data(const char *, umode_t,
 					      struct proc_dir_entry *, void *);
@@ -162,6 +163,11 @@ static inline struct proc_dir_entry *proc_symlink(const char *name,
 static inline struct proc_dir_entry *proc_mkdir(const char *name,
 	struct proc_dir_entry *parent) {return NULL;}
 static inline struct proc_dir_entry *proc_create_mount_point(const char *name) { return NULL; }
+static inline struct proc_dir_entry *_proc_mkdir(const char *name, umode_t mode,
+		struct proc_dir_entry *parent, void *data, bool force_lookup)
+{
+	return NULL;
+}
 static inline struct proc_dir_entry *proc_mkdir_data(const char *name,
 	umode_t mode, struct proc_dir_entry *parent, void *data) { return NULL; }
 static inline struct proc_dir_entry *proc_mkdir_mode(const char *name,
@@ -199,7 +205,7 @@ struct net;
 static inline struct proc_dir_entry *proc_net_mkdir(
 	struct net *net, const char *name, struct proc_dir_entry *parent)
 {
-	return proc_mkdir_data(name, 0, parent, net);
+	return _proc_mkdir(name, 0, parent, net, true);
 }
 
 struct ns_common;
