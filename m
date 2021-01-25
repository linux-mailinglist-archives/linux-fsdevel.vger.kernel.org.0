Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66C302E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbhAYVs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732827AbhAYVia (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD793C06178B
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 13:36:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so383815pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 13:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lupDZJ10NzXK0b+10r3QRAsNyJ1iziPajhNPR3b8z7I=;
        b=d12kqnlV/PdD1QoL93339vQ/NhDc07chPyumWparJtDUSffDW9gpxP4E6Wt5PpvQQC
         z/BwEah+DMT/sG5h/7UWU5DlFxvCe9DU9h8SxB4KgeAhFr8qJadIbRHC+oO3EFLVQ8zP
         Itdf9wPXzSXR6dnGdH4cjGalX7hFWqg+uk4EYSRdzKpgMAOlR3hlnjSP6sZ+A13edqx5
         FaujeA8ntFuyqE5ftoF8u88wyKZSPZSWKHLF9JiGVzxrOkZeJrnOhwNPz/gErwTC+MBF
         jGNIdRdBFI4RbRPvI6UxRrF58CkdsRyr7OCVr0VsVmmYGgGQmmm0tHgLAheXe1PrvKUU
         XpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lupDZJ10NzXK0b+10r3QRAsNyJ1iziPajhNPR3b8z7I=;
        b=Ko5LCntjWQGUBu8KVXLerxeyyDdQ560ExqTt6vs82HDEYC0gQ5IrqJUxEdoIrBrE10
         SE6Z6JISP2kBkqOPsO1/rHmcIUQipFomxK7GViWN1/jntQsb0LXPkRbuc0CUipl3Mqb0
         Yx6TCRF3tHLaDTZxKxPGqfBOapI/vxL5LpLWufgAAGJdHvv6S/l8nASreBku6bvsYliQ
         O3sSoRfBYvBoORoAzFJMaag3LdssmYFgq6YYbVq8K6I/wHYm/1EgbL3XHDiDaJJYFi+6
         lrOhts0ReihJVWSBXfiw5AaRDEzNe31jJpS3uYaK/CBAbHPQ71SZqNlhn2XSHKSokPaN
         /i4A==
X-Gm-Message-State: AOAM533bX31dU6SjXbOR/oMF+SScWXkfAfoykXF+WrI9kz/7sg/Gq2+Z
        DbOiD5wd+kME0meJs42pMX3fsvkYA9zLGA==
X-Google-Smtp-Source: ABdhPJwgQlObIjxIV+ehpprZT8QZloV083Ib+KV4YRhMfTNnw2wtlro4yRXNXnpXdWU5EPRce++sXQ==
X-Received: by 2002:a17:902:ec83:b029:df:e942:93c0 with SMTP id x3-20020a170902ec83b02900dfe94293c0mr2606319plg.55.1611610584026;
        Mon, 25 Jan 2021 13:36:24 -0800 (PST)
Received: from localhost.localdomain (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i3sm9638913pfq.194.2021.01.25.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:36:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] fs: add support for AT_STATX_CACHED
Date:   Mon, 25 Jan 2021 14:36:12 -0700
Message-Id: <20210125213614.24001-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125213614.24001-1-axboe@kernel.dk>
References: <20210125213614.24001-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since we now have LOOKUP_CACHED to only perform a fast lookup of the
dentry cache for path resolution, expose this as AT_STATX_CACHED to
provide the same functionality on the statx side.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/stat.c                  | 4 +++-
 include/uapi/linux/fcntl.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..f42d6fa1ec20 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -171,7 +171,7 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
-		      AT_STATX_SYNC_TYPE))
+		      AT_STATX_SYNC_TYPE | AT_STATX_CACHED))
 		return -EINVAL;
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
@@ -180,6 +180,8 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		lookup_flags |= LOOKUP_AUTOMOUNT;
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
+	if (flags & AT_STATX_CACHED)
+		lookup_flags |= LOOKUP_CACHED;
 
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..19d5059393e7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -111,4 +111,6 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+#define AT_STATX_CACHED		0x10000 /* Only succeeds if inode/dentry is already cached */
+
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.30.0

