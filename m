Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500F2B8492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKRTSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgKRTSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA98EC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c66so2052445pfa.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KL+zLObenCRr8TAbXP/rY1WYpChE4QtW4PGigi8A0pA=;
        b=W/kyk3UDt3N7DPmCQPn4ZkKE4LRkiGyWiXzS17YjMRUopPF7pj+l5p3aCGOx0y8yez
         LUhgUiSi3TGntuFX4SnKbdGyei9PNC7s7MrwoYocox7/GCj9+ahokPlTadNoSllSyTgm
         9jn9krpjQvRIK3MYE8xSqKdYfyEgpG536h8SkpS8VkoJ47IfzPCMlvawLS+3rI6eLHy5
         BaZzmwBTe0Jna3aj1CkSbM+OCJdxGseZ7VzdNtiETHJ9va8uMQG6VCHIAwOYyR8MqnWg
         sZg+iEXj9vDlIGiHnm7CXnYaYUxA3Cg79ye5kWp/AbBBgGgDWkambzmqMJGCmit2Pyeg
         5KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL+zLObenCRr8TAbXP/rY1WYpChE4QtW4PGigi8A0pA=;
        b=FrjrqUfiygaUnlnE1KFW8I14zXisl8/RCC0IHvGXTgCZSrf+AasjI5RchXoYMSICrC
         bmh16m+tRSPwsxKFr8IsHnL1rNkkTL0xanG/fHOSlBtc2xdAUDKP8vNVpg50ejNVt97f
         2aune4YHO9ere8Rq79x/O9ZLbqH8j/deF7kj/zwgRedPkpUHk4MWZPMS+hJj4beU3m2A
         Fmr5xRzG5dINbQXiahp0IqZ0/pfMnfoVOtF08rXAi+KdNWIQjlyRA2fYfaj/YMae5C2i
         mcRYm1WpW4PzZG3VNpTm0t2D3kEBgi22ioEMh5mrMzvnQkP6fU7wsaBNmNOJ7To822+x
         iZGQ==
X-Gm-Message-State: AOAM530hTrLBijbPEoMpg1PYEtPim/XPgC3eU+BZJNfN/L8SZIs+JXNo
        0rjbow1pB8yqLCRQjP15JK+XYgxGiSsPBw==
X-Google-Smtp-Source: ABdhPJxAbHO0tARrMZSfd6RzlDMZigHIOyHnSdmYV5kaI6Bt3uxBbiinTupUgu6by4f3nUzMzOaO/w==
X-Received: by 2002:a63:d549:: with SMTP id v9mr1670792pgi.242.1605727116738;
        Wed, 18 Nov 2020 11:18:36 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:35 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
Date:   Wed, 18 Nov 2020 11:18:09 -0800
Message-Id: <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723568.git.osandov@fb.com>
References: <cover.1605723568.git.osandov@fb.com>
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
fcntl(). The flag is not cleared in any way on fork or exec. It must be
combined with O_CLOEXEC when opening to avoid accidental leaks (if
needed, it may be set without O_CLOEXEC by using fnctl()).

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
 fs/open.c                            |  7 +++++++
 include/linux/fcntl.h                |  2 +-
 include/uapi/asm-generic/fcntl.h     |  4 ++++
 8 files changed, 27 insertions(+), 3 deletions(-)

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
index 19ac5baad50f..9302f68fe698 100644
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
index d4a6dd772303..fbf64ce61088 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2890,6 +2890,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* O_ALLOW_ENCODED can only be set by superuser */
+	if ((flag & O_ALLOW_ENCODED) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return 0;
 }
 
diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..f2863aaf78e7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		acc_mode = 0;
 	}
 
+	/*
+	 * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
+	 * leaking encoded I/O privileges.
+	 */
+	if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
+		return -EINVAL;
+
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
 	 * check for O_DSYNC if the need any syncing at all we enforce it's
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
2.29.2

