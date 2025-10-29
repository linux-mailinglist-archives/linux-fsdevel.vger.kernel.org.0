Return-Path: <linux-fsdevel+bounces-66177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8382C18486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BD93AA961
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 05:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1B2F744F;
	Wed, 29 Oct 2025 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1E2JS1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE872625
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715327; cv=none; b=F2aRC4aS9OtN8AkmupZJoVM84WJwpYlG/KIGdg86xb/XfyzDbnq82gH4ovPfA6LPUPoZJWF+tTdbBEcbYcRCadag78hpvNR/IjBi1dArWRatx0vmtCdePxxNvHfgGPu5mZaj0zR+MNrS9I1uUuNNFj0uC+UqDmVcTjvRe+zrUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715327; c=relaxed/simple;
	bh=J1mI4dFP4VGPtKDVh7T/yZkWFbrjYmWOrBdMaCQk4Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeedJGqvE1Q5FODqFnsus5abm+GhH85sHHWWEXRjIH0mRYOgC2KHU3tNM1RzbKdAUKJl7iX8TCjR5S+fB9rm4CQB1n+0RwZGx2EdaCJyhnj6EZciKfbg0jR/5ajbv6jiQTqt1veUsJoZYlTjVtfIY9RInd4qmmVeaDl5LynnZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1E2JS1F; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cf1a95274so4704256a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 22:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761715325; x=1762320125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SODIa8BuF+U0+vkCdFW3wGqNqj2DDjcIFg619XtnjjM=;
        b=m1E2JS1F+WI11eBDa04tJ32wlNbBpkaJoQPUY7Gc8cJl7gJKLGOe5JN6UNinZTqUKM
         AOzCszxWSSDIOtkKi5S5UQ5c3p+HrrLi65F17P/d8bXVcQ9rtSWslzaDelBuBc2j02V+
         oWt7LUCBhfZGLVMqEp70F/6cpj15mfZy6qGXU0lgInnOnxqi5MFKuFhPjp6jaziog8JV
         tLRIUnZnGaw8zhEj062uMtPmPgOG5eZ2xdOGfvUJ4QJ0WCRjVNmN90eEkU0E/rCl8pX+
         G8FW8l1nFsU9o7OfE3kZ3L2IvSAalsaKwgjncZYas6RfWfAXYIeU1ZUbd+OMJruuPufP
         2LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761715325; x=1762320125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SODIa8BuF+U0+vkCdFW3wGqNqj2DDjcIFg619XtnjjM=;
        b=FuBaaBh5XPh7j4xsxm68fClvotm7qc0c8BRQxMZUmJk/OXi3TwVEHPL14lUOnD6QR1
         fx/AgWJwNHc71LDCJjRtmiNBevHkxTBdqA4LF2RdWIzyW9OZ9QkMEDCE/yVn+I8yl2Ju
         j26g01ekgxUhUZRAKhlApbi251DDctbn70X7UtTgKzaJztCQQC9466g3AYptdnTZnps5
         ygr3EIjFai0a/i1ypgVaTQelNMEj3sB/PtNmXT5ImANOrbxrVzTG4jCbm82waAQN8A8Y
         jNXkOmj+0/Rk/PYPCVYAYd1Cc4eya548O0nS6UIJoY/r6xzSVOHY2z9l8KgQQ4um2i2A
         6nBQ==
X-Gm-Message-State: AOJu0YzYujI7cH24aNm0dGxR0Tl2wg3YmQEmggv4+f5AH9WGE3VAjBC4
	FeE/RsEHT5uGXeR3/qCvJC5ws/zUks53fq1itp6eBZe+8rUPRtwkz9E3
