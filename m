Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE621D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfEQShE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:04 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57586 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729358AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000og-02; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 12/22] coda: get rid of CODA_ALLOC()
Date:   Fri, 17 May 2019 14:36:50 -0400
Message-Id: <e56010c822e7a7cbaa8a238cf82ad31c67eaa800.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

These days we have kvzalloc() so we can delete CODA_ALLOC().

I made a couple related changes in coda_psdev_write().  First, I
added some error handling to avoid a NULL dereference if the allocation
failed.  Second, I used kvmalloc() instead of kvzalloc() because we
copy over the memory on the next line so there is no need to zero it
first.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/coda_linux.h | 10 ----------
 fs/coda/psdev.c      |  6 +++++-
 fs/coda/upcall.c     |  4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index 126155cadfa9..1ea9521e79d7 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -63,16 +63,6 @@ unsigned short coda_flags_to_cflags(unsigned short);
 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
 
-#define CODA_ALLOC(ptr, cast, size) do { \
-    if (size < PAGE_SIZE) \
-        ptr = kzalloc((unsigned long) size, GFP_KERNEL); \
-    else \
-        ptr = (cast)vzalloc((unsigned long) size); \
-    if (!ptr) \
-	pr_warn("kernel malloc returns 0 at %s:%d\n", __FILE__, __LINE__); \
-} while (0)
-
-
 #define CODA_FREE(ptr, size) kvfree((ptr))
 
 /* inode to cnode access functions */
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 7e9ee614ec57..e90ac440fa29 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -127,7 +127,11 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		        nbytes = size;
 		}
-		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
+		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
+		if (!dcbuf) {
+			retval = -ENOMEM;
+			goto out;
+		}
 		if (copy_from_user(dcbuf, buf, nbytes)) {
 			CODA_FREE(dcbuf, nbytes);
 			retval = -EFAULT;
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index cf1e662681a5..b6ac5fc98189 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -46,7 +46,7 @@ static void *alloc_upcall(int opcode, int size)
 {
 	union inputArgs *inp;
 
-	CODA_ALLOC(inp, union inputArgs *, size);
+	inp = kvzalloc(size, GFP_KERNEL);
         if (!inp)
 		return ERR_PTR(-ENOMEM);
 
@@ -743,7 +743,7 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	CODA_ALLOC((sig_req->uc_data), char *, sizeof(struct coda_in_hdr));
+	sig_req->uc_data = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
 	if (!sig_req->uc_data) {
 		kfree(sig_req);
 		goto exit;
-- 
2.20.1

