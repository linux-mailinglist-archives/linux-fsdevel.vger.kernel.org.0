Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4351F155D70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGSOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 13:14:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgBGSOJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:14:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A52DAE0D;
        Fri,  7 Feb 2020 18:14:07 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/5] proc/sysctl: optimize proc_sys_readdir
Date:   Fri,  7 Feb 2020 10:03:02 -0800
Message-Id: <20200207180305.11092-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200207180305.11092-1-dave@stgolabs.net>
References: <20200207180305.11092-1-dave@stgolabs.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch coverts struct ctl_dir to use an llrbtree
instead of a regular rbtree such that computing nodes for
potential usable entries becomes a branchless O(1) operation,
therefore optimizing first_usable_entry(). The cost are
mainly three additional pointers: one for the root and two
for each struct ctl_node next/prev nodes, enlarging it from
32 to 48 bytes on x86-64.

Cc: mcgrof@kernel.org
Cc: keescook@chromium.org
Cc: yzaikin@google.com
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/proc/proc_sysctl.c  | 37 +++++++++++++++++++------------------
 include/linux/sysctl.h |  6 +++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d80989b6c344..5a1b3b8be16b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -111,15 +111,14 @@ static struct ctl_table *find_entry(struct ctl_table_header **phead,
 {
 	struct ctl_table_header *head;
 	struct ctl_table *entry;
-	struct rb_node *node = dir->root.rb_node;
+	struct rb_node *node = dir->root.rb_root.rb_node;
 
-	while (node)
-	{
+	while (node) {
 		struct ctl_node *ctl_node;
 		const char *procname;
 		int cmp;
 
-		ctl_node = rb_entry(node, struct ctl_node, node);
+		ctl_node = llrb_entry(node, struct ctl_node, node);
 		head = ctl_node->header;
 		entry = &head->ctl_table[ctl_node - head->node];
 		procname = entry->procname;
@@ -139,9 +138,10 @@ static struct ctl_table *find_entry(struct ctl_table_header **phead,
 
 static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
-	struct rb_node **p = &head->parent->root.rb_node;
+	struct rb_node *node = &head->node[entry - head->ctl_table].node.rb_node;
+	struct rb_node **p = &head->parent->root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
+	struct llrb_node *prev = NULL;
 	const char *name = entry->procname;
 	int namelen = strlen(name);
 
@@ -153,7 +153,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 		int cmp;
 
 		parent = *p;
-		parent_node = rb_entry(parent, struct ctl_node, node);
+		parent_node = llrb_entry(parent, struct ctl_node, node);
 		parent_head = parent_node->header;
 		parent_entry = &parent_head->ctl_table[parent_node - parent_head->node];
 		parent_name = parent_entry->procname;
@@ -161,9 +161,10 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 		cmp = namecmp(name, namelen, parent_name, strlen(parent_name));
 		if (cmp < 0)
 			p = &(*p)->rb_left;
-		else if (cmp > 0)
+		else if (cmp > 0) {
+			prev = llrb_from_rb(parent);
 			p = &(*p)->rb_right;
-		else {
+		} else {
 			pr_err("sysctl duplicate entry: ");
 			sysctl_print_dir(head->parent);
 			pr_cont("/%s\n", entry->procname);
@@ -172,15 +173,15 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 	}
 
 	rb_link_node(node, parent, p);
-	rb_insert_color(node, &head->parent->root);
+	llrb_insert(&head->parent->root, llrb_from_rb(node), prev);
 	return 0;
 }
 
 static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 {
-	struct rb_node *node = &head->node[entry - head->ctl_table].node;
+	struct llrb_node *node = &head->node[entry - head->ctl_table].node;
 
-	rb_erase(node, &head->parent->root);
+	llrb_erase(node, &head->parent->root);
 }
 
 static void init_header(struct ctl_table_header *head,
@@ -223,7 +224,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 	/* Am I creating a permanently empty directory? */
 	if (header->ctl_table == sysctl_mount_point) {
-		if (!RB_EMPTY_ROOT(&dir->root))
+		if (!RB_EMPTY_ROOT(&dir->root.rb_root))
 			return -EINVAL;
 		set_empty_dir(dir);
 	}
@@ -381,11 +382,11 @@ static struct ctl_table *lookup_entry(struct ctl_table_header **phead,
 	return entry;
 }
 
-static struct ctl_node *first_usable_entry(struct rb_node *node)
+static struct ctl_node *first_usable_entry(struct llrb_node *node)
 {
 	struct ctl_node *ctl_node;
 
-	for (;node; node = rb_next(node)) {
+	for (; node; node = llrb_next(node)) {
 		ctl_node = rb_entry(node, struct ctl_node, node);
 		if (use_table(ctl_node->header))
 			return ctl_node;
@@ -401,7 +402,7 @@ static void first_entry(struct ctl_dir *dir,
 	struct ctl_node *ctl_node;
 
 	spin_lock(&sysctl_lock);
-	ctl_node = first_usable_entry(rb_first(&dir->root));
+	ctl_node = first_usable_entry(llrb_first(&dir->root));
 	spin_unlock(&sysctl_lock);
 	if (ctl_node) {
 		head = ctl_node->header;
@@ -420,7 +421,7 @@ static void next_entry(struct ctl_table_header **phead, struct ctl_table **pentr
 	spin_lock(&sysctl_lock);
 	unuse_table(head);
 
-	ctl_node = first_usable_entry(rb_next(&ctl_node->node));
+	ctl_node = first_usable_entry(llrb_next(&ctl_node->node));
 	spin_unlock(&sysctl_lock);
 	head = NULL;
 	if (ctl_node) {
@@ -1711,7 +1712,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 
 void retire_sysctl_set(struct ctl_table_set *set)
 {
-	WARN_ON(!RB_EMPTY_ROOT(&set->dir.root));
+	WARN_ON(!RB_EMPTY_ROOT(&set->dir.root.rb_root));
 }
 
 int __init proc_sys_init(void)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa84493f23..afb35fa61b91 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -25,7 +25,7 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
-#include <linux/rbtree.h>
+#include <linux/ll_rbtree.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/sysctl.h>
 
@@ -133,7 +133,7 @@ struct ctl_table {
 } __randomize_layout;
 
 struct ctl_node {
-	struct rb_node node;
+	struct llrb_node node;
 	struct ctl_table_header *header;
 };
 
@@ -161,7 +161,7 @@ struct ctl_table_header {
 struct ctl_dir {
 	/* Header must be at the start of ctl_dir */
 	struct ctl_table_header header;
-	struct rb_root root;
+	struct llrb_root root;
 };
 
 struct ctl_table_set {
-- 
2.16.4

