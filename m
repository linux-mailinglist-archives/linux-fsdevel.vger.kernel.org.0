Return-Path: <linux-fsdevel+bounces-75633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQHE+X9eGmOuQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:03:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A898BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D893072231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7A324B1B;
	Tue, 27 Jan 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKxy/k6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A62D47E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536898; cv=none; b=IeK0Pk9+Hn6cZOVkT2gdEc6jv0/i8nVVMRBTYEiu412NYGEHp9RKe474hWo3vVezsll7xTxwZ1gzAcSNg5Yh10WiRK34U7KsEGbD9P+ggclxrUBBM10rOacB5fMz3S3WGnnOZp21JbzAeatrn08TSs3tUM5XsNnapdeTEeLNWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536898; c=relaxed/simple;
	bh=s1VRtrN1rCxIrmB1bp08y4a8rJA3GT+7VXS+NY5X8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3g1lB/+e/kLvuxJ04DTm2Vgc8bzVObRCPQQyZMg+m6mVSHDSy+ArqVnIgzvLVTWtIspVN2gaGRKOJ3/CUxeJdwKmcbWzJM4nUOivfGrZm+puR+TxNuLcva/edlWhPOy9U5GT0i1FRz+5v75Qht/D9heQHX23rb4xAQaea39ygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKxy/k6a; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c613161b489so2344926a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536896; x=1770141696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npSZ8A74m3ybU6LKADRoribfE0dXr+fNAZsDs5EV4p4=;
        b=EKxy/k6a5Ili/VXblawiyA1fGANXCEk1p7FC5fIzeUqRoY8mIRyTokKTLIfR2j3fd1
         i6WFTpORdDPryFL4FQTzuONfJDR8YX/5vOs0aHahczh7sveQD+F7/Cqk1p3yRcmJqvKK
         kPH+p53y4ZQJNLXDfKTs5gb4m8dZm2Wc5gvX+VvljhN3E0cwDilYnGHMg72maVlYu+U3
         c/DQBliEppKweYvUu/5F87VbyCnCFws2qYVagfYb7+KCV8u4F3qw5LsJsr2Us2z+eG9a
         I0bUDYv7Mu5TWjU8uznF7ke6c+yCV5jfiqiMz5/ay3Xm3zjb7FDDoMMrFnBNRAT7RDwN
         NR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536896; x=1770141696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npSZ8A74m3ybU6LKADRoribfE0dXr+fNAZsDs5EV4p4=;
        b=UeGjQw9bmFFFGxYSbqgyMSdi5h1pcKos5+pHyRzCbIF3wgV+Ir4L8lKGe4BgDgN52P
         1478YKPjozfjEp+Pmc5OER4wrBGcU+sgbFwyrkiGFMxJB+PRAWaD7ApuaEmWVGIRcLAa
         CsGa+3Mui3XF8kLmib2v7dWJ8r/IoDWT9BHWgfNWowvFs4q1rfZft1Q40/hIbeLE+4FA
         saoSZpEQaUUjIsfRAquMST2V4pz7LULz4mCoizu/2/X75FaxxLphW8ArChaBlvPw4+js
         B9HUethKYjbonXhTvAAs9XWSwbFpxdgdPNuYVc7u5RgR9MGlIg9IUN4eXood8u/jkAs2
         nAfQ==
X-Gm-Message-State: AOJu0Yw3lala6Pm/+B9pgtbAeIkIeWBQ/uh0E7CBO/nzo1AYYP4KBddu
	N2NspDJYCoKB515J1JF9gq6VnUoC/u9sPOAwbGVNRxscxos4ivQ3TBk+QXdk2w==
X-Gm-Gg: AZuq6aLaIvR/L7ehfW0NgIgRhk9KIZfAEmOR5WCquFgww0+NH105RM35I9UDWpg4iiH
	ydXqRDRHXc7K6RC7wS8bYK933+mXDswyVSOOyQcRKAIULjc21GBx7Oft6qI59X+6Ydn/LOHOiqO
	KGaqDdOsLpN7Vp0rTfS+OthqEcPB2BRyLXqYgGbvs1gyouVM/f8a/RnruOmPIIQUf34I5z/EBoe
	TZsGT3BmMyA8lJ6DWG7a3AqgP0WMWydGo7k0EL4k+nNsKpRQx1Snpra/OKLWfi3u9ZHz7kbw+V0
	P7FrzsYGjW87xSY1VFLxCbyE0nTji2XE8gOGVQvOgwdS1Cb/aO0p/TSXAaexYVkFcf/D2fHqmT3
	GO9jlv3KF/6qpOjDsmqyt3Tt02q0/Ik3OeALAPLWV4NkPaU7lYHH3RMx+JP0C5FEoYQO6n13K6z
	4db4Cd8CHRzEkCAPiVdJvBNAnENATCw199EBftmosjvsXjnqxU8UYZ8w==
X-Received: by 2002:a17:90b:270e:b0:34a:b459:bd10 with SMTP id 98e67ed59e1d1-353fed7104bmr2394940a91.24.1769536894069;
        Tue, 27 Jan 2026 10:01:34 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc68sm216891b3a.2.2026.01.27.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:01:33 -0800 (PST)
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
	adilger@dilger.ca
