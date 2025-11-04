Return-Path: <linux-fsdevel+bounces-66957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B1C319BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 15:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC8714F1A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4D32ED5B;
	Tue,  4 Nov 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMppRTw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009E32E73A;
	Tue,  4 Nov 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267613; cv=none; b=Y+K9rZEjKPB99cNA66DoFEUMp8j3nR2H5AGLO0hBDx5hqsOX8vvYxNjJGuKYntTyft1+jZkg7+JiLby7cOuW6FMIY9Bf+EemcPGS5stFp7sbyOenzJX8yEVSjhFSKDlDs5p8AKWvp3duKzS/D9Wbeix0EkVp8NQCDbhZWDUgYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267613; c=relaxed/simple;
	bh=PSoXhcWsZ+D9gsmxshOetA4iLxbhZadu6Vol3FUt214=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEodQgqe5AKUrCR1oNVeIdzaTf56josAMPsEXhMCWx2wvLX21NK0Tx58Vn/TlMOXNC8cjRIicFXQ8eOaMpk2SLSNe7eQ1SAUsEc7AuLeUvnyEZbw3c1YKABCALnex+afJAkVfZlCWru3VIPIQvt7TDEjnGtjrDvfP6gn72t5W10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMppRTw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27186C19421;
	Tue,  4 Nov 2025 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267612;
	bh=PSoXhcWsZ+D9gsmxshOetA4iLxbhZadu6Vol3FUt214=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DMppRTw+ZeDvjoVoi9lBqIrbiKZrL4/QKE6sQBD5LdOVahpjgVBJPSrnRMbGnlTPA
	 gXKnQohtS6wUQZedJiqUGYmBo7dYnFtyfP5Lv3KqyPknqKOzlBA8A4kReQ9A5pAaPD
	 FCZRO37YF7fEHsKw3/E1nn7IqfhD+kbfeJ+49u6/g7PtExeNirYfTAoOiwu6CLqVWZ
	 xw/jm9D/PqwXwiRws70LtSy75tx3AeNxiFIRSfE83kaQV+bXnw1dQA/5QBH4/NvGz5
	 bw/tcycI8AhWzZ0K3O1HJh9h05TF6enesAX0VwKlMfYs6eJ5iCcXFp2Zw90f43Fcp+
	 23oR30n3KLTXw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 15:46:32 +0100
Subject: [PATCH 1/3] fs: rename fs_types.h to fs_dirent.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-fs-header-v1-1-fb39a2efe39e@kernel.org>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
In-Reply-To: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PSoXhcWsZ+D9gsmxshOetA4iLxbhZadu6Vol3FUt214=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyCd64uZBPrluhWNSl/AbX08xlXU6eqxbItAqcPXzTM
 UDy3ZKtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJ52JkuHSakcWMkd/rKnNw
 Vb5K2JctMy4FVEzt3KP/TfeB/umcy4wMH67XKSdK3WueJbqp1X7/5POsintSFi+V+y3/odbktsQ
 kHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We will split out a bunch of types into a separate header.
So free up the appropriate name for it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Makefile                               |  2 +-
 fs/{fs_types.c => fs_dirent.c}            |  2 +-
 include/linux/fs.h                        |  2 +-
 include/linux/{fs_types.h => fs_dirent.h} | 11 +++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index e3523ab2e587..a04274a3c854 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -14,7 +14,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
+		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
 		file_attr.o
 
diff --git a/fs/fs_types.c b/fs/fs_dirent.c
similarity index 98%
rename from fs/fs_types.c
rename to fs/fs_dirent.c
index 78365e5dc08c..e5e08f213816 100644
--- a/fs/fs_types.c
+++ b/fs/fs_dirent.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/fs.h>
+#include <linux/fs_dirent.h>
 #include <linux/export.h>
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..3c971ddace41 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -37,7 +37,7 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
-#include <linux/fs_types.h>
+#include <linux/fs_dirent.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
 #include <linux/mount.h>
diff --git a/include/linux/fs_types.h b/include/linux/fs_dirent.h
similarity index 92%
rename from include/linux/fs_types.h
rename to include/linux/fs_dirent.h
index 54816791196f..92f75c5bac19 100644
--- a/include/linux/fs_types.h
+++ b/include/linux/fs_dirent.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_FS_TYPES_H
-#define _LINUX_FS_TYPES_H
+#ifndef _LINUX_FS_DIRENT_H
+#define _LINUX_FS_DIRENT_H
+
+#include <linux/stat.h>
+#include <linux/types.h>
 
 /*
  * This is a header for the common implementation of dirent
@@ -66,10 +69,10 @@
 
 /*
  * declarations for helper functions, accompanying implementation
- * is in fs/fs_types.c
+ * is in fs/fs_dirent.c
  */
 extern unsigned char fs_ftype_to_dtype(unsigned int filetype);
 extern unsigned char fs_umode_to_ftype(umode_t mode);
 extern unsigned char fs_umode_to_dtype(umode_t mode);
 
-#endif
+#endif /* _LINUX_FS_DIRENT_H */

-- 
2.47.3


