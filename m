Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE15B18E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIHJje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 05:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIHJj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:39:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FBBC;
        Thu,  8 Sep 2022 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662629965;
  x=1694165965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GYN6K1XEtbZIYFOF497nm3dEoRDRacw5iqjWmI9bicw=;
  b=bTnXta5bUEvS3Uf/3Rbdyta8/G8B3RbCDNnLKAkRsfh3+2ZCTy0bC4TX
   XJ/PcxzcWcQ+4qIkuWKu8EPvw1u2L49a5RUOewa+b5BiREY/lBFV4pZix
   7kz/43IH313mImItz0FfV0kuf/HW9A11nnBMHa+F80DX+MYfLh/J1Atwj
   zLQQYk14zKQ3pKcAfHqTopxSdDUjnROo1i+NS58M8QKnaeI0olQZWqudW
   39GbeW3uMeVXJWy71aqDf1YkqrgPVrMbvm1ZjWT8Z42Hj8zKg8Wk+2Dwc
   iRgXN8e50fiWD6VYhvLMwPmpM+bNoE6XFg04yyrMgmi/7i1w4aLlk6byb
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <akpm@linux-foundation.org>
CC:     <kernel@axis.com>, <adobriyan@gmail.com>, <vbabka@suse.cz>,
        <dancol@google.com>, <linux-mm@kvack.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] proc: Enable smaps_rollup without ptrace rights
Date:   Thu, 8 Sep 2022 11:39:19 +0200
Message-ID: <20220908093919.843346-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

smaps_rollup is currently only allowed on processes which the user has
ptrace permissions for, since it uses a common proc open function used
by other files like mem and smaps.

However, while smaps provides detailed, individual information about
each memory map in the process (justifying its ptrace rights
requirement), smaps_rollup only provides a summary of the memory usage,
which is not unlike the information available from other places like the
status and statm files, which do not need ptrace permissions.

The first line of smaps_rollup could however be sensitive, since it
exposes the randomized start and end of the process' address space.
This information however does not seem essential to smap_rollup's
purpose and could be replaced with placeholder values to preserve the
format without leaking information.  (I could not find any user space in
Debian or Android which uses the information in the first line.)

Replace the start with 0 and end with ~0 and allow smaps_rollup to be
opened and read regardless of ptrace permissions.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/proc/base.c     | 18 +++++++++++++++---
 fs/proc/internal.h |  1 +
 fs/proc/task_mmu.c |  5 ++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..9482eb3954de 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -792,14 +792,16 @@ static const struct file_operations proc_single_file_operations = {
 	.release	= single_release,
 };
 
-
-struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
+static struct mm_struct *__proc_mem_open(struct inode *inode, unsigned int mode, bool creds)
 {
 	struct task_struct *task = get_proc_task(inode);
 	struct mm_struct *mm = ERR_PTR(-ESRCH);
 
 	if (task) {
-		mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
+		if (creds)
+			mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
+		else
+			mm = get_task_mm(task);
 		put_task_struct(task);
 
 		if (!IS_ERR_OR_NULL(mm)) {
@@ -813,6 +815,16 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 	return mm;
 }
 
+struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
+{
+	return __proc_mem_open(inode, mode, true);
+}
+
+struct mm_struct *proc_mem_open_nocreds(struct inode *inode)
+{
+	return __proc_mem_open(inode, 0, false);
+}
+
 static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
 	struct mm_struct *mm = proc_mem_open(inode, mode);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..5c906661b018 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -293,6 +293,7 @@ struct proc_maps_private {
 } __randomize_layout;
 
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
+struct mm_struct *proc_mem_open_nocreds(struct inode *inode);
 
 extern const struct file_operations proc_pid_maps_operations;
 extern const struct file_operations proc_pid_numa_maps_operations;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4e0023643f8b..13f910b51dce 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -969,8 +969,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		vma = vma->vm_next;
 	}
 
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+	show_vma_header_prefix(m, 0, ~0lu, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
 
@@ -1015,7 +1014,7 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open_nocreds(inode);
 	if (IS_ERR(priv->mm)) {
 		ret = PTR_ERR(priv->mm);
 
-- 
2.34.1

