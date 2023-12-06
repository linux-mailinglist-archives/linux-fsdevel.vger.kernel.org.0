Return-Path: <linux-fsdevel+bounces-4933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75080674D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94853282097
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA2171BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DvAMfVUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F118F;
	Tue,  5 Dec 2023 21:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701841991;
	bh=Obg463o2nUaqlKVnHihci9mdJ8erJ3Acr4y+3KUJ0+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvAMfVUAQc3JAzovdRfLlFDt820RLJkkqJy2eix01bytTPc2eAS8WZKHm0QT7HgH9
	 w09u6X8jLsrHIaNUej6R1D6xBSET6SQUzteb8KAzggKc+QtRlt4vqOC7mnoM1uSg24
	 RPXTSQGRIb6jM6Yf8FtHjn287tHmQ+5UwmTjzYiE=
Date: Wed, 6 Dec 2023 06:53:10 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
	Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <0450d705-3739-4b6d-a1f2-b22d54617de1@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
 <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
 <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
 <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ij3u6egz2zdk6fho"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>


--ij3u6egz2zdk6fho
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2023-12-05 14:50:01-0800, Luis Chamberlain wrote:
> On Tue, Dec 5, 2023 at 2:41 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> > > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
> > > >             return -EROFS;
> > > >
> > > >     /* Am I creating a permanently empty directory? */
> > > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > > +   if (header->ctl_table == sysctl_mount_point ||
> > > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > > >             if (!RB_EMPTY_ROOT(&dir->root))
> > > >                     return -EINVAL;
> > > >             sysctl_set_perm_empty_ctl_header(dir_h);
> > >
> > > While you're at it.
> >
> > This hunk is completely gone in v3/the code that you merged.
> 
> It is worse in that it is not obvious:
> 
> +       if (table == sysctl_mount_point)
> +               sysctl_set_perm_empty_ctl_header(head);
> 
> > Which kind of unsafety do you envision here?
> 
> Making the code obvious during patch review hy this is needed /
> special, and if we special case this, why not remove enum, and make it
> specific to only that one table. The catch is that it is not
> immediately obvious that we actually call
> sysctl_set_perm_empty_ctl_header() in other places, and it begs the
> question if this can be cleaned up somehow.

Making it specific won't work because the flag needs to be transferred
from the leaf table to the table representing the directory.

What do you think of the aproach taken in the attached patch?
(On top of current sysctl-next, including my series)

Note: Current sysctl-next ist still based on v6.6.

--ij3u6egz2zdk6fho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-sysctl-simplify-handling-of-permanently-empty-direct.patch"

From 2fb9887fb2a5024c2620f2d694bc6dcc32afde67 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 6 Dec 2023 06:17:22 +0100
Subject: [PATCH] sysctl: simplify handling of permanently empty directories

---
 fs/proc/proc_sysctl.c  | 76 +++++++++++++++++++-----------------------
 include/linux/sysctl.h | 13 ++------
 2 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c92e9b972ada..c4d6d09b0e68 100644
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
-static const struct ctl_table sysctl_mount_point[] = {
-	{ }
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
-	(hptr->type == SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
-#define sysctl_set_perm_empty_ctl_header(hptr)		\
-	(hptr->type = SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
-#define sysctl_clear_perm_empty_ctl_header(hptr)		\
-	(hptr->type = SYSCTL_TABLE_TYPE_DEFAULT)
-
 void proc_sys_poll_notify(struct ctl_table_poll *poll)
 {
 	if (!poll)
@@ -199,8 +174,6 @@ static void init_header(struct ctl_table_header *head,
 	head->set = set;
 	head->parent = NULL;
 	head->node = node;
-	if (table == sysctl_mount_point)
-		sysctl_set_perm_empty_ctl_header(head);
 	INIT_HLIST_HEAD(&head->inodes);
 	if (node) {
 		const struct ctl_table *entry;
@@ -228,17 +201,9 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 
 
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
@@ -254,8 +219,6 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	erase_header(header);
 	put_links(header);
 fail_links:
-	if (header->ctl_table == sysctl_mount_point)
-		sysctl_clear_perm_empty_ctl_header(dir_h);
 	header->parent = NULL;
 	drop_sysctl_table(dir_h);
 	return err;
@@ -442,6 +405,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		struct ctl_table_header *head, const struct ctl_table *table)
 {
 	struct ctl_table_root *root = head->root;
+	struct ctl_dir *ctl_dir;
 	struct inode *inode;
 	struct proc_inode *ei;
 
@@ -475,7 +439,9 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &proc_sys_dir_operations;
 		inode->i_fop = &proc_sys_dir_file_operations;
-		if (sysctl_is_perm_empty_ctl_header(head))
+
+		ctl_dir = container_of(head, struct ctl_dir, header);
+		if (ctl_dir->permanently_empty)
 			make_empty_dir_inode(inode);
 	}
 
@@ -1214,8 +1180,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table_header *tmp_head;
 	const struct ctl_table *entry, *link;
 
-	if (header->ctl_table_size == 0 ||
-	    sysctl_is_perm_empty_ctl_header(header))
+	if (header->ctl_table_size == 0 || dir->permanently_empty)
 		return true;
 
 	/* Are there links available for every entry in table? */
@@ -1536,6 +1501,33 @@ void unregister_sysctl_table(struct ctl_table_header * header)
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
index 7c96d5abafc7..329e68d484ed 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -177,23 +177,14 @@ struct ctl_table_header {
 	struct ctl_dir *parent;
 	struct ctl_node *node;
 	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
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
 };
 
 struct ctl_dir {
 	/* Header must be at the start of ctl_dir */
 	struct ctl_table_header header;
 	struct rb_root root;
+	/* Permanently empty directory target to serve as mount point. */
+	bool permanently_empty;
 };
 
 struct ctl_table_set {

base-commit: a6fd07f80ab7bd94edb4d56c35e61117ffb9957e
prerequisite-patch-id: 0000000000000000000000000000000000000000
prerequisite-patch-id: 13932e9add940cb65c71e04b5efdfcd3622fd27e
prerequisite-patch-id: 2e4d88f7b8aaa805598f0e87a3ea726825bb4264
prerequisite-patch-id: 674a680d9cb138cd34cfd0e1a4ec3a5d1c220078
prerequisite-patch-id: e27c92582aa20b1dfb122c172b336dbaf9d6508a
prerequisite-patch-id: 9b409a34ab6a4d8d8c5225ba9a72db3116e3c8b3
prerequisite-patch-id: 86ff15a81d850ebda16bb707491251f4b705e4fd
prerequisite-patch-id: b7ab65512ac9acfb2dd482b0271b399467afc56d
prerequisite-patch-id: 0354922fbf2508a89f3e9d9a4e274fc98deb2e93
prerequisite-patch-id: b71389e82026ffc19cbb717bba1a014ad6cab6da
prerequisite-patch-id: fbb0201f89bf6c41d0585af867bdeec8d51649b2
prerequisite-patch-id: e3b4b5b69b4eadf87ed97beb8c03a471e7628cb9
prerequisite-patch-id: 3fbc9745cf3f28872b3e63f6d1f6e2fd7598be8a
prerequisite-patch-id: ba2b190c2e54cfb505a282e688c2222712f0acd7
prerequisite-patch-id: 47e5ca730748bb7bf9248a9e711045d8c1028199
prerequisite-patch-id: dcd9f87f00290d2f9be83e404f8883eb90c5fb1c
prerequisite-patch-id: d4629be1a61585ab821da2d2850f246761f72f25
prerequisite-patch-id: f740190f4b94e57cbf3659f220d94483713341a1
prerequisite-patch-id: 301c2e530e2af4568267e19247d4a49ac2a9871d
-- 
2.43.0


--ij3u6egz2zdk6fho--

