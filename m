Return-Path: <linux-fsdevel+bounces-65564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA0C07AC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4B524F2853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A511A347BD7;
	Fri, 24 Oct 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7oSTOsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BA347BAC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329714; cv=none; b=s1I5/6lJt/fkogeoDtZn2ht+8B+wGWAsxIo3pferaA8YpGjagv/4RUJIvh42QiFNW5fe6Gy0TGLv80vIIoCkYVFL+xTBB5XrkRa3wUxJLy+015BGwc2VcjymDI71gS3HQt0+Ohm9J7jTTITeEAzS2jNvB5sAOzK+iBvGx8j4rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329714; c=relaxed/simple;
	bh=39flosLeHSikbyT6rDL2WU9cluujnbGqz2GIrwNKUjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYDpeAJ6QjunIDHD6k2JgmcOW+88aIZT0LUG1vXyvwCoC3bpSh98Wc70nSwOmQEd6LiOsfgfg63Y72+rjpsDm5x0OVjocjeHBNqhqent1+HHjANTcY4vgNcOLq2AP3uyx9FtfJF+LbskYcrKpEf6fTMnWW22Ce/syXDvChuX1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7oSTOsD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cee846998so1573703a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329710; x=1761934510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqA0NRdQJ105/xOyCxwL01PDrFytP4SWVEoqR15mU3k=;
        b=V7oSTOsD1vOuyiEJgVtI4WljKxn2LZN2UQYrw2L/RcFIVo9zSnMc5XErTlhESFbeNK
         SZk/4C2CCLisl3q0JGBWbwR7nxfDCmCWb9NKGttnVyh4sIn69PeHpjFsj12cH5ZrZhAc
         nYHNaxxsrLSc/iuB2YDfbCyEFyXpxeVHj8ygGEdherDkWml2SCnTL3xAG2bw6UYbUn0m
         ysdMFNSTL73U0AATGxJOTzKFJ9eiuL/do3zqCCAhMAIl0U8ZhgZ0bg6YCAMLqKSe5Iq3
         BHEi9ntsgSHihNjiWg33k7WzVnHKcMLFDR7jw0gdz5sPtWUuypmnFZJnjcuvtxWCjlEM
         mtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329710; x=1761934510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqA0NRdQJ105/xOyCxwL01PDrFytP4SWVEoqR15mU3k=;
        b=IaKq8edy7AyA7t0RgAkJYfJ5GVCpWGPIpj/i2j+sBOXAg9GgneH1JELhKbPb9wmz0B
         m3YcrdqwX+bosWFDIg1lyHkXrAKSZVAoEXsjc38pFzpVrIxkNCT1KaKQlqS3llNRiWrP
         C46mPozEX20x2nWX4H6lSbh/IDSXv5v/85OHCfoTvXbl+psgLymjbzuaB1tBRC0bJ66J
         zG9FiiZijk6pToMyy56q9ytw/RIUbXI4WEB7I18Fmz95MKtHPJRmRBi+U44IGq1xhkCR
         jbAjPgqOR4hqjWHSVm2kIfngOju8/GSYEtS1jq2KvQfVGd/GKAU8rR0zYbvnYm9OqPQo
         eZTQ==
X-Gm-Message-State: AOJu0YztAADZfSgUhuwkzE590DIlwyIxEkiefA7T/N/RKC+G1IUutPav
	eOZB2efbSz5ZBqP3sVoUpumLoFiEW7S7dUmdAEiF2aEiFfNF9aW7U3BT
X-Gm-Gg: ASbGncuA0fBQc4DXNI9ZNmWvTA8k/mBN4kFSMpWkb57Bz+8OV5kUg/UDYn/R0UbcL6A
	3+Xjv4+3d1NOEAdnzcPcHgivQkffl8incbQLC9SENxTyit5gXrLJGCRcUGDyjzEXPf4epl2jUgp
	9TGmu+5DwPiQUowp7AAoo17w2KRzITdhVYntawIInoGH3mPgwQf7sPqPIjFT85aQ+JUALNxCYE0
	+nbgmOirHZVBPevO5LtfX3l2pHLwPVdMIg0KIcaSt3ik7bimbbWwsvAPqlRLxVkczWZ1/mshQpa
	/i5/dstfBR7IfupJTY0PiE4+QQzeaKZEnnbh6Kg8/fVb5Ruwtf/5KEOpv5+l4pA8lh64V/tQ1Vl
	B0xBZHO486xzQ2vPk3SkBkmt8jwusWfZMlSQRhEg31wCGSpvPjYd+6p6kjCeJ6Xg5GqHJPaTQWr
	rY
