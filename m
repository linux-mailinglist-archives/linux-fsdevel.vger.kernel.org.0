Return-Path: <linux-fsdevel+bounces-63348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D95BB660E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667404E6273
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B372BE7D1;
	Fri,  3 Oct 2025 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="zczoeOkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CA13A258
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483957; cv=none; b=l2sRiNe+k8P9+KCp+fAPxSWZwAlSQxtEtuEK6tqBMQxCNmccrtJkWr2k4XB7z9uf1MyN3Tso2l2Kw2yyBOa5nQzK5lzXuynwXPSnSKbtq0LVBt6sc1sde8qh5K7p+mJy60xWCa+urkgL++SVPZ0sXYXr2WKFadwJoOFhNlc93VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483957; c=relaxed/simple;
	bh=27L4uh3T3sD3FaT3mi6Um/T3GNSikDRGKpdcFCKlw0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjP44NMs+9f9l5LpDatrrpFXw99BHxrkH17MVNR6eJVKC7PFxWYMQQSG7IjrVvm1uJQf39Imw8AKfbafeMGslgL5ggbo42Of5pZJ5EtnThoPdOdUgg0s4zI+ecS6flhpmHd/IXxpWSjOCjK6Eh5noOuEcOoMgIxIRSA5Lry+Zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=zczoeOkH; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so2429164e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1759483954; x=1760088754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTNlKoj8Gh3CtoTvU/s2KlgWO3qTOL9nprGGGi1sGuU=;
        b=zczoeOkHlcGkEK1eG7Fd2yEpu9Yi3e9EmWFsSOFAFiSbKWh7vqAgNzYMuGak71qedR
         E5uIBu5dJt4jT+UW72cv3fuQhpLZbHyH8Nvhkj81lpv5GQ0tXCsItHEb+utOTmRtlwE5
         2UvTEjVC2LPw6llXNhYl8alq47dOn5bflnVEnhsz3W3eubfg7RYqNG4VL7cGdlXtHBR+
         m3AI4quCfcc/xjPzPqqsjUa6upQEcemN1g2VGxXTu+xbSq03gAx1OtaAv1FX7AXIosK/
         GIYI0FCbybGFGqc/gUA1oqu051GDOgZhoCVYocPFR0ejHnonndCTBKGiGRQxS0fIHIRH
         Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483954; x=1760088754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTNlKoj8Gh3CtoTvU/s2KlgWO3qTOL9nprGGGi1sGuU=;
        b=gt51JUzRDP6F9L422bT1xo0/beAdeHmrpt+YMFrrYvbSJ53eQ+wyNYfa95DF7CE7K0
         sXvHZSUjoYIz9E9qVpWFHJw3nZUOexLEKaUPA4Bi1guRCXy5WKUfhyvemulileg/idV2
         twEpdecj2DGuO4QVtyhWOC8nzPOkcWT+TzImSU+K+Vhu0Mmpk7gZXM/5S2CnyIvI1Z62
         pJe7QTd7nUNPTgkqsYjvDVeAm9v/fnlEDuStHZ6E8+1Ye3DT+boR41dBhQoBKExKXhXH
         EdsB1LdQPtt925U/anjlRDkUSXkqGwJnAH9rB+r3xj2cufEJw/ko0ttc+nFCZ8WMxhzp
         VCVw==
X-Gm-Message-State: AOJu0YwtZIxRrQexevm5i/xdIvot/Dg6CNqPZq3tmeONPVW/ikek9Pi/
	ZWLtKPIIg8k94sqs0jAuLa+I/oQzLR7ulOUpptcpGIbgGHPQ0WYHowrK4U9/lPqtNMftLkm7xXG
	Q2y+PGZgmgarwSut/22uL4aVFC27yYk8jFHrpE91zc5f4oYyrr5SmTYZCsadLVY75q48ycVIiza
	zJqiEpmgnrr5E0IsP5Hm2d49f7gqw7+e7P5Snd9W+w3YXQT6Ut3G0FU8quN9hjRinSdxPIlMLtq
	t67oPU1/gs124oDlB62lha2aqSe6eC4qzB+8DdBUw1E7g+Z22BMlsfi/tbSXyf4+QriYeb9OkVg
	ChQLF2HJz+JA8KZW2qbjemmYkpfU8XUSso0kss4Yj7V+L9HjhCkvsfQbiFV4etKecz2GXCZEWpE
	=
