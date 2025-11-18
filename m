Return-Path: <linux-fsdevel+bounces-68921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DFC6846E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11B4B358F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48876305971;
	Tue, 18 Nov 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqaCJ54N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678E30E844
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455749; cv=none; b=S9dwGl8YTiplTkk0GDteJ5z9RAX6hsb6+EAqKcdMu8+tFzfiKVxuEuleufDh2UQCNWifrjUZlU6202JQQdGlus11f+QfrHemAcuyZ3xcDk5ZKST7NPUgK78vLQWvD0nkI5zQSA7zUjK96Ws6TU336BDvRkOwFuONwbKpYxl6+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455749; c=relaxed/simple;
	bh=W3x1PTmtZ3Z/D0FhN+NbR9sOC5qsrgt2Qb/qnCIsgHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkAs7h9CMKM4TWmfvbrcjsI9twy6mEzosiOCS6zzqvUmANneNZYnPDepVjORhlkpXc8J3L6XJ8p98OQGTebNhAlBg2qYKJbMf9yKlnB2zrp92PWO1QyhJZohfTWel1Gk2kh0ruY+QcJGao56luKrpenKHvTZlwmIppR50HnThrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqaCJ54N; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340e525487eso3395646a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763455747; x=1764060547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd67JIqjBnffJd56/mtC8XiwZ8ONmUWOMWGf8uhbslw=;
        b=gqaCJ54Nu69D0CEMX9Wd9ZopYcC5yrsP2dVRt3pcLWwYFnCyF8NznSsOQp1vGpiraM
         XckG4/sa1QrEMEm80xvDseGsMJCoH7VTjUtcDqa9V4LhTKTbc/VmlDBImqGInZUTeqOK
         x+JiV9OS3GFQ95ys+Gqh6It1IKKvXwUWOHBFBVi+UWt0MvlW/96wD4eJNYVRbbNys/uk
         DFe+KlixZOpLXM+ZK021maKgAPuYa2q7YcYY6ozXMNQvdb68Qf4hUACYRV/DDH/QtnOU
         9X6XrCDeLYntKONjTyi61O1b5UE0FkskWqTHGdR52ylnwnkU5+qFe/THSA22YCGkmExW
         fsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455747; x=1764060547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fd67JIqjBnffJd56/mtC8XiwZ8ONmUWOMWGf8uhbslw=;
        b=hJ1MPpUvAnE+UrWKJZE7lLV3B6i5b8wKImwj28a+VPAnZZpe/K0UjbXEi787s3602o
         MkuXVwy2HayLnJQXxdTAHFFALcn3fmFkdRdE267cZC5r1+BPuq+bjkmPYaokaUNfTyIx
         mKDF8d2py7GjQ0euMckTn9J6JHLQasV94w7wgss6aW5My8SuFVxMkjaTGAfvjgU7nHJj
         SF8QK+a6LHl0IKABN+J6exVi/gbT+jo0nHXRN26NuOyHYtUO/2VBGCtJQpy4/BA8/s3C
         uTKHNiFXcS3e1L0QXGlY1ofeoYDQwJ5022R1Ma4hBYIQC3j05Mk5GGGQ9TvjAw6EboUz
         MoxQ==
X-Gm-Message-State: AOJu0Yw5lBovZJdtx+GEyLg+qH95uYFMOX2Bh3BBtpULDATRD9VU+en4
	rFn2g/at0M5xwQjziAF0sO3qBoVNH41WmjNPToUKpH360iko9rzU0OQh
X-Gm-Gg: ASbGnctL9l3DKODz3g/SWe6D909BtTLKBmXCpg/vVleP6qNSfvn6CEn/03An/0x9Ld9
	/hdrQizhpKJ/UbG5Uz1J+okC2EGzxdDCZfqsDjQJNgAhc6BTzjN7MewYk407HJcZLEvawoP+wBw
	KIqFPuLoP2XaE/sXaRCj1ndgws29tTaH6KyAi+H81AQzsTyevQpp1LFnujg17LsxvZEC4szXBvm
	eI+yS+cDbIJULqBI8MKin3GrMiCMj2F723ecZrdOsaOT2k7BskjiLGUnID4M1Zxf6amFAXe2ZY7
	MHjCXQ/ydEQ0m6hU4smrg7lkOGPX1HXrjqFWudsu2UN4Wh2r8PMbSNNd0Qs9/B3lwY4oj3qXs1J
	vc+t3a8DvTuWKLyrd7eQe1hdlJXkdHsbI7I19QNBoSO3T7jZdhSOJKkq7ITojBXIYfBeU5Qt3Td
	HzrUZvNh0LdK8=