X-Gm-Gg: ASbGncs8sFoTIKmeUek+TdetfQdxmUNBpVQT1nFQS2KytZczGhc1yOH4C3NxCOvxz1i
	5n+09Jf3tx64ZF9LVxzCJfdOzQfX6XaSLXyfuYg7rBmU6mVWl4S6iUQaS+lTTte9FdVrp6FHWiA
	0wD6uPbHILZMPj/vK6V0f6tWK83tYCEMY8lIioHR3fntA/4FcuGp7r5sspARRMetxdLl2r7hcMB
	+995RuLpxg5JPwpLHXz2CLdXgMp+lsRUhPiUzed1UQfEbwgv9NqjmolFBfbHTCs9wTUJ3EP50N9
	rlk+y4/HZgWW1vJI18NiCMMaTVSqtoaWlFsejCKFLTtdHlAT2Dv7wHLOfHK68oaGmyRMC9De+7F
	enwz7LVFtPD5w6gRBGGsTAchIjrDiqXT8ok+pGGqV08zgovI2IAD6epzKjIP0iJtHGAdt1K0jgY
	wu71Gs9+/lOXs=
X-Google-Smtp-Source: AGHT+IHq+REJiWLZzR5S1J6mU0X9dNNWeI0M3PMSnOJRJ/dhwy6XNNazaPfIVkBPK2xkf5TN9/SLEw==
X-Received: by 2002:a17:902:e747:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-294dee11281mr20543155ad.22.1761715324543;
        Tue, 28 Oct 2025 22:22:04 -0700 (PDT)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm138700755ad.8.2025.10.28.22.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:22:04 -0700 (PDT)
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
Subject: [PATCH v4] statmount: accept fd as a parameter
Date: Wed, 29 Oct 2025 10:47:05 +0530
Message-ID: <20251029052037.506273-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.1
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
return "[unmounted]" and the mnt_ns_id to be 0.

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

Changes from v3 [2] to v4:
* Change the string returned when there is no mountpoint to be
"[unmounted]" instead of "[detached]".
* Remove the new DEFINE_FREE put_file and use the one already present in
include/linux/file.h (fput) [3].
* Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
prepare_klistmount prototype.
* If STATMOUNT_BY_FD is set, check for mnt_ns_id && mnt_id to be 0.

Changes from v2 [4] to v3:
* Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
* Fixed UAF bug caused by the reference to fd_mount being bound by scope
of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
* Reused @spare parameter in mnt_id_req instead of adding new fields to
the struct.

Changes from v1 [5] to v2:
v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount.

Introducing umount_mnt_ns complicated namespace locking and modified
performance sensitive code [6] and it was agreed upon that fd-based
statmount would be better.

[1]: https://github.com/checkpoint-restore/criu/pull/2754
[2]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gmail.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/file.h#n97
[4]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
[5]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
[6]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
---
 fs/namespace.c             | 101 ++++++++++++++++++++++++++-----------
 include/uapi/linux/mount.h |   7 ++-
 2 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..516de51ab521 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_mnt_point_unmounted(struct kstatmount *s, struct seq_file *seq)
+{
+	seq_puts(seq, "[unmounted]");
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
+			ret = statmount_mnt_point_unmounted(s, seq);
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
@@ -5736,11 +5752,16 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
 	if (ret)
 		return ret;
-	if (kreq->spare != 0)
-		return -EINVAL;
-	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
-	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
-		return -EINVAL;
+	if (flags & STATMOUNT_BY_FD) {
+		if (kreq->mnt_id || kreq->mnt_ns_id)
+			return -EINVAL;
+	} else {
+		if (kreq->fd != 0)
+			return -EINVAL;
+		/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+		if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
+			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -5749,20 +5770,21 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
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
 
@@ -5788,23 +5810,39 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct kstatmount *ks __free(kfree) = NULL;
+	struct file *file_from_fd __free(fput) = NULL;
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
+
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
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+	if (ns && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -ENOENT;
 
@@ -5817,8 +5855,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
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
@@ -5927,7 +5968,7 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	if (!kls->kmnt_ids)
 		return -ENOMEM;
 
-	kls->ns = grab_requested_mnt_ns(kreq);
+	kls->ns = grab_requested_mnt_ns(kreq, 0);
 	if (!kls->ns)
 		return -ENOENT;
 
@@ -5957,7 +5998,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
 		return -EFAULT;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, 0);
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
2.51.1


