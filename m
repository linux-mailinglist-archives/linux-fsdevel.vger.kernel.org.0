Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9822DA015
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502154AbgLNTOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 14:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440496AbgLNTOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:14:18 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14292C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:38 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x15so16878492ilq.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/Y3zSbEAx5VH6dVCdGyeMeVWBXxWYk68SsntHDex+o=;
        b=KSeF2CyC8kVq08OiG0rdey3qndGohgYbEYoGM5Bdhl+y4+DNu+DU5wMHLxj4bpZnJQ
         Hwnt1HMwbEeuCgfbr+yBT7wimq5eZhhhXYnkYgWuXMMWVg8Hjcs+vC1C1zSbjgfhkM7m
         a4RV8wwA7IcweatXnqvhoHjb8SBGLxNaVuf+Tfc9rwPZoO//38unRMQcEGslHoalrTRo
         PE9Q8E+J3QbKHwkcdsBD0xD9ap/71JPnoibXQSuBmAMP0Yu6C0q9YMM3ZK9yy0yJilXP
         /5XnLJd6B5Gb9M+sq4MLZ91IYzwvJUtunIpH81GoVTI4J5msfzHEbKO1vfl0nG8Kjwvw
         9rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/Y3zSbEAx5VH6dVCdGyeMeVWBXxWYk68SsntHDex+o=;
        b=SQrcymxSZcQUwtnCUGR1WKvDB8gayfH3ew9Rp6LoMeZMxeWOs27mBZvxTFgBuQoXrs
         AQcQ6BlYutfIkJYbWFuj1YeFfMJKfQR299ZyCos0rrY7eY9zFsSPkcLRHRD/6S4TxCkQ
         d1ehKkmJvJHopwnIMu6lic9Uyt1aSX0JBaiTybk+6hmdnx4HsD3wF762CSTYLFTvy4zr
         +HV4KKO234u3Yt2geSnIyhGj5BxvV3dS8+qAhQNPqSLeMJN9PxBV55wc7zY50GY3Kgnc
         eI0x0aRWcKf2T7Q8bkqOXyvZDle+X8FN6Bf5R2I4XKf53qFSHUJEWK3WL3D25fPuQjaS
         inaA==
X-Gm-Message-State: AOAM5316lZ9pQIGjxkxi3PBSQwdx/n0DlLyEHX2Nq+5yiBIOKA0jYM52
        QOHJgu2/ehKFl9KAo0kUDsuEBs4/vjx/jw==
X-Google-Smtp-Source: ABdhPJyxZfghV7XdWRj2wNuXLTtRUvrRFhrzHaoTiJpEYR5daHl95XjV0MJ2iB/pjnGU9QE6w8ZrNg==
X-Received: by 2002:a92:607:: with SMTP id x7mr35864078ilg.34.1607973217131;
        Mon, 14 Dec 2020 11:13:37 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 11sm11760566ilt.54.2020.12.14.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:13:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
Date:   Mon, 14 Dec 2020 12:13:23 -0700
Message-Id: <20201214191323.173773-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
References: <20201214191323.173773-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we support non-blocking path resolution internally, expose it
via openat2() in the struct open_how ->resolve flags. This allows
applications using openat2() to limit path resolution to the extent that
it is already cached.

If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
will return -1/-EAGAIN.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/open.c                    | 6 ++++++
 include/linux/fcntl.h        | 2 +-
 include/uapi/linux/openat2.h | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..a83434cfe01c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1087,6 +1087,12 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_NONBLOCK) {
+		/* Don't bother even trying for create/truncate open */
+		if (flags & (O_TRUNC | O_CREAT))
+			return -EAGAIN;
+		lookup_flags |= LOOKUP_NONBLOCK;
+	}
 
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 921e750843e6..919a13c9317c 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,7 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NONBLOCK)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 58b1eb711360..7bc1d0c35108 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -35,5 +35,9 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_NONBLOCK	0x20 /* Only complete if resolution can be
+					completed through cached lookup. May
+					return -EAGAIN if that's not
+					possible. */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.29.2