X-Google-Smtp-Source: AGHT+IHpxl1vaHywMTHJt6XsTd3wuUqqopu9lpCGEzJwHos21RCwnrWBjYpTgx/8GxQLE/H2gGhaWA==
X-Received: by 2002:a17:902:d506:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-290c9c8a5d0mr340917485ad.4.1761329709992;
        Fri, 24 Oct 2025 11:15:09 -0700 (PDT)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f0654sm63746795ad.81.2025.10.24.11.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:15:08 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH v3] statmount: accept fd as a parameter
Date: Fri, 24 Oct 2025 23:40:37 +0530
Message-ID: <20251024181443.786363-1-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_BY_FD
flag. When a valid fd is provided and STATMOUNT_BY_FD is set, statmount
will return mountinfo about the mount the fd is on.

This even works for "unmounted" mounts (mounts that have been umounted
using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
on that mount. These "umounted" mounts will have no mountpoint hence we
return "[detached]" and the mnt_ns_id to be 0.

Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
We would like to add support for checkpoint/restoring file descriptors
open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
Userspace) [1].

Currently, we have no way to get mount info for these "unmounted" mounts
since they do appear in /proc/<pid>/mountinfo and statmount does not
work on them, since they do not belong to any mount namespace.

This patch helps us by providing a way to get mountinfo for these
"unmounted" mounts by using a fd on the mount.

Changes from v2 [2] to v3:
* Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
* Fixed UAF bug caused by the reference to fd_mount being bound by scope
of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
* Reused @spare parameter in mnt_id_req instead of adding new fields to
the struct.

Changes from v1 [3] to v2:
v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount.

Introducing umount_mnt_ns complicated namespace locking and modified
performance sensitive code [4] and it was agreed upon that fd-based
statmount would be better.

[1]: https://github.com/checkpoint-restore/criu/pull/2754
[2]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
[3]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
[4]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
---
 fs/namespace.c             | 96 +++++++++++++++++++++++++++-----------
 include/uapi/linux/mount.h |  7 ++-
 2 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..7e47397045dd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
+{
+	seq_puts(seq, "[detached]");
+	return 0;
+}
+
 static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
@@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 {
 	s->sm.mask |= STATMOUNT_MNT_NS_ID;
-	s->sm.mnt_ns_id = ns->ns.ns_id;
+	if (ns)
+		s->sm.mnt_ns_id = ns->ns.ns_id;
+	else
+		s->sm.mnt_ns_id = 0;
 }
 
 static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
@@ -5431,7 +5440,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		break;
 	case STATMOUNT_MNT_POINT:
 		offp = &sm->mnt_point;
-		ret = statmount_mnt_point(s, seq);
+		if (!s->root.mnt && !s->root.dentry)
+			ret = statmount_mnt_point_detached(s, seq);
+		else
+			ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
 		offp = &sm->mnt_opts;
@@ -5572,29 +5584,33 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 
 /* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
-			struct mnt_namespace *ns)
+			struct mnt_namespace *ns, unsigned int flags)
 {
 	struct mount *m;
 	int err;
 
 	/* Has the namespace already been emptied? */
-	if (mnt_ns_id && mnt_ns_empty(ns))
+	if (!(flags & STATMOUNT_BY_FD) && mnt_ns_id && mnt_ns_empty(ns))
 		return -ENOENT;
 
-	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
-	if (!s->mnt)
-		return -ENOENT;
+	if (!(flags & STATMOUNT_BY_FD)) {
+		s->mnt = lookup_mnt_in_ns(mnt_id, ns);
+		if (!s->mnt)
+			return -ENOENT;
+	}
 
