Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793FA282ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfEWQUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfEWQUg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:20:36 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CD6217F9;
        Thu, 23 May 2019 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558628436;
        bh=B3iL2MevvjloSFBuvJsfwES0AAP7Grp3rVRM5r6SXjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+27ZJA4lAe2s9cHIkr9IWkfKIqdqkWlDUXzPKNEtRP8ZXAilze52ADm20A08WW3+
         jGkVx78JLZNGVozWPylSZzMY7Lf/oEieSQmMFupU3dV4OFtIwVcKGzG0ijb9BjXxS6
         9dyhn+49Arhg6gl8KwyUSX8cpGODU1DGB08nWrv4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-api@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH v3 03/15] fs-verity: add UAPI header
Date:   Thu, 23 May 2019 09:17:59 -0700
Message-Id: <20190523161811.6259-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523161811.6259-1-ebiggers@kernel.org>
References: <20190523161811.6259-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add the UAPI header for fs-verity, including two ioctls:

- FS_IOC_ENABLE_VERITY
- FS_IOC_MEASURE_VERITY

These ioctls are documented in the "User API" section of
Documentation/filesystems/fsverity.rst.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 include/uapi/linux/fsverity.h        | 39 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/uapi/linux/fsverity.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index c9558146ac589..21767c81e86d5 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -225,6 +225,7 @@ Code  Seq#(hex)	Include File		Comments
 'f'	00-0F	fs/ext4/ext4.h		conflict!
 'f'	00-0F	linux/fs.h		conflict!
 'f'	00-0F	fs/ocfs2/ocfs2_fs.h	conflict!
+'f'	81-8F	linux/fsverity.h
 'g'	00-0F	linux/usb/gadgetfs.h
 'g'	20-2F	linux/usb/g_printer.h
 'h'	00-7F				conflict! Charon filesystem
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
new file mode 100644
index 0000000000000..57d1d7fc0c345
--- /dev/null
+++ b/include/uapi/linux/fsverity.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * fs-verity user API
+ *
+ * These ioctls can be used on filesystems that support fs-verity.  See the
+ * "User API" section of Documentation/filesystems/fsverity.rst.
+ *
+ * Copyright 2019 Google LLC
+ */
+#ifndef _UAPI_LINUX_FSVERITY_H
+#define _UAPI_LINUX_FSVERITY_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define FS_VERITY_HASH_ALG_SHA256	1
+
+struct fsverity_enable_arg {
+	__u32 version;
+	__u32 hash_algorithm;
+	__u32 block_size;
+	__u32 salt_size;
+	__u64 salt_ptr;
+	__u32 sig_size;
+	__u32 __reserved1;
+	__u64 sig_ptr;
+	__u64 __reserved2[11];
+};
+
+struct fsverity_digest {
+	__u16 digest_algorithm;
+	__u16 digest_size; /* input/output */
+	__u8 digest[];
+};
+
+#define FS_IOC_ENABLE_VERITY	_IOW('f', 133, struct fsverity_enable_arg)
+#define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)
+
+#endif /* _UAPI_LINUX_FSVERITY_H */
-- 
2.21.0

