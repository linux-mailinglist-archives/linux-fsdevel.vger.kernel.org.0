Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6530E47703D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 12:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhLPL3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 06:29:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39392 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhLPL3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:29:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CAEBB8239E;
        Thu, 16 Dec 2021 11:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F42C36AE5;
        Thu, 16 Dec 2021 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639654158;
        bh=GNGIYsqQsIQ/elxcX3ye9js1zWR5oM3mXSnFyZN90Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doxthBY2Im/Khu5Y1jgbc9zXca9uFc2L0Q68vz2oEtnER+vBQrWQP9Tkvui14ZcAI
         UQ9YAkJxpbIqi87AgqCSa9XpKr++aUIXoG5IBwWooE1y6HBXYSFubgim+WqpSDLQ88
         qbpibYJ0WyLacuocMjiJkEs3awqjMPtTBZxGC+MwSq4RgwSwX57OkwG1CpzPRF5SI3
         Sazrofbg6omyJFgYXo0IML72EXKyaTF1yKA7F3ctK4UzMKYPeBQuIW298I6iNu9Tfy
         sc2kMmKzYq/iJ3IyUd9V/4aDXzIhA5SxtyEwRiPzbNYN14jrZy5YkgKGvBRdk/+YAq
         TPCqVGS3wb/1A==
From:   Christian Brauner <brauner@kernel.org>
To:     Serge Hallyn <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
Date:   Thu, 16 Dec 2021 12:26:59 +0100
Message-Id: <20211216112659.310979-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216112659.310979-1-brauner@kernel.org>
References: <20211216112659.310979-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23999; h=from:subject; bh=24SoEqGcpUTm1S1201LDfmHxSNSajZvXLTmg4YRsSBc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTuVsopTYkxOlzgrzNV6Qlzz7m+s4XZOht7DP9/D1xrot7f u4ejo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKhFowMXQbObz69C1qbGRZ7y7Fdu3 v2ki/S1xyfqcRHu22u9+2sZfjvLNly6ciLUNOHl5bWr9L8EMRlOP329Nr9rIFrvY7veR/PDQA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

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

root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
1000000  \_ /sbin/init
1000000      \_ /lib/systemd/systemd-journald
1000000      \_ /lib/systemd/systemd-udevd
1000100      \_ /lib/systemd/systemd-networkd
1000101      \_ /lib/systemd/systemd-resolved
1000000      \_ /usr/sbin/cron -f
1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
1000104      \_ /usr/sbin/rsyslogd -n -iNONE
1000000      \_ /lib/systemd/systemd-logind
1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd

