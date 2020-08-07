Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66023F366
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHGT5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:57:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgHGTzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1YK+dRX48++bcQSBbjSrKQM9bu8x29oyfw9Y+MmJRY=;
        b=GiiUK4WF61TFDghYBsIH3XiUCHpwrGg+Hwll2o14UzW5gR3wKwMiGcGsjzm1Y0/NUeiY6r
        Ybc74+G6hdoxP3gM2djMKOyGjYpTE3FITVaS3ytR4LPdEah9PYmGGQQLCofKYQato6JzLn
        wP0ffTOtHnrnHxoFTqMYntBu3puemno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-NBf-wxbKNtWXmpCp-38WHw-1; Fri, 07 Aug 2020 15:55:47 -0400
X-MC-Unique: NBf-wxbKNtWXmpCp-38WHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D293107BEF5;
        Fri,  7 Aug 2020 19:55:46 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CE62DE77;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EBAEF222E53; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 11/20] fuse: implement FUSE_INIT map_alignment field
Date:   Fri,  7 Aug 2020 15:55:17 -0400
Message-Id: <20200807195526.426056-12-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           | 19 +++++++++++++++++--
 include/uapi/linux/fuse.h |  4 +++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 478c940b05b4..4a46e35222c7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,7 +47,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
-/* Default memory range size, 2MB */
+/*
+ * Default memory range size.  A power of 2 so it agrees with common FUSE_INIT
+ * map_alignment values 4KB and 64KB.
+ */
 #define FUSE_DAX_SZ	(2*1024*1024)
 #define FUSE_DAX_SHIFT	(21)
 #define FUSE_DAX_PAGES	(FUSE_DAX_SZ/PAGE_SIZE)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b82eb61d63cc..9b690456de30 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -980,9 +980,10 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 {
 	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
 	struct fuse_init_out *arg = &ia->out;
+	bool ok = true;
 
 	if (error || arg->major != FUSE_KERNEL_VERSION)
-		fc->conn_error = 1;
+		ok = false;
 	else {
 		unsigned long ra_pages;
 
@@ -1045,6 +1046,14 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
+			    (FUSE_DAX_SZ % (1ul << arg->map_alignment))) {
+				printk(KERN_ERR "FUSE: map_alignment %u"
+				       " incompatible with dax mem range size"
+				       " %u\n", arg->map_alignment,
+				       FUSE_DAX_SZ);
+				ok = false;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1060,6 +1069,11 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 	}
 	kfree(ia);
 
+	if (!ok) {
+		fc->conn_init = 0;
+		fc->conn_error = 1;
+	}
+
 	fuse_set_initialized(fc);
 	wake_up_all(&fc->blocked_waitq);
 }
@@ -1082,7 +1096,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_MAP_ALIGNMENT;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..5b85819e045f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -313,7 +313,9 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
- * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
-- 
2.25.4

