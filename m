Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC3137220
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgAJQDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgAJQDl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:03:41 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162F420838;
        Fri, 10 Jan 2020 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672218;
        bh=swIbU59wYKHZKq/XoVWioFppo5z6wnJBiOZ6INl5MXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSCfpTGp/0Af1goV7PASluFNKLIXMVsbvbyTkZZekhsMHtu/0Qs5NLlFOwd/NlfDO
         NzAd2TOzKUHb8lRecFcJIMbdIinv9IJzLRrIqQPei4v0GEKTZcQLTKo6CFHZrvyw+M
         5RjNFP8m3SE+FrPWWjqihYoFzMJH6hNn0z1cez2g=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/22] bootconfig: Add Extra Boot Config support
Date:   Sat, 11 Jan 2020 01:03:32 +0900
Message-Id: <157867221257.17873.1775090991929862549.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extra Boot Config (XBC) allows admin to pass a tree-structured
boot configuration file when boot up the kernel. This extends
the kernel command line in an efficient way.

Boot config will contain some key-value commands, e.g.

key.word = value1
another.key.word = value2

It can fold same keys with braces, also you can write array
data. For example,

key {
   word1 {
      setting1 = data
      setting2
   }
   word2.array = "val1", "val2"
}

User can access these key-value pair and tree structure via
SKC APIs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Remove "!!" from xbc_node_is_value().
  - Redefine xbc_node_is_key() as "!xbc_node_is_value()".
  - Fix a memory leak and a bug in __xbc_parse_value() (Thanks Steve!).
  - Add xbc_destroy_all() to clean up the parsed data.
  - Fix to treat comment right after value as a newline.
 Changes in v5:
  - Fix help comment and indent (Thanks Randy!)
  - Restrict available characters in values (only printables and spaces.)
  - Drop "escape" backslash support.
 Changes in v4:
  - Rename suppremental kernel command line to extended boot.
    config so that easy to understand what it is.
  - Clean up given data if failed to parse it.
  - Add comment support (start with #)
  - Return -ENOENT if given data has no node.
  - Ensure the key max depth and keylen are under limitation.
  - Add single quotes support.
  - Allow newline and closing brace to terminate key-value.
  - Add xbc_node_compose_key_after().
  - Move kconfig to generic setup.
  - Expand the max number of node to 1024.
---
 MAINTAINERS                |    6 
 include/linux/bootconfig.h |  224 ++++++++++++
 init/Kconfig               |   11 +
 lib/Kconfig                |    3 
 lib/Makefile               |    2 
 lib/bootconfig.c           |  803 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1049 insertions(+)
 create mode 100644 include/linux/bootconfig.h
 create mode 100644 lib/bootconfig.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..1ef065234cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15773,6 +15773,12 @@ W:	http://www.stlinux.com
 S:	Supported
 F:	drivers/net/ethernet/stmicro/stmmac/
 
+EXTRA BOOT CONFIG
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+S:	Maintained
+F:	lib/bootconfig.c
+F:	include/linux/bootconfig.h
+
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>
 W:	http://sammy.net/sun3/
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
new file mode 100644
index 000000000000..7e18c939663e
--- /dev/null
+++ b/include/linux/bootconfig.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_XBC_H
+#define _LINUX_XBC_H
+/*
+ * Extra Boot Config
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+/* XBC tree node */
+struct xbc_node {
+	u16 next;
+	u16 child;
+	u16 parent;
+	u16 data;
+} __attribute__ ((__packed__));
+
+#define XBC_KEY		0
+#define XBC_VALUE	(1 << 15)
+/* Maximum size of boot config is 32KB - 1 */
+#define XBC_DATA_MAX	(XBC_VALUE - 1)
+
+#define XBC_NODE_MAX	1024
+#define XBC_KEYLEN_MAX	256
+#define XBC_DEPTH_MAX	16
+
+/* Node tree access raw APIs */
+struct xbc_node * __init xbc_root_node(void);
+int __init xbc_node_index(struct xbc_node *node);
+struct xbc_node * __init xbc_node_get_parent(struct xbc_node *node);
+struct xbc_node * __init xbc_node_get_child(struct xbc_node *node);
+struct xbc_node * __init xbc_node_get_next(struct xbc_node *node);
+const char * __init xbc_node_get_data(struct xbc_node *node);
+
+/**
+ * xbc_node_is_value() - Test the node is a value node
+ * @node: An XBC node.
+ *
+ * Test the @node is a value node and return true if a value node, false if not.
+ */
+static inline __init bool xbc_node_is_value(struct xbc_node *node)
+{
+	return node->data & XBC_VALUE;
+}
+
+/**
+ * xbc_node_is_key() - Test the node is a key node
+ * @node: An XBC node.
+ *
+ * Test the @node is a key node and return true if a key node, false if not.
+ */
+static inline __init bool xbc_node_is_key(struct xbc_node *node)
+{
+	return !xbc_node_is_value(node);
+}
+
+/**
+ * xbc_node_is_array() - Test the node is an arraied value node
+ * @node: An XBC node.
+ *
+ * Test the @node is an arraied value node.
+ */
+static inline __init bool xbc_node_is_array(struct xbc_node *node)
+{
+	return xbc_node_is_value(node) && node->next != 0;
+}
+
+/**
+ * xbc_node_is_leaf() - Test the node is a leaf key node
+ * @node: An XBC node.
+ *
+ * Test the @node is a leaf key node which is a key node and has a value node
+ * or no child. Returns true if it is a leaf node, or false if not.
+ */
+static inline __init bool xbc_node_is_leaf(struct xbc_node *node)
+{
+	return xbc_node_is_key(node) &&
+		(!node->child || xbc_node_is_value(xbc_node_get_child(node)));
+}
+
+/* Tree-based key-value access APIs */
+struct xbc_node * __init xbc_node_find_child(struct xbc_node *parent,
+					     const char *key);
+
+const char * __init xbc_node_find_value(struct xbc_node *parent,
+					const char *key,
+					struct xbc_node **vnode);
+
+struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
+						 struct xbc_node *leaf);
+
+const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
+						 struct xbc_node **leaf);
+
+/**
+ * xbc_find_value() - Find a value which matches the key
+ * @key: Search key
+ * @vnode: A container pointer of XBC value node.
+ *
+ * Search a value whose key matches @key from whole of XBC tree and return
+ * the value if found. Found value node is stored in *@vnode.
+ * Note that this can return 0-length string and store NULL in *@vnode for
+ * key-only (non-value) entry.
+ */
+static inline const char * __init
+xbc_find_value(const char *key, struct xbc_node **vnode)
+{
+	return xbc_node_find_value(NULL, key, vnode);
+}
+
+/**
+ * xbc_find_node() - Find a node which matches the key
+ * @key: Search key
+ *
+ * Search a (key) node whose key matches @key from whole of XBC tree and
+ * return the node if found. If not found, returns NULL.
+ */
+static inline struct xbc_node * __init xbc_find_node(const char *key)
+{
+	return xbc_node_find_child(NULL, key);
+}
+
+/**
+ * xbc_array_for_each_value() - Iterate value nodes on an array
+ * @anode: An XBC arraied value node
+ * @value: A value
+ *
+ * Iterate array value nodes and values starts from @anode. This is expected to
+ * be used with xbc_find_value() and xbc_node_find_value(), so that user can
+ * process each array entry node.
+ */
+#define xbc_array_for_each_value(anode, value)				\
+	for (value = xbc_node_get_data(anode); anode != NULL ;		\
+	     anode = xbc_node_get_next(anode),				\
+	     value = anode ? xbc_node_get_data(anode) : NULL)
+
+/**
+ * xbc_node_for_each_child() - Iterate child nodes
+ * @parent: An XBC node.
+ * @child: Iterated XBC node.
+ *
+ * Iterate child nodes of @parent. Each child nodes are stored to @child.
+ */
+#define xbc_node_for_each_child(parent, child)				\
+	for (child = xbc_node_get_child(parent); child != NULL ;	\
+	     child = xbc_node_get_next(child))
+
+/**
+ * xbc_node_for_each_array_value() - Iterate array entries of geven key
+ * @node: An XBC node.
+ * @key: A key string searched under @node
+ * @anode: Iterated XBC node of array entry.
+ * @value: Iterated value of array entry.
+ *
+ * Iterate array entries of given @key under @node. Each array entry node
+ * is stroed to @anode and @value. If the @node doesn't have @key node,
+ * it does nothing.
+ * Note that even if the found key node has only one value (not array)
+ * this executes block once. Hoever, if the found key node has no value
+ * (key-only node), this does nothing. So don't use this for testing the
+ * key-value pair existence.
+ */
+#define xbc_node_for_each_array_value(node, key, anode, value)		\
+	for (value = xbc_node_find_value(node, key, &anode); value != NULL; \
+	     anode = xbc_node_get_next(anode),				\
+	     value = anode ? xbc_node_get_data(anode) : NULL)
+
+/**
+ * xbc_node_for_each_key_value() - Iterate key-value pairs under a node
+ * @node: An XBC node.
+ * @knode: Iterated key node
+ * @value: Iterated value string
+ *
+ * Iterate key-value pairs under @node. Each key node and value string are
+ * stored in @knode and @value respectively.
+ */
+#define xbc_node_for_each_key_value(node, knode, value)			\
+	for (knode = NULL, value = xbc_node_find_next_key_value(node, &knode);\
+	     knode != NULL; value = xbc_node_find_next_key_value(node, &knode))
+
+/**
+ * xbc_for_each_key_value() - Iterate key-value pairs
+ * @knode: Iterated key node
+ * @value: Iterated value string
+ *
+ * Iterate key-value pairs in whole XBC tree. Each key node and value string
+ * are stored in @knode and @value respectively.
+ */
+#define xbc_for_each_key_value(knode, value)				\
+	xbc_node_for_each_key_value(NULL, knode, value)
+
+/* Compose partial key */
+int __init xbc_node_compose_key_after(struct xbc_node *root,
+			struct xbc_node *node, char *buf, size_t size);
+
+/**
+ * xbc_node_compose_key() - Compose full key string of the XBC node
+ * @node: An XBC node.
+ * @buf: A buffer to store the key.
+ * @size: The size of the @buf.
+ *
+ * Compose the full-length key of the @node into @buf. Returns the total
+ * length of the key stored in @buf. Or returns -EINVAL if @node is NULL,
+ * and -ERANGE if the key depth is deeper than max depth.
+ */
+static inline int __init xbc_node_compose_key(struct xbc_node *node,
+					      char *buf, size_t size)
+{
+	return xbc_node_compose_key_after(NULL, node, buf, size);
+}
+
+/* XBC node initializer */
+int __init xbc_init(char *buf);
+
+/* XBC cleanup data structures */
+void __init xbc_destroy_all(void);
+
+/* Debug dump functions */
+void __init xbc_debug_dump(void);
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index a34064a031a5..63450d3bbf12 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1215,6 +1215,17 @@ source "usr/Kconfig"
 
 endif
 
