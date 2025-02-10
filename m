Return-Path: <linux-fsdevel+bounces-41359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5CDA2E384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 06:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C883A7E2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424D16ABC6;
	Mon, 10 Feb 2025 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="U+CGlf3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrA1PSGC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E2191F89;
	Mon, 10 Feb 2025 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164886; cv=none; b=cskXwGGKdmKuGZtT4XgmxO8RGddLPLZ9CWIXn+gWXDDS8cm4enkEurnQBJmUvvSgCDnAuFhQ3mD7Ok0u41qQ62MmCdBxYws6hLJWQMUfQaMSd27cq9pLt6CaKCwG8FxzP9ZX5LCGxeKgIf4lzNEDsMGJtyGnPGDmLvHCthhEogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164886; c=relaxed/simple;
	bh=jzV4MwAxxKfbEvNPHYiOR3bTvGh3RphYVCA4Bnm9tow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehW1VVSymzXk+KiZ3KQBEYTIj9erFGDba2H5NsggGnI+nTPmouwrjjfU/aUynrKbss2Wze88KzhF0mtY2PGa/DuNK4Skvt0GVbbpXCKJOAXMQXmuOvgSyoWGKnB9Pnb+F9P+s80qWzA7rw83/alc+9aQmIjHeKQHpiT+aLmf7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=U+CGlf3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrA1PSGC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38B791140198;
	Mon, 10 Feb 2025 00:21:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Feb 2025 00:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164883; x=
	1739251283; bh=M9jDqz6z9/FQtQkaPFqPQJedPGgr6ZZ+JkD5gQgDg9k=; b=U
	+CGlf3DrQiXlVkwcs8VvzPdgXg2TCA3uIvCdKBduT+bVwvsQvyxeHdOG7kxIRVYz
	QpHc0ayhXkleUTt6mlUVnyxCn8IqmI9+SYtWirwJgIteYcVXbD28/HptTudcIKat
	7BHOiutjVOz6mNFgjtARlzq4zkE3mUO2/cpoFld5g1bsNZzOSnIjtLnXOCeO4gNy
	uiSnBFcV92dVWUzVTR3DHrCJlwnkf06hif+9n+EPTvNRlX14ZxoKMDW9jvLVlPv0
	IoN74x0waI6pd6H5f2dyB61yKEGFyo7eV4fM3ZAe1nA1VN3nQybWa7bkrwVBGRAu
	zHAAvcuBX4vivNC9gv8Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164883; x=1739251283; bh=M
	9jDqz6z9/FQtQkaPFqPQJedPGgr6ZZ+JkD5gQgDg9k=; b=jrA1PSGC37JLIT4hA
	Us5SZjIqtVtb13EYHqZLta5bDkcXzo4pMhYYG4Mu0XXCWey7hp782XS5qNJ44FgQ
	Xd5nnuNeASIu5jWybDhiuICCs2qTpBlZHR8G00d7xA/KaY9cVcxf9WqDA2bjWIg3
	Iayoi/l/0pry96vqUlxpSaR3VK8j9RejV19tVcVm7Ug+embAxvgNRHcUXOvep0As
	AOKIR8zyqY/OPmXn3RPzDc9VL2+m9Y667xvRSoCJOn/5HoAV5yVOVJ5nPPW25h3p
	ZIhbpMW15lN5TIwVIQSRWb54owGW/IrAMKAUmSynFNUKJ0XTGfVo4RuirYrDPaKy
	sCCCA==
X-ME-Sender: <xms:0oypZ5IECP_uTViwdOM_lTQF_3iijBP7khAL4AOK9qAiKeTMz2QW-w>
    <xme:0oypZ1I6E-XYxDGyG1ynxahurxU5e19MDvbPWxxza1xeDEQW0ftr2x7Bw0AFFV4Mv
    s1Dxu1eJAgEM17sOg0>
