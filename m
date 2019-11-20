Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC26810434F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfKTSY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:24:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39955 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfKTSYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id f9so151004plr.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2+igEOnCXCoZoiAJpf5HHbPvlBNpJqwdgFjMnknAbY=;
        b=eK7TtBsTTOswuydlQGQCX2MZgOEiLqA+PiWtbN5oI92q3BbkVN+U1v9tQPxo4a+nA8
         qXLloGoiSXBYGYBi1uoMZ9N5DZHRylT68PwWBNEaIUgs7+98Ke7UlxU8LxMTzTtQ4RVF
         79dPyl/ktVGqSBYNPDrSk/g29ZW5hl/rqcLDAWdxzeA4jxFWBc4WYKg6O5ya1geXHC2B
         AmqWoym6YUG0n6A4ZdOF2sm3so8h4uvd0D+vOHQx54Tl5ln2OQLTkjyiq/sHLTm/rH8a
         AhVHmKQgVa/zVc+Ussn1SSXr0zkUT4E/hsONWHKxEURZP+UKb8GJP0BFqBaHehqb40jK
         bAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2+igEOnCXCoZoiAJpf5HHbPvlBNpJqwdgFjMnknAbY=;
        b=dKgwqEvj2zUtJRWTEtEOlQVi4S5DEzM8uwmva56S5F3vVGj5ZbEzdK2lAUYvRR8BoV
         BmEgYMyqxp+UMO24qg6CFfrTk51zr+nDQRbLZ/p5a1Jua/h86D+zZEEFnNWn+YQvKhiq
         H6uo6z0JS1I+NmRmENYNQFu+YcYSIgsGFNUeQrNKUcKRsw3Bf2iaxLgRtYgBMeS03xCp
         1bMNv5fyn6LztGl+SUgS0qgQSYKeFXmCWgUDA0juqY20TJ7i5pASnA292DSa9RDuqMmf
         mEWJTkQ97wdjCm0kQ3yzydhkccUnOjPSXH95NGXKXLsgTtZVrlwwn4UmfquZYBDUbn9D
         ZxmQ==
X-Gm-Message-State: APjAAAVWsKxaJ/WfZWSOsKgWi7GooItv2Boa3JHHRbcseIJ3ncCQ0zQJ
        0Csg0r7v6OYhSFL5fYj3Sf6pMSB1pMg=
X-Google-Smtp-Source: APXvYqz/nFa1LIb2dXpleNzDUkBRlPW/dFm2GFWU8U4h6SWYn5eD5w9bHRly15ufQHluyuVeanTRjA==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr5695411pjz.110.1574274292981;
        Wed, 20 Nov 2019 10:24:52 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:52 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 02/12] fs: add O_ALLOW_ENCODED open flag
Date:   Wed, 20 Nov 2019 10:24:22 -0800
Message-Id: <f4f6d2902b3845b1193d39c69c1a38c0b286c78a.1574273658.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The upcoming RWF_ENCODED operation introduces some security concerns:

1. Compressed writes will pass arbitrary data to decompression
   algorithms in the kernel.
2. Compressed reads can leak truncated/hole punched data.

Therefore, we need to require privilege for RWF_ENCODED. It's not
possible to do the permissions checks at the time of the read or write
because, e.g., io_uring submits IO from a worker thread. So, add an open
flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
fcntl(). The flag is not cleared in any way on fork or exec; it should
probably be used with O_CLOEXEC in most cases.

Note that the usual issue that unknown open flags are ignored doesn't
really matter for O_ALLOW_ENCODED; if the kernel doesn't support
O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 arch/alpha/include/uapi/asm/fcntl.h  |  1 +
 arch/parisc/include/uapi/asm/fcntl.h |  1 +
 arch/sparc/include/uapi/asm/fcntl.h  |  1 +
 fs/fcntl.c                           | 10 ++++++++--
 fs/namei.c                           |  4 ++++
 include/linux/fcntl.h                |  2 +-
 include/uapi/asm-generic/fcntl.h     |  4 ++++
 7 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..391e0d112e41 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define O_ALLOW_ENCODED	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03ce20e5ad7d..1188b27002b3 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -22,6 +22,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define O_ALLOW_ENCODED	100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..ac3e8c9cb32c 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define O_ALLOW_ENCODED	0x8000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..407e663dff4a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -30,7 +30,8 @@
 #include <asm/siginfo.h>
 #include <linux/uaccess.h>
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | \
+		    O_ALLOW_ENCODED)
 
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
@@ -49,6 +50,11 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 		if (!inode_owner_or_capable(inode))
 			return -EPERM;
 
+	/* O_ALLOW_ENCODED can only be set by superuser */
+	if ((arg & O_ALLOW_ENCODED) && !(filp->f_flags & O_ALLOW_ENCODED) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	/* required for strict SunOS emulation */
 	if (O_NONBLOCK != O_NDELAY)
 	       if (arg & O_NDELAY)
@@ -1031,7 +1037,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..737d9f05b095 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2978,6 +2978,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* O_ALLOW_ENCODED can only be set by superuser */
+	if ((flag & O_ALLOW_ENCODED) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return 0;
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index d019df946cb2..0dc6fa93f7cb 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_ALLOW_ENCODED)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..75321c7a66ac 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_ALLOW_ENCODED
+#define O_ALLOW_ENCODED	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.24.0

