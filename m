Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE12D8875
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbgLLQwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407684AbgLLQwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:52:34 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487FC06179C
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:20 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id bj5so6341165plb.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jx2p8zKcStTihV6+upJYHlS8EgfFfVFr751VhyGZa2I=;
        b=UuvnrO3fWVC9xrRHQSZQ5RM0661ic/ajsGVxdApFEYAjmW9J8bEm5CnP8+W4gz1DI4
         6syYsWwGocS1HyG9ow6tw+40+QRNLxv6ptuj/HbD8+5KeMtcxCRh9jO8mxLfMsUTAyT4
         y5Vy7XYTklBlV7rWAiglVtQXLwbdr4fHM+7uCqNbESQBr/2+dkRzSXWcuW0vi/7IL/hw
         LwDNfxf+LprxZGZgK7czpWhP9nQfGsydBuFWZ/pLAZG1WC3TXvW/i1PaAKb1Ig+Gc8C9
         v5cUU7Mijh4qNUaf+DFhvcBi+M7WGJo8b0dyb7/fm2mw+jkrBZZ23D9eLnBZYQJdUqCC
         jxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jx2p8zKcStTihV6+upJYHlS8EgfFfVFr751VhyGZa2I=;
        b=poDOFrSAzBuovddLT0CfjwjNmCrF2xQVMSNOnUW16jxao7XbgaP0ggXgojVEmvErHe
         7bJTrXA374QpRPEkeDLz+zND+EdMByLqDtuEr/fnkt4RD4kraIRdfoalqA4IgM6ZT7X6
         7W1+QoBOaK724a9sHpeUM7ytbQpx7nFMGDceixMQ+fJ9VKYxMNoUpLtE4Xc8RJyb6BKH
         oM1kswpz1bH8zrQ0/i71N7d2LCY3mKauffb0vkXxYTUi7GULaaQFjS5a5u8zPmydrN5/
         JbLaPwiHxKmg/6X5J2eaEEGwYQHbF7r05ac3ertLitKAehrWsdcSZMvPYhPGLpGne4lZ
         YGYA==
X-Gm-Message-State: AOAM533Qmrk5oJdKR6sj6+b2V5DQ4lKJId37o8jl6cA2xg932YuBO5O9
        rfnQwaI1tADL+a5CmLcdhP52GcXoUUQGZg==
X-Google-Smtp-Source: ABdhPJz8j6dPy0qxFPoutYPKyocd3AhloYQEN6avW7MC1aH9b47/N+XAv608OtdUji8jfh2F4YvPIg==
X-Received: by 2002:a17:902:9309:b029:db:c725:d19c with SMTP id bc9-20020a1709029309b02900dbc725d19cmr16197172plb.39.1607791879295;
        Sat, 12 Dec 2020 08:51:19 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
Date:   Sat, 12 Dec 2020 09:51:05 -0700
Message-Id: <20201212165105.902688-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165105.902688-1-axboe@kernel.dk>
References: <20201212165105.902688-1-axboe@kernel.dk>
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
 fs/open.c                    | 5 +++++
 include/linux/fcntl.h        | 2 +-
 include/uapi/linux/openat2.h | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..3561ef4a6689 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1087,6 +1087,11 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_NONBLOCK) {
+		if (flags & O_TRUNC)
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

