Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF37B0F39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 00:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjI0W64 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjI0W6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:58:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE5114
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:58:48 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38RKBOcL018679
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:58:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3tcpcxvkyd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:58:47 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 27 Sep 2023 15:58:46 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D80CE38C9A634; Wed, 27 Sep 2023 15:58:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v6 bpf-next 03/13] bpf: introduce BPF token object
Date:   Wed, 27 Sep 2023 15:57:59 -0700
Message-ID: <20230927225809.2049655-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927225809.2049655-1-andrii@kernel.org>
References: <20230927225809.2049655-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 23IOl6lBw-i6XSk0XoezlmvptuQ5JGkq
X-Proofpoint-GUID: 23IOl6lBw-i6XSk0XoezlmvptuQ5JGkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new kind of BPF kernel object, BPF token. BPF token is meant to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while have a good amount of control over which
privileged operations could be performed using provided BPF token.

This is achieved through mounting BPF FS instance with extra delegation
mount options, which determine what operations are delegatable, and also
constraining it to the owning user namespace (as mentioned in the
previous patch).

BPF token itself is just a derivative from BPF FS and can be created
through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
a path specification (using the usual fd + string path combo) to a BPF
FS mount. Currently, BPF token "inherits" delegated command, map types,
prog type, and attach type bit sets from BPF FS as is. In the future,
having an BPF token as a separate object with its own FD, we can allow
to further restrict BPF token's allowable set of things either at the creation
time or after the fact, allowing the process to guard itself further
from, e.g., unintentionally trying to load undesired kind of BPF
programs. But for now we keep things simple and just copy bit sets as is.

When BPF token is created from BPF FS mount, we take reference to the
BPF super block's owning user namespace, and then use that namespace for
checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
capabilities that are normally only checked against init userns (using
capable()), but now we check them using ns_capable() instead (if BPF
token is provided). See bpf_token_capable() for details.

Such setup means that BPF token in itself is not sufficient to grant BPF
functionality. User namespaced process has to *also* have necessary
combination of capabilities inside that user namespace. So while
previously CAP_BPF was useless when granted within user namespace, now
it gains a meaning and allows container managers and sys admins to have
a flexible control over which processes can and need to use BPF
functionality within the user namespace (i.e., container in practice).
And BPF FS delegation mount options and derived BPF tokens serve as
a per-container "flag" to grant overall ability to use bpf() (plus further
restrict on which parts of bpf() syscalls are treated as namespaced).

The alternative to creating BPF token object was:
  a) not having any extra object and just pasing BPF FS path to each
     relevant bpf() command. This seems suboptimal as it's racy (mount
     under the same path might change in between checking it and using it
     for bpf() command). And also less flexible if we'd like to further
     restrict ourselves compared to all the delegated functionality
     allowed on BPF FS.
  b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
     a dedicated FD that would represent a token-like functionality. This
     doesn't seem superior to having a proper bpf() command, so
     BPF_TOKEN_CREATE was chosen.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  40 +++++++
 include/uapi/linux/bpf.h       |  39 +++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  10 +-
 kernel/bpf/syscall.c           |  17 +++
 kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  39 +++++++
 7 files changed, 339 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5bd40f71fd0..c43131a24579 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -51,6 +51,10 @@ struct module;
 struct bpf_func_state;
 struct ftrace_ops;
 struct cgroup;
+struct bpf_token;
+struct user_namespace;
+struct super_block;
+struct inode;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1572,6 +1576,13 @@ struct bpf_mount_opts {
 	u64 delegate_attachs;
 };
 
