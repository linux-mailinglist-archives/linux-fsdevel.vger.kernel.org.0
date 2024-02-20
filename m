Return-Path: <linux-fsdevel+bounces-12131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E985B755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37FA1F25CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5B46026A;
	Tue, 20 Feb 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02+7I3BM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821A5FDB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421251; cv=none; b=iVzon5hywJ7j72PBYMz6iSMAQambgc45nahbV2d5ZtTxF6gilIlDMgJxe1YRHX/ixUufODzK3pgYLx2neutMgRuzQB4DEIsdIJhqdgScyg97rF5BCE2hA5iUCvuv5XMcrfzcgTZDt/Y9mIQMBDFtr/KLfJcS0K8rCG2D5/tTqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421251; c=relaxed/simple;
	bh=AL20AmpyQfee6Z/j0ZATVimRlJXhAXHnqSaawdUpLe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNaAXsvICC4uDt7HAevBAaD+YiA6dOrWYvfL2lOShgJvyvIY58iPd4qGaFOm8/ky+RrQY4nNNk3IXG+EBiQqDy0XmXvCt5n3hH7o2XfrPmwZ18hvSqMVnjTFMQkaIfEbFUxZOyecNeRDQxyOYZsh6bFkR5I0rvRQKHFAbCC5qFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02+7I3BM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3eb1f48fa9so202680566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421248; x=1709026048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lz7fHeDd50+R3cUNoViqANc65ILW8vP9xX9CHfsnXXw=;
        b=02+7I3BMjRvK1eP4WZQPlFGj0nnbdApxKrW2ASAzuBs1dPCnPi4VFo8AfXAv9eMV3o
         GigoFtByj/6Hv6woJZbTzVfTdx4dMJsSD/yccgWO8MJ9+faDQ9M8fePEPDDTZyAShRpR
         /1eUgHUO4zW9FAG9Fb6DgyAq+1Vd1xGMy/1UoPvRyl9jmwd/PNWwzDdhO8jNXa6S7z7j
         sbAunneAhwc85GEZ2Af3cifsvcNK62fPYngFlnGRMAFiuUifSsulq19T0lZl6757bBSC
         MsGJuMKuPu6jbaXH+92kI3dGti47tlITXf0/YSHNJt5kh5surs345XegKvXkjML8zYdw
         z4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421248; x=1709026048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz7fHeDd50+R3cUNoViqANc65ILW8vP9xX9CHfsnXXw=;
        b=A0mkONm1GJvQswjYrZE8ZrgaWucLpYgYe45XyAQ36D/Bnwjq1Y4L9919AeV0aYQ/TB
         s6Ej0IKnmUnU07V7Bk39kOjT/48LJdLExb4gdSAiuV6PH+XFsBZCo4YCUBCijhZgCUCz
         1HjCO7LiVt+n27E8LZ/iFpF/GjRSTmcwiQLUWd7TaxSD9O1fA4Nfg1d0uN4XAx1iLMuf
         SNLNKSO/xHpXRawhfF0njw2oVUm7ZkHUxF/G06jblSsINKtWzSf9nlZUOFi1ksXys9d8
         knRnIa6rRJ/Sv1rjj3HqsO3F3l5jaR98lGz782ONtc5b2U4zNeN41RfxZCxyo8klznzN
         HSgg==
X-Forwarded-Encrypted: i=1; AJvYcCWzq4Qc/hFC5/r5CllCtE7iJ29uht0agAkp2sHOJeuJwxGZefa2IyhR0Lxup556gJRQqBdWcPuSAUHQeFVl+ee7muDAADc4ToyNfsAn0Q==
X-Gm-Message-State: AOJu0YxduYyZDQSupJh+mn0p1oNwujoV0sCO53Az7iWcVLD/Xd2WBOQa
	VHaB6HIYL5izitXr0t8z9FUicf/nNZC42A0m5XDl91tUNTcobh7vvPA3lY/GNw==
X-Google-Smtp-Source: AGHT+IGkr0X0lMpAqjaEt3s6FP4GjyxMCgxuHHrR+OCBptQEv3+5AjDUsbbybmJOtGRSNWz+EdK0jg==
X-Received: by 2002:a17:906:a19a:b0:a3d:2a52:380f with SMTP id s26-20020a170906a19a00b00a3d2a52380fmr9595331ejy.72.1708421247549;
        Tue, 20 Feb 2024 01:27:27 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm2531070ejc.142.2024.02.20.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:27 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:23 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 01/11] bpf: make bpf_d_path() helper use probe-read
 semantics
Message-ID: <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

There has now been several reported instances [0, 1, 2] where the
usage of the BPF helper bpf_d_path() has led to some form of memory
corruption issue.

