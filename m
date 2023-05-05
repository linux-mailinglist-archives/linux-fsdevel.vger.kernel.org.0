Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689B6F7E8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 10:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEEIRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 04:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEIRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 04:17:06 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DD160B0
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 01:17:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683274619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nT7kQry8oHMnNXnvgQgPuRtK/YcDHASPdexri6qXCeY=;
        b=w2DKtyJ4l0xDE+JVYJERr5hrlLjBAIMm7wsx66xpPqPLUtrofhZP8vbHIaKi9F1SGUX3GM
        ED0i9fSk0niKM44H+jYBhyztb8j1luL1Hwz0FN7W3bbsmFJ4dAC17/nc7Q6gUUj91ebTQv
        sv9b5G+AERswfpCa+holwoeiS5nEbTU=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: add a new flag to allow shared mmap in FOPEN_DIRECT_IO mode
Date:   Fri,  5 May 2023 16:16:52 +0800
Message-Id: <20230505081652.43008-1-hao.xu@linux.dev>
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
virtiofs. Therefore, add a new flag FOPEN_DIRECT_IO_SHARED_MMAP to allow
shared mmap for these cases.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/fuse/file.c            | 11 ++++++++---
 include/uapi/linux/fuse.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e0..655896bdb0d5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -161,7 +161,8 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	}
 
 	if (isdir)
-		ff->open_flags &= ~FOPEN_DIRECT_IO;
+		ff->open_flags &=
+			~(FOPEN_DIRECT_IO | FOPEN_DIRECT_IO_SHARED_MMAP);
 
 	ff->nodeid = nodeid;
 
@@ -2509,8 +2510,12 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return fuse_dax_mmap(file, vma);
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
-		/* Can't provide the coherency needed for MAP_SHARED */
-		if (vma->vm_flags & VM_MAYSHARE)
+		/* Can't provide the coherency needed for MAP_SHARED.
+		 * So disable it if FOPEN_DIRECT_IO_SHARED_MMAP is not
+		 * set, which means we do need strong coherency.
+		 */
+		if (!(ff->open_flags & FOPEN_DIRECT_IO_SHARED_MMAP) &&
+		    vma->vm_flags & VM_MAYSHARE)
 			return -ENODEV;
 
 		invalidate_inode_pages2(file->f_mapping);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..003dcf42e8c2 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -314,6 +314,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_DIRECT_IO_SHARED_MMAP: allow shared mmap when FOPEN_DIRECT_IO is set
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -322,6 +323,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_DIRECT_IO_SHARED_MMAP	(1 << 7)
 
 /**
  * INIT request/reply flags
-- 
2.25.1