X-ME-Received: <xmr:0oypZxvZjab_t69tvOeswYcnKdlCJWrQlMEIsugt-F-NdoJm82fqg3g8jwmulG4YvXcCx_Ykp1jcPgYmUNy0TgBhgp4X46zWszAFplWhE90-FMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:0oypZ6YeOy_VdbQho6Vkt94n6c6OFozdWY_3bY7VmLk1b-bAKa6CdA>
    <xmx:0oypZwb1AKt2hVWxpnSy0AVpCyNS5UCPgMANnaWtLsZZl2yZb_45hQ>
    <xmx:0oypZ-BT-kFqq_g3qoO4T6_8WXlQTFzigGB1Fu82du38KzarPVXGcQ>
    <xmx:0oypZ-aHDgSE2XaHFGByzhQVsVk-h0ndld-hxnN7lpzw86V4ENvtWg>
    <xmx:04ypZ9TURkREWgJIurjCWgcfGNWUTGaKtrgiP-Pd-c0Eb9nXgcLQ7RGN>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:21 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] relay: Replace dentry with debugfs_node
Date: Sun,  9 Feb 2025 21:20:23 -0800
Message-ID: <20250210052039.144513-4-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the relay documentation suggests support for multiple filesystems,
in practice all existing users rely on debugfs. This commit updates the
relay API and documentation to use debugfs_node instead of dentry, making
the subsequent migration of relay users to debugfs_node smoother.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 Documentation/filesystems/relay.rst | 32 +++++------
 include/linux/relay.h               | 19 ++++---
 kernel/relay.c                      | 88 ++++++++++++++---------------
 3 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/Documentation/filesystems/relay.rst b/Documentation/filesystems/relay.rst
index 04ad083cfe62..b0ee7dcab8e7 100644
--- a/Documentation/filesystems/relay.rst
+++ b/Documentation/filesystems/relay.rst
@@ -15,8 +15,8 @@ clients write into the channel buffers using efficient write
 functions; these automatically log into the current cpu's channel
 buffer.  User space applications mmap() or read() from the relay files
 and retrieve the data as it becomes available.  The relay files
-themselves are files created in a host filesystem, e.g. debugfs, and
-are associated with the channel buffers using the API described below.
+themselves are files created in debugfs and are associated with the
+channel buffers using the API described below.
 
 The format of the data logged into the channel buffers is completely
 up to the kernel client; the relay interface does however provide
@@ -185,7 +185,7 @@ TBD(curr. line MT:/API/)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
     create_buf_file(filename, parent, mode, buf, is_global)
-    remove_buf_file(dentry)
+    remove_buf_file(node)
 
   helper functions::
 
@@ -203,12 +203,10 @@ read from in user space.  The files are named basename0...basenameN-1
 where N is the number of online cpus, and by default will be created
 in the root of the filesystem (if the parent param is NULL).  If you
 want a directory structure to contain your relay files, you should
-create it using the host filesystem's directory creation function,
-e.g. debugfs_create_dir(), and pass the parent directory to
+create it using debugfs_create_dir(), and pass the parent directory to
 relay_open().  Users are responsible for cleaning up any directory
-structure they create, when the channel is closed - again the host
-filesystem's directory removal functions should be used for that,
-e.g. debugfs_remove().
+structure they create, when the channel is closed with
+debugfs_remove().
 
 In order for a channel to be created and the host filesystem's files
 associated with its channel buffers, the user must provide definitions
@@ -216,7 +214,7 @@ for two callback functions, create_buf_file() and remove_buf_file().
 create_buf_file() is called once for each per-cpu buffer from
 relay_open() and allows the user to create the file which will be used
 to represent the corresponding channel buffer.  The callback should
-return the dentry of the file created to represent the channel buffer.
+return the node of the file created to represent the channel buffer.
 remove_buf_file() must also be defined; it's responsible for deleting
 the file(s) created in create_buf_file() and is called during
 relay_close().
