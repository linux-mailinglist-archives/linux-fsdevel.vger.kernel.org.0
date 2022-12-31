Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1365A85F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jan 2023 00:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiLaX6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Dec 2022 18:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiLaX6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:58:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B061000
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 15:57:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja17so17884136wmb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Dec 2022 15:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WccIxo2DJfoEJ5YBwAHVUk30lKwL/NF6q/shqTsMJ/g=;
        b=PYD6Et/bUEgVTRKONHNLIX7Br1SoQK0HjrzczFsh/b64dhdRb+RXa2lfP3U09MVjh+
         8QvH+g41Y2eOOAKAHLMfJ+0olZNzOtxWFnihyy1LZLSoYKVhClQRxA52aiPbQ27h192s
         QBfqv4MetVxeBXsMm8vag5d/5f/MJqZP7H5aDFsTYgX5YJ/wQLScyVt2wkejd1j8LntM
         RZFxnBqLX9DNcuZv3h+buaEphFbigGVSzE3/CMre5MTrICibRgCwDYsXcuINNxPWnZ83
         Fvh3siYDtPPUe9Uh8YVHebdfiqSQruf8lAjV5jEU4PTxkGytB4uw5H/eO+ns1vWfe9Sb
         xhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WccIxo2DJfoEJ5YBwAHVUk30lKwL/NF6q/shqTsMJ/g=;
        b=ARFyaw4lqExxWVRFmScWKIbQK0kTRW8Ms88VnlfnrhfmSTdEqk0HaM2ZjrKI5C3hFn
         8t/Ookac5nHBXW/l563HGkXdR8dUpaoxzEXe6ndicuZKVned0NuOEKdOUmPIfzqCScUg
         QE1kgSHlysYiozRXHyl4G84zvjtOhvxYHZSoX7j3MGQJP57pErR29y3sM3urdb0K9dfV
         oRp0oZgJr3U7GZ1nAnCVsidLL0V6jNGiuIZ6XYT3Pml6rKR+HLhsSpLwqFUIisTScb5K
         8HLsHk7vpfYjNcYvQLrBO+kkcIMQmN10LCANmXPAl5GYgEaGvvz0ofz4LkTF0BtIuMHW
         Qp8Q==
X-Gm-Message-State: AFqh2kpiB/09rn2L1Nkml0exCYHU0epSu6JGvKZUegD5BaRY/kon34+n
        gUxRw7/w2/7MdVdmmKG23qnp8g==
X-Google-Smtp-Source: AMrXdXtRNBDndHkFdZDBELgeq2/SNgFiLZ/gcwKGh8wlH1+fUQyak3Pd1DeT6ZQr37/CBJzorwy7xA==
X-Received: by 2002:a05:600c:3509:b0:3cf:ae53:9193 with SMTP id h9-20020a05600c350900b003cfae539193mr25892482wmq.39.1672531078140;
        Sat, 31 Dec 2022 15:57:58 -0800 (PST)
Received: from localhost.localdomain ([2400:adc1:158:c700:fcdc:d674:179b:c287])
        by smtp.googlemail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm56066592wms.2.2022.12.31.15.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 15:57:57 -0800 (PST)
From:   Ameer Hamza <ahamza@ixsystems.com>
To:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        chuck.lever@oracle.com, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, f.fainelli@gmail.com, slark_xiao@163.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, davem@davemloft.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ahamza@ixsystems.com,
        awalker@ixsystems.com, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: [PATCH v2] Add new open(2) flag - O_EMPTY_PATH
Date:   Sun,  1 Jan 2023 04:56:18 +0500
Message-Id: <20221231235618.117201-1-ahamza@ixsystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202212310842.ysbymPHY-lkp@intel.com>
References: <202212310842.ysbymPHY-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a new flag O_EMPTY_PATH that allows openat and open
system calls to open a file referenced by fd if the path is empty,
and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
beneficial in some cases since it would avoid having to grant /proc
access to things like samba containers for reopening files to change
flags in a race-free way.

Signed-off-by: Ameer Hamza <ahamza@ixsystems.com>

---
Change in v2:
add nonconflicting values for O_EMPTY_PATH on architectures
where default conflicts with existing flags.
---
---
 arch/alpha/include/uapi/asm/fcntl.h    | 1 +
 arch/parisc/include/uapi/asm/fcntl.h   | 1 +
 arch/sparc/include/uapi/asm/fcntl.h    | 1 +
 fs/fcntl.c                             | 2 +-
 fs/namei.c                             | 4 ++--
 fs/open.c                              | 2 +-
 include/linux/fcntl.h                  | 2 +-
 include/uapi/asm-generic/fcntl.h       | 4 ++++
 tools/include/uapi/asm-generic/fcntl.h | 4 ++++
 9 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/uapi/asm/fcntl.h
index 50bdc8e8a271..ea08341bb9fe 100644
--- a/arch/alpha/include/uapi/asm/fcntl.h
+++ b/arch/alpha/include/uapi/asm/fcntl.h
@@ -34,6 +34,7 @@
 
 #define O_PATH		040000000
 #define __O_TMPFILE	0100000000
+#define O_EMPTY_PATH	0200000000
 
 #define F_GETLK		7
 #define F_SETLK		8
diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include/uapi/asm/fcntl.h
index 03dee816cb13..e6144823ee5b 100644
--- a/arch/parisc/include/uapi/asm/fcntl.h
+++ b/arch/parisc/include/uapi/asm/fcntl.h
@@ -19,6 +19,7 @@
 
 #define O_PATH		020000000
 #define __O_TMPFILE	040000000
+#define O_EMPTY_PATH	0100000000
 
 #define F_GETLK64	8
 #define F_SETLK64	9
diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/uapi/asm/fcntl.h
index 67dae75e5274..08aed1e2b32d 100644
--- a/arch/sparc/include/uapi/asm/fcntl.h
+++ b/arch/sparc/include/uapi/asm/fcntl.h
@@ -37,6 +37,7 @@
 
 #define O_PATH		0x1000000
 #define __O_TMPFILE	0x2000000
+#define O_EMPTY_PATH	0x4000000
 
 #define F_GETOWN	5	/*  for sockets. */
 #define F_SETOWN	6	/*  for sockets. */
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 146c9ab0cd4b..7aac650e16e2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1027,7 +1027,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 309ae6fc8c99..2b2735af6d03 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -192,7 +192,7 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	if (unlikely(!len)) {
 		if (empty)
 			*empty = 1;
-		if (!(flags & LOOKUP_EMPTY)) {
+		if (!(flags & (LOOKUP_EMPTY | O_EMPTY_PATH))) {
 			putname(result);
 			return ERR_PTR(-ENOENT);
 		}
@@ -2347,7 +2347,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	if ((flags & (LOOKUP_RCU | LOOKUP_CACHED)) == LOOKUP_CACHED)
 		return ERR_PTR(-EAGAIN);
 
-	if (!*s)
+	if (!*s && unlikely(!(flags & O_EMPTY_PATH)))
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
diff --git a/fs/open.c b/fs/open.c
index 82c1a28b3308..b4ec054a418f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1301,7 +1301,7 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 	if (fd)
 		return fd;
 
-	tmp = getname(filename);
+	tmp = getname_flags(filename, how->flags & O_EMPTY_PATH, NULL);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..bf8467bb0bd2 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTY_PATH)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..a03f4275517b 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index b02c8e0f4057..f32a81604296 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.25.1