The fundamental reason behind why we repeatedly see bpf_d_path() being
susceptible to such memory corruption issues is because it only
enforces ARG_PTR_TO_BTF_ID constraints onto it's struct path
argument. This essentially means that it only requires an in-kernel
pointer of type struct path to be provided to it. Depending on the
underlying context and where the supplied struct path was obtained
from and when, depends on whether the struct path is fully intact or
not when calling bpf_d_path(). It's certainly possible to call
bpf_d_path() and subsequently d_path() from contexts where the
supplied struct path to bpf_d_path() has already started being torn
down by __fput() and such. An example of this is perfectly illustrated
in [0].

Moving forward, we simply cannot enforce KF_TRUSTED_ARGS semantics
onto struct path of bpf_d_path(), as this approach would presumably
lead to some pretty wide scale and highly undesirable BPF program
breakage. To avoid breaking any pre-existing BPF program that is
dependent on bpf_d_path(), I propose that we take a different path and
re-implement an incredibly minimalistic and bare bone version of
d_path() which is entirely backed by kernel probe-read semantics. IOW,
a version of d_path() that is backed by
copy_from_kernel_nofault(). This ensures that any reads performed
against the supplied struct path to bpf_d_path() which may end up
faulting for whatever reason end up being gracefully handled and fixed
up.

The caveats with such an approach is that we can't fully uphold all of
d_path()'s path resolution capabilities. Resolving a path which is
comprised of a dentry that make use of dynamic names via isn't
possible as we can't enforce probe-read semantics onto indirect
function calls performed via d_op as they're implementation
dependent. For such cases, we just return -EOPNOTSUPP. This might be a
little surprising to some users, especially those that are interested
in resolving paths that involve a dentry that resides on some
non-mountable pseudo-filesystem, being pipefs/sockfs/nsfs, but it's
arguably better than enforcing KF_TRUSTED_ARGS onto bpf_d_path() and
causing an unnecessary shemozzle for users. Additionally, we don't
make use of all the locking semantics, or handle all the erroneous
cases in which d_path() naturally would. This is fine however, as
we're only looking to provide users with a rather acceptable version
of a reconstructed path, whilst they eventually migrate over to the
trusted bpf_path_d_path() BPF kfunc variant.

