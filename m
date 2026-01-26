Return-Path: <linux-fsdevel+bounces-75474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB+PNGGLd2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:42:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBEC8A43A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAB773004434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C018933FE1A;
	Mon, 26 Jan 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4lDfXBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D333DEED
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442137; cv=none; b=jdUDf+5Rn6aUD3i6EPmXqi5oVFZ3ssKvTqW5bssuhrKPF3VBmWt37bBOsMHBFxBsIrLqHEHqcNhK+EA0vPwrL6z57/w3fYwm1vDldO9h16VlmjdUZ18XvzvOrzB6rRv60Eaj7PiAlTPozO0wQ6jNnf2Do2sPyaQg0Uhffyxw+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442137; c=relaxed/simple;
	bh=zJ9Vt9tPerdPPt4mnUd175UEfBBVgrlSnaR5oX/vaqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+kyRLErOad9k19jFHBiciMFUkd/AfoATh30S7d68CwSaFHZ4keKvgxVew4KineGL9G4xePMIWnKshFnlzzJmAurr4lrZ85qEcaXmhU4Aqa89ZJyZTVqVCyfixxy3CS17rlTD7RR/T3eIsWXFY5rQMobHN2ohcpxDygfzko4iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4lDfXBs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c56188aef06so1829674a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769442135; x=1770046935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWa3a+DKzR2Fpyep8VZA+b+oY1lgONUe6UlM5lxiQJI=;
        b=d4lDfXBs+43Ht2/JO4rsyt+/6Xno0QewFEXDaExzrj7HIICKU/VW3zqXK2gIrWTNHN
         9MjqNHlKklL4jk0CA+nHSRURoWZ0xiv9Cb60ss/AYb6A3V8hX08tOiDPkW5xvShTZBkP
         YYCwmUaaIZ9j0nzYEn/JXUtm/6lqNNxQF8Y5F5nrMxBJ5+VPKUbncKat4dXAZYLeobfa
         nwjBZYHzpRfFRLRNUaugK0oX0Pq4o/Ug2E7tv5s9Voy9Dnk0PnI/maQ0b5QXXE7XgZZA
         IzPrTKWpLnC0bv0Vzk037s34nPMM45CqptOHnzzjFIJwXuzgIU6AdxAkst38fv3veyNA
         eeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442135; x=1770046935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWa3a+DKzR2Fpyep8VZA+b+oY1lgONUe6UlM5lxiQJI=;
        b=Uj7gVsw/hK2aYXAf9WgHTFhGBjjP1o3mFTY45X6+ZSpD+1B7Jibxmx/P8z0IYEXf2o
         mBj5+CzU1HWbdr73ohW9w0Kb/90r3BBbO+vXJf4FUykzOW2vMQzkOpzG816uSBYFkmGX
         xjkmSt/FE+HkJxUcdh+Ml9QTTiQ0Txwvg1O5n6Zw3djlOcsYHXjq0ovzRzcym7g4cGW4
         SghsbkPkFXG4llo06CX9V3tsQED4H01vsRNqGyOmAhdCWBQpdZYhJxq5Ex8+6YQ0jqpN
         lQGULqzqvOSrIN/Psqf0ydm14UxpBl7EFFZAFRPfcPMupUhoPdQC2x06b/S3Stw2Lx6z
         1alw==
X-Gm-Message-State: AOJu0YxvO8v57ovEJesiWb77qpMaxdQlCW/Q9CsXoQJ7ImJCZGnNeRqE
	ikurcTPLdlfxn/3s4Q/6i/x422tu6asLFLopkwMtc4EzItcz/yTLeczhVZKUDQ==
X-Gm-Gg: AZuq6aKgSILzx312eANoDDI6ndHh4UlbS3lpN0KfImibvEZ7vXAXpkFi2y2plRfrkBT
	64pdI2IfP6PP7hmxbGCKiQfz06wZz3RMWMNejr+g7K/OXAKsQvPexdMLU11uee8sYhf7Vqx2i6l
	nUg8d2c0la8tHs2aFW7mJiZucC8WETLbj7YazrmMsFjErpJpVugWdi4DRfEfYRuKVsLlqATveM8
	q+PF8c3dRcEUw9rVmsxMO4tqCPbVmG+4MGxA9NhXfe9VX/dHFtxxdc0P0PzxN983zw79CNX1w5A
	Hf7fG06M94MGhJ3sb32BvrJax9BZfrJiqOefoUxFbMYdWNSayDA7C2fBYMfEgHOqSnybHgecW+8
	mOmSJaUNx1GBz7FPCwIaJNNkGG3Ud//k1mozzm4on09fJunT6azIyqL4ULLIm8ZNASRctT835Ps
	v8CWah512z1Ii//6hsfkoNdOSSPBdd4ryHcDDLniX6Guyjd6ELYToW7Q==
X-Received: by 2002:a17:90b:3a87:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-353c416b994mr4659325a91.19.1769442134809;
        Mon, 26 Jan 2026 07:42:14 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536d88b098sm8649100a91.3.2026.01.26.07.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:42:14 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de
Subject: [PATCH v2 1/2] open: new O_REGULAR flag support
Date: Mon, 26 Jan 2026 21:39:21 +0600
Message-ID: <20260126154156.55723-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126154156.55723-1-dorjoychy111@gmail.com>
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75474-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CBEC8A43A
X-Rspamd-Action: no action

This flag indicates the path should be opened if it's a regular file.
A relevant error code ENOTREGULAR(35) has been introduced. For example,
if open is called on path /dev/null with O_REGULAR in the flag param,
it will return -ENOTREGULAR.

When used in combination with O_CREAT, either the regular file is
created, or if the path already exists, it is opened if it's a regular
file. Otherwise, -ENOTREGULAR is returned.

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
index 03dee816cb13..efd763335ff7 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define O_REGULAR	060000000
 
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


