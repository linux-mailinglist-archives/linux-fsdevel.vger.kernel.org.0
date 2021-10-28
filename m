Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64FC43DEE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1Kew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 06:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhJ1Kes (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:34:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71D7361040;
        Thu, 28 Oct 2021 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635417141;
        bh=EEH1kQpZ6zNvVfX0L7XGWE/jH9+syRJkIcKYB+ZHdFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFmbHMMOBNYVcssEypIP4HfJvPjfN/e7jJAkmGpDVh0QNrnq5pQivoiImzhHceDS9
         zVyeyZKHen34kUD6F42Ln5Je37ukCR4CwAF3Mp7Ght4ycUicLmTh6J/OmXfnOFJR4E
         gkdQk4s4jfM+srfj5ryrAV0mT5dWJheqigNs1iiCUSYfWnubSnXkwoIm6BXd3Lnqdi
         KRx3AMoJ2CaC8mPhbTZYqjAMVM1qs3zIwbDfMfqHTFAf78LcVR58S43Z3zqofgLO0s
         ZFhdE+qrVmToznkLpc7eVZwxTh2s4WAkozbbj3AoFH0TwP3kVMGZOpO4IivG18eJOk
         eFHs7d+s5rvew==
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, containers@lists.linux.dev
Subject: [PATCH 2/2] binfmt_misc: enable sandboxed mounts
Date:   Thu, 28 Oct 2021 12:31:14 +0200
Message-Id: <20211028103114.2849140-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028103114.2849140-1-brauner@kernel.org>
References: <20211028103114.2849140-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Laurent Vivier <laurent@vivier.eu>

Enable unprivileged sandboxes to create their own binfmt_misc mounts.
This is based on Laurent's work in [1] but has been significantly
reworked to fix various issues we identified in earlier versions.

While binfmt_misc can currently only be mounted in the initial user
namespace, binary types registered in this binfmt_misc instance are
available to all sandboxes (Either by having them installed in the
sandbox or by registering the binary type with the F flag causing the
interpreter to be opened right away). So binfmt_misc binary types are
already delegated to sandboxes implicitly.

However, while a sandbox has access to all registered binary types in
binfmt_misc a sandbox cannot currently register its own binary types
in binfmt_misc. This has prevented various use-cases some of which were
already outlined in [1] but we have a range of issues associated with
this (cf. [3]-[5] below which are just a small sample).

Extend binfmt_misc to be mountable in non-initial user namespaces.
Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
keyed superblock management. The key determines whether we need to
create a new superblock or can reuse an already existing one. We use the
user namespace of the mount as key. This means a new binfmt_misc
superblock is created once per user namespace creation. Subsequent
mounts of binfmt_misc in the same user namespace will mount the same
binfmt_misc instance. We explicitly do not create a new binfmt_misc
superblock on every binfmt_misc mount as the semantics for
load_misc_binary() line up with the keying model. This also allows us to
retrieve the relevant binfmt_misc instance based on the caller's user
namespace which can be done in a simple (bounded to 32 levels) loop.

Similar to the current binfmt_misc semantics allowing access to the
binary types in the initial binfmt_misc instance we do allow sandboxes
access to their parent's binfmt_misc mounts if they do not have created
a separate binfmt_misc instance.

Overall, this will unblock the use-cases mentioned below and in general
will also allow to support and harden execution of another
architecture's binaries in tight sandboxes. For instance, using the
unshare binary it possible to start a chroot of another architecture and
configure the binfmt_misc interpreter without being root to run the
binaries in this chroot and without requiring the host to modify its
binary type handlers.

Henning had already posted a few experiments in the cover letter at [1].
But here's an additional example where an unprivileged container
registers qemu-user-static binary handlers for various binary types in
its separate binfmt_misc mount and is then seamlessly able to start
containers with a different architecture without affecting the host:

[lxc monitor] /var/lib/lxc imp2
 \_ /sbin/init
     \_ /lib/systemd/systemd-journald
     \_ /lib/systemd/systemd-udevd
     \_ /lib/systemd/systemd-networkd
     \_ /usr/sbin/cron -f -P
     \_ @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
     \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
     \_ /usr/sbin/rsyslogd -n -iNONE
     \_ /lib/systemd/systemd-logind
     \_ /lib/systemd/systemd-resolved
     \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
     \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
     \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
     \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
     \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
     \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
     \_ [lxc monitor] /var/lib/lxc alp1
         \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /sbin/init /sbin/init
             \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-journald /lib/systemd/systemd-journald
             \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-udevd /lib/systemd/systemd-udevd
             \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /usr/sbin/cron /usr/sbin/cron -f -P
             \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-resolved /lib/systemd/systemd-resolved
             \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-logind /lib/systemd/systemd-logind

Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu
[1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
[2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
[3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
[4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
[5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Henning Schild <henning.schild@siemens.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
[christian.brauner@ubuntu.com: rework patch substantially]
[christian.brauner@ubuntu.com: add new commit message]
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/binfmt_misc.c               | 158 ++++++++++++++++++++++++++++-----
 include/linux/binfmts.h        |  10 +++
 include/linux/user_namespace.h |   8 ++
 kernel/user.c                  |  13 +++
 kernel/user_namespace.c        |   3 +
 5 files changed, 168 insertions(+), 24 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5a9d5e44c750..033834d83455 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -40,9 +40,6 @@ enum {
 	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
 };
 
-static LIST_HEAD(entries);
-static int enabled = 1;
-
 enum {Enabled, Magic};
 #define MISC_FMT_PRESERVE_ARGV0 (1 << 31)
 #define MISC_FMT_OPEN_BINARY (1 << 30)
@@ -63,7 +60,6 @@ typedef struct {
 	refcount_t ref;
 } Node;
 
-static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
 
 /*
@@ -81,18 +77,39 @@ static struct file_system_type bm_fs_type;
  */
 #define MAX_REGISTER_LENGTH 1920
 
+static struct binfmt_misc *binfmt_misc(struct user_namespace *user_ns)
+{
+	while (user_ns) {
+		struct binfmt_misc *misc;
+
+		/* Pairs with smp_store_release() in bm_fill_super(). */
+		misc = smp_load_acquire(&user_ns->binfmt_misc);
+		if (misc)
+			return misc;
+
+		user_ns = user_ns->parent;
+	}
+
+	/*
+	 * As the first user namespace is initialized with
+	 * &init_binfmt_misc we should never come here.
+	 */
+	WARN_ON_ONCE(1);
+	return ERR_PTR(-EINVAL);
+}
+
 /*
  * Check if we support the binfmt
  * if we do, return the node, else NULL
  * locking is done in load_misc_binary
  */
-static Node *check_file(struct linux_binprm *bprm)
+static Node *check_file(struct binfmt_misc *misc, struct linux_binprm *bprm)
 {
 	char *p = strrchr(bprm->interp, '.');
 	struct list_head *l;
 
 	/* Walk all the registered handlers. */
-	list_for_each(l, &entries) {
+	list_for_each(l, &misc->entries) {
 		Node *e = list_entry(l, Node, list);
 		char *s;
 		int j;
@@ -143,18 +160,23 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	Node *fmt;
 	struct file *interp_file = NULL;
 	int retval;
+	struct binfmt_misc *misc;
+
+	misc = binfmt_misc(current_user_ns());
+	if (IS_ERR(misc))
+		return PTR_ERR(misc);
 
 	retval = -ENOEXEC;
-	if (!enabled)
+	if (!misc->enabled)
 		return retval;
 
 	/* to keep locking time low, we copy the interpreter string */
-	read_lock(&entries_lock);
-	fmt = check_file(bprm);
+	read_lock(&misc->entries_lock);
+	fmt = check_file(misc, bprm);
 	/* Make sure the node isn't freed behind our back. */
 	if (fmt)
 		refcount_inc(&fmt->ref);
-	read_unlock(&entries_lock);
+	read_unlock(&misc->entries_lock);
 	if (!fmt)
 		return retval;
 
@@ -579,14 +601,20 @@ static void bm_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	if (e) {
-		write_lock(&entries_lock);
+		struct binfmt_misc *misc;
+
+		misc = binfmt_misc(inode->i_sb->s_user_ns);
+		if (IS_ERR(misc))
+			return;
+
+		write_lock(&misc->entries_lock);
 		list_del_init(&e->list);
-		write_unlock(&entries_lock);
+		write_unlock(&misc->entries_lock);
 		put_node(e);
 	}
 }
 
-static void kill_node(Node *e)
+static void kill_node(struct binfmt_misc *misc, Node *e)
 {
 	struct dentry *dentry;
 
@@ -626,8 +654,14 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct dentry *root;
-	Node *e = file_inode(file)->i_private;
+	struct inode *inode = file_inode(file);
+	Node *e = inode->i_private;
 	int res = parse_command(buffer, count);
+	struct binfmt_misc *misc;
+
+	misc = binfmt_misc(inode->i_sb->s_user_ns);
+	if (IS_ERR(misc))
+		return PTR_ERR(misc);
 
 	switch (res) {
 	case 1:
@@ -644,7 +678,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		inode_lock(d_inode(root));
 
 		if (!list_empty(&e->list))
-			kill_node(e);
+			kill_node(misc, e);
 
 		inode_unlock(d_inode(root));
 		break;
@@ -670,16 +704,25 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	struct inode *inode;
 	struct super_block *sb = file_inode(file)->i_sb;
 	struct dentry *root = sb->s_root, *dentry;
+	struct binfmt_misc *misc;
 	int err = 0;
 	struct file *f = NULL;
 
+	misc = binfmt_misc(file_inode(file)->i_sb->s_user_ns);
+	if (IS_ERR(misc))
+		return PTR_ERR(misc);
+
 	e = create_entry(buffer, count);
 
 	if (IS_ERR(e))
 		return PTR_ERR(e);
 
 	if (e->flags & MISC_FMT_OPEN_FILE) {
+		const struct cred *old_cred;
+
+		old_cred = override_creds(file->f_cred);
 		f = open_exec(e->interpreter);
+		revert_creds(old_cred);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
@@ -711,9 +754,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode->i_fop = &bm_entry_operations;
 
 	d_instantiate(dentry, inode);
-	write_lock(&entries_lock);
-	list_add(&e->list, &entries);
-	write_unlock(&entries_lock);
+	write_lock(&misc->entries_lock);
+	list_add(&e->list, &misc->entries);
+	write_unlock(&misc->entries_lock);
 
 	err = 0;
 out2:
@@ -740,33 +783,45 @@ static const struct file_operations bm_register_operations = {
 static ssize_t
 bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
-	char *s = enabled ? "enabled\n" : "disabled\n";
+	struct binfmt_misc *misc;
+	char *s;
 
+	misc = binfmt_misc(file_inode(file)->i_sb->s_user_ns);
+	if (IS_ERR(misc))
+		return PTR_ERR(misc);
+
+	s = misc->enabled ? "enabled\n" : "disabled\n";
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
 static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
+	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
 	struct dentry *root;
 
+	misc = binfmt_misc(file_inode(file)->i_sb->s_user_ns);
+	if (IS_ERR(misc))
+		return PTR_ERR(misc);
+
 	switch (res) {
 	case 1:
 		/* Disable all handlers. */
-		enabled = 0;
+		misc->enabled = false;
 		break;
 	case 2:
 		/* Enable all handlers. */
-		enabled = 1;
+		misc->enabled = true;
 		break;
 	case 3:
 		/* Delete all handlers. */
 		root = file_inode(file)->i_sb->s_root;
 		inode_lock(d_inode(root));
 
-		while (!list_empty(&entries))
-			kill_node(list_first_entry(&entries, Node, list));
+		while (!list_empty(&misc->entries))
+			kill_node(misc,
+				  list_first_entry(&misc->entries, Node, list));
 
 		inode_unlock(d_inode(root));
 		break;
@@ -785,32 +840,86 @@ static const struct file_operations bm_status_operations = {
 
 /* Superblock handling */
 
+static void bm_put_super(struct super_block *sb)
+{
+	struct user_namespace *user_ns = sb->s_fs_info;
+
+	sb->s_fs_info = NULL;
+	put_user_ns(user_ns);
+}
+
 static const struct super_operations s_ops = {
 	.statfs		= simple_statfs,
 	.evict_inode	= bm_evict_inode,
+	.put_super	= bm_put_super,
 };
 
 static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int err;
+	struct user_namespace *user_ns = sb->s_user_ns;
+	struct binfmt_misc *misc;
 	static const struct tree_descr bm_files[] = {
 		[2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
 		[3] = {"register", &bm_register_operations, S_IWUSR},
 		/* last one */ {""}
 	};
 
+	/*
+	 * Allocate a new binfmt_misc instance for this namespace.
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for binfmt_misc. Hence, the vfs guarantees that
+	 * bm_fill_super() is called exactly once whenever a binfmt_misc
+	 * superblock for a userns is created. This in turn lets us conclude
+	 * that when a binfmt_misc superblock is created for the first time for
+	 * a userns there's no one racing us. Therefore we don't need any
+	 * barriers when we dereference binfmt_misc.
+	 */
+	misc = user_ns->binfmt_misc;
+	if (!misc) {
+		misc = kmalloc(sizeof(struct binfmt_misc), GFP_KERNEL);
+		if (!misc)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&misc->entries);
+		rwlock_init(&misc->entries_lock);
+
+		/* Pairs with smp_load_acquire() in binfmt_misc(). */
+		smp_store_release(&user_ns->binfmt_misc, misc);
+	}
+
+	/*
+	 * When the binfmt_misc superblock for this userns is shutdown
+	 * ->enabled might have been set to false and we don't reinitialize
+	 * ->enabled again in put_super() as someone might already be mounting
+	 * binfmt_misc again. It also would be pointless since by the time
+	 * ->put_super() is called we know that the binary type list for this
+	 * bintfmt_misc mount is empty making load_misc_binary() return
+	 * -ENOEXEC independent of whether ->enabled is true. Instead, if
+	 * someone mounts binfmt_misc for the first time or again we simply
+	 * reset ->enabled to true.
+	 */
+	misc->enabled = true;
+
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)
 		sb->s_op = &s_ops;
 	return err;
 }
 
+static void bm_free(struct fs_context *fc)
+{
+	if (fc->s_fs_info)
+		put_user_ns(fc->s_fs_info);
+}
+
 static int bm_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, bm_fill_super);
+	return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));
 }
 
 static const struct fs_context_operations bm_context_ops = {
+	.free		= bm_free,
 	.get_tree	= bm_get_tree,
 };
 
@@ -829,6 +938,7 @@ static struct file_system_type bm_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "binfmt_misc",
 	.init_fs_context = bm_init_fs_context,
+	.fs_flags	= FS_USERNS_MOUNT,
 	.kill_sb	= kill_litter_super,
 };
 MODULE_ALIAS_FS("binfmt_misc");
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 049cf9421d83..42efcefc56c7 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -102,6 +102,16 @@ struct linux_binfmt {
 	unsigned long min_coredump;	/* minimal dump size */
 } __randomize_layout;
 
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+struct binfmt_misc {
+	struct list_head entries;
+	rwlock_t entries_lock;
+	bool enabled;
+} __randomize_layout;
+
+extern struct binfmt_misc init_binfmt_misc;
+#endif
+
 extern void __register_binfmt(struct linux_binfmt *fmt, int insert);
 
 /* Registration of default binfmt handlers */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..a49f8f121fc4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -63,6 +63,10 @@ enum ucount_type {
 
 #define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
 
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+struct binfmt_misc;
+#endif
+
 struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
@@ -99,6 +103,10 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
+
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+	struct binfmt_misc *binfmt_misc;
+#endif
 } __randomize_layout;
 
 struct ucounts {
diff --git a/kernel/user.c b/kernel/user.c
index e2cf8c22b539..d2e7575dbfa2 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -18,8 +18,18 @@
 #include <linux/interrupt.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/binfmts.h>
 #include <linux/proc_ns.h>
 
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+struct binfmt_misc init_binfmt_misc = {
+	.entries = LIST_HEAD_INIT(init_binfmt_misc.entries),
+	.enabled = true,
+	.entries_lock = __RW_LOCK_UNLOCKED(init_binfmt_misc.entries_lock),
+};
+EXPORT_SYMBOL_GPL(init_binfmt_misc);
+#endif
+
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
  * and 1 for... ?
@@ -67,6 +77,9 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+	.binfmt_misc = &init_binfmt_misc,
+#endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..2bdf2ff69148 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -196,6 +196,9 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+		kfree(ns->binfmt_misc);
+#endif
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
-- 
2.30.2