[1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
[2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
[3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
[4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
[5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11

Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Henning Schild <henning.schild@siemens.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Serge Hallyn <serge@hallyn.com>:
  - Use GFP_KERNEL_ACCOUNT for userspace triggered allocations when a
    new binary type handler is registered.
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Switch authorship to me. I refused to do that earlier even though
    Laurent said I should do so because I think it's genuinely bad form.
    But by now I have changed so many things that it'd be unfair to
    blame Laurent for any potential bugs in here.
  - Add more comments that explain what's going on.
  - Rename functions while changing them to better reflect what they are
    doing to make the code easier to understand.
  - In the first version when a specific binary type handler was removed
    either through a write to the entry's file or all binary type
    handlers were removed by a write to the binfmt_misc mount's status
    file all cleanup work happened during inode eviction.
    That includes removal of the relevant entries from entry list. While
    that works fine I disliked that model after thinking about it for a
    bit. Because it means that there was a window were someone has
    already removed a or all binary handlers but they could still be
    safely reached from load_misc_binary() when it has managed to take
    the read_lock() on the entries list while inode eviction was already
    happening. Again, that perfectly benign but it's cleaner to remove
    the binary handler from the list immediately meaning that ones the
    write to then entry's file or the binfmt_misc status file returns
    the binary type cannot be executed anymore. That gives stronger
    guarantees to the user.
---
 fs/binfmt_misc.c               | 202 +++++++++++++++++++++++++++------
 include/linux/binfmts.h        |  10 ++
 include/linux/user_namespace.h |   8 ++
 kernel/user.c                  |  13 +++
 kernel/user_namespace.c        |   3 +
 5 files changed, 202 insertions(+), 34 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 3fd99a20694b..40b74751ecfd 100644
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
 	refcount_t users;		/* sync removal with load_misc_binary() */
 } Node;
 
-static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
 
 /*
@@ -90,13 +86,14 @@ static struct file_system_type bm_fs_type;
  *
  * Return: binary type list entry on success, NULL on failure
  */
-static Node *search_binfmt_handler(struct linux_binprm *bprm)
+static Node *search_binfmt_handler(struct binfmt_misc *misc,
+				   struct linux_binprm *bprm)
 {
 	char *p = strrchr(bprm->interp, '.');
 	Node *e;
 
 	/* Walk all the registered handlers. */
-	list_for_each_entry(e, &entries, list) {
+	list_for_each_entry(e, &misc->entries, list) {
 		char *s;
 		int j;
 
@@ -138,15 +135,16 @@ static Node *search_binfmt_handler(struct linux_binprm *bprm)
  *
  * Return: binary type list entry on success, NULL on failure
  */
-static Node *get_binfmt_handler(struct linux_binprm *bprm)
+static Node *get_binfmt_handler(struct binfmt_misc *misc,
+				struct linux_binprm *bprm)
 {
 	Node *e;
 
-	read_lock(&entries_lock);
-	e = search_binfmt_handler(bprm);
+	read_lock(&misc->entries_lock);
+	e = search_binfmt_handler(misc, bprm);
 	if (e)
 		refcount_inc(&e->users);
-	read_unlock(&entries_lock);
+	read_unlock(&misc->entries_lock);
 	return e;
 }
 
@@ -167,6 +165,35 @@ static void put_binfmt_handler(Node *e)
 	}
 }
 
+/**
+ * load_binfmt_misc - load the binfmt_misc of the caller's user namespace
+ *
+ * To be called in load_misc_binary() to load the relevant struct binfmt_misc.
+ * If a user namespace doesn't have its own binfmt_misc mount it can make use
+ * of its ancestor's binfmt_misc handlers. This mimicks the behavior of
+ * pre-namespaced binfmt_misc where all registered binfmt_misc handlers where
+ * available to all user and user namespaces on the system.
+ *
+ * Return: the binfmt_misc instance of the caller's user namespace
+ */
+static struct binfmt_misc *load_binfmt_misc(void)
+{
+	const struct user_namespace *user_ns;
+	struct binfmt_misc *misc;
+
+	user_ns = current_user_ns();
+	while (user_ns) {
+		/* Pairs with smp_store_release() in bm_fill_super(). */
+		misc = smp_load_acquire(&user_ns->binfmt_misc);
+		if (misc)
+			return misc;
+
+		user_ns = user_ns->parent;
+	}
+
+	return &init_binfmt_misc;
+}
+
 /*
  * the loader itself
  */
@@ -174,13 +201,14 @@ static int load_misc_binary(struct linux_binprm *bprm)
 {
 	Node *fmt;
 	struct file *interp_file = NULL;
-	int retval;
+	int retval = -ENOEXEC;
+	struct binfmt_misc *misc;
 
-	retval = -ENOEXEC;
-	if (!enabled)
+	misc = load_binfmt_misc();
+	if (!misc->enabled)
 		return retval;
 
-	fmt = get_binfmt_handler(bprm);
+	fmt = get_binfmt_handler(misc, bprm);
 	if (!fmt)
 		return retval;
 
@@ -238,9 +266,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	/*
 	 * If we actually put the node here all concurrent calls to
 	 * load_misc_binary() will have finished. We also know
-	 * that for the refcount to be zero ->evict_inode() must have removed
-	 * the node to be deleted from the list. All that is left for us is to
-	 * close and free.
+	 * that for the refcount to be zero someone must have concurently
+	 * removed the binary type handler from the list and it's our job to
+	 * free it.
 	 */
 	put_binfmt_handler(fmt);
 
@@ -332,7 +360,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
 
 	err = -ENOMEM;
 	memsize = sizeof(Node) + count + 8;
-	e = kmalloc(memsize, GFP_KERNEL);
+	e = kmalloc(memsize, GFP_KERNEL_ACCOUNT);
 	if (!e)
 		goto out;
 
@@ -444,7 +472,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
 
 			if (e->mask) {
 				int i;
-				char *masked = kmalloc(e->size, GFP_KERNEL);
+				char *masked = kmalloc(e->size, GFP_KERNEL_ACCOUNT);
 
 				print_hex_dump_bytes(
 					KBUILD_MODNAME ": register:  mask[decoded]: ",
@@ -598,6 +626,22 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	return inode;
 }
 
+/**
+ * i_binfmt_misc - retrieve struct binfmt_misc from a binfmt_misc inode
+ * @inode: inode of the relevant binfmt_misc instance
+ *
+ * This helper retrieves struct binfmt_misc from a binfmt_misc inode. This can
+ * be done without any memory barriers because we are guaranteed that
+ * user_ns->binfmt_misc is fully initialized. It was fully initialized when the
+ * binfmt_misc mount was first created.
+ *
+ * Return: struct binfmt_misc of the relevant binfmt_misc instance
+ */
+static struct binfmt_misc *i_binfmt_misc(struct inode *inode)
+{
+	return inode->i_sb->s_user_ns->binfmt_misc;
+}
+
 /**
  * bm_evict_inode - cleanup data associated with @inode
  * @inode: inode to which the data is attached
@@ -618,10 +662,13 @@ static void bm_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	if (e) {
-		write_lock(&entries_lock);
+		struct binfmt_misc *misc;
+
+		misc = i_binfmt_misc(inode);
+		write_lock(&misc->entries_lock);
 		if (!list_empty(&e->list))
 			list_del_init(&e->list);
-		write_unlock(&entries_lock);
+		write_unlock(&misc->entries_lock);
 		put_binfmt_handler(e);
 	}
 }
@@ -675,11 +722,11 @@ static void unlink_binfmt_dentry(struct dentry *dentry)
  * to use writes to files in order to delete binary type handlers. But it has
  * worked for so long that it's not a pressing issue.
  */
-static void remove_binfmt_handler(Node *e)
+static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 {
-	write_lock(&entries_lock);
+	write_lock(&misc->entries_lock);
 	list_del_init(&e->list);
-	write_unlock(&entries_lock);
+	write_unlock(&misc->entries_lock);
 	unlink_binfmt_dentry(e->dentry);
 }
 
@@ -735,7 +782,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		 * actually remove the entry from the list.
 		 */
 		if (!list_empty(&e->list))
-			remove_binfmt_handler(e);
+			remove_binfmt_handler(i_binfmt_misc(inode), e);
 
 		inode_unlock(inode);
 		break;
@@ -761,6 +808,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	struct inode *inode;
 	struct super_block *sb = file_inode(file)->i_sb;
 	struct dentry *root = sb->s_root, *dentry;
+	struct binfmt_misc *misc;
 	int err = 0;
 	struct file *f = NULL;
 
@@ -770,7 +818,18 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		return PTR_ERR(e);
 
 	if (e->flags & MISC_FMT_OPEN_FILE) {
+		const struct cred *old_cred;
+
+		/*
+		 * Now that we support unprivileged binfmt_misc mounts make
+		 * sure we use the credentials that the register @file was
+		 * opened with to also open the interpreter. Before that this
+		 * didn't matter much as only a privileged process could open
+		 * the register file.
+		 */
+		old_cred = override_creds(file->f_cred);
 		f = open_exec(e->interpreter);
+		revert_creds(old_cred);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
@@ -802,9 +861,10 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	inode->i_fop = &bm_entry_operations;
 
 	d_instantiate(dentry, inode);
-	write_lock(&entries_lock);
-	list_add(&e->list, &entries);
-	write_unlock(&entries_lock);
+	misc = i_binfmt_misc(inode);
+	write_lock(&misc->entries_lock);
+	list_add(&e->list, &misc->entries);
+	write_unlock(&misc->entries_lock);
 
 	err = 0;
 out2:
@@ -831,26 +891,31 @@ static const struct file_operations bm_register_operations = {
 static ssize_t
 bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
-	char *s = enabled ? "enabled\n" : "disabled\n";
+	struct binfmt_misc *misc;
+	char *s;
 
+	misc = i_binfmt_misc(file_inode(file));
+	s = misc->enabled ? "enabled\n" : "disabled\n";
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
 static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
+	struct binfmt_misc *misc;
 	int res = parse_command(buffer, count);
 	Node *e, *next;
 	struct inode *inode;
 
+	misc = i_binfmt_misc(file_inode(file));
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
@@ -866,8 +931,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		 * read-only. So we only need to take the write lock when we
 		 * actually remove the entry from the list.
 		 */
-		list_for_each_entry_safe(e, next, &entries, list)
-			remove_binfmt_handler(e);
+		list_for_each_entry_safe(e, next, &misc->entries, list)
+			remove_binfmt_handler(misc, e);
 
 		inode_unlock(inode);
 		break;
@@ -886,32 +951,100 @@ static const struct file_operations bm_status_operations = {
 
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
 
+	if (WARN_ON(user_ns != current_user_ns()))
+		return -EINVAL;
+
+	/*
+	 * Lazily allocate a new binfmt_misc instance for this namespace, i.e.
+	 * do it here during the first mount of binfmt_misc. We don't need to
+	 * waste memory for every user namespace allocation. It's likely much
+	 * more common to not mount a separate binfmt_misc instance than it is
+	 * to mount one.
+	 *
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
+		/*
+		 * If it turns out that most user namespaces actually want to
+		 * register their own binary type handler and therefore all
+		 * create their own separate binfm_misc mounts we should
+		 * consider turning this into a kmem cache.
+		 */
+		misc = kzalloc(sizeof(struct binfmt_misc), GFP_KERNEL);
+		if (!misc)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&misc->entries);
+		rwlock_init(&misc->entries_lock);
+
+		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
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
 
@@ -930,6 +1063,7 @@ static struct file_system_type bm_fs_type = {
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

