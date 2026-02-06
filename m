Return-Path: <linux-fsdevel+bounces-76630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGSlLgE8hmnzLAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:07:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3591026FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF88305F3CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 19:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265A330322;
	Fri,  6 Feb 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVfR8LuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064FF428833
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404762; cv=none; b=gVnvnkFT9FsWCJR1fHBY+xh+b/PuGCOTySkqGYdMmy+7JbyeqqDywvuNVWNyLegKstSGmAR5FEfGgicY5XKM9vC99x/NZAwW5bV6yBZ11ZBkXrptIo9vOCRpmXHv1pPnIbWCiLkaFY/m0EddN+dQ1NjL1Jj+i1U1Pt5sb0WpJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404762; c=relaxed/simple;
	bh=chxz5SueDmNOtWuRDFHcWjdP9erYQDc7P92CJU2kUSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j89iCrh4YktrWoHCZ2mxpUQT4m3fuWeygNgWyfoxtzeR5E9wL79IzlPAFs++Hb6w6ZH3he34U6iLwRNmR4x75tCtKXnmQoIFuPdaJ677VV7BUxpOEjkJ+l43z3SdbWnThbuFZlqBJtmFCjUFL7ETMAkSbJvYBOZ+qWwGikKll0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVfR8LuH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824484dba4dso822331b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770404761; x=1771009561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0RAzzsYhNATKDjt0+B8ASQxppYbfTlRqCJWuIOU5T4=;
        b=eVfR8LuHOpl8i+acFlSZMh1T1mG4suXvvhy9uK1cWvYASXbsNFduOEWbaoeAHglFtD
         SifaE8CQD7++yvOriALazJqU4OoimYJEvAAgDnXTjKbzNRjDNtrQaWRquvNxWKWvVDnM
         ZHKQaaT5acfE5DD6fZNLYhiLDq+oagWgvkF3OkfGb9MTDpSB57ABRMHpMu6BHZ8HUHAb
         I+CveQwwVTagc76SmoFGLty0+5BQZugf2DXzTO1m0ePJUGqj86XMVBftyfbghCG9nLu+
         Tx3hZoXRbtFP4W1c9KDyQdufMZPmEJPLdEUkA2jtcIS5nD/7DBjZ+pAKPq2Vky09/8wT
         kioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404761; x=1771009561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0RAzzsYhNATKDjt0+B8ASQxppYbfTlRqCJWuIOU5T4=;
        b=uvuqYmE6t5pAf6u+vNnwM/XfrOYXNimwMDd9FVBtPyyjr2oHlV+rb4ZsnEqE5WtKb+
         6HY5RzcvXT91STg33K+CJRlUwQkb+gpV5VeSHo1PP/X3t15bw/T5S/KMj0Goj2fxknLy
         fHai/7nyZ9rgwolfbmyl9ucLzVwruIYvFFtxird361bo096BbEXxazppwdTfV/I44jYc
         nViWOPQOc+LJxtTK8ZQdnYUWmHTpVj/dVMCrZDMT7/+9pA2vaQ4aZSUu8Vagg1AArdkv
         4WfQGLLGJ3XMy3hFEBtiECVyN1dmDk9xFJgqVEsQu+DDxYSSgfaGtSshBhj94VHfgW+l
         VR3g==
X-Gm-Message-State: AOJu0YwP8dmzUrbbHz5GGTCkc564n8unXlP/NXVBcXY0nDHf+jsrTT7h
	9FT4XLMC3mLrc31YldOuXc58u6vq2PLuGp88aAPCnASsA5dKZ5kMN0uDMPc6cA==
X-Gm-Gg: AZuq6aKL/gtDE/+RQcDA+0OffnZErJTN4toWyWWXXKCv0FWSuBxddQgU1FJaz6lgJRs
	1bcljNTxOvUl2pdoPWgztP60/5OPAMzX4DR7PBI0ejr0XBwLCfxvHejRNJ6MxlL/iOtSul4kUxk
	dTY6gxJXYnfnL70zcsI2l977C3WN8Qtn3OP6LdIzFKXZ1GsaJFQ4lTBrZkq1kGoBneGdyv4yb72
	aL0ufmlGSIJQZPbJqLOh2I+nyzw9nbL05AqoS/w2Ot+bQkKeFCiDKKWgrX2XBjY+BHZBwnkw5hS
	FfNZaJKLMk837blUroPrMBmLyeZ63O4OobhNbCD4i6azGUUJLc7xSS5FiIASpGaWkVTIsxRZdud
	pfrvtPMjbwyT4kw9bfbglV8+zu8vFIOzYBhWcxLEbVqnc2lLGVnovAn68qWghzg6/2EAko1cou4
	R+DUWWmVnPfA6ItcpcDW39e2bHfCdCM/xYPsu1iJc0Shg=