+config BOOT_CONFIG
+	bool "Boot config support"
+	select LIBXBC
+	default y
+	help
+	  Extra boot config allows system admin to pass a config file as
+	  complemental extension of kernel cmdline when booting.
+	  The boot config file is usually attached at the end of initramfs.
+
+	  If unsure, say Y.
+
 choice
 	prompt "Compiler optimization level"
 	default CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/lib/Kconfig b/lib/Kconfig
index 6e790dc55c5b..10012b646009 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -566,6 +566,9 @@ config DIMLIB
 config LIBFDT
 	bool
 
+config LIBXBC
+	bool
+
 config OID_REGISTRY
 	tristate
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 93217d44237f..75a64d2552a2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -228,6 +228,8 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
+lib-$(CONFIG_LIBXBC) += bootconfig.o
+
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
new file mode 100644
index 000000000000..055014e233a5
--- /dev/null
+++ b/lib/bootconfig.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extra Boot Config
+ * Masami Hiramatsu <mhiramat@kernel.org>
+ */
+
+#define pr_fmt(fmt)    "bootconfig: " fmt
+
+#include <linux/bug.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/bootconfig.h>
+#include <linux/string.h>
+
+/*
+ * Extra Boot Config (XBC) is given as tree-structured ascii text of
+ * key-value pairs on memory.
+ * xbc_parse() parses the text to build a simple tree. Each tree node is
+ * simply a key word or a value. A key node may have a next key node or/and
+ * a child node (both key and value). A value node may have a next value
+ * node (for array).
+ */
+
+static struct xbc_node xbc_nodes[XBC_NODE_MAX] __initdata;
+static int xbc_node_num __initdata;
+static char *xbc_data __initdata;
+static size_t xbc_data_size __initdata;
+static struct xbc_node *last_parent __initdata;
+
+static int __init xbc_parse_error(const char *msg, const char *p)
+{
+	int pos = p - xbc_data;
+
+	pr_err("Parse error at pos %d: %s\n", pos, msg);
+	return -EINVAL;
+}
+
+/**
+ * xbc_root_node() - Get the root node of extended boot config
+ *
+ * Return the address of root node of extended boot config. If the
+ * extended boot config is not initiized, return NULL.
+ */
+struct xbc_node * __init xbc_root_node(void)
+{
+	if (unlikely(!xbc_data))
+		return NULL;
+
+	return xbc_nodes;
+}
+
+/**
+ * xbc_node_index() - Get the index of XBC node
+ * @node: A target node of getting index.
+ *
+ * Return the index number of @node in XBC node list.
+ */
+int __init xbc_node_index(struct xbc_node *node)
+{
+	return node - &xbc_nodes[0];
+}
+
+/**
+ * xbc_node_get_parent() - Get the parent XBC node
+ * @node: An XBC node.
+ *
+ * Return the parent node of @node. If the node is top node of the tree,
+ * return NULL.
+ */
+struct xbc_node * __init xbc_node_get_parent(struct xbc_node *node)
+{
+	return node->parent == XBC_NODE_MAX ? NULL : &xbc_nodes[node->parent];
+}
+
+/**
+ * xbc_node_get_child() - Get the child XBC node
+ * @node: An XBC node.
+ *
+ * Return the first child node of @node. If the node has no child, return
+ * NULL.
+ */
+struct xbc_node * __init xbc_node_get_child(struct xbc_node *node)
+{
+	return node->child ? &xbc_nodes[node->child] : NULL;
+}
+
+/**
+ * xbc_node_get_next() - Get the next sibling XBC node
+ * @node: An XBC node.
+ *
+ * Return the NEXT sibling node of @node. If the node has no next sibling,
+ * return NULL. Note that even if this returns NULL, it doesn't mean @node
+ * has no siblings. (You also has to check whether the parent's child node
+ * is @node or not.)
+ */
+struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
+{
+	return node->next ? &xbc_nodes[node->next] : NULL;
+}
+
+/**
+ * xbc_node_get_data() - Get the data of XBC node
+ * @node: An XBC node.
+ *
+ * Return the data (which is always a null terminated string) of @node.
+ * If the node has invalid data, warn and return NULL.
+ */
+const char * __init xbc_node_get_data(struct xbc_node *node)
+{
+	int offset = node->data & ~XBC_VALUE;
+
+	if (WARN_ON(offset >= xbc_data_size))
+		return NULL;
+
+	return xbc_data + offset;
+}
+
+static bool __init
+xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
+{
+	const char *p = xbc_node_get_data(node);
+	int len = strlen(p);
+
+	if (strncmp(*prefix, p, len))
+		return false;
+
+	p = *prefix + len;
+	if (*p == '.')
+		p++;
+	else if (*p != '\0')
+		return false;
+	*prefix = p;
+
+	return true;
+}
+
+/**
+ * xbc_node_find_child() - Find a child node which matches given key
+ * @parent: An XBC node.
+ * @key: A key string.
+ *
+ * Search a node under @parent which matches @key. The @key can contain
+ * several words jointed with '.'. If @parent is NULL, this searches the
+ * node from whole tree. Return NULL if no node is matched.
+ */
+struct xbc_node * __init
+xbc_node_find_child(struct xbc_node *parent, const char *key)
+{
+	struct xbc_node *node;
+
+	if (parent)
+		node = xbc_node_get_child(parent);
+	else
+		node = xbc_root_node();
+
+	while (node && xbc_node_is_key(node)) {
+		if (!xbc_node_match_prefix(node, &key))
+			node = xbc_node_get_next(node);
+		else if (*key != '\0')
+			node = xbc_node_get_child(node);
+		else
+			break;
+	}
+
+	return node;
+}
+
+/**
+ * xbc_node_find_value() - Find a value node which matches given key
+ * @parent: An XBC node.
+ * @key: A key string.
+ * @vnode: A container pointer of found XBC node.
+ *
+ * Search a value node under @parent whose (parent) key node matches @key,
+ * store it in *@vnode, and returns the value string.
+ * The @key can contain several words jointed with '.'. If @parent is NULL,
+ * this searches the node from whole tree. Return the value string if a
+ * matched key found, return NULL if no node is matched.
+ * Note that this returns 0-length string and stores NULL in *@vnode if the
+ * key has no value. And also it will return the value of the first entry if
+ * the value is an array.
+ */
+const char * __init
+xbc_node_find_value(struct xbc_node *parent, const char *key,
+		    struct xbc_node **vnode)
+{
+	struct xbc_node *node = xbc_node_find_child(parent, key);
+
+	if (!node || !xbc_node_is_key(node))
+		return NULL;
+
+	node = xbc_node_get_child(node);
+	if (node && !xbc_node_is_value(node))
+		return NULL;
+
+	if (vnode)
+		*vnode = node;
+
+	return node ? xbc_node_get_data(node) : "";
+}
+
+/**
+ * xbc_node_compose_key_after() - Compose partial key string of the XBC node
+ * @root: Root XBC node
+ * @node: Target XBC node.
+ * @buf: A buffer to store the key.
+ * @size: The size of the @buf.
+ *
+ * Compose the partial key of the @node into @buf, which is starting right
+ * after @root (@root is not included.) If @root is NULL, this returns full
+ * key words of @node.
+ * Returns the total length of the key stored in @buf. Returns -EINVAL
+ * if @node is NULL or @root is not the ancestor of @node or @root is @node,
+ * or returns -ERANGE if the key depth is deeper than max depth.
+ * This is expected to be used with xbc_find_node() to list up all (child)
+ * keys under given key.
+ */
+int __init xbc_node_compose_key_after(struct xbc_node *root,
+				      struct xbc_node *node,
+				      char *buf, size_t size)
+{
+	u16 keys[XBC_DEPTH_MAX];
+	int depth = 0, ret = 0, total = 0;
+
+	if (!node || node == root)
+		return -EINVAL;
+
+	if (xbc_node_is_value(node))
+		node = xbc_node_get_parent(node);
+
+	while (node && node != root) {
+		keys[depth++] = xbc_node_index(node);
+		if (depth == XBC_DEPTH_MAX)
+			return -ERANGE;
+		node = xbc_node_get_parent(node);
+	}
+	if (!node && root)
+		return -EINVAL;
+
+	while (--depth >= 0) {
+		node = xbc_nodes + keys[depth];
+		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
+			       depth ? "." : "");
+		if (ret < 0)
+			return ret;
+		if (ret > size) {
+			size = 0;
+		} else {
+			size -= ret;
+			buf += ret;
+		}
+		total += ret;
+	}
+
+	return total;
+}
+
+/**
+ * xbc_node_find_next_leaf() - Find the next leaf node under given node
+ * @root: An XBC root node
+ * @node: An XBC node which starts from.
+ *
+ * Search the next leaf node (which means the terminal key node) of @node
+ * under @root node (including @root node itself).
+ * Return the next node or NULL if next leaf node is not found.
+ */
+struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
+						 struct xbc_node *node)
+{
+	if (unlikely(!xbc_data))
+		return NULL;
+
+	if (!node) {	/* First try */
+		node = root;
+		if (!node)
+			node = xbc_nodes;
+	} else {
+		if (node == root)	/* @root was a leaf, no child node. */
+			return NULL;
+
+		while (!node->next) {
+			node = xbc_node_get_parent(node);
+			if (node == root)
+				return NULL;
+			/* User passed a node which is not uder parent */
+			if (WARN_ON(!node))
+				return NULL;
+		}
+		node = xbc_node_get_next(node);
+	}
+
+	while (node && !xbc_node_is_leaf(node))
+		node = xbc_node_get_child(node);
+
+	return node;
+}
+
+/**
+ * xbc_node_find_next_key_value() - Find the next key-value pair nodes
+ * @root: An XBC root node
+ * @leaf: A container pointer of XBC node which starts from.
+ *
+ * Search the next leaf node (which means the terminal key node) of *@leaf
+ * under @root node. Returns the value and update *@leaf if next leaf node
+ * is found, or NULL if no next leaf node is found.
+ * Note that this returns 0-length string if the key has no value, or
+ * the value of the first entry if the value is an array.
+ */
+const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
+						 struct xbc_node **leaf)
+{
+	/* tip must be passed */
+	if (WARN_ON(!leaf))
+		return NULL;
+
+	*leaf = xbc_node_find_next_leaf(root, *leaf);
+	if (!*leaf)
+		return NULL;
+	if ((*leaf)->child)
+		return xbc_node_get_data(xbc_node_get_child(*leaf));
+	else
+		return "";	/* No value key */
+}
+
+/* XBC parse and tree build */
+
+static struct xbc_node * __init xbc_add_node(char *data, u32 flag)
+{
+	struct xbc_node *node;
+	unsigned long offset;
+
+	if (xbc_node_num == XBC_NODE_MAX)
+		return NULL;
+
+	node = &xbc_nodes[xbc_node_num++];
+	offset = data - xbc_data;
+	node->data = (u16)offset;
+	if (WARN_ON(offset >= XBC_DATA_MAX))
+		return NULL;
+	node->data |= flag;
+	node->child = 0;
+	node->next = 0;
+
+	return node;
+}
+
+static inline __init struct xbc_node *xbc_last_sibling(struct xbc_node *node)
+{
+	while (node->next)
+		node = xbc_node_get_next(node);
+
+	return node;
+}
+
+static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+{
+	struct xbc_node *sib, *node = xbc_add_node(data, flag);
+
+	if (node) {
+		if (!last_parent) {
+			node->parent = XBC_NODE_MAX;
+			sib = xbc_last_sibling(xbc_nodes);
+			sib->next = xbc_node_index(node);
+		} else {
+			node->parent = xbc_node_index(last_parent);
+			if (!last_parent->child) {
+				last_parent->child = xbc_node_index(node);
+			} else {
+				sib = xbc_node_get_child(last_parent);
+				sib = xbc_last_sibling(sib);
+				sib->next = xbc_node_index(node);
+			}
+		}
+	}
+
+	return node;
+}
+
+static inline __init struct xbc_node *xbc_add_child(char *data, u32 flag)
+{
+	struct xbc_node *node = xbc_add_sibling(data, flag);
+
+	if (node)
+		last_parent = node;
+
+	return node;
+}
+
+static inline __init bool xbc_valid_keyword(char *key)
+{
+	if (key[0] == '\0')
+		return false;
+
+	while (isalnum(*key) || *key == '-' || *key == '_')
+		key++;
+
+	return *key == '\0';
+}
+
+static char *skip_comment(char *p)
+{
+	char *ret;
+
+	ret = strchr(p, '\n');
+	if (!ret)
+		ret = p + strlen(p);
+	else
+		ret++;
+
+	return ret;
+}
+
+static char *skip_spaces_until_newline(char *p)
+{
+	while (isspace(*p) && *p != '\n')
+		p++;
+	return p;
+}
+
+static int __init __xbc_open_brace(void)
+{
+	/* Mark the last key as open brace */
+	last_parent->next = XBC_NODE_MAX;
+
+	return 0;
+}
+
+static int __init __xbc_close_brace(char *p)
+{
+	struct xbc_node *node;
+
+	if (!last_parent || last_parent->next != XBC_NODE_MAX)
+		return xbc_parse_error("Unexpected closing brace", p);
+
+	node = last_parent;
+	node->next = 0;
+	do {
+		node = xbc_node_get_parent(node);
+	} while (node && node->next != XBC_NODE_MAX);
+	last_parent = node;
+
+	return 0;
+}
+
+/*
+ * Return delimiter or error, no node added. As same as lib/cmdline.c,
+ * you can use " around spaces, but can't escape " for value.
+ */
+static int __init __xbc_parse_value(char **__v, char **__n)
+{
+	char *p, *v = *__v;
+	int c, quotes = 0;
+
+	v = skip_spaces(v);
+	while (*v == '#') {
+		v = skip_comment(v);
+		v = skip_spaces(v);
+	}
+	if (*v == '"' || *v == '\'') {
+		quotes = *v;
+		v++;
+	}
+	p = v - 1;
+	while ((c = *++p)) {
+		if (!isprint(c) && !isspace(c))
+			return xbc_parse_error("Non printable value", p);
+		if (quotes) {
+			if (c != quotes)
+				continue;
+			quotes = 0;
+			*p++ = '\0';
+			p = skip_spaces_until_newline(p);
+			c = *p;
+			if (c && !strchr(",;\n#}", c))
+				return xbc_parse_error("No value delimiter", p);
+			if (*p)
+				p++;
+			break;
+		}
+		if (strchr(",;\n#}", c)) {
+			v = strim(v);
+			*p++ = '\0';
+			break;
+		}
+	}
+	if (quotes)
+		return xbc_parse_error("No closing quotes", p);
+	if (c == '#') {
+		p = skip_comment(p);
+		c = '\n';	/* A comment must be treated as a newline */
+	}
+	*__n = p;
+	*__v = v;
+
+	return c;
+}
+
+static int __init xbc_parse_array(char **__v)
+{
+	struct xbc_node *node;
+	char *next;
+	int c = 0;
+
+	do {
+		c = __xbc_parse_value(__v, &next);
+		if (c < 0)
+			return c;
+
+		node = xbc_add_sibling(*__v, XBC_VALUE);
+		if (!node)
+			return -ENOMEM;
+		*__v = next;
+	} while (c == ',');
+	node->next = 0;
+
+	return c;
+}
+
+static inline __init
+struct xbc_node *find_match_node(struct xbc_node *node, char *k)
+{
+	while (node) {
+		if (!strcmp(xbc_node_get_data(node), k))
+			break;
+		node = xbc_node_get_next(node);
+	}
+	return node;
+}
+
+static int __init __xbc_add_key(char *k)
+{
+	struct xbc_node *node;
+
+	if (!xbc_valid_keyword(k))
+		return xbc_parse_error("Invalid keyword", k);
+
+	if (unlikely(xbc_node_num == 0))
+		goto add_node;
+
+	if (!last_parent)	/* the first level */
+		node = find_match_node(xbc_nodes, k);
+	else
+		node = find_match_node(xbc_node_get_child(last_parent), k);
+
+	if (node)
+		last_parent = node;
+	else {
+add_node:
+		node = xbc_add_child(k, XBC_KEY);
+		if (!node)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static int __init __xbc_parse_keys(char *k)
+{
+	char *p;
+	int ret;
+
+	k = strim(k);
+	while ((p = strchr(k, '.'))) {
+		*p++ = '\0';
+		ret = __xbc_add_key(k);
+		if (ret)
+			return ret;
+		k = p;
+	}
+
+	return __xbc_add_key(k);
+}
+
+static int __init xbc_parse_kv(char **k, char *v)
+{
+	struct xbc_node *prev_parent = last_parent;
+	struct xbc_node *node;
+	char *next;
+	int c, ret;
+
+	ret = __xbc_parse_keys(*k);
+	if (ret)
+		return ret;
+
+	c = __xbc_parse_value(&v, &next);
+	if (c < 0)
+		return c;
+
+	node = xbc_add_sibling(v, XBC_VALUE);
+	if (!node)
+		return -ENOMEM;
+
+	if (c == ',') {	/* Array */
+		c = xbc_parse_array(&next);
+		if (c < 0)
+			return c;
+	}
+
+	last_parent = prev_parent;
+
+	if (c == '}') {
+		ret = __xbc_close_brace(next - 1);
+		if (ret < 0)
+			return ret;
+	}
+
+	*k = next;
+
+	return 0;
+}
+
+static int __init xbc_parse_key(char **k, char *n)
+{
+	struct xbc_node *prev_parent = last_parent;
+	int ret;
+
+	*k = strim(*k);
+	if (**k != '\0') {
+		ret = __xbc_parse_keys(*k);
+		if (ret)
+			return ret;
+		last_parent = prev_parent;
+	}
+	*k = n;
+
+	return 0;
+}
+
+static int __init xbc_open_brace(char **k, char *n)
+{
+	int ret;
+
+	ret = __xbc_parse_keys(*k);
+	if (ret)
+		return ret;
+	*k = n;
+
+	return __xbc_open_brace();
+}
+
+static int __init xbc_close_brace(char **k, char *n)
+{
+	int ret;
+
+	ret = xbc_parse_key(k, n);
+	if (ret)
+		return ret;
+	/* k is updated in xbc_parse_key() */
+
+	return __xbc_close_brace(n - 1);
+}
+
+static int __init xbc_verify_tree(void)
+{
+	int i, depth, len, wlen;
+	struct xbc_node *n, *m;
+
+	/* Empty tree */
+	if (xbc_node_num == 0)
+		return -ENOENT;
+
+	for (i = 0; i < xbc_node_num; i++) {
+		if (xbc_nodes[i].next > xbc_node_num) {
+			return xbc_parse_error("No closing brace",
+				xbc_node_get_data(xbc_nodes + i));
+		}
+	}
+
+	/* Key tree limitation check */
+	n = &xbc_nodes[0];
+	depth = 1;
+	len = 0;
+
+	while (n) {
+		wlen = strlen(xbc_node_get_data(n)) + 1;
+		len += wlen;
+		if (len > XBC_KEYLEN_MAX)
+			return xbc_parse_error("Too long key length",
+				xbc_node_get_data(n));
+
+		m = xbc_node_get_child(n);
+		if (m && xbc_node_is_key(m)) {
+			n = m;
+			depth++;
+			if (depth > XBC_DEPTH_MAX)
+				return xbc_parse_error("Too many key words",
+						xbc_node_get_data(n));
+			continue;
+		}
+		len -= wlen;
+		m = xbc_node_get_next(n);
+		while (!m) {
+			n = xbc_node_get_parent(n);
+			if (!n)
+				break;
+			len -= strlen(xbc_node_get_data(n)) + 1;
+			depth--;
+			m = xbc_node_get_next(n);
+		}
+		n = m;
+	}
+
+	return 0;
+}
+
+/**
+ * xbc_destroy_all() - Clean up all parsed bootconfig
+ *
+ * This clears all data structures of parsed bootconfig on memory.
+ * If you need to reuse xbc_init() with new boot config, you can
+ * use this.
+ */
+void __init xbc_destroy_all(void)
+{
+	xbc_data = NULL;
+	xbc_data_size = 0;
+	xbc_node_num = 0;
+	memset(xbc_nodes, 0, sizeof(xbc_nodes));
+}
+
+/**
+ * xbc_init() - Parse given XBC file and build XBC internal tree
+ * @buf: boot config text
+ *
+ * This parses the boot config text in @buf. @buf must be a
+ * null terminated string and smaller than XBC_DATA_MAX.
+ * Return 0 if succeeded, or -errno if there is any error.
+ */
+int __init xbc_init(char *buf)
+{
+	char *p, *q;
+	int ret, c;
+
+	if (xbc_data)
+		return -EBUSY;
+
+	ret = strlen(buf);
+	if (ret > XBC_DATA_MAX - 1 || ret == 0)
+		return -ERANGE;
+
+	xbc_data = buf;
+	xbc_data_size = ret + 1;
+	last_parent = NULL;
+
+	p = buf;
+	do {
+		q = strpbrk(p, "{}=;\n#");
+		if (!q) {
+			p = skip_spaces(p);
+			if (*p != '\0')
+				ret = xbc_parse_error("No delimiter", p);
+			break;
+		}
+
+		c = *q;
+		*q++ = '\0';
+		switch (c) {
+		case '=':
+			ret = xbc_parse_kv(&p, q);
+			break;
+		case '{':
+			ret = xbc_open_brace(&p, q);
+			break;
+		case '#':
+			q = skip_comment(q);
+			/* fall through */
+		case ';':
+		case '\n':
+			ret = xbc_parse_key(&p, q);
+			break;
+		case '}':
+			ret = xbc_close_brace(&p, q);
+			break;
+		}
+	} while (!ret);
+
+	if (!ret)
+		ret = xbc_verify_tree();
+
+	if (ret < 0)
+		xbc_destroy_all();
+
+	return ret;
+}
+
+/**
+ * xbc_debug_dump() - Dump current XBC node list
+ *
+ * Dump the current XBC node list on printk buffer for debug.
+ */
+void __init xbc_debug_dump(void)
+{
+	int i;
+
+	for (i = 0; i < xbc_node_num; i++) {
+		pr_debug("[%d] %s (%s) .next=%d, .child=%d .parent=%d\n", i,
+			xbc_node_get_data(xbc_nodes + i),
+			xbc_node_is_value(xbc_nodes + i) ? "value" : "key",
+			xbc_nodes[i].next, xbc_nodes[i].child,
+			xbc_nodes[i].parent);
+	}
+}

