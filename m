Return-Path: <linux-fsdevel+bounces-5465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AEC80C7E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29FF2817D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1A36B0E;
	Mon, 11 Dec 2023 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l4jO1Vpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F030ABD;
	Mon, 11 Dec 2023 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702293910;
	bh=ZvgW0aYfCLWt5NV86Ke4c9thN3uF82opqg4tLuJpvEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4jO1Vpanp/cdwKq2g8dOspBwuK27Q/lgFXI6toegd2+2VnyAiEg1vmUmr50Gr+o5
	 grrFW4AhaKda6/tUEKNuM2+PcIMob95h1Gbkxcnc2/pzDbdni9rFVaYgRexltawlwP
	 L3XAVnY1iIbqZmc1HRsY4oijnWokkSyib0B5t904=
Date: Mon, 11 Dec 2023 12:25:10 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="igpenhi52ez4jwxm"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208095926.aavsjrtqbb5rygmb@localhost>


--igpenhi52ez4jwxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2023-12-08 10:59:26+0100, Joel Granados wrote:
> On Thu, Dec 07, 2023 at 08:19:43PM +0100, Thomas Weißschuh wrote:
> > On 2023-12-07 11:43:57+0100, Joel Granados wrote:

> [..]

> > > I suggest you chunk it up with directories in mind. Something similar to
> > > what I did for [4] where I divided stuff that when for fs/*, kernel/*,
> > > net/*, arch/* and drivers/*. That will complicate your patch a tad
> > > because you have to ensure that the tree can be compiled/run for every
> > > commit. But it will pay off once you push it to the broader public.
> > 
> > This will break bisections. All function signatures need to be switched

> I was suggesting a solution without breaking bisections of course. I can
> think of a couple of ways to do this in chunks but it might be
> premature. You can send it and if you get push back because of this then
> we can deal with chunking it down.

I'm curious about those ways. I don't see how to split the big commit.

> I'm still concerned about the header size for those mails. How does the
> mail look like when you run the get maintainers script on it?

The full series has 142 recipients in total,
the biggest patch itself has 124.

Before sending it I'd like to get feedback on the internal rework of the
is_empty detection from you and/or Luis.

https://git.sr.ht/~t-8ch/linux/commit/ea27507070f3c47be6febebe451bbb88f6ea707e
or the attached patch.

> [..]

--igpenhi52ez4jwxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="ea27507070f3c47be6febebe451bbb88f6ea707e.patch"
Content-Transfer-Encoding: 8bit

From ea27507070f3c47be6febebe451bbb88f6ea707e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 3 Dec 2023 21:56:46 +0100
Subject: [PATCH] sysctl: move permanently empty flag to ctl_dir
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplify the logic by always keeping the permanently_empty flag on the
ctl_dir.
The previous logic kept the flag in the leaf ctl_table and from there
transferred it to the ctl_table from the directory.

This also removes the need to have a mutable ctl_table and will allow
the constification of those structs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  | 74 +++++++++++++++++++-----------------------
 include/linux/sysctl.h | 13 ++------
 2 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 35c97ad54f34..33f41af58e9b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -17,6 +17,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/mount.h>
 #include <linux/kmemleak.h>
+#include <linux/cleanup.h>
 #include "internal.h"
 
 #define list_for_each_table_entry(entry, header)	\
@@ -29,32 +30,6 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
-/* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = {
-	{.type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY }
-};
-
-/**
- * register_sysctl_mount_point() - registers a sysctl mount point
- * @path: path for the mount point
- *
- * Used to create a permanently empty directory to serve as mount point.
- * There are some subtle but important permission checks this allows in the
- * case of unprivileged mounts.
- */
-struct ctl_table_header *register_sysctl_mount_point(const char *path)
-{
-	return register_sysctl(path, sysctl_mount_point);
-}
-EXPORT_SYMBOL(register_sysctl_mount_point);
-
-#define sysctl_is_perm_empty_ctl_header(hptr)		\
-	(hptr->ctl_table[0].type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
-#define sysctl_set_perm_empty_ctl_header(hptr)		\
-	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
-#define sysctl_clear_perm_empty_ctl_header(hptr)	\
-	(hptr->ctl_table[0].type = SYSCTL_TABLE_TYPE_DEFAULT)
-
 void proc_sys_poll_notify(struct ctl_table_poll *poll)
 {
 	if (!poll)
@@ -226,17 +201,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 
 	/* Is this a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_header(dir_h))
+	if (dir->permanently_empty)
 		return -EROFS;
 
-	/* Am I creating a permanently empty directory? */
-	if (header->ctl_table_size > 0 &&
-	    sysctl_is_perm_empty_ctl_header(header)) {
-		if (!RB_EMPTY_ROOT(&dir->root))
-			return -EINVAL;
-		sysctl_set_perm_empty_ctl_header(dir_h);
-	}
-
 	dir_h->nreg++;
 	header->parent = dir;
 	err = insert_links(header);
@@ -252,8 +219,6 @@ fail:
 	erase_header(header);
 	put_links(header);
 fail_links:
-	if (header->ctl_table == sysctl_mount_point)
-		sysctl_clear_perm_empty_ctl_header(dir_h);
 	header->parent = NULL;
 	drop_sysctl_table(dir_h);
 	return err;
@@ -440,6 +405,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		struct ctl_table_header *head, struct ctl_table *table)
 {
 	struct ctl_table_root *root = head->root;
+	struct ctl_dir *ctl_dir;
 	struct inode *inode;
 	struct proc_inode *ei;
 
@@ -473,7 +439,9 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &proc_sys_dir_operations;
 		inode->i_fop = &proc_sys_dir_file_operations;
-		if (sysctl_is_perm_empty_ctl_header(head))
+
+		ctl_dir = container_of(head, struct ctl_dir, header);
+		if (ctl_dir->permanently_empty)
 			make_empty_dir_inode(inode);
 	}
 
@@ -1211,8 +1179,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table_header *tmp_head;
 	struct ctl_table *entry, *link;
 
-	if (header->ctl_table_size == 0 ||
-	    sysctl_is_perm_empty_ctl_header(header))
+	if (header->ctl_table_size == 0 || dir->permanently_empty)
 		return true;
 
 	/* Are there links available for every entry in table? */
@@ -1533,6 +1500,33 @@ void unregister_sysctl_table(struct ctl_table_header * header)
 }
 EXPORT_SYMBOL(unregister_sysctl_table);
 