X-Received: by 2002:a05:6a00:4487:b0:81f:4675:c2a9 with SMTP id d2e1a72fcca58-824413cb6b7mr3626544b3a.0.1770404761012;
        Fri, 06 Feb 2026 11:06:01 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a70fesm2910894b3a.45.2026.02.06.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:06:00 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com
Subject: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
Date: Sat,  7 Feb 2026 01:03:36 +0600
Message-ID: <20260206190536.57289-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206190536.57289-1-dorjoychy111@gmail.com>
References: <20260206190536.57289-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76630-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C3591026FB
X-Rspamd-Action: no action

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being tricked
into opening device nodes with special semantics while thinking they
operate on regular files. This is a requested feature from uapi-group[1].

A corresponding error code EFTYPE has been introduced. For example, if
openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag param,
it will return -EFTYPE.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -EFTYPE is returned.

When OPENAT2_REGULAR is combined with O_DIRECTORY, the path will be opened
if the path is either a regular file or a directory.

[1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/alpha/include/uapi/asm/errno.h        | 2 ++
 arch/alpha/include/uapi/asm/fcntl.h        | 1 +
 arch/mips/include/uapi/asm/errno.h         | 2 ++
 arch/parisc/include/uapi/asm/errno.h       | 2 ++
 arch/parisc/include/uapi/asm/fcntl.h       | 1 +
 arch/sparc/include/uapi/asm/errno.h        | 2 ++
 arch/sparc/include/uapi/asm/fcntl.h        | 1 +
 fs/9p/vfs_inode.c                          | 3 +++
 fs/9p/vfs_inode_dotl.c                     | 3 +++
 fs/ceph/file.c                             | 3 +++
 fs/fuse/dir.c                              | 3 +++
 fs/gfs2/inode.c                            | 3 +++
 fs/namei.c                                 | 9 ++++++++-
 fs/nfs/dir.c                               | 3 +++
 fs/nfs/file.c                              | 3 +++
 fs/open.c                                  | 2 +-
 fs/smb/client/dir.c                        | 3 +++
 fs/vboxsf/dir.c                            | 3 +++
 include/linux/fcntl.h                      | 2 ++
 include/uapi/asm-generic/errno.h           | 2 ++
 include/uapi/asm-generic/fcntl.h           | 4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
 tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
 tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
 tools/include/uapi/asm-generic/errno.h     | 2 ++
 26 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..fe488bf7c18e 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define OPENAT2_REGULAR	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..d46812f2f0f4 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define OPENAT2_REGULAR	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..bb6e9fa94bc9 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define OPENAT2_REGULAR	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1..3d1f91220e17 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -771,6 +771,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..2e096eb0be11 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 31b691b2aea2..d0fa6cd65e0a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -794,6 +794,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	err = ceph_wait_on_conflict_unlink(dentry);
 	if (err)
 		return err;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f25ee47822ad..cbc6008f6810 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -936,6 +936,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (d_in_lookup(entry)) {
 		struct dentry *res = fuse_lookup(dir, entry, 0);
 		if (res || d_really_is_positive(entry))
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c02ebf0ca625..1efb86b718e1 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1385,6 +1385,9 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index d7923f2c7b62..a5ce3f91a283 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4614,8 +4614,15 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
-	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
+
+	if ((open_flag & OPENAT2_REGULAR) && (nd->flags & LOOKUP_DIRECTORY)) {
+		if (!d_is_reg(nd->path.dentry) && !d_can_lookup(nd->path.dentry))
+			return -EFTYPE;
+	} else if ((open_flag & OPENAT2_REGULAR) && !d_is_reg(nd->path.dentry)) {
+		return -EFTYPE;
+	} else if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry)) {
 		return -ENOTDIR;
+	}
 
 	do_truncate = false;
 	acc_mode = op->acc_mode;
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f9ea79b7882..ae12bf75ad93 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2315,6 +2315,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
+	if (open_flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (open_flags & O_CREAT) {
 		error = nfs_do_create(dir, dentry, mode, open_flags);
 		if (!error) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 5d08b6409c28..032fc3dbe992 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
 		return -EINVAL;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_check_flags);
diff --git a/fs/open.c b/fs/open.c
index 74c4c1462b3e..2cef40a3f139 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1211,7 +1211,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 747256025e49..fc77c5401574 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -473,6 +473,9 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
+	if (oflags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
 	 * opens (rather than creates), because we do not know if it is a file
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..936ba2962fd0 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 	u64 handle;
 	int err;
 
+	if (flags & OPENAT2_REGULAR)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..a80026718217 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OPENAT2_REGULAR)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..b2c2ddd0edc0 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..1a99f38813c7 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define EFTYPE		140	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..1835a50b69ce 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define EFTYPE		169	/* Wrong file type for the intended operation */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..93194fbb0a80 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define EFTYPE		258	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..71940ec9130b 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define EFTYPE		136	/* Wrong file type for the intended operation */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..bd78e69e0a43 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define EFTYPE		134	/* Wrong file type for the intended operation */
+
 #endif
-- 
2.53.0


