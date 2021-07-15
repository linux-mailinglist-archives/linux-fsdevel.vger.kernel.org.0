Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B393C9667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhGODUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:20:50 -0400
Received: from foss.arm.com ([217.140.110.172]:46028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234195AbhGODTP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A4211D4;
        Wed, 14 Jul 2021 20:16:22 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15EA23F7D8;
        Wed, 14 Jul 2021 20:16:19 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 08/13] fs/coredump: simplify the printing with '%pD' and '%pd' specifier
Date:   Thu, 15 Jul 2021 11:15:28 +0800
Message-Id: <20210715031533.9553-9-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the printing of dentry and struct file name can be simplified.

Given the space with proper length would be allocated in vprintk_store(),
it is worthy of dropping kmalloc()/kfree() to avoid additional space
allocation.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/coredump.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 07afb5ddb1c4..88063056a801 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -156,35 +156,17 @@ int cn_esc_printf(struct core_name *cn, const char *fmt, ...)
 static int cn_print_exe_file(struct core_name *cn, bool name_only)
 {
 	struct file *exe_file;
-	char *pathbuf, *path, *ptr;
 	int ret;
 
 	exe_file = get_mm_exe_file(current->mm);
 	if (!exe_file)
 		return cn_esc_printf(cn, "%s (path unknown)", current->comm);
 
-	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!pathbuf) {
-		ret = -ENOMEM;
-		goto put_exe_file;
-	}
-
-	path = file_path(exe_file, pathbuf, PATH_MAX);
-	if (IS_ERR(path)) {
-		ret = PTR_ERR(path);
-		goto free_buf;
-	}
-
-	if (name_only) {
-		ptr = strrchr(path, '/');
-		if (ptr)
-			path = ptr + 1;
-	}
-	ret = cn_esc_printf(cn, "%s", path);
+	if (name_only)
+		ret = cn_esc_printf(cn, "%pd", exe_file->f_path.dentry);
+	else
+		ret = cn_esc_printf(cn, "%pD", exe_file);
 
-free_buf:
-	kfree(pathbuf);
-put_exe_file:
 	fput(exe_file);
 	return ret;
 }
-- 
2.17.1