+/**
+ * register_sysctl_mount_point() - registers a sysctl mount point
+ * @path: path for the mount point
+ *
+ * Used to create a permanently empty directory to serve as mount point.
+ * There are some subtle but important permission checks this allows in the
+ * case of unprivileged mounts.
+ */
+struct ctl_table_header *register_sysctl_mount_point(const char *path)
+{
+	struct ctl_dir *dir = sysctl_mkdir_p(&sysctl_table_root.default_set.dir, path);
+
+	if (IS_ERR(dir))
+		return NULL;
+
+	guard(spinlock)(&sysctl_lock);
+
+	if (!RB_EMPTY_ROOT(&dir->root)) {
+		drop_sysctl_table(&dir->header);
+		return NULL;
+	}
+
+	dir->permanently_empty = true;
+	return &dir->header;
+}
+EXPORT_SYMBOL(register_sysctl_mount_point);
+
 void setup_sysctl_set(struct ctl_table_set *set,
 	struct ctl_table_root *root,
 	int (*is_seen)(struct ctl_table_set *))
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ada36ef8cecb..57cb0060d7d7 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -137,17 +137,6 @@ struct ctl_table {
 	void *data;
 	int maxlen;
 	umode_t mode;
-	/**
-	 * enum type - Enumeration to differentiate between ctl target types
-	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
-	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
-	 *                                       empty directory target to serve
-	 *                                       as mount point.
-	 */
-	enum {
-		SYSCTL_TABLE_TYPE_DEFAULT,
-		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
-	} type;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;
@@ -194,6 +183,8 @@ struct ctl_dir {
 	/* Header must be at the start of ctl_dir */
 	struct ctl_table_header header;
 	struct rb_root root;
+	/* Permanently empty directory target to serve as mount point. */
+	bool permanently_empty;
 };
 
 struct ctl_table_set {
-- 
2.38.5


--igpenhi52ez4jwxm--