Subject: [PATCH v3 1/4] open: new O_REGULAR flag support
Date: Tue, 27 Jan 2026 23:58:17 +0600
Message-ID: <20260127180109.66691-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127180109.66691-1-dorjoychy111@gmail.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75633-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D70A898BE8
X-Rspamd-Action: no action

This flag indicates the path should be opened if it's a regular file.
This is useful to write secure programs that want to avoid being tricked
into opening device nodes with special semantics while thinking they
operate on regular files.

A corresponding error code ENOTREG has been introduced. For example, if
open is called on path /dev/null with O_REGULAR in the flag param, it
will return -ENOTREG.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -ENOTREG is returned.

-EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
part of O_TMPFILE) because it doesn't make sense to open a path that
is both a directory and a regular file.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 arch/alpha/include/uapi/asm/errno.h        | 2 ++
 arch/alpha/include/uapi/asm/fcntl.h        | 1 +
 arch/mips/include/uapi/asm/errno.h         | 2 ++
 arch/parisc/include/uapi/asm/errno.h       | 2 ++
 arch/parisc/include/uapi/asm/fcntl.h       | 1 +
 arch/sparc/include/uapi/asm/errno.h        | 2 ++
 arch/sparc/include/uapi/asm/fcntl.h        | 1 +
 fs/fcntl.c                                 | 2 +-
 fs/namei.c                                 | 6 ++++++
 fs/open.c                                  | 4 +++-
 include/linux/fcntl.h                      | 2 +-
 include/uapi/asm-generic/errno.h           | 2 ++
 include/uapi/asm-generic/fcntl.h           | 4 ++++
 tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
 tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
 tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
 tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
 tools/include/uapi/asm-generic/errno.h     | 2 ++
 18 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..8bbcaa9024f9 100644
--- a/arch/alpha/include/uapi/asm/errno.h
+++ b/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define ENOTREG		140	/* Not a regular file */
+
 #endif
diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..4da5a64c23bd 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define O_REGULAR	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..293c78777254 100644
--- a/arch/mips/include/uapi/asm/errno.h
+++ b/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define ENOTREG		169	/* Not a regular file */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..442917484f99 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define ENOTREG		258	/* Not a regular file */
+
 #endif
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..0cc3320fe326 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define O_REGULAR	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..8dce0bfeab74 100644
--- a/arch/sparc/include/uapi/asm/errno.h
+++ b/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define ENOTREG		136	/* Not a regular file */
+
 #endif
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..a93d18d2c23e 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define O_REGULAR	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index f93dbca08435..62ab4ad2b6f5 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
diff --git a/fs/namei.c b/fs/namei.c
index b28ecb699f32..f5504ae4b03c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
+
+	if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
+		return -ENOTREG;
+
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
@@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	struct path path;
 	int error = path_lookupat(nd, flags, &path);
 	if (!error) {
+		if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentry))
+			return -ENOTREG;
 		audit_inode(nd->name, path.dentry, 0);
 		error = vfs_open(&path, file);
 		path_put(&path);
diff --git a/fs/open.c b/fs/open.c
index 74c4c1462b3e..82153e21907e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_REGULAR)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
+	} else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
+		return -EINVAL;
 	}
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..4fd07b0e0a17 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..2216ab9aa32e 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define ENOTREG		134	/* Not a regular file */
+
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..3468b352a575 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_REGULAR
+#define O_REGULAR	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
index 6791f6508632..8bbcaa9024f9 100644
--- a/tools/arch/alpha/include/uapi/asm/errno.h
+++ b/tools/arch/alpha/include/uapi/asm/errno.h
@@ -127,4 +127,6 @@
 
 #define EHWPOISON	139	/* Memory page has hardware error */
 
+#define ENOTREG		140	/* Not a regular file */
+
 #endif
diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
index c01ed91b1ef4..293c78777254 100644
--- a/tools/arch/mips/include/uapi/asm/errno.h
+++ b/tools/arch/mips/include/uapi/asm/errno.h
@@ -126,6 +126,8 @@
 
 #define EHWPOISON	168	/* Memory page has hardware error */
 
+#define ENOTREG		169	/* Not a regular file */
+
 #define EDQUOT		1133	/* Quota exceeded */
 
 
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 8cbc07c1903e..442917484f99 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -124,4 +124,6 @@
 
 #define EHWPOISON	257	/* Memory page has hardware error */
 
+#define ENOTREG		258	/* Not a regular file */
+
 #endif
diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
index 4a41e7835fd5..8dce0bfeab74 100644
--- a/tools/arch/sparc/include/uapi/asm/errno.h
+++ b/tools/arch/sparc/include/uapi/asm/errno.h
@@ -117,4 +117,6 @@
 
 #define EHWPOISON	135	/* Memory page has hardware error */
 
+#define ENOTREG		136	/* Not a regular file */
+
 #endif
diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..2216ab9aa32e 100644
--- a/tools/include/uapi/asm-generic/errno.h
+++ b/tools/include/uapi/asm-generic/errno.h
@@ -122,4 +122,6 @@
 
 #define EHWPOISON	133	/* Memory page has hardware error */
 
+#define ENOTREG		134	/* Not a regular file */
+
 #endif
-- 
2.52.0


