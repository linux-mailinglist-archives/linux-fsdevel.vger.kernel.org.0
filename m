Return-Path: <linux-fsdevel+bounces-70210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A2C93AF4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD0C03470E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22026AA91;
	Sat, 29 Nov 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0FhOj94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8923B609
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407728; cv=none; b=hosRj/7a46UUuFvrit52UsD8Bb0IBEjJEwSZiWSKBTrP0lLzblMksPi2M4casyADHGJ9YPbwMo/15itjh21IMh2FB1/ym3jdHFQzzMjB3z3uWsApjZyvb+kLkDO2d4lCaGNHGjDKCVF2fCi9xBog0AbhX0Il35XDnwNAyc3vi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407728; c=relaxed/simple;
	bh=IhlLSpZF72FSrdV1+YHnN2WHoXOri79HtwWzTG5DQ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qvg5cBi9qvSTZ7WR/owo9qrBWuoJ10hXNTCBLvLXsVKu+hZaEfidu5zfnQVHz+Z1c33J4FeUGNiGAeFEGB4SJfdQyT/qNvfVrWxA/PWOD6wCo2vmfx68WuLV1j2vkcQDTqfU/gpeTusAa5DH9zcAno6D5v97swdbKr2oob5CsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0FhOj94; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so3188668b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764407727; x=1765012527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVcxx22uwcyWv5Zel36iqnOvGPO1H7KVbIWMJe+WJP8=;
        b=E0FhOj949Hsiqm6nPJpxDW4QqJsYQciautH01EnFNmh4bLUUEjz0vLN8Mq7FO28byM
         LiJrtVIZ3Sf5f6a8Mle6A0qb5nVlM6FIOpCbSZwN8CTi172u5IVmIePtSuEBgDUwUAip
         TehmMH48IDnoa4hVMeoASfCmjw7WkL85zfUagiZm2MmjwQdzQStYPJGXrIiBPewhlZfH
         Z0IwGTk/rN8HA85cfornPZcLN7ZevZju202fLGCLZJE0GIGN2TjkbLVVB5wCTdewgKOl
         Q4H6FtTCEhl6Fz/s9WdAYskutIDehriMLkbwfEm7b0m2DOk2PNX1rLAXjlbvpVCVEFl6
         /cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764407727; x=1765012527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pVcxx22uwcyWv5Zel36iqnOvGPO1H7KVbIWMJe+WJP8=;
        b=glPhXmdFUyioQTlJjEgHbAZGu7LNygJKmp6ZbMAqD7gJiTpro9CcpQVlU7KgX61dh/
         Z9NKo6OWZMGmCA1RAqF+Qyvfx6fWkvIFsGvcpziz6PK5H67BdYibewdlwnBhrFfcVMk1
         znMKQ9m/SnGPspG9F7114l3lfmWgrUJLuIzv5CdfrMNSBXfvw3E8Y0pZ8b3swd5SnWzC
         6uu3MlSwd+QlgzlTLXyaibKSw55TFRxTM3l/VpWM+hHPzVm9efjye+26fKK07KA48XKs
         SSNiliC5QtCQBdrWRvQdToXv8O88rk1TCfofxOEEm00/MjJ2zmYzBXAlP9DC+o9FGrz2
         WvHA==
X-Gm-Message-State: AOJu0YzbJ0JyMaBtrpUU4lfBsRZm1cg3gklTth2EANGJOXZF7OvApoCe
	Bqj2lOT/CceXcDJNW3sSPHKc+Y7qTyjGr+x0xP4q+7hYNj6Bm9QZQRzv
X-Gm-Gg: ASbGnculrKon/tGQExVX9/jLC2rlleYgYmzYJoTJb4U3pnnbaHLKj0z1LWVoSMBXpgm
	3I9LMNss5MLEYqFy7v1nbox1OEfVL088++VszNW0eehHoEPE4Plrp/Ni5MZewwX3EKjCkPIYRlZ
	NVGUqgtDbqztGBqe/gfmHi/NXUNjbFrXmerPY72sH1e350ScKwJdU+vUlUHhgwQpOXQ36d07q1j
	kuoZDgXHdJfVP8YDuK8tGAqrpI5OBIjF1JUTe9is//k6iLK5NkbQfkIrqMS7p6fuuFkh0arK8/o
	kvrbr3Rzwyyx6bDNtQ4WqgxM/hm1Ao8hJ5WUGKRZWXbGNBY+Mf/5/P/aZq+tqXRbk91oEdBEUH/
	uR7bJmg8dJb0LILR9RpSoFZQ4SARfvbemTbj47eKu0fp7thcQ25+UDuv0tsc+D9ryG99ohu7+Ap
	86Aha0/nsywXQ=