Note that the selftests that go with this change to bpf_d_path() have
been purposely split out into a completely separate patch. This is so
that the reviewers attention is not torn by noise and can remain
focused on reviewing the implementation details contained within this
patch.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
[1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 fs/Makefile                       |   6 +-
 fs/probe_read_d_path.c            | 150 ++++++++++++++++++++++++++++++
 include/linux/probe_read_d_path.h |  13 +++
 kernel/trace/bpf_trace.c          |  13 ++-
 4 files changed, 172 insertions(+), 10 deletions(-)
 create mode 100644 fs/probe_read_d_path.c
 create mode 100644 include/linux/probe_read_d_path.h

diff --git a/fs/Makefile b/fs/Makefile
index c09016257f05..945c9c84d35d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -4,7 +4,7 @@
 #
 # 14 Sep 2000, Christoph Hellwig <hch@infradead.org>
 # Rewritten to use lists instead of if-statements.
-# 
+#
 
 
 obj-y :=	open.o read_write.o file_table.o super.o \
@@ -12,7 +12,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		ioctl.o readdir.o select.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
-		pnode.o splice.o sync.o utimes.o d_path.o \
+		pnode.o splice.o sync.o utimes.o d_path.o probe_read_d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o
@@ -58,7 +58,7 @@ obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
 obj-$(CONFIG_DLM)		+= dlm/
- 
+
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
diff --git a/fs/probe_read_d_path.c b/fs/probe_read_d_path.c
new file mode 100644
index 000000000000..8d0db902f836
--- /dev/null
+++ b/fs/probe_read_d_path.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Google LLC.
+ */
+
+#include "asm/ptrace.h"
+#include <linux/container_of.h>
+#include <linux/dcache.h>
+#include <linux/fs_struct.h>
+#include <linux/uaccess.h>
+#include <linux/path.h>
+#include <linux/probe_read_d_path.h>
+
+#include "mount.h"
+
+#define PROBE_READ(src)                                              \
+	({                                                           \
+		typeof(src) __r;                                     \
+		if (copy_from_kernel_nofault((void *)(&__r), (&src), \
+					     sizeof((__r))))         \
+			memset((void *)(&__r), 0, sizeof((__r)));    \
+		__r;                                                 \
+	})
+
+static inline bool probe_read_d_unlinked(const struct dentry *dentry)
+{
+	return !PROBE_READ(dentry->d_hash.pprev) &&
+	       !(dentry == PROBE_READ(dentry->d_parent));
+}
+
+static long probe_read_prepend(const char *s, int len, char *buf, int *buflen)
+{
+	/*
+	 * The supplied len that is to be copied into the buffer will result in
+	 * an overflow. The true implementation of d_path() already returns an
+	 * error for such overflow cases, so the semantics with regards to the
+	 * bpf_d_path() helper returning the same error value for overflow cases
+	 * remain the same.
+	 */
+	if (len > *buflen)
+		return -ENAMETOOLONG;
+
+	/*
+	 * The supplied string fits completely into the remaining buffer
+	 * space. Attempt to make the copy.
+	 */
+	*buflen -= len;
+	buf += *buflen;
+	return copy_from_kernel_nofault(buf, s, len);
+}
+
+static bool use_dname(const struct path *path)
+{
+	const struct dentry_operations *d_op;
+	char *(*d_dname)(struct dentry *, char *, int);
+
+	d_op = PROBE_READ(path->dentry->d_op);
+	d_dname = PROBE_READ(d_op->d_dname);
+
+	return d_op && d_dname &&
+	       (!(path->dentry == PROBE_READ(path->dentry->d_parent)) ||
+		path->dentry != PROBE_READ(path->mnt->mnt_root));
+}
+
+char *probe_read_d_path(const struct path *path, char *buf, int buflen)
+{
+	int len;
+	long err;
+	struct path root;
+	struct mount *mnt;
+	struct dentry *dentry;
+
+	dentry = path->dentry;
+	mnt = container_of(path->mnt, struct mount, mnt);
+
+	/*
+	 * We cannot back dentry->d_op->d_dname() with probe-read semantics, so
+	 * just return an error to the caller when the supplied path contains a
+	 * dentry component that makes use of a dynamic name.
+	 */
+	if (use_dname(path))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	err = probe_read_prepend("\0", 1, buf, &buflen);
+	if (err)
+		return ERR_PTR(err);
+
+	if (probe_read_d_unlinked(dentry)) {
+		err = probe_read_prepend(" (deleted)", 10, buf, &buflen);
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	len = buflen;
+	root = PROBE_READ(current->fs->root);
+	while (dentry != root.dentry || &mnt->mnt != root.mnt) {
+		struct dentry *parent;
+		if (dentry == PROBE_READ(mnt->mnt.mnt_root)) {
+			struct mount *m;
+
+			m = PROBE_READ(mnt->mnt_parent);
+			if (mnt != m) {
+				dentry = PROBE_READ(mnt->mnt_mountpoint);
+				mnt = m;
+				continue;
+			}
+
+			/*
+			 * If we've reached the global root, then there's
+			 * nothing we can really do but bail.
+			 */
+			break;
+		}
+
+		parent = PROBE_READ(dentry->d_parent);
+		if (dentry == parent) {
+			/*
+			 * Escaped? We return an ECANCELED error here to signify
+			 * that we've prematurely terminated pathname
+			 * reconstruction. We've potentially hit a root dentry
+			 * that isn't associated with any roots from the mounted
+			 * filesystems that we've jumped through, so it's not
+			 * clear where we are in the VFS exactly.
+			 */
+			err = -ECANCELED;
+			break;
+		}
+
+		err = probe_read_prepend(dentry->d_name.name,
+					 PROBE_READ(dentry->d_name.len), buf,
+					 &buflen);
+		if (err)
+			break;
+
+		err = probe_read_prepend("/", 1, buf, &buflen);
+		if (err)
+			break;
+		dentry = parent;
+	}
+
+	if (err)
+		return ERR_PTR(err);
+
+	if (len == buflen) {
+		err = probe_read_prepend("/", 1, buf, &buflen);
+		if (err)
+			return ERR_PTR(err);
+	}
+	return buf + buflen;
+}
diff --git a/include/linux/probe_read_d_path.h b/include/linux/probe_read_d_path.h
new file mode 100644
index 000000000000..9b3908746657
--- /dev/null
+++ b/include/linux/probe_read_d_path.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Google LLC.
+ */
+
+#ifndef _LINUX_PROBE_READ_D_PATH_H
+#define _LINUX_PROBE_READ_D_PATH_H
+
+#include <linux/path.h>
+
+extern char *probe_read_d_path(const struct path *path, char *buf, int buflen);
+
+#endif /* _LINUX_PROBE_READ_D_PATH_H */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..12dbd9cef1fa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -25,6 +25,7 @@
 #include <linux/verification.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/probe_read_d_path.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -923,14 +924,12 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 	if (len < 0)
 		return len;
 
-	p = d_path(&copy, buf, sz);
-	if (IS_ERR(p)) {
-		len = PTR_ERR(p);
-	} else {
-		len = buf + sz - p;
-		memmove(buf, p, len);
-	}
+	p = probe_read_d_path(&copy, buf, sz);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
+	len = buf + sz - p;
+	memmove(buf, p, len);
 	return len;
 }
 
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

