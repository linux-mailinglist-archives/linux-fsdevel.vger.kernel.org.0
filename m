Return-Path: <linux-fsdevel+bounces-7277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF208237AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABA128464D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607DC1DDE9;
	Wed,  3 Jan 2024 22:20:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043621DA4A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GjxKA019854
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:20:52 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcyxp65jj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:20:52 -0800
Received: from twshared44805.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:20:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id BEA9F3DF9EA74; Wed,  3 Jan 2024 14:20:41 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Date: Wed, 3 Jan 2024 14:20:08 -0800
Message-ID: <20240103222034.2582628-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u4p0vKwfjIaRo4yunP3JHvUEJCLs16HP
X-Proofpoint-GUID: u4p0vKwfjIaRo4yunP3JHvUEJCLs16HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Add new kind of BPF kernel object, BPF token. BPF token is meant to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while having a good amount of control over whic=
h
privileged operations could be performed using provided BPF token.

This is achieved through mounting BPF FS instance with extra delegation
mount options, which determine what operations are delegatable, and also
constraining it to the owning user namespace (as mentioned in the
previous patch).

BPF token itself is just a derivative from BPF FS and can be created
through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
FS FD, which can be attained through open() API by opening BPF FS mount
point. Currently, BPF token "inherits" delegated command, map types,
prog type, and attach type bit sets from BPF FS as is. In the future,
having an BPF token as a separate object with its own FD, we can allow
to further restrict BPF token's allowable set of things either at the
creation time or after the fact, allowing the process to guard itself
further from unintentionally trying to load undesired kind of BPF
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
a per-container "flag" to grant overall ability to use bpf() (plus furthe=
r
restrict on which parts of bpf() syscalls are treated as namespaced).

Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
within the BPF FS owning user namespace, rounding up the ns_capable()
story of BPF token.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  41 +++++++
 include/uapi/linux/bpf.h       |  37 ++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  12 +-
 kernel/bpf/syscall.c           |  17 +++
 kernel/bpf/token.c             | 214 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  37 ++++++
 7 files changed, 354 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d3658bd959f2..e87fe928645f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -52,6 +52,10 @@ struct module;
 struct bpf_func_state;
 struct ftrace_ops;
 struct cgroup;
+struct bpf_token;
+struct user_namespace;
+struct super_block;
+struct inode;
=20
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1620,6 +1624,13 @@ struct bpf_mount_opts {
 	u64 delegate_attachs;
 };
=20
+struct bpf_token {
+	struct work_struct work;
+	atomic64_t refcnt;
+	struct user_namespace *userns;
+	u64 allowed_cmds;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
=20
@@ -2079,6 +2090,7 @@ static inline void bpf_enable_instrumentation(void)
 	migrate_enable();
 }
=20
+extern const struct super_operations bpf_super_ops;
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
@@ -2213,6 +2225,8 @@ static inline void bpf_map_dec_elem_count(struct bp=
f_map *map)
=20
 extern int sysctl_unprivileged_bpf_disabled;
=20
+bool bpf_token_capable(const struct bpf_token *token, int cap);
+
 static inline bool bpf_allow_ptr_leaks(void)
 {
 	return perfmon_capable();
@@ -2247,8 +2261,17 @@ int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
=20
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+int bpf_token_create(union bpf_attr *attr);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
);
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags=
);
+struct inode *bpf_get_inode(struct super_block *sb, const struct inode *=
dir,
+			    umode_t mode);
=20
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
@@ -2606,6 +2629,24 @@ static inline int bpf_obj_get_user(const char __us=
er *pathname, int flags)
 	return -EOPNOTSUPP;
 }
=20
+static inline bool bpf_token_capable(const struct bpf_token *token, int =
cap)
+{
+	return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN=
));
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
index 754e68ca8744..ab48e037d543 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -847,6 +847,36 @@ union bpf_iter_link_info {
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
@@ -901,6 +931,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
=20
 enum bpf_map_type {
@@ -1714,6 +1746,11 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_fd;
+	} token_create;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..4ce95acfcaa7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
 endif
 CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-no=
gcse-yy)
=20
-obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 70b748f6228c..565be1f3f1ea 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops =3D =
{ };
 static const struct inode_operations bpf_map_iops  =3D { };
 static const struct inode_operations bpf_link_iops  =3D { };
=20
-static struct inode *bpf_get_inode(struct super_block *sb,
-				   const struct inode *dir,
-				   umode_t mode)
+struct inode *bpf_get_inode(struct super_block *sb,
+			    const struct inode *dir,
+			    umode_t mode)
 {
 	struct inode *inode;
=20
@@ -603,6 +603,7 @@ static int bpf_show_options(struct seq_file *m, struc=
t dentry *root)
 	struct inode *inode =3D d_inode(root);
 	umode_t mode =3D inode->i_mode & S_IALLUGO & ~S_ISVTX;
 	struct bpf_mount_opts *opts =3D root->d_sb->s_fs_info;
+	u64 mask;
=20
 	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=3D%u",
@@ -613,7 +614,8 @@ static int bpf_show_options(struct seq_file *m, struc=
t dentry *root)
 	if (mode !=3D S_IRWXUGO)
 		seq_printf(m, ",mode=3D%o", mode);
=20
-	if (opts->delegate_cmds =3D=3D ~0ULL)
+	mask =3D (1ULL << __MAX_BPF_CMD) - 1;
+	if ((opts->delegate_cmds & mask) =3D=3D mask)
 		seq_printf(m, ",delegate_cmds=3Dany");
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
@@ -646,7 +648,7 @@ static void bpf_free_inode(struct inode *inode)
 	free_inode_nonrcu(inode);
 }
