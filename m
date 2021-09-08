Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CF403B89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbhIHOaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:22 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41492 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351926AbhIHOaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:21 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAP-0004rd-0W; Wed, 08 Sep 2021 10:03:09 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH 7/9] coda: Convert from atomic_t to refcount_t on coda_vm_ops->refcnt
Date:   Wed,  8 Sep 2021 10:03:06 -0400
Message-Id: <20210908140308.18491-8-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 52deab784667..29dd87be2fb8 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -8,6 +8,7 @@
  * to the Coda project. Contact Peter Braam <coda@cs.cmu.edu>.
  */
 
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -28,7 +29,7 @@
 #include "coda_int.h"
 
 struct coda_vm_ops {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	struct file *coda_file;
 	const struct vm_operations_struct *host_vm_ops;
 	struct vm_operations_struct vm_ops;
@@ -98,7 +99,7 @@ coda_vm_open(struct vm_area_struct *vma)
 	struct coda_vm_ops *cvm_ops =
 		container_of(vma->vm_ops, struct coda_vm_ops, vm_ops);
 
-	atomic_inc(&cvm_ops->refcnt);
+	refcount_inc(&cvm_ops->refcnt);
 
 	if (cvm_ops->host_vm_ops && cvm_ops->host_vm_ops->open)
 		cvm_ops->host_vm_ops->open(vma);
@@ -113,7 +114,7 @@ coda_vm_close(struct vm_area_struct *vma)
 	if (cvm_ops->host_vm_ops && cvm_ops->host_vm_ops->close)
 		cvm_ops->host_vm_ops->close(vma);
 
-	if (atomic_dec_and_test(&cvm_ops->refcnt)) {
+	if (refcount_dec_and_test(&cvm_ops->refcnt)) {
 		vma->vm_ops = cvm_ops->host_vm_ops;
 		fput(cvm_ops->coda_file);
 		kfree(cvm_ops);
@@ -189,7 +190,7 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 		cvm_ops->vm_ops.open = coda_vm_open;
 		cvm_ops->vm_ops.close = coda_vm_close;
 		cvm_ops->coda_file = coda_file;
-		atomic_set(&cvm_ops->refcnt, 1);
+		refcount_set(&cvm_ops->refcnt, 1);
 
 		vma->vm_ops = &cvm_ops->vm_ops;
 	}
-- 
2.25.1