@@ -227,22 +225,22 @@ using debugfs::
     /*
     * create_buf_file() callback.  Creates relay file in debugfs.
     */
-    static struct dentry *create_buf_file_handler(const char *filename,
-						struct dentry *parent,
-						umode_t mode,
-						struct rchan_buf *buf,
-						int *is_global)
+    static struct debugfs_node *create_buf_file_handler(const char *filename,
+							struct debugfs_node *parent,
+							umode_t mode,
+							struct rchan_buf *buf,
+							int *is_global)
     {
 	    return debugfs_create_file(filename, mode, parent, buf,
-				    &relay_file_operations);
+				       &relay_file_operations);
     }
 
     /*
     * remove_buf_file() callback.  Removes relay file from debugfs.
     */
-    static int remove_buf_file_handler(struct dentry *dentry)
+    static int remove_buf_file_handler(struct debugfs_node *node)
     {
-	    debugfs_remove(dentry);
+	    debugfs_remove(node);
 
 	    return 0;
     }
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..75d5a147ea9e 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -22,6 +22,7 @@
 #include <linux/poll.h>
 #include <linux/kref.h>
 #include <linux/percpu.h>
+#include <linux/debugfs.h>
 
 /*
  * Tracks changes to rchan/rchan_buf structs
@@ -41,7 +42,7 @@ struct rchan_buf
 	struct rchan *chan;		/* associated channel */
 	wait_queue_head_t read_wait;	/* reader wait queue */
 	struct irq_work wakeup_work;	/* reader wakeup */
-	struct dentry *dentry;		/* channel file dentry */
+	struct debugfs_node *node;	/* channel file node */
 	struct kref kref;		/* channel buffer refcount */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
@@ -69,7 +70,7 @@ struct rchan
 	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
-	struct dentry *parent;		/* parent dentry passed to open */
+	struct debugfs_node *parent;	/* parent node passed to open */
 	int has_base_filename;		/* has a filename associated? */
 	char base_filename[NAME_MAX];	/* saved base filename */
 };
@@ -117,7 +118,7 @@ struct rchan_callbacks
 	 * created outside of relay, the parent must also exist in
 	 * that filesystem.
 	 *
-	 * The callback should return the dentry of the file created
+	 * The callback should return the debugfs_node of the file created
 	 * to represent the relay buffer.
 	 *
 	 * Setting the is_global outparam to a non-zero value will
@@ -128,15 +129,15 @@ struct rchan_callbacks
 	 *
 	 * See Documentation/filesystems/relay.rst for more info.
 	 */
-	struct dentry *(*create_buf_file)(const char *filename,
-					  struct dentry *parent,
+	struct debugfs_node *(*create_buf_file)(const char *filename,
+					  struct debugfs_node *parent,
 					  umode_t mode,
 					  struct rchan_buf *buf,
 					  int *is_global);
 
 	/*
 	 * remove_buf_file - remove file representing a relay channel buffer
-	 * @dentry: the dentry of the file to remove
+	 * @node: the debugfs_node of the file to remove
 	 *
 	 * Called during relay_close(), once for each per-cpu buffer,
 	 * to allow the client to remove a file used to represent a
@@ -146,7 +147,7 @@ struct rchan_callbacks
 	 *
 	 * This callback is mandatory.
 	 */
-	int (*remove_buf_file)(struct dentry *dentry);
+	int (*remove_buf_file)(struct debugfs_node *node);
 };
 
 /*
@@ -154,14 +155,14 @@ struct rchan_callbacks
  */
 
 struct rchan *relay_open(const char *base_filename,
-			 struct dentry *parent,
+			 struct debugfs_node *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
 			 const struct rchan_callbacks *cb,
 			 void *private_data);
 extern int relay_late_setup_files(struct rchan *chan,
 				  const char *base_filename,
-				  struct dentry *parent);
+				  struct debugfs_node *parent);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
diff --git a/kernel/relay.c b/kernel/relay.c
index a8ae436dc77e..16cf9098d697 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -337,18 +337,18 @@ void relay_reset(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_reset);
 