X-Google-Smtp-Source: AGHT+IFy53cLbESiXML1MJ4hrBJswXxa/BoGl5z6KQzHvzuNLRuKNd9j4dRr8DLhGkrFztEpABmyuA==
X-Received: by 2002:a05:6a21:999a:b0:361:2fff:7b19 with SMTP id adf61e73a8af0-3614ee0a140mr34179763637.52.1764407726448;
        Sat, 29 Nov 2025 01:15:26 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm7300563b3a.41.2025.11.29.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:15:25 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v7 2/3] statmount: accept fd as a parameter
Date: Sat, 29 Nov 2025 14:41:21 +0530
Message-ID: <20251129091455.757724-3-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
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
 fs/namespace.c             | 102 ++++++++++++++++++++++++-------------
 include/uapi/linux/mount.h |  10 +++-
 2 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ee36d67f1ac2..73ffa1fbdad7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5563,31 +5563,49 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 
 /* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
-			struct mnt_namespace *ns)
+                        struct file *mnt_file, struct mnt_namespace *ns)
 {
-	struct mount *m;
 	int err;
 
-	/* Has the namespace already been emptied? */
-	if (mnt_ns_id && mnt_ns_empty(ns))
-		return -ENOENT;
+	if (mnt_file) {
+		WARN_ON_ONCE(ns != NULL);
 
-	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
-	if (!s->mnt)
-		return -ENOENT;
+		s->mnt = mnt_file->f_path.mnt;
+		ns = real_mount(s->mnt)->mnt_ns;
+		if (!ns)
+			/*
+			 * We can't set mount point and mnt_ns_id since we don't have a
+			 * ns for the mount. This can happen if the mount is unmounted
+			 * with MNT_DETACH.
+			 */
+			s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
+	} else {
+		/* Has the namespace already been emptied? */
+		if (mnt_ns_id && mnt_ns_empty(ns))
+			return -ENOENT;
 
-	err = grab_requested_root(ns, &s->root);
-	if (err)
-		return err;
+		s->mnt = lookup_mnt_in_ns(mnt_id, ns);
+		if (!s->mnt)
+			return -ENOENT;
+	}
 
-	/*
-	 * Don't trigger audit denials. We just want to determine what
-	 * mounts to show users.
-	 */
-	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
+	if (ns) {
+		err = grab_requested_root(ns, &s->root);
+		if (err)
+			return err;
+
+		if (!mnt_file) {
+			struct mount *m;
+			/*
+			 * Don't trigger audit denials. We just want to determine what
+			 * mounts to show users.
+			 */
+			m = real_mount(s->mnt);
+			if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
+			    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+				return -EPERM;
+		}
+	}
 
 	err = security_sb_statfs(s->mnt->mnt_root);
 	if (err)
@@ -5709,7 +5727,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 }
 
 static int copy_mnt_id_req(const struct mnt_id_req __user *req,
-			   struct mnt_id_req *kreq)
+			   struct mnt_id_req *kreq, unsigned int flags)
 {
 	int ret;
 	size_t usize;
@@ -5727,11 +5745,17 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
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
+		if (kreq->mnt_ns_fd != 0 && kreq->mnt_ns_id)
+			return -EINVAL;
+		/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
+		if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
+			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -5777,25 +5801,33 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
 	struct kstatmount *ks __free(kfree) = NULL;
+	struct file *mnt_file __free(fput) = NULL;
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
+		mnt_file = fget_raw(kreq.mnt_fd);
+		if (!mnt_file)
+			return -EBADF;
+		/* do_statmount sets ns in case of STATMOUNT_BY_FD */
+	} else {
+		ns = grab_requested_mnt_ns(&kreq);
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
 
-	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
+		if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
+		    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+			return -EPERM;
+	}
 
 	ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
 	if (!ks)
@@ -5807,7 +5839,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 		return ret;
 
 	scoped_guard(namespace_shared)
-		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
+		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, mnt_file, ns);
 
 	if (!ret)
 		ret = copy_statmount_to_user(ks);
@@ -5947,7 +5979,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
 		return -EFAULT;
 
-	ret = copy_mnt_id_req(req, &kreq);
+	ret = copy_mnt_id_req(req, &kreq, 0);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 5d3f8c9e3a62..18c624405268 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -197,7 +197,10 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 mnt_ns_fd;
+	union {
+		__u32 mnt_ns_fd;
+		__u32 mnt_fd;
+	};
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
@@ -232,4 +235,9 @@ struct mnt_id_req {
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
 #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
+/*
+ * @flag bits for statmount(2)
+ */
+#define STATMOUNT_BY_FD		0x00000001U	/* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.52.0


