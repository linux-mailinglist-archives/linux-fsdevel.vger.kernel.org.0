Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4359924CF74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHUHjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgHUHi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:38:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F9FC061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j13so464317pjd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hunj461oh9Q7J38eWlWUsMBSMG0f/jDb/B+wMlt2xiA=;
        b=MHC+Q9YS8W33sMSsIbwDX2ubNCHI0/zr/tTwDkHTw2+yRFZV5SKeYg15UU1Rh1fFBd
         ZG2vd9Jsn7SI1cCdUwtSeAwChS9bpSIA4At0G1HxE2GRXpDVQLcYAjqcTZV6qufvRfvO
         1KvNTgv2EeGEfN7GHDIYT7lTB4O3icdcbJKSzEr3Q112Or/e9+xt6102h7N5BqIzzLxT
         jEkB9IjQxKiwKPkkioOA9zbtVE+VI+AvHKfMr3T3+JtNuvnq+UC4b+mkh51WN+K7E5cQ
         l067YQm2/pf2ItQojV4rmIXQBd/3mmKMwZ2Lf3m0G09d3fMI6gnOyAPoYMzpk/79Ri7o
         DbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hunj461oh9Q7J38eWlWUsMBSMG0f/jDb/B+wMlt2xiA=;
        b=rlOUbrCrE7H62yHtXpWk4vpOA5X1MeT2Ig1uZ4eut0DBeW36tw5vhX5mSOK4yD7oun
         enTJ76tczv9DTPbnt/uOuSyMUtQ1S2Vi4MPJLM6SBV2J75xaDLx4X9B7dFhIQjbvahj9
         lncd/qYzZE57TGNN6aLa+5xZBmtagftm7aZtzzr/1ajKqjsFD2181k5olojHQcQ6BPJc
         iv/fnrCIG2Ut3ADD9rnJPL4VEmPwhL0TlxbN/kJaBQTJSDsYHR02P4MWVoTL2V9rNRGY
         64MV9RvF08Qv/pCwRkg9rAlGNKb02qLgyA9RyEK7dyZqEEUgJHSdW0pfEioh9kvTZpb1
         wGHg==
X-Gm-Message-State: AOAM531lLdZuQTYmhkhNnj5xQQzsLjNKDmN3W6UCv66eMpC2q+uL3HTQ
        v9aaIvi7Hb9qwsB7picTumNzT3P0S/uJiw==
X-Google-Smtp-Source: ABdhPJwlsPmBRjb1n1dkBd+DorJyEILG58tSCYf6h+j8+2UDVq9tBeyNGexYM1D3ZPKo8ebAZdk3Dg==
X-Received: by 2002:a17:90b:808:: with SMTP id bk8mr1353159pjb.63.1597995535600;
        Fri, 21 Aug 2020 00:38:55 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:54 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 2/9] fs: add O_ALLOW_ENCODED open flag
Date:   Fri, 21 Aug 2020 00:38:33 -0700
Message-Id: <f0db9f271dbe563d2ceaae68f8b74ce4b424efe5.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
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
index 2e4c0fa2074b..a9daebd41d03 100644
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
@@ -1033,7 +1039,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7..7fc5ed73078c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2889,6 +2889,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* O_ALLOW_ENCODED can only be set by superuser */
+	if ((flag & O_ALLOW_ENCODED) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return 0;
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..670939ea3c80 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
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
2.28.0