-static inline void relay_set_buf_dentry(struct rchan_buf *buf,
-					struct dentry *dentry)
+static inline void relay_set_buf_node(struct rchan_buf *buf,
+				      struct debugfs_node *node)
 {
-	buf->dentry = dentry;
-	d_inode(buf->dentry)->i_size = buf->early_bytes;
+	buf->node = node;
+	debugfs_node_inode(buf->node)->i_size = buf->early_bytes;
 }
 
-static struct dentry *relay_create_buf_file(struct rchan *chan,
-					    struct rchan_buf *buf,
-					    unsigned int cpu)
+static struct debugfs_node *relay_create_buf_file(struct rchan *chan,
+						  struct rchan_buf *buf,
+						  unsigned int cpu)
 {
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	char *tmpname;
 
 	tmpname = kzalloc(NAME_MAX + 1, GFP_KERNEL);
@@ -357,15 +357,15 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
 
 	/* Create file in fs */
-	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
-					   S_IRUSR, buf,
-					   &chan->is_global);
-	if (IS_ERR(dentry))
-		dentry = NULL;
+	node = chan->cb->create_buf_file(tmpname, chan->parent,
+					 S_IRUSR, buf,
+					 &chan->is_global);
+	if (IS_ERR(node))
+		node = NULL;
 
 	kfree(tmpname);
 
-	return dentry;
+	return node;
 }
 
 /*
@@ -376,7 +376,7 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
 	struct rchan_buf *buf;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 
  	if (chan->is_global)
 		return *per_cpu_ptr(chan->buf, 0);
@@ -386,16 +386,16 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		return NULL;
 
 	if (chan->has_base_filename) {
-		dentry = relay_create_buf_file(chan, buf, cpu);
-		if (!dentry)
+		node = relay_create_buf_file(chan, buf, cpu);
+		if (!node)
 			goto free_buf;
-		relay_set_buf_dentry(buf, dentry);
+		relay_set_buf_node(buf, node);
 	} else {
 		/* Only retrieve global info, nothing more, nothing less */
-		dentry = chan->cb->create_buf_file(NULL, NULL,
-						   S_IRUSR, buf,
-						   &chan->is_global);
-		if (IS_ERR_OR_NULL(dentry))
+		node = chan->cb->create_buf_file(NULL, NULL,
+						 S_IRUSR, buf,
+						 &chan->is_global);
+		if (IS_ERR_OR_NULL(node))
 			goto free_buf;
 	}
 
@@ -426,7 +426,7 @@ static void relay_close_buf(struct rchan_buf *buf)
 {
 	buf->finalized = 1;
 	irq_work_sync(&buf->wakeup_work);
-	buf->chan->cb->remove_buf_file(buf->dentry);
+	buf->chan->cb->remove_buf_file(buf->node);
 	kref_put(&buf->kref, relay_remove_buf);
 }
 