X-Gm-Gg: ASbGncuIQorxDxX16DwaG1jq760Ozgbr3FVQOVylYFXztPMkvAGhQ72mYgQgxB37vsJ
	djQOjFm9390b9BuFq2KK/IKqMDDM03FZwND34yG5f98HdGJNiqqNmiFYXAPwMnL6QbNCcShTKF8
	EBblC0FzbTkm2L4vjaI6j9kq7bV2w5M4eRalh6XLSC5qbX50+pXuLyI5uqSKDK6SaaJz5LypuNB
	JCdojZkFUVrjnVuUe20RuV2K+DpqRCYr5Bm8VWj0rfE0dniK5PpbBpCOJ2+42cTPdv0uCtF+O3E
	VU78V5IzxIKnsCec4Dcpi11NpwI9Xbsn3FV7jx9no0cts9+l+A2I6krL1F0qleo+nSp23oUKhPO
	5xU4q2sXLKSw8Fd4pVPjhysu2JkkLMSM8kPHwQQ==
X-Google-Smtp-Source: AGHT+IGpfJAAhfW13Lb1WB4Fxy+WLIX6gaaJa1KchEW313p+JIYM62Y7eTKC53iAsevdGMQI2y1kbQ==
X-Received: by 2002:ac2:5692:0:b0:57d:d62e:b229 with SMTP id 2adb3069b0e04-58cb9b2e612mr755607e87.16.1759483953331;
        Fri, 03 Oct 2025 02:32:33 -0700 (PDT)
