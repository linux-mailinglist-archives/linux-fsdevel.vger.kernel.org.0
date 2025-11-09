Return-Path: <linux-fsdevel+bounces-67557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CBDC438E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 06:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 878FC34752D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D980023E320;
	Sun,  9 Nov 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqkG8e5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFC23B605
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762666817; cv=none; b=LxU0lamvu4RFyYWVxawC9P++8LrfAGsVD5YBo5mnYl90gjzLqPj+mZtlOTy8yVN4o6TiU2h+Znof6IhxV8wcLfnoPiPXUkKzsEKHHQUtDp2mFLZb9uD5+vQxoJuGDBe/AtLVv29+8jjIdjL77/Ujhq2P3JrMsOdoc88x7z9l7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762666817; c=relaxed/simple;
	bh=jD5ld4+9VPClfs4oJtISBaXHCh54bqpe2OO3WNXLAoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLtO0Jr2dtRhHMfgG+nuDOmDCSu4W+QVWtDvCNZQuUbsVoE5zBHBYZ1yNWANfkhx/xnko+XfiP0nphBY56Rp7W31Tp7EjtfmXeUneSMqFudUHTfnZi3uHgxQnyL4XKjbVNwp8Gm5UFXDYMAPSodi0poQLzNvYDHEnqbOmJG6PME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqkG8e5J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298145fe27eso153205ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 21:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762666815; x=1763271615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zF04vsYRgB1l2omMpmeobc+4MiMrn2fxFE+4l0Q+OA=;
        b=SqkG8e5J+CAkC/RtaC7QZ4wfBWp9nGHbH0ctpqS3rKxBHs1LwbwG0SFqacbIlQEhEt
         UqHS2xfd3wCiCs65ITYyPUj9AYtuz3KpiV6GHFLvfffNCn9or/nCxjI3iQHhChadxPB5
         gRkLPS51DKgWu0IsYeXyDplzPeTi71ia+Vmi0+5KYoKAy6Yh6IUIs/k6+GFcY8GihwAF
         2fmzpYbYRA7gaxdlDKMlXFhxNzsYhXUZAQgDs4E8iuS02s2L8jw5p8figJAZpyk91N4u
         jlYQaX/XWkiRWFELhrFztTP/wS27pEiBLZIwoC+N82wBPCJ/7Y+qGYTnV4U+1QU7V4zv
         6RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762666815; x=1763271615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zF04vsYRgB1l2omMpmeobc+4MiMrn2fxFE+4l0Q+OA=;
        b=h9ky9gtv1Yg2ogkCx51VIJXX/WqYuf8L/BCNKV83AqZhxhZEqufk6v/IzewnNQPIT7
         5KnX8kgvaZNw7f6rIjJ/3iCKXuWaAKComAvkyRK26YIi/AxiUCx2+auCGrUOu6C+4ccV
         N8KO5fioe/WtNasxwPfZk/po6p9+tIl9UZAj3/8Dh1rmMzTGRh4Eq45HdY/iVWsPREwY
         Vb2j6db0EMh0HGgkVB8NuQzgV8UrKHhLTnGxlcOxSnDd8tlRL/OCum8jyuCCR5W2Xmrq
         p7gtVZFpLvavoplvaHvqB8mZNwhJInq8zQLsqTVx0cpCrC/Dgo+o8xNwJnQgAL18v8Gh
         w5gQ==
X-Gm-Message-State: AOJu0YzkpCeVf0NnYm3GHWDv++CI4vjhBdD1Ys3eSBR78uLfEpyYOCuU
	9fDLvbAq7P02pFw0qS9jy91ljCt3pr/9rFOKhR0Xm0VOsncpnMJB7rJj
X-Gm-Gg: ASbGncvOtRtqM4bc+y3TcvlRaQIEplUhLvpHftAq3IaRoF4yUJUjb/REoLX9H+5qzh5
	CgBokrC6S//xwdQYTWHkrkXjnpVf0OowE3e3nsiYp8nRf1+UzY2qaP5ZAFnYCzlwbAHC6BVWY4m
	js2ttcmJeTy+6MWPgCltb8si/MKRgw5swR13g92ba3oHMCcmW3ryhK0Hm4sMJbMau3iKsnougP7
	5kLellPuIweNV9wfoH8B4lKeghcOdzO84fmzhm9sOHP1arqCPh07++MKxfNx9iBF4i7b+Q3vu7j
	6S6VEN+2NKs6Kiv8Ue3DF1FeAwbVB5xNKENafleBLbRtx4D+Uh8sE5jU9T7QRqGSVMvs72ZfSqi
	CMxkwgW+lhv5U1fqQT6ppq4QVnIZ0kmeUKkvbF57sLFTuHkEly6+sE5EDGb8D6gYIdAx2/tOGIs
	A=