@@ -454,7 +454,7 @@ int relay_prepare_cpu(unsigned int cpu)
 /**
  *	relay_open - create a new relay channel
  *	@base_filename: base name of files to create, %NULL for buffering only
- *	@parent: dentry of parent directory, %NULL for root directory or buffer
+ *	@parent: node of parent directory, %NULL for root directory or buffer
  *	@subbuf_size: size of sub-buffers
  *	@n_subbufs: number of sub-buffers
  *	@cb: client callback functions
@@ -468,11 +468,11 @@ int relay_prepare_cpu(unsigned int cpu)
  *	permissions will be %S_IRUSR.
  *
  *	If opening a buffer (@parent = NULL) that you later wish to register
- *	in a filesystem, call relay_late_setup_files() once the @parent dentry
+ *	in a filesystem, call relay_late_setup_files() once the @parent node
  *	is available.
  */
 struct rchan *relay_open(const char *base_filename,
-			 struct dentry *parent,
+			 struct debugfs_node *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
 			 const struct rchan_callbacks *cb,
@@ -538,40 +538,40 @@ EXPORT_SYMBOL_GPL(relay_open);
 
 struct rchan_percpu_buf_dispatcher {
 	struct rchan_buf *buf;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 };
 
 /* Called in atomic context. */
-static void __relay_set_buf_dentry(void *info)
+static void __relay_set_buf_node(void *info)
 {
 	struct rchan_percpu_buf_dispatcher *p = info;
 
-	relay_set_buf_dentry(p->buf, p->dentry);
+	relay_set_buf_node(p->buf, p->node);
 }
 
 /**
  *	relay_late_setup_files - triggers file creation
  *	@chan: channel to operate on
  *	@base_filename: base name of files to create
- *	@parent: dentry of parent directory, %NULL for root directory
+ *	@parent: node of parent directory, %NULL for root directory
  *
  *	Returns 0 if successful, non-zero otherwise.
  *
  *	Use to setup files for a previously buffer-only channel created
- *	by relay_open() with a NULL parent dentry.
+ *	by relay_open() with a NULL parent node.
  *
  *	For example, this is useful for perfomring early tracing in kernel,
- *	before VFS is up and then exposing the early results once the dentry
+ *	before VFS is up and then exposing the early results once the node
  *	is available.
  */
 int relay_late_setup_files(struct rchan *chan,
 			   const char *base_filename,
-			   struct dentry *parent)
+			   struct debugfs_node *parent)
 {
 	int err = 0;
 	unsigned int i, curr_cpu;
 	unsigned long flags;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	struct rchan_buf *buf;
 	struct rchan_percpu_buf_dispatcher disp;
 
@@ -593,9 +593,9 @@ int relay_late_setup_files(struct rchan *chan,
 		err = -EINVAL;
 		buf = *per_cpu_ptr(chan->buf, 0);
 		if (!WARN_ON_ONCE(!buf)) {
-			dentry = relay_create_buf_file(chan, buf, 0);
-			if (dentry && !WARN_ON_ONCE(!chan->is_global)) {
-				relay_set_buf_dentry(buf, dentry);
+			node = relay_create_buf_file(chan, buf, 0);
+			if (node && !WARN_ON_ONCE(!chan->is_global)) {
+				relay_set_buf_node(buf, node);
 				err = 0;
 			}
 		}
@@ -617,23 +617,23 @@ int relay_late_setup_files(struct rchan *chan,
 			break;
 		}
 
-		dentry = relay_create_buf_file(chan, buf, i);
-		if (unlikely(!dentry)) {
+		node = relay_create_buf_file(chan, buf, i);
+		if (unlikely(!node)) {
 			err = -EINVAL;
 			break;
 		}
 
 		if (curr_cpu == i) {
 			local_irq_save(flags);
-			relay_set_buf_dentry(buf, dentry);
+			relay_set_buf_node(buf, node);
 			local_irq_restore(flags);
 		} else {
 			disp.buf = buf;
-			disp.dentry = dentry;
+			disp.node = node;
 			smp_mb();
 			/* relay_channels_mutex must be held, so wait. */
 			err = smp_call_function_single(i,
-						       __relay_set_buf_dentry,
+						       __relay_set_buf_node,
 						       &disp, 1);
 		}
 		if (unlikely(err))
@@ -669,8 +669,8 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 		buf->padding[old_subbuf] = buf->prev_padding;
 		buf->subbufs_produced++;
-		if (buf->dentry)
-			d_inode(buf->dentry)->i_size +=
+		if (buf->node)
+			debugfs_node_inode(buf->node)->i_size +=
 				buf->chan->subbuf_size -
 				buf->padding[old_subbuf];
 		else