X-Google-Smtp-Source: AGHT+IEgBwuS1DJAsmgPcY9fauxnHgEWvKncpN2aql5DMZ9kFcZP+AJ8w+3vmDc0Q8yljTSaUfNvQw==
X-Received: by 2002:a17:90b:4d0d:b0:343:688e:3252 with SMTP id 98e67ed59e1d1-343f9ebca28mr17752724a91.12.1763455746633;
        Tue, 18 Nov 2025 00:49:06 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b01d934csm964041a91.1.2025.11.18.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:49:06 -0800 (PST)
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
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v6 2/2] statmount: accept fd as a parameter
Date: Tue, 18 Nov 2025 14:16:42 +0530
Message-ID: <20251118084836.2114503-3-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118084836.2114503-1-b.sachdev1904@gmail.com>
References: <20251118084836.2114503-1-b.sachdev1904@gmail.com>
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
on that mount. These "umounted" mounts will have no mountpoint and no
valid mount namespace. Hence, we unset the STATMOUNT_MNT_POINT and
STATMOUNT_MNT_NS_ID in statmount.mask for "unmounted" mounts.

In case of STATMOUNT_BY_FD, given that we already have access to an fd
on the mount, accessing mount information without a capability check
seems fine because of the following reasons:

- All fs related information is available via fstatfs() without any
  capability check.
- Mount information is also available via /proc/pid/mountinfo (without
  any capability check).
- Given that we have access to a fd on the mount which tells us that we
  had access to the mount at some point (or someone that had access gave
  us the fd). So, we should be able to access mount info.

Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c             | 99 ++++++++++++++++++++++++++------------
 include/uapi/linux/mount.h |  7 ++-
 2 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ee36d67f1ac2..1c41c6e2304a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5563,29 +5563,41 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 
 /* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
-			struct mnt_namespace *ns)
+			struct mnt_namespace *ns, unsigned int flags)
 {
 	struct mount *m;
 	int err;
 
-	/* Has the namespace already been emptied? */
-	if (mnt_ns_id && mnt_ns_empty(ns))
-		return -ENOENT;
+	/* caller sets s->mnt in case of STATMOUNT_BY_FD */
+	if (!(flags & STATMOUNT_BY_FD)) {
+		/* Has the namespace already been emptied? */
+		if (mnt_ns_id && mnt_ns_empty(ns))
+			return -ENOENT;
 
-	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
-	if (!s->mnt)
-		return -ENOENT;
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
+	} else {
+		/*
+		 * We can't set mount point and mnt_ns_id since we don't have a
+		 * ns for the mount. This can happen if the mount is unmounted
+		 * with MNT_DETACH.
+		 */
+		s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
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
 
@@ -5709,7 +5721,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 }
 
 static int copy_mnt_id_req(const struct mnt_id_req __user *req,
-			   struct mnt_id_req *kreq)
+			   struct mnt_id_req *kreq, unsigned int flags)
 {
 	int ret;
 	size_t usize;
@@ -5727,11 +5739,18 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
 	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
 	if (ret)
 		return ret;
-	if (kreq->mnt_ns_fd != 0 && kreq->mnt_ns_id)
-		return -EINVAL;
-	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
-	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
-		return -EINVAL;
+
+	if (flags & STATMOUNT_BY_FD) {
+		if (kreq->mnt_id || kreq->mnt_ns_id)
+			return -EINVAL;
+	} else {
+		if (kreq->fd != 0 && kreq->mnt_ns_id)
+			return -EINVAL;
+
+		/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+		if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
+			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -5740,16 +5759,18 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
  * that, or if not simply grab a passive reference on our mount namespace and
  * return that.
  */
-static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq)
+static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq,
+						   unsigned int flags)
 {
 	struct mnt_namespace *mnt_ns;
 
 	if (kreq->mnt_ns_id) {
 		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
-	} else if (kreq->mnt_ns_fd) {
+	/* caller sets mnt_ns in case of STATMOUNT_BY_FD */
+	} else if (!(flags & STATMOUNT_BY_FD) && kreq->fd) {
 		struct ns_common *ns;
 
-		CLASS(fd, f)(kreq->mnt_ns_fd);
+		CLASS(fd, f)(kreq->fd);
 		if (fd_empty(f))
 			return ERR_PTR(-EBADF);
 
@@ -5777,25 +5798,38 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
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
-	if (IS_ERR(ns))
-		return PTR_ERR(ns);
+	if (flags & STATMOUNT_BY_FD) {
+		file_from_fd = fget_raw(kreq.fd);
+		if (!file_from_fd)
+			return -EBADF;
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
+		fd_mnt = file_from_fd->f_path.mnt;
+		ns = real_mount(fd_mnt)->mnt_ns;
+		if (ns)
+			refcount_inc(&ns->passive);
+	} else {
+		ns = grab_requested_mnt_ns(&kreq, 0);
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+
+		if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+		    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+			return -EPERM;
+	}
 
 	ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
 	if (!ks)
@@ -5806,8 +5840,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
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
@@ -5916,7 +5953,7 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
 	if (!kls->kmnt_ids)
 		return -ENOMEM;
 
-	ns = grab_requested_mnt_ns(kreq);
+	ns = grab_requested_mnt_ns(kreq, 0);
 	if (IS_ERR(ns))
 		return PTR_ERR(ns);
 	kls->ns = ns;
@@ -5947,7 +5984,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
 		return -EFAULT;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 5d3f8c9e3a62..a2156599ddc6 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -197,7 +197,7 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 mnt_ns_fd;
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
+#define STATMOUNT_BY_FD		0x00000001U	/* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.51.1


