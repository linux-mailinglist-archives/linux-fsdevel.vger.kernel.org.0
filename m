Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D264F305D57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313224AbhAZWdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbhAZFvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:51:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64693C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 21:50:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p18so10827811pgm.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 21:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hQh9xucPDb8N6xyy474SDbEP/uNP4NQsuioCdvk19o=;
        b=a+udas64ePBT8ikC13g16EZbNKiyk1L2mcgjemzexLqsCW+U0bizKIALhjcWtG/j2i
         V4pqWFPXYvh6y8fih7Y3ADZdSUHUt1aSoTLWLLM+8StMMWzmrcKnwX2rgz2+zlF64WWn
         HSVwQOAoMFrKRe+TxPEdKRnpxGX2TRM3UvurI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hQh9xucPDb8N6xyy474SDbEP/uNP4NQsuioCdvk19o=;
        b=JypX0lLnp9WUoNGkw5VaauLNWfFgULTLAngtYAhBa5Y8awn5ei2KXRQjWKCsiyrDGI
         JNm27X5XfsjwXH+973V5H/B1+XMLpj5S2t+Iz+L7XGod0oc2RRxQ5+LSpbcPqj6d35zP
         NMTAZV9cHF3JNddJx22mb9rd6HyFPSY0wp+zIksvlVlj1Z2jpIS+DsDY74dy5TZbFNNM
         AfPIywcmaOoZ1+xSFqI7VJT5p6yeR7buBIfAib7pdXAukOLT9S24da1qEYuYU/PHVUEn
         HW8zQ3TeVODtSsWNMKHZMr5K3d5B0pcViKTvJHmUxPe7izI8tBleddK6/4gMHn/QMSCZ
         dTcw==
X-Gm-Message-State: AOAM531ALvfbGUUlnDo6uF+PcypgNJIIw0hXO0IT3jCzXke+9lMNz7To
        uaEPxSKsx7ki+7OI+Eq/N1oWe3+TEXKQqA==
X-Google-Smtp-Source: ABdhPJwvkUbWuPxcPS1nBQYiFVPoOVWKBaDqRW/eItWWfUwyzTIR3SXdibpFIWmtRkxAMTTSksHpYA==
X-Received: by 2002:a63:5a4c:: with SMTP id k12mr4221493pgm.95.1611640228657;
        Mon, 25 Jan 2021 21:50:28 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:50cc:9282:4fdd:3979])
        by smtp.gmail.com with ESMTPSA id c8sm17544003pfo.148.2021.01.25.21.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:50:28 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Luis Lozano <llozano@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: generic_copy_file_checks: Do not adjust count based on file size
Date:   Tue, 26 Jan 2021 13:50:22 +0800
Message-Id: <20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_file_range (which calls generic_copy_file_checks) uses the
inode file size to adjust the copy count parameter. This breaks
with special filesystems like procfs/sysfs, where the file size
appears to be zero, but content is actually returned when a read
operation is performed.

This commit ignores the source file size, and makes copy_file_range
match the end of file behaviour documented in POSIX's "read",
where 0 is returned to mark EOF. This would allow "cp" and other
standard tools to make use of copy_file_range with the exact same
behaviour as they had in the past.

Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
This can be reproduced with this simple test case:
 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 #include <unistd.h>

 int
 main(int argc, char **argv)
 {
   int fd_in, fd_out;
   loff_t ret;

   fd_in = open("/proc/version", O_RDONLY);
   fd_out = open("version", O_CREAT | O_WRONLY | O_TRUNC, 0644);

   do {
     ret = copy_file_range(fd_in, NULL, fd_out, NULL, 1024, 0);
     printf("%d bytes copied\n", (int)ret);
   } while (ret > 0);

   return 0;
 }

Without this patch, `version` output file is empty, and no bytes
are copied:
0 bytes copied

With this patch, the loop runs twice and the content of the file
is copied:
315 bytes copied
0 bytes copied

We hit this issue when upgrading Go compiler from 1.13 to 1.15 [1],
as we use Go's `io.Copy` to copy the content of
`/sys/kernel/debug/tracing/trace` to a temporary file.

Under the hood, Go 1.15 uses `copy_file_range` syscall to optimize the
copy operation. However, that fails to copy any content when the input
file is from sysfs/tracefs, with an apparent size of 0 (but there is
still content when you `cat` it, of course).

[1] http://issuetracker.google.com/issues/178332739

 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..7236146f6ad7 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1424,7 +1424,6 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
 	uint64_t count = *req_count;
-	loff_t size_in;
 	int ret;
 
 	ret = generic_file_rw_checks(file_in, file_out);
@@ -1442,13 +1441,6 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	if (pos_in + count < pos_in || pos_out + count < pos_out)
 		return -EOVERFLOW;
 
-	/* Shorten the copy to EOF */
-	size_in = i_size_read(inode_in);
-	if (pos_in >= size_in)
-		count = 0;
-	else
-		count = min(count, size_in - (uint64_t)pos_in);
-
 	ret = generic_write_check_limits(file_out, pos_out, &count);
 	if (ret)
 		return ret;
-- 
2.30.0.280.ga3ce27912f-goog