=20
-static const struct super_operations bpf_super_ops =3D {
+const struct super_operations bpf_super_ops =3D {
 	.statfs		=3D simple_statfs,
 	.drop_inode	=3D generic_delete_inode,
 	.show_options	=3D bpf_show_options,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2392e1802364..423702f33ba6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5390,6 +5390,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
=20
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_fd
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
@@ -5523,6 +5537,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsig=
ned int size)
 	case BPF_PROG_BIND_MAP:
 		err =3D bpf_prog_bind_map(&attr);
 		break;
+	case BPF_TOKEN_CREATE:
+		err =3D token_create(&attr);
+		break;
 	default:
 		err =3D -EINVAL;
 		break;
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
new file mode 100644
index 000000000000..e18aaecc67e9
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,214 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
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
+	/* BPF token allows ns_capable() level of capabilities, but only if
+	 * token's userns is *exactly* the same as current user's userns
+	 */
+	if (token && current_user_ns() =3D=3D token->userns) {
+		if (ns_capable(token->userns, cap))
+			return true;
+		if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN)=
)
+			return true;
+	}
+	/* otherwise fallback to capable() checks */
+	return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN=
));
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
+	struct bpf_token *token =3D container_of(work, struct bpf_token, work);
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
+	struct bpf_token *token =3D filp->private_data;
+
+	bpf_token_put(token);
+	return 0;
+}
+
+static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	struct bpf_token *token =3D filp->private_data;
+	u64 mask;
+
+	BUILD_BUG_ON(__MAX_BPF_CMD >=3D 64);
+	mask =3D (1ULL << __MAX_BPF_CMD) - 1;
+	if ((token->allowed_cmds & mask) =3D=3D mask)
+		seq_printf(m, "allowed_cmds:\tany\n");
+	else
+		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+}
+
+#define BPF_TOKEN_INODE_NAME "bpf-token"
+
+static const struct inode_operations bpf_token_iops =3D { };
+
+static const struct file_operations bpf_token_fops =3D {
+	.release	=3D bpf_token_release,
+	.show_fdinfo	=3D bpf_token_show_fdinfo,
+};
+
+int bpf_token_create(union bpf_attr *attr)
+{
+	struct bpf_mount_opts *mnt_opts;
+	struct bpf_token *token =3D NULL;
+	struct user_namespace *userns;
+	struct inode *inode;
+	struct file *file;
+	struct path path;
+	struct fd f;
+	umode_t mode;
+	int err, fd;
+
+	f =3D fdget(attr->token_create.bpffs_fd);
+	if (!f.file)
+		return -EBADF;
+
+	path =3D f.file->f_path;
+	path_get(&path);
+	fdput(f);
+
+	if (path.dentry !=3D path.mnt->mnt_sb->s_root) {
+		err =3D -EINVAL;
+		goto out_path;
+	}
+	if (path.mnt->mnt_sb->s_op !=3D &bpf_super_ops) {
+		err =3D -EINVAL;
+		goto out_path;
+	}
+	err =3D path_permission(&path, MAY_ACCESS);
+	if (err)
+		goto out_path;
+
+	userns =3D path.dentry->d_sb->s_user_ns;
+	/*
+	 * Enforce that creators of BPF tokens are in the same user
+	 * namespace as the BPF FS instance. This makes reasoning about
+	 * permissions a lot easier and we can always relax this later.
+	 */
+	if (current_user_ns() !=3D userns) {
+		err =3D -EPERM;
+		goto out_path;
+	}
+	if (!ns_capable(userns, CAP_BPF)) {
+		err =3D -EPERM;
+		goto out_path;
+	}
+
+	mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
+	inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
+	if (IS_ERR(inode)) {
+		err =3D PTR_ERR(inode);
+		goto out_path;
+	}
+
+	inode->i_op =3D &bpf_token_iops;
+	inode->i_fop =3D &bpf_token_fops;
+	clear_nlink(inode); /* make sure it is unlinked */
+
+	file =3D alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDW=
R, &bpf_token_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		err =3D PTR_ERR(file);
+		goto out_path;
+	}
+
+	token =3D kvzalloc(sizeof(*token), GFP_USER);
+	if (!token) {
+		err =3D -ENOMEM;
+		goto out_file;
+	}
+
+	atomic64_set(&token->refcnt, 1);
+
+	/* remember bpffs owning userns for future ns_capable() checks */
+	token->userns =3D get_user_ns(userns);
+
+	mnt_opts =3D path.dentry->d_sb->s_fs_info;
+	token->allowed_cmds =3D mnt_opts->delegate_cmds;
+
+	fd =3D get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err =3D fd;
+		goto out_token;
+	}
+
+	file->private_data =3D token;
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
+	struct fd f =3D fdget(ufd);
+	struct bpf_token *token;
+
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+	if (f.file->f_op !=3D &bpf_token_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	token =3D f.file->private_data;
+	bpf_token_inc(token);
+	fdput(f);
+
+	return token;
+}
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd=
)
+{
+	/* BPF token can be used only within exactly the same userns in which
+	 * it was created
+	 */
+	if (!token || current_user_ns() !=3D token->userns)
+		return false;
+
+	return token->allowed_cmds & (1ULL << cmd);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 7f24d898efbb..57487d0c0b73 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -847,6 +847,36 @@ union bpf_iter_link_info {
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
@@ -901,6 +931,8 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
+	__MAX_BPF_CMD,
 };
=20
 enum bpf_map_type {
@@ -1714,6 +1746,11 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		__u32		flags;
+		__u32		bpffs_fd;
+	} token_create;
+
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
--=20
2.34.1


