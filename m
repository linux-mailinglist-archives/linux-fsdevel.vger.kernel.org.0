Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9E2DD50D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgLQQUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLQQT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:19:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254EDC06138C
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:19 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 2so26334954ilg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ol+tmUketwscpuPuBQaI1Z7kOiVhZH3tyzDhGgPjybU=;
        b=0LPMk8OW45H/vwx4e1nPSySr7etylJ5I9SWavfnWHcP9tczXMk22hLerawj2OTp6xV
         mGP8333+4XTlXIiN0+M4P3h239Q0kbgwwQt9OSMqJndFevbLp/U+e62Z6RBHI71xRY+c
         R0MSeg0nLKcsRh0d7F/6BjlDdeG2PZGcHBNp7yvJ+R3wXbA9XiBSQdQfQMEx4dMgwf20
         AcYw0mh/x1yt5xF/ZvfFrrGWoE7D/izhJkoQoPlXWonRkoXZ7EYhhRnxnOyvusFrV96G
         OblpBxSxOaYPcl0ZsqnbQ1c0d+tZL+/c9GdkirK023UxXWfiWHf77ksV6Wseyn8+RcPQ
         STmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ol+tmUketwscpuPuBQaI1Z7kOiVhZH3tyzDhGgPjybU=;
        b=RzCRhi/d2A1Cj+gP4Ef/NMXFNLETcKz+tlbDo1DqHnQeoFZn3NNqfp3vSMIuMF9pWT
         CUcOTccMQ6DrY0Y4h1KXlDozPA+TIwjdUO5oHngyzuhIe1akfvE1qnBjUUT30f5uCuHg
         3ObJI6pDg4A3s8ueSHPFUetLR7IV1JSDm89SM6pn+i7NoooSbjy8qBH2gxLeQPF5/2sa
         hPIS7NNcCUXlTvSph9Nond2+hl0PMhjzvkEKpRy4PsnEGehK/8glJg5v2E1+T4cobdtN
         gygflS2m0l9H3wheoKfEiOCYS4fg9objATMRy2u+ZUTsrGZIa0sY2GnjtPaD4VK3Y/1w
         7vQQ==
X-Gm-Message-State: AOAM5319nRBRPudvAQGzC/qM8ZFEoNm/ZV6mqeqCklcRn9FsJzmrRc8I
        vp0vapKcJrtSEMv33U6uGRGqS/vkIWt2Nw==
X-Google-Smtp-Source: ABdhPJxMQ8/iGY5qb+nQHTU/LhfzTacUaYn+29v8xA4LCfgEY1JD27Ycd3vjPP0KdbGHJnoRWo267Q==
X-Received: by 2002:a05:6e02:1525:: with SMTP id i5mr50826860ilu.14.1608221958275;
        Thu, 17 Dec 2020 08:19:18 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm3849957ilk.36.2020.12.17.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:19:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] fs: expose LOOKUP_CACHED through openat2() RESOLVE_CACHED
Date:   Thu, 17 Dec 2020 09:19:10 -0700
Message-Id: <20201217161911.743222-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217161911.743222-1-axboe@kernel.dk>
References: <20201217161911.743222-1-axboe@kernel.dk>
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
index 1e06e443a565..ca5444733acd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1091,6 +1091,12 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_CACHED) {
+		/* Don't bother even trying for create/truncate/tmpfile open */
+		if (flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+			return -EAGAIN;
+		lookup_flags |= LOOKUP_CACHED;
+	}
 
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 921e750843e6..766fcd973beb 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,7 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_CACHED)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 58b1eb711360..a5feb7604948 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -35,5 +35,9 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_CACHED		0x20 /* Only complete if resolution can be
+					completed through cached lookup. May
+					return -EAGAIN if that's not
+					possible. */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.29.2