X-Google-Smtp-Source: AGHT+IEKPjRWRoxD2rH2w/CMr9fk/xfdJscfS5I9I1AI1GxACeJaQzGNBZPGxuoeQWvfWBjbvQSGgQ==
X-Received: by 2002:a17:902:f683:b0:297:e231:f40c with SMTP id d9443c01a7336-297e562ea74mr58353145ad.19.1762666814499;
        Sat, 08 Nov 2025 21:40:14 -0800 (PST)
Received: from fedora ([115.99.142.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c5ccsm103970185ad.57.2025.11.08.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 21:40:14 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	criu@lists.linux.dev,
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
Subject: [PATCH v5] statmount: accept fd as a parameter
Date: Sun,  9 Nov 2025 11:03:17 +0530
Message-ID: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
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

Changes from v4 [2] to v5:
Check only for s->root.mnt to be NULL instead of checking for both
s->root.mnt and s->root.dentry (I did not find a case where only one of
them would be NULL).

* Only allow system root (CAP_SYS_ADMIN in init_user_ns) to call
statmount() on fd's on "unmounted" mounts. We (mostly Pavel) spent some
time thinking about how our previous approach (of checking the opener's
file credentials) caused problems.

Please take a look at the linked pictures they describe everything more
clearly.

Case 1: A fd is on a normal mount (Link to Picture: [3])
Consider, a situation where we have two processes P1 and P2 and a file
F1. F1 is opened on mount ns M1 by P1. P1 is nested inside user
namespace U1 and U2. P2 is also in U1. P2 is also in a pid namespace and
mount namespace separate from M1.

P1 sends F1 to P2 (using a unix socket). But, P2 is unable to call
statmount() on F1 because since it is a separate pid and mount
namespace. This is good and expected.

Case 2: A fd is on a "unmounted" mount (Link to Picture: [4])
Consider a similar situation as Case 1. But now F1 is on a mounted that
has been "unmounted". Now, since we used openers credentials to check
for permissions P2 ends up having the ability call statmount() and get
mount info for this "unmounted" mount.

Hence, It is better to restrict the ability to call statmount() on fds
on "unmounted" mounts to system root only (There could also be other
cases than the one described above).

Changes from v3 [5] to v4:
* Change the string returned when there is no mountpoint to be
"[unmounted]" instead of "[detached]".
* Remove the new DEFINE_FREE put_file and use the one already present in
include/linux/file.h (fput) [6].
* Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
prepare_klistmount prototype.
* If STATMOUNT_BY_FD is set, check for mnt_ns_id == 0 && mnt_id == 0.

Changes from v2 [7] to v3:
* Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
* Fixed UAF bug caused by the reference to fd_mount being bound by scope
of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
* Reused @spare parameter in mnt_id_req instead of adding new fields to
the struct.

Changes from v1 [8] to v2:
v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount.

Introducing umount_mnt_ns complicated namespace locking and modified
performance sensitive code [9] and it was agreed upon that fd-based
statmount would be better.

This code is also available on github [10].

[1]: https://github.com/checkpoint-restore/criu/pull/2754
[2]: https://lore.kernel.org/all/20251029052037.506273-2-b.sachdev1904@gmail.com/
[3]: https://github.com/bsach64/linux/blob/statmount-fd-v5/fd_on_normal_mount.png
[4]: https://github.com/bsach64/linux/blob/statmount-fd-v5/file_on_unmounted_mount.png
[5]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gmail.com/
[6]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/file.h#n97
[7]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
[8]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
[9]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
[10]: https://github.com/bsach64/linux/tree/statmount-fd-v5
---
 fs/namespace.c             | 101 ++++++++++++++++++++++++++-----------
 include/uapi/linux/mount.h |   7 ++-
 2 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..153c0ea85386 100644
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
+		if (!s->root.mnt)
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
+			if (!capable(CAP_SYS_ADMIN))
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


