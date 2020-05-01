Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA51C10FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEAKlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728443AbgEAKlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 06:41:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C42C08E934;
        Fri,  1 May 2020 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aJUIIZx7llyDiWvPxWoaiZ3tmDbGoGzldq4PN6hVryI=; b=SNFvmznHxKG8Sox/+N264cTyuK
        Yrw1uRYxbU2ViLxujech/PF4P59SecwgkDVuOxbpI4w+35TdYZH4th7UhEV56Efbc2I3KDVW4Hx2h
        DsL1dv7+k/RdNpRqkeF7RCkIteaWzYUGDFcTOQ4IgNbRS7V6fmBb2H7KUdWMtw0ZLVPC18DeIxiIk
        7iePkTBLF8EqAlXF7NmLO9UHKAaJgml0VtGewu3Su7OTnlN8K0FDNVRWWhMsP+nhqTJEJGZPlyqwD
        YoNXywJRkP8DsnzJwxZWqb9GwoTnsa6zLZJuD4DrNG2OLSkFHpKvW5Uto8KNbmolY18pvSUXd2olB
        UarltaUg==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUT6T-0008Dk-T9; Fri, 01 May 2020 10:41:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exec: simplify the copy_strings_kernel calling convention
Date:   Fri,  1 May 2020 12:41:04 +0200
Message-Id: <20200501104105.2621149-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501104105.2621149-1-hch@lst.de>
References: <20200501104105.2621149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_strings_kernel is always used with a single argument,
adjust the calling convention to that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_em86.c        |  6 +++---
 fs/binfmt_misc.c        |  4 ++--
 fs/binfmt_script.c      |  6 +++---
 fs/exec.c               | 13 ++++++-------
 include/linux/binfmts.h |  3 +--
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index 466497860c626..f33fa668c91f5 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -68,15 +68,15 @@ static int load_em86(struct linux_binprm *bprm)
 	 * user environment and arguments are stored.
 	 */
 	remove_arg_zero(bprm);
-	retval = copy_strings_kernel(1, &bprm->filename, bprm);
+	retval = copy_string_kernel(bprm->filename, bprm);
 	if (retval < 0) return retval; 
 	bprm->argc++;
 	if (i_arg) {
-		retval = copy_strings_kernel(1, &i_arg, bprm);
+		retval = copy_string_kernel(i_arg, bprm);
 		if (retval < 0) return retval; 
 		bprm->argc++;
 	}
-	retval = copy_strings_kernel(1, &i_name, bprm);
+	retval = copy_string_kernel(i_name, bprm);
 	if (retval < 0)	return retval;
 	bprm->argc++;
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cdb45829354d9..b15257d8ff5e4 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -190,13 +190,13 @@ static int load_misc_binary(struct linux_binprm *bprm)
 		bprm->file = NULL;
 	}
 	/* make argv[1] be the path to the binary */
-	retval = copy_strings_kernel(1, &bprm->interp, bprm);
+	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
 		goto error;
 	bprm->argc++;
 
 	/* add the interp as argv[0] */
-	retval = copy_strings_kernel(1, &fmt->interpreter, bprm);
+	retval = copy_string_kernel(fmt->interpreter, bprm);
 	if (retval < 0)
 		goto error;
 	bprm->argc++;
diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index e9e6a6f4a35f5..c4fb7f52a46e5 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -117,17 +117,17 @@ static int load_script(struct linux_binprm *bprm)
 	retval = remove_arg_zero(bprm);
 	if (retval)
 		return retval;
-	retval = copy_strings_kernel(1, &bprm->interp, bprm);
+	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
 		return retval;
 	bprm->argc++;
 	if (i_arg) {
-		retval = copy_strings_kernel(1, &i_arg, bprm);
+		retval = copy_string_kernel(i_arg, bprm);
 		if (retval < 0)
 			return retval;
 		bprm->argc++;
 	}
-	retval = copy_strings_kernel(1, &i_name, bprm);
+	retval = copy_string_kernel(i_name, bprm);
 	if (retval)
 		return retval;
 	bprm->argc++;
diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d9..b2a77d5acedef 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -588,24 +588,23 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 }
 
 /*
- * Like copy_strings, but get argv and its values from kernel memory.
+ * Copy and argument/environment string from the kernel to the processes stack.
  */
-int copy_strings_kernel(int argc, const char *const *__argv,
-			struct linux_binprm *bprm)
+int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 {
 	int r;
 	mm_segment_t oldfs = get_fs();
 	struct user_arg_ptr argv = {
-		.ptr.native = (const char __user *const  __user *)__argv,
+		.ptr.native = (const char __user *const  __user *)&arg,
 	};
 
 	set_fs(KERNEL_DS);
-	r = copy_strings(argc, argv, bprm);
+	r = copy_strings(1, argv, bprm);
 	set_fs(oldfs);
 
 	return r;
 }
-EXPORT_SYMBOL(copy_strings_kernel);
+EXPORT_SYMBOL(copy_string_kernel);
 
 #ifdef CONFIG_MMU
 
@@ -1863,7 +1862,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out;
 
-	retval = copy_strings_kernel(1, &bprm->filename, bprm);
+	retval = copy_string_kernel(bprm->filename, bprm);
 	if (retval < 0)
 		goto out;
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index a345d9fed3d8d..3d3afe094c97d 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -144,8 +144,7 @@ extern int setup_arg_pages(struct linux_binprm * bprm,
 extern int transfer_args_to_stack(struct linux_binprm *bprm,
 				  unsigned long *sp_location);
 extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
-extern int copy_strings_kernel(int argc, const char *const *argv,
-			       struct linux_binprm *bprm);
+int copy_string_kernel(const char *arg, struct linux_binprm *bprm);
 extern void install_exec_creds(struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
-- 
2.26.2

