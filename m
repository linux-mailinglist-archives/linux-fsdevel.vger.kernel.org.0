Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8D7421EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjF2IT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 04:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjF2IS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:18:28 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DD1727
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 01:17:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688026659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5SMNGabxPZbxYJCCh7gi6dZzrgolHz2a6GLENvxN2eo=;
        b=EqVc2UFkbY25Q5tZ2EUf/gWt+tvm9eo6ZaWVdEGyBjlLu1xdV9gBxRnwFPKkhg7X38sYPH
        4VfMFkIpxvSQowEUDvbirT4sqNXiNrW62MI0yvywHUa5AFmsE/aVEnIZnxtyKZgOo19pZ9
        uGqlwPh8j5IeQlSZIhUgO9ymTKUjMfc=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
Subject: [PATCH v2] fuse: add a new fuse init flag to relax restrictions in no cache mode
Date:   Thu, 29 Jun 2023 16:17:33 +0800
Message-Id: <20230629081733.11309-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

FOPEN_DIRECT_IO is usually set by fuse daemon to indicate need of strong
coherency, e.g. network filesystems. Thus shared mmap is disabled since
it leverages page cache and may write to it, which may cause
inconsistence. But FOPEN_DIRECT_IO can be used not for coherency but to
reduce memory footprint as well, e.g. reduce guest memory usage with
virtiofs. Therefore, add a new fuse init flag FUSE_DIRECT_IO_RELAX to
relax restrictions in that mode, currently, it allows shared mmap.
One thing to note is to make sure it doesn't break coherency in your
use case.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---

v1 -> v2:
    make the new flag a fuse init one rather than a open flag since it's
    not common that different files in a filesystem has different
    strategy of shared mmap.

 fs/fuse/file.c            | 8 ++++++--
 fs/fuse/fuse_i.h          | 3 +++
 fs/fuse/inode.c           | 5 ++++-
 include/uapi/linux/fuse.h | 1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bc4115288eec..871b66b54322 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2478,14 +2478,18 @@ static const struct vm_operations_struct fuse_file_vm_ops = {
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = ff->fm->fc;
 
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
-		/* Can't provide the coherency needed for MAP_SHARED */
-		if (vma->vm_flags & VM_MAYSHARE)
+		/* Can't provide the coherency needed for MAP_SHARED
+		 * if FUSE_DIRECT_IO_RELAX isn't set.
+		 */
+		if (!(ff->open_flags & fc->direct_io_relax) &&
+		    vma->vm_flags & VM_MAYSHARE)
 			return -ENODEV;
 
 		invalidate_inode_pages2(file->f_mapping);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9b7fc7d3c7f1..d830c2360aef 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -792,6 +792,9 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	/* relax restrictions in FOPEN_DIRECT_IO mode */
+	unsigned int direct_io_relax:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d66070af145d..049f9ee547d5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1209,6 +1209,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->init_security = 1;
 			if (flags & FUSE_CREATE_SUPP_GROUP)
 				fc->create_supp_group = 1;
+
+			if (flags & FUSE_DIRECT_IO_RELAX)
+				fc->direct_io_relax = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1254,7 +1257,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
+		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP | FUSE_DIRECT_IO_RELAX;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..2da2acec6bf4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -406,6 +406,7 @@ struct fuse_file_lock {
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
+#define FUSE_DIRECT_IO_RELAX	(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.25.1

