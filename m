Return-Path: <linux-fsdevel+bounces-75381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKNBK7sldmn0MQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:16:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F68D80F1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18A1E300E3A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD431A7E2;
	Sun, 25 Jan 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfItEUh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4D31A545
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769350550; cv=none; b=Hqqf0uZ8+RVm9nxDxezdFwRXmtXPjHOPED9eF48l/rjzviAwgQwjqbu0qT6EWqcyOYtJmzL/k0VsL4uRqRq1haHisYSmjALxsi+DjsdoVuVJlIUbd/TJ0hawkpOUlcfYw8lnROC2bDGE/IlB/UIZMftO74dZurUXhgx7m6SVmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769350550; c=relaxed/simple;
	bh=QGqt3Aux3twCcABLjHQ/Ga7oCvF1NTPOcQsWQVGV3Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZfubA9N11Hgln3veYeHN0VHDzQaPIdsuCi/qL3Q+2UgXlFeo0q9LF6cU6cPFLxv2wxRk8Wejw9cnpDLevS5iPFusy03V76fb6jd7TxWUHguEftw+XKeofeoDO2gO8Ku7rRyNGM8cj82APvRyOXw8zxtQOGGvD88eLCLxoK9wAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfItEUh0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso1358414a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769350548; x=1769955348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJiKhU14Mhs8ijvHzdc1uU3OQsSQcJ/y7OjoVneEUNo=;
        b=kfItEUh0pd4Vcbt45g8xwIwtRpGO/iNvkCMz+yeR3zmujqIYROZ2xsoo/tscfMIbdZ
         p2+AQhvDVphFowFaeEDmcts9kD+kbSpl2RKgvhHcUtrtMkykgryU42jGkoQa1ijFnp2m
         d5vt+gAvjMcJ/m99MEkKLPXBAiseWjvOE3JeaSBJhC7bmmB/kdWJrleHoGk/5MXrOZIQ
         vHT2C7ubG4uDhEUcaumbRaY86GRbtVzCP+7UkI6gj3yI/g/+xpQsIXWONsTxoprUpmTj
         QmWeGzuwB77SvIgtyDgJVkmBoqaT1gFTTZv4rOTbYv3IKP5DKCptkoyotuV2Nu+1EFQt
         C39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769350548; x=1769955348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJiKhU14Mhs8ijvHzdc1uU3OQsSQcJ/y7OjoVneEUNo=;
        b=ZkfgSMxaTtUB+DT+SNCZFk1REFR7d3HC1iDi6SfOJ8k4XYQcTkDlF4SddntQTeKIbJ
         1kk7fBP2bLHIMx2Gvb3hWDNhM/p46/AA1i+hm7OOwDeozPHmVIYkqIN0FNWx/moxvvq0
         g9zuowHsMnlq7Hz8gLsWlwGSKN38vjRojsGYVQuqf7RZvRIzM1tUVRFs/L1l994LgDO7
         63ZHboEn2wbEa8O89/kHuDg9fn1a96wSAQRsoSdTpzU0kkf+2RJLKSv2W8kznDAILXei
         RgDiTnRkVfCIYpzMz8aSxIU+Hbaxmc7bE72gH6RGP2L+17gJwOPCQRmQN4js4EuJjgi4
         ++8Q==
X-Gm-Message-State: AOJu0YwMXTizWW7tLUbsTCFKWH9fY4XOgBSQ9A1WHxSL1n7Rd6JfAR6x
	mD2VU6ha8PsdJ8UJMZsjajtuPq/bwfgQVDuwhcsYCOnhj1Of5cbXIAJTr/oupQ==
X-Gm-Gg: AZuq6aKVOcAdU4txIErNyAuGiQwiF3+Kk+VTyMdwDArxkIBWaqui86iAQLQ2CS5zPJQ
	L9D5GE6EVcqtxZeqFDUThUcjQ73jSLByteZTuDMHVJbSxuh88lnBJIQTSNBaecQykd8HLH9ybyE
	pSjtUt1CuRyqJ5XLXpmCHSAMcA8/+h3A44BdzkS8xzEQpKfkiQCS0heWAiqvEhhPjJwZK955OoY
	MgJchsC+yZ6JOm9hn2RA2Qe0CTwDLFVtjPvs7rKS3pfSRHpYWPL8wov5fL70Qo2EoX9SI3HheKX
	abhLn/o6eVjGhYJ+fFzG/J/VUjUaJYZ3WXYgYLSXbuftiipsWV9QrApu8aCPz71QSHgOIU8tuXC
	cOBLkijn4E8dZiMKe9NblJp1PLQArq2qQ5DvadbrqSqwULtfMzj4DIBLv5VD4R68tYiDKwFukJ5
	XBUhEWitfJ6cp8fZJal1TTRSsFWe2kWr1CCt6mLDA22SWc+1WUaRQkjw==
X-Received: by 2002:a05:6a21:2e18:b0:340:cc06:94f5 with SMTP id adf61e73a8af0-38e9f1cc3dfmr1469019637.44.1769350547814;
        Sun, 25 Jan 2026 06:15:47 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a4135e6sm6334225a12.25.2026.01.25.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 06:15:47 -0800 (PST)
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
Subject: [PATCH 1/2] open: new O_REGULAR flag support
Date: Sun, 25 Jan 2026 20:14:05 +0600
Message-ID: <20260125141518.59493-2-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125141518.59493-1-dorjoychy111@gmail.com>
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75381-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F68D80F1C
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
 fs/fcntl.c                            | 2 +-
 fs/namei.c                            | 6 ++++++
 fs/open.c                             | 4 +++-
 include/linux/fcntl.h                 | 2 +-
 include/uapi/asm-generic/errno-base.h | 1 +
 include/uapi/asm-generic/fcntl.h      | 4 ++++
 6 files changed, 16 insertions(+), 3 deletions(-)

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
index cf16b6822dd3..365f3cc77e1c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4617,6 +4617,10 @@ static int do_open(struct nameidata *nd,
 		if (unlikely(error))
 			return error;
 	}
+
+	if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
+		return -ENOTREGULAR;
+
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
 
@@ -4766,6 +4770,8 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	struct path path;
 	int error = path_lookupat(nd, flags, &path);
 	if (!error) {
+		if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentry))
+			return -ENOTREGULAR;
 		audit_inode(nd->name, path.dentry, 0);
 		error = vfs_open(&path, file);
 		path_put(&path);
diff --git a/fs/open.c b/fs/open.c
index f328622061c5..670cd6b4967a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1212,7 +1212,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_REGULAR)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1289,6 +1289,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
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
diff --git a/include/uapi/asm-generic/errno-base.h b/include/uapi/asm-generic/errno-base.h
index 9653140bff92..ea9a96d30737 100644
--- a/include/uapi/asm-generic/errno-base.h
+++ b/include/uapi/asm-generic/errno-base.h
@@ -36,5 +36,6 @@
 #define	EPIPE		32	/* Broken pipe */
 #define	EDOM		33	/* Math argument out of domain of func */
 #define	ERANGE		34	/* Math result not representable */
+#define	ENOTREGULAR	35      /* Not a regular file */
 
 #endif
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..11e5eadab868 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_REGULAR
+#define O_REGULAR       040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.52.0