+struct bpf_token {
+	struct work_struct work;
+	atomic64_t refcnt;
+	struct user_namespace *userns;
+	u64 allowed_cmds;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
 
@@ -2162,6 +2173,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
 
 extern int sysctl_unprivileged_bpf_disabled;
 
+bool bpf_token_capable(const struct bpf_token *token, int cap);
+
 static inline bool bpf_allow_ptr_leaks(void)
 {
 	return perfmon_capable();
@@ -2196,8 +2209,17 @@ int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
 
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+int bpf_token_create(union bpf_attr *attr);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
+struct inode *bpf_get_inode(struct super_block *sb, const struct inode *dir,
+			    umode_t mode);
 
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
@@ -2557,6 +2579,24 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
 	return -EOPNOTSUPP;
 }
 
+static inline bool bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+}
+
+static inline void bpf_token_inc(struct bpf_token *token)
+{
+}
+
+static inline void bpf_token_put(struct bpf_token *token)
+{
+}
+
+static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void __dev_flush(void)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70bfa997e896..78692911f4a0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -847,6 +847,37 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows:
+ *		- a set of allowed bpf() syscall commands;
+ *		- a set of allowed BPF map types to be created with
+ *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
+ *		- a set of allowed BPF program types and BPF program attach
+ *		types to be loaded with BPF_PROG_LOAD command, if
+ *		BPF_PROG_LOAD itself is allowed.
+ *
+ *		BPF token is created (derived) from an instance of BPF FS,
+ *		assuming it has necessary delegation mount options specified.
+ *		BPF FS mount is specified with openat()-style path FD + string.
+ *		This BPF token can be passed as an extra parameter to various
+ *		bpf() syscall commands to grant BPF subsystem functionality to
+ *		unprivileged processes.
+ *
+ *		When created, BPF token is "associated" with the owning
+ *		user namespace of BPF FS instance (super block) that it was
+ *		derived from, and subsequent BPF operations performed with
+ *		BPF token would be performing capabilities checks (i.e.,
+ *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
+ *		that user namespace. Without BPF token, such capabilities
+ *		have to be granted in init user namespace, making bpf()
+ *		syscall incompatible with user namespace, for the most part.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -901,6 +932,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
 
 enum bpf_map_type {
@@ -1694,6 +1727,12 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_path_fd;
+		__u64		bpffs_pathname;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..4ce95acfcaa7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 24b3faf901f4..de1fdf396521 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops = { };
 static const struct inode_operations bpf_map_iops  = { };
 static const struct inode_operations bpf_link_iops  = { };
 
-static struct inode *bpf_get_inode(struct super_block *sb,
-				   const struct inode *dir,
-				   umode_t mode)
+struct inode *bpf_get_inode(struct super_block *sb,
+			    const struct inode *dir,
+			    umode_t mode)
 {
 	struct inode *inode;
 
@@ -603,11 +603,13 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
+	u64 mask;
 
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 
-	if (opts->delegate_cmds == ~0ULL)
+	mask = (1ULL << __MAX_BPF_CMD) - 1;
+	if ((opts->delegate_cmds & mask) == mask)
 		seq_printf(m, ",delegate_cmds=any");
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7445dad01fb3..b47791a80930 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5304,6 +5304,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_pathname
+
+static int token_create(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_TOKEN_CREATE))
+		return -EINVAL;
+
+	/* no flags are supported yet */
+	if (attr->token_create.flags)
+		return -EINVAL;
+
+	return bpf_token_create(attr);
+}
+
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5437,6 +5451,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_BIND_MAP:
 		err = bpf_prog_bind_map(&attr);
 		break;
+	case BPF_TOKEN_CREATE:
+		err = token_create(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
new file mode 100644
index 000000000000..779aad5007a3
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,197 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/namei.h>
+#include <linux/user_namespace.h>
+
+bool bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	/* BPF token allows ns_capable() level of capabilities */
+	if (token) {
+		if (ns_capable(token->userns, cap))
+			return true;
+		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
+			return true;
+	}
+	/* otherwise fallback to capable() checks */
+	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+}
+
+void bpf_token_inc(struct bpf_token *token)
+{
+	atomic64_inc(&token->refcnt);
+}
+
+static void bpf_token_free(struct bpf_token *token)
+{
+	put_user_ns(token->userns);
+	kvfree(token);
+}
+
+static void bpf_token_put_deferred(struct work_struct *work)
+{
+	struct bpf_token *token = container_of(work, struct bpf_token, work);
+
+	bpf_token_free(token);
+}
+
+void bpf_token_put(struct bpf_token *token)
+{
+	if (!token)
+		return;
+
+	if (!atomic64_dec_and_test(&token->refcnt))
+		return;
+
+	INIT_WORK(&token->work, bpf_token_put_deferred);
+	schedule_work(&token->work);
+}
+
+static int bpf_token_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_token *token = filp->private_data;
+
+	bpf_token_put(token);
+	return 0;
+}
+
+static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	struct bpf_token *token = filp->private_data;
+	u64 mask;
+
+	mask = (1ULL << __MAX_BPF_CMD) - 1;
+	if ((token->allowed_cmds & mask) == mask)
+		seq_printf(m, "allowed_cmds:\tany\n");
+	else
+		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+}
+
+static struct bpf_token *bpf_token_alloc(void)
+{
+	struct bpf_token *token;
+
+	token = kvzalloc(sizeof(*token), GFP_USER);
+	if (!token)
+		return NULL;
+
+	atomic64_set(&token->refcnt, 1);
+
+	return token;
+}
+
+#define BPF_TOKEN_INODE_NAME "bpf-token"
+
+static const struct inode_operations bpf_token_iops = { };
+
+static const struct file_operations bpf_token_fops = {
+	.release	= bpf_token_release,
+	.show_fdinfo	= bpf_token_show_fdinfo,
+};
+
+int bpf_token_create(union bpf_attr *attr)
+{
+	struct bpf_mount_opts *mnt_opts;
+	struct bpf_token *token = NULL;
+	struct inode *inode;
+	struct file *file;
+	struct path path;
+	umode_t mode;
+	int err, fd;
+
+	err = user_path_at(attr->token_create.bpffs_path_fd,
+			   u64_to_user_ptr(attr->token_create.bpffs_pathname),
+			   LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
+	if (err)
+		return err;
+
+	if (path.mnt->mnt_root != path.dentry) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	err = path_permission(&path, MAY_ACCESS);
+	if (err)
+		goto out_path;
+
+	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
+	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out_path;
+	}
+
+	inode->i_op = &bpf_token_iops;
+	inode->i_fop = &bpf_token_fops;
+	clear_nlink(inode); /* make sure it is unlinked */
+
+	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		err = PTR_ERR(file);
+		goto out_file;
+	}
+
+	token = bpf_token_alloc();
+	if (!token) {
+		err = -ENOMEM;
+		goto out_file;
+	}
+
+	/* remember bpffs owning userns for future ns_capable() checks */
+	token->userns = get_user_ns(path.dentry->d_sb->s_user_ns);
+
+	mnt_opts = path.dentry->d_sb->s_fs_info;
+	token->allowed_cmds = mnt_opts->delegate_cmds;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto out_token;
+	}
+
+	file->private_data = token;
+	fd_install(fd, file);
+
+	path_put(&path);
+	return fd;
+
+out_token:
+	bpf_token_free(token);
+out_file:
+	fput(file);
+out_path:
+	path_put(&path);
+	return err;
+}
+
+struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	struct fd f = fdget(ufd);
+	struct bpf_token *token;
+
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+	if (f.file->f_op != &bpf_token_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	token = f.file->private_data;
+	bpf_token_inc(token);
+	fdput(f);
+
+	return token;
+}
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	if (!token)
+		return false;
+
+	return token->allowed_cmds & (1ULL << cmd);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70bfa997e896..78692911f4a0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -847,6 +847,37 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows:
+ *		- a set of allowed bpf() syscall commands;
+ *		- a set of allowed BPF map types to be created with
+ *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
+ *		- a set of allowed BPF program types and BPF program attach
+ *		types to be loaded with BPF_PROG_LOAD command, if
+ *		BPF_PROG_LOAD itself is allowed.
+ *
+ *		BPF token is created (derived) from an instance of BPF FS,
+ *		assuming it has necessary delegation mount options specified.
+ *		BPF FS mount is specified with openat()-style path FD + string.
+ *		This BPF token can be passed as an extra parameter to various
+ *		bpf() syscall commands to grant BPF subsystem functionality to
+ *		unprivileged processes.
+ *
+ *		When created, BPF token is "associated" with the owning
+ *		user namespace of BPF FS instance (super block) that it was
+ *		derived from, and subsequent BPF operations performed with
+ *		BPF token would be performing capabilities checks (i.e.,
+ *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
+ *		that user namespace. Without BPF token, such capabilities
+ *		have to be granted in init user namespace, making bpf()
+ *		syscall incompatible with user namespace, for the most part.
+ *
+ *	Return
+ *		A new file descriptor (a nonnegative integer), or -1 if an
+ *		error occurred (in which case, *errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -901,6 +932,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
 
 enum bpf_map_type {
@@ -1694,6 +1727,12 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_path_fd;
+		__u64		bpffs_pathname;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.34.1

