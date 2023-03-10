Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2AC6B52D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjCJV15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C63117FFB;
        Fri, 10 Mar 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ovuiX50qxtOyMXh0JsgRX7kfHJDixjO8KnqG2nJuLwA=; b=vqcgKQtbFVB3ofI0Glkl1QG+U8
        I0FDhY3YeZ4SuIlRf4ERV3BogLvNuJtVMXdZPJ6hPCsL4t4nkRzwcKILAPUIQN/kj7yecB25IKygY
        b8WIXM7LLuPOsEvelZ1cPfOaIKLyyw2F9oGcWw13OLNa4n7U/ZqPBGC00le4JK1Pyjtt0SSDpV2Yw
        QdEcI+MUpluJcsOtCwFg8ybDPuoOziNYlzYf8wPBdC612McyD/JhqOulBEGU8dlcSk3a9/0t12Dqr
        BPjZoIz46rdMWtuU7rW/D+KZbUnZf700uTg4hCG8vu5RAkQqr8ZLIDmz1Rg2aOpxTsTfBc7QOgIw4
        t7diKJUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHF-00FR6D-27;
        Fri, 10 Mar 2023 21:27:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] kill the last remaining user of proc_ns_fget()
Date:   Fri, 10 Mar 2023 21:27:44 +0000
Message-Id: <20230310212748.3679076-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
References: <20230310212536.GX3390869@ZenIV>
 <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lookups by descriptor are better off closer to syscall surface...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nsfs.c                | 18 ------------------
 include/linux/proc_ns.h  |  1 -
 net/core/net_namespace.c | 23 +++++++++++------------
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index f8df60b3b901..f602a96a1afe 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -235,24 +235,6 @@ bool proc_ns_file(const struct file *file)
 	return file->f_op == &ns_file_operations;
 }
 
-struct file *proc_ns_fget(int fd)
-{
-	struct file *file;
-
-	file = fget(fd);
-	if (!file)
-		return ERR_PTR(-EBADF);
-
-	if (file->f_op != &ns_file_operations)
-		goto out_invalid;
-
-	return file;
-
-out_invalid:
-	fput(file);
-	return ERR_PTR(-EINVAL);
-}
-
 /**
  * ns_match() - Returns true if current namespace matches dev/ino provided.
  * @ns: current namespace
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..49539bc416ce 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -72,7 +72,6 @@ static inline int ns_alloc_inum(struct ns_common *ns)
 
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
-extern struct file *proc_ns_fget(int fd);
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
 extern int ns_get_path(struct path *path, struct task_struct *task,
 			const struct proc_ns_operations *ns_ops);
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 7b69cf882b8e..3e3598cd49f2 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
 #include <linux/cookie.h>
+#include <linux/proc_fs.h>
 
 #include <net/sock.h>
 #include <net/netlink.h>
@@ -676,21 +677,19 @@ EXPORT_SYMBOL_GPL(get_net_ns);
 
 struct net *get_net_ns_by_fd(int fd)
 {
-	struct file *file;
-	struct ns_common *ns;
-	struct net *net;
+	struct fd f = fdget(fd);
+	struct net *net = ERR_PTR(-EINVAL);
 
-	file = proc_ns_fget(fd);
-	if (IS_ERR(file))
-		return ERR_CAST(file);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
 
-	ns = get_proc_ns(file_inode(file));
-	if (ns->ops == &netns_operations)
-		net = get_net(container_of(ns, struct net, ns));
-	else
-		net = ERR_PTR(-EINVAL);
+	if (proc_ns_file(f.file)) {
+		struct ns_common *ns = get_proc_ns(file_inode(f.file));
+		if (ns->ops == &netns_operations)
+			net = get_net(container_of(ns, struct net, ns));
+	}
+	fdput(f);
 
-	fput(file);
 	return net;
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_fd);
-- 
2.30.2

