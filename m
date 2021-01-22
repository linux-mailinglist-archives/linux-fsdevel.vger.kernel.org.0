Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7549300E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbhAVUut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbhAVUtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:49:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA4C061356
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 31so3954795plb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ebBFLla+oq6Fu8NNd3NcGHArvFeQ09WYnlC9IkZrxIc=;
        b=CRAF4UcnAm/BtIvVRfBo4+C4xSKqe1kvd5ymqv1SnomF7F+lPPFW3nV2U014DKZ8/m
         gaInPQXQnY7Kuk4NQ/xioc90wp6AhyUMUn2STCF1ZMP66n9zzOCuUrXhU/I6xofMKjSl
         2fVQQHKy7GEdsijw6IeX/rSTujpvHskGJ0arnytgw8N+ZDxHidc8PY/BAhqaJO+5iAKM
         h6FD00W5lpR+pXoQGg8T4sgCRCC0hytnlCibvHPRdCd9G2gIy5mMvkmOf8pt2dNwIKTC
         FJ9qNFyTLo0RLmDkV81EarSPHAGWoykD2mriPKAF6HO2j1Eo3i0PbHFhTG/6gnyTd+dQ
         lLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ebBFLla+oq6Fu8NNd3NcGHArvFeQ09WYnlC9IkZrxIc=;
        b=YP/B9YFo7Sx382/w22uvUmFeN6nD0UYxT7kBIFp1xt4qj3wJ6UGkNjmAzibNrA3ITf
         k+sGFPJMIIJfhZuHbF3cnY4mDaOLytNJNBw8Pkj/XvIX9LNU4UQiNt6n8BN5AO+1JOUJ
         hjSjzTTUvm22fXddTVj6J8n/d2htQN3iD8jYBnDLdj139S84OiXsWc9RdXi3iNrGGmgh
         GWJgzijKxx6B8wsTnfxlEzSY1Aeuc1ovT6hDuv5p1ytTHN/YUVcXGRJyMbuaGS/LHt+R
         x4WU5pHr2Cl/m6hZsNXvqE0N8e488skN2kme7HVPzzwOTYlCOJBDnpq1gcmPeElQjpps
         sgPA==
X-Gm-Message-State: AOAM530EXb47EsGVP/+hlsuO1j2+gGkpi0jyR+cS6dDna2EkU8HtLuiO
        8jEw5omJ7hiG24lLffQX2INO1aLu9olf+A==
X-Google-Smtp-Source: ABdhPJzlU6VoXtH6Y1tNDhS0ekWFfZXU5C+5K1BPn9WzwPAHc8pTtFnqs9nco3ZT5ZQORSBVeehdnQ==
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr214949pjz.234.1611348443355;
        Fri, 22 Jan 2021 12:47:23 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:22 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 02/10] fs: add O_ALLOW_ENCODED open flag
Date:   Fri, 22 Jan 2021 12:46:49 -0800
Message-Id: <09988d880282a6ef0dd04d1fce7db1dbbd2d335c.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
fcntl(). The flag is not cleared in any way on fork or exec.

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
index 03dee816cb13..72ea9bdf5f04 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
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
index 05b36b28f2e8..2c1f0580a497 100644
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
@@ -1035,7 +1041,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 78443a85480a..73b925b133a0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2892,6 +2892,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* O_ALLOW_ENCODED can only be set by superuser */
+	if ((flag & O_ALLOW_ENCODED) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return 0;
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 921e750843e6..dc66c557b7d0 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_ALLOW_ENCODED)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
 #define VALID_UPGRADE_FLAGS \
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
2.30.0

