Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A796E9821A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfHUR6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbfHUR5j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99A3930014C6;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 611886762B;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A810E223D05; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 09/19] fuse: implement FUSE_INIT map_alignment field
Date:   Wed, 21 Aug 2019 13:57:10 -0400
Message-Id: <20190821175720.25901-10-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
constraints via the FUST_INIT map_alignment field.  Parse this field and
ensure our DAX mappings meet the alignment constraints.

We don't actually align anything differently since our mappings are
already 2MB aligned.  Just check the value when the connection is
established.  If it becomes necessary to honor arbitrary alignments in
the future we'll have to adjust how mappings are sized.

The upshot of this commit is that we can be confident that mappings will
work even when emulating x86 on Power and similar combinations where the
host page sizes are different.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           | 19 +++++++++++++++++--
 include/uapi/linux/fuse.h |  7 ++++++-
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f1059b51c539..b020a4071f80 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -50,7 +50,10 @@
 /** Number of page pointers embedded in fuse_req */
 #define FUSE_REQ_INLINE_PAGES 1
 
-/* Default memory range size, 2MB */
+/*
+ * Default memory range size.  A power of 2 so it agrees with common FUSE_INIT
+ * map_alignment values 4KB and 64KB.
+ */
 #define FUSE_DAX_MEM_RANGE_SZ	(2*1024*1024)
 #define FUSE_DAX_MEM_RANGE_PAGES	(FUSE_DAX_MEM_RANGE_SZ/PAGE_SIZE)
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0af147c70558..d5d134a01117 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -949,9 +949,10 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_init_out *arg = &req->misc.init_out;
+	bool ok = true;
 
 	if (req->out.h.error || arg->major != FUSE_KERNEL_VERSION)
-		fc->conn_error = 1;
+		ok = false;
 	else {
 		unsigned long ra_pages;
 
@@ -1014,6 +1015,13 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
+			    (FUSE_DAX_MEM_RANGE_SZ % arg->map_alignment)) {
+				printk(KERN_ERR "FUSE: map_alignment %u incompatible with dax mem range size %u\n",
+				       arg->map_alignment,
+				       FUSE_DAX_MEM_RANGE_SZ);
+				ok = false;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1027,6 +1035,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
 		fc->conn_init = 1;
 	}
+
+	if (!ok) {
+		fc->conn_init = 0;
+		fc->conn_error = 1;
+	}
+
 	fuse_set_initialized(fc);
 	wake_up_all(&fc->blocked_waitq);
 }
@@ -1046,7 +1060,8 @@ void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_MAP_ALIGNMENT;
 	req->in.h.opcode = FUSE_INIT;
 	req->in.numargs = 1;
 	req->in.args[0].size = sizeof(*arg);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..4461fd640cf2 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -274,6 +274,9 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains byte alignment for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -301,6 +304,7 @@ struct fuse_file_lock {
 #define FUSE_CACHE_SYMLINKS	(1 << 23)
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
+#define FUSE_MAP_ALIGNMENT      (1 << 26)
 
 /**
  * CUSE INIT request/reply flags
@@ -653,7 +657,8 @@ struct fuse_init_out {
 	uint32_t	time_gran;
 	uint16_t	max_pages;
 	uint16_t	padding;
-	uint32_t	unused[8];
+	uint32_t	map_alignment;
+	uint32_t	unused[7];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.20.1