Received: from fedora ([104.28.198.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e4a5sm1650041e87.93.2025.10.03.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:32:31 -0700 (PDT)
From: Pavel Emelyanov <xemul@scylladb.com>
To: linux-fsdevel@vger.kernel.org
Cc: "Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>
Subject: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
Date: Fri,  3 Oct 2025 12:32:13 +0300
Message-ID: <20251003093213.52624-1-xemul@scylladb.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

The FMODE_NOCMTIME flag tells that ctime and mtime stamps are not
updated on IO. The flag was introduced long ago by 4d4be482a4 ([XFS]
add a FMODE flag to make XFS invisible I/O less hacky. Back then it
was suggested that this flag is propagated to a O_NOCMTIME one.
This patch does so.

It can be used by workloads that want to write a file but don't care
much about the preciese timestamp on it and can update it later with
utimens() call.

There's another reason for having this patch. When performing AIO write,
the file_modified_flags() function checks whether or not to update inode
times. In case update is needed and iocb carries the RWF_NOWAIT flag,
the check return EINTR error that quickly propagates into cb completion
without doing any IO. This restriction effectively prevents doing AIO
writes with nowait flag, as file modifications really imply time update.

There was an attempt to mitigate this requirement [1] by a patch titled
"inode: Relax RWF_NOWAIT restriction for EINTR in file_modified_flags()"
It would require lazytime mount, but it's still probabilistic, as
marking inode dirty for future timestamp update is not guaranteed not to
block. More bullet-proof aproach would be not to update cmtime on writes
at all.

Signed-off-by: Pavel Emelyanov <xemul@scylladb.com>

[1] https://marc.info/?l=linux-fsdevel&m=175768745515859&w=2
---
 arch/alpha/include/uapi/asm/fcntl.h  | 2 ++
 arch/parisc/include/uapi/asm/fcntl.h | 2 ++
 arch/sparc/include/uapi/asm/fcntl.h  | 2 ++
 fs/fcntl.c                           | 7 ++++---
 fs/inode.c                           | 2 +-
 fs/namei.c                           | 2 +-
 fs/xfs/xfs_exchrange.c               | 4 ++--
 fs/xfs/xfs_handle.c                  | 3 +--
 include/linux/fcntl.h                | 2 +-
 include/linux/fs.h                   | 8 --------
 include/trace/misc/fs.h              | 1 +
 include/uapi/asm-generic/fcntl.h     | 4 ++++
 12 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..41b31ed1714d 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -35,6 +35,8 @@
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
 
+#define O_NOCMTIME	0200000000
+
 #define F_GETLK		7
 #define F_SETLK		8
 #define F_SETLKW	9
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..3c68f7918b70 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -20,6 +20,8 @@
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
 
+#define O_NOCMTIME	0100000000
+
 #define F_GETLK64	8
 #define F_SETLK64	9
 #define F_SETLKW64	10
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..69590581b9f7 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -38,6 +38,8 @@
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
 
+#define O_NOCMTIME	0x4000000
+
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
 #define F_GETLK		7
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 72f8433d9109..e05129e7f658 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -34,7 +34,7 @@
 
 #include "internal.h"
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | O_NOCMTIME)
 
 static int setfl(int fd, struct file * filp, unsigned int arg)
 {
@@ -49,7 +49,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 		return -EPERM;
 
 	/* O_NOATIME can only be set by the owner or superuser */
-	if ((arg & O_NOATIME) && !(filp->f_flags & O_NOATIME))
+	if (((arg & O_NOATIME) && !(filp->f_flags & O_NOATIME)) ||
+			((arg & O_NOCMTIME) && !(filp->f_flags & O_NOCMTIME)))
 		if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
 			return -EPERM;
 
@@ -1156,7 +1157,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..69b2faf6350b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2404,7 +2404,7 @@ static int file_modified_flags(struct file *file, int flags)
 	if (ret)
 		return ret;
 
-	if (unlikely(file->f_mode & FMODE_NOCMTIME))
+	if (unlikely(file->f_flags & O_NOCMTIME))
 		return 0;
 
 	ret = inode_needs_update_time(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 507ca0d7878d..ba423dd12e48 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3577,7 +3577,7 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 	}
 
 	/* O_NOATIME can only be set by the owner or superuser */
-	if (flag & O_NOATIME && !inode_owner_or_capable(idmap, inode))
+	if (flag & (O_NOATIME | O_NOCMTIME) && !inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	return 0;
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 0b41bdfecdfb..4b1eaa9db4ae 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -772,9 +772,9 @@ xfs_exchange_range(
 		return ret;
 
 	/* Update cmtime if the fd/inode don't forbid it. */
-	if (!(fxr->file1->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode1))
+	if (!(fxr->file1->f_flags & O_NOCMTIME) && !IS_NOCMTIME(inode1))
 		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME1;
-	if (!(fxr->file2->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode2))
+	if (!(fxr->file2->f_flags & O_NOCMTIME) && !IS_NOCMTIME(inode2))
 		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME2;
 
 	file_start_write(fxr->file2);
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index f19fce557354..0e8c84385f37 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -295,8 +295,7 @@ xfs_open_by_handle(
 	}
 
 	if (S_ISREG(inode->i_mode)) {
-		filp->f_flags |= O_NOATIME;
-		filp->f_mode |= FMODE_NOCMTIME;
+		filp->f_flags |= (O_NOATIME | O_NOCMTIME);
 	}
 
 	fd_install(fd, filp);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..1105a0bd5847 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_NOCMTIME)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 75fb216b0f7a..3f84e6a42e6e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -136,14 +136,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* 64bit hashes as llseek() offset (for directories) */
 #define FMODE_64BITHASH         ((__force fmode_t)(1 << 10))
 
-/*
- * Don't update ctime and mtime.
- *
- * Currently a special hack for the XFS open_by_handle ioctl, but we'll
- * hopefully graduate it to a proper O_CMTIME flag supported by open(2) soon.
- */
-#define FMODE_NOCMTIME		((__force fmode_t)(1 << 11))
-
 /* Expect random access pattern */
 #define FMODE_RANDOM		((__force fmode_t)(1 << 12))
 
diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
index 0406ebe2a80a..aa8cf481dcc0 100644
--- a/include/trace/misc/fs.h
+++ b/include/trace/misc/fs.h
@@ -37,6 +37,7 @@
 		{ O_DIRECTORY,		"O_DIRECTORY" }, \
 		{ O_NOFOLLOW,		"O_NOFOLLOW" }, \
 		{ O_NOATIME,		"O_NOATIME" }, \
+		{ O_NOCMTIME,		"O_NOCMTIME" }, \
 		{ O_CLOEXEC,		"O_CLOEXEC" })
 
 #define __fmode_flag(x)	{ (__force unsigned long)FMODE_##x, #x }
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..39f637bfb19a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -95,6 +95,10 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+#ifndef O_NOCMTIME
+#define O_NOCMTIME	040000000
+#endif
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
-- 
2.51.0