-	err = grab_requested_root(ns, &s->root);
-	if (err)
-		return err;
+	if (ns) {
+		err = grab_requested_root(ns, &s->root);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Don't trigger audit denials. We just want to determine what
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
+	if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -5718,7 +5734,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 }
 
 static int copy_mnt_id_req(const struct mnt_id_req __user *req,
-			   struct mnt_id_req *kreq)
+			   struct mnt_id_req *kreq, unsigned int flags)
 {
 	int ret;
 	size_t usize;
@@ -5736,7 +5752,9 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
 	if (ret)
 		return ret;
-	if (kreq->spare != 0)
+	if (flags & STATMOUNT_BY_FD)
+		return 0;
+	if (kreq->fd != 0)
 		return -EINVAL;
 	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
 	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
@@ -5749,20 +5767,21 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
  * that, or if not simply grab a passive reference on our mount namespace and
  * return that.
  */
-static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq)
+static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq,
+						   unsigned int flags)
 {
 	struct mnt_namespace *mnt_ns;
 
-	if (kreq->mnt_ns_id && kreq->spare)
+	if (kreq->mnt_ns_id && kreq->fd)
 		return ERR_PTR(-EINVAL);
 
 	if (kreq->mnt_ns_id)
 		return lookup_mnt_ns(kreq->mnt_ns_id);
 
-	if (kreq->spare) {
+	if (!(flags & STATMOUNT_BY_FD) && kreq->fd) {
 		struct ns_common *ns;
 
-		CLASS(fd, f)(kreq->spare);
+		CLASS(fd, f)(kreq->fd);
 		if (fd_empty(f))
 			return ERR_PTR(-EBADF);
 
@@ -5782,29 +5801,47 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 	return mnt_ns;
 }
 
+DEFINE_FREE(put_file, struct file *, if (_T) fput(_T))
+
 SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 		struct statmount __user *, buf, size_t, bufsize,
 		unsigned int, flags)
 {
 	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct kstatmount *ks __free(kfree) = NULL;
+	struct file *file_from_fd __free(put_file) = NULL;
+	struct vfsmount *fd_mnt;
 	struct mnt_id_req kreq;
 	/* We currently support retrieval of 3 strings. */
 	size_t seq_size = 3 * PATH_MAX;
 	int ret;
 
-	if (flags)
+	if (flags & ~STATMOUNT_BY_FD)
 		return -EINVAL;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, flags);
 	if (ret)
 		return ret;
 
-	ns = grab_requested_mnt_ns(&kreq);
-	if (!ns)
-		return -ENOENT;
+	if (flags & STATMOUNT_BY_FD) {
+		file_from_fd = fget_raw(kreq.fd);
+		if (!file_from_fd)
+			return -EBADF;
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+		fd_mnt = file_from_fd->f_path.mnt;
+		ns = real_mount(fd_mnt)->mnt_ns;
+		if (ns)
+			refcount_inc(&ns->passive);
+		else
+			if (!ns_capable_noaudit(file_from_fd->f_cred->user_ns, CAP_SYS_ADMIN))
+				return -ENOENT;
+	} else {
+		ns = grab_requested_mnt_ns(&kreq, flags);
+		if (!ns)
+			return -ENOENT;
+	}
+
+	if (ns && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -ENOENT;
 
@@ -5817,8 +5854,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
+	if (flags & STATMOUNT_BY_FD)
+		ks->mnt = fd_mnt;
+
 	scoped_guard(namespace_shared)
-		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
+		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns, flags);
 
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
@@ -5910,7 +5950,7 @@ static void __free_klistmount_free(const struct klistmount *kls)
 }
 
 static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
-				     size_t nr_mnt_ids)
+				     size_t nr_mnt_ids, unsigned int flags)
 {
 
 	u64 last_mnt_id = kreq->param;
@@ -5927,7 +5967,7 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	if (!kls->kmnt_ids)
 		return -ENOMEM;
 
-	kls->ns = grab_requested_mnt_ns(kreq);
+	kls->ns = grab_requested_mnt_ns(kreq, flags);
 	if (!kls->ns)
 		return -ENOENT;
 
@@ -5957,11 +5997,11 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
 		return -EFAULT;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, 0);
 	if (ret)
 		return ret;
 
-	ret = prepare_klistmount(&kls, &kreq, nr_mnt_ids);
+	ret = prepare_klistmount(&kls, &kreq, nr_mnt_ids, flags);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7fa67c2031a5..3eaa21d85531 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -197,7 +197,7 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 spare;
+	__u32 fd;
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
@@ -232,4 +232,9 @@ struct mnt_id_req {
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
 #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
+/*
+ * @flag bits for statmount(2)
+ */
+#define STATMOUNT_BY_FD		0x0000001U /* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.51.0


