Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1F25A01F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIAUlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 16:41:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57063 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgIAUlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598992866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlstCtrvBNZWrpBYKThZFAl0DgLY52zzXwoMROSSukI=;
        b=hOczQQ7tvelKXIWATe8lD3+hJb7jPlpOg5yhs728fu5eeiWQDVgZJFTYq7047Yh9Lh1fqE
        18jMuNhSyF+f8NWEigi/yklT3v9A25UJPDbFbJM+zebxHKXuSWrCXxJHX3KLL2OKBTBmlU
        Dc74sbZbGHeI0/sElB/EHT96bHXifOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-67EMG3syNBu2avK8K-VzCQ-1; Tue, 01 Sep 2020 16:41:02 -0400
X-MC-Unique: 67EMG3syNBu2avK8K-VzCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C5EF802B7E;
        Tue,  1 Sep 2020 20:41:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C59E35D9CC;
        Tue,  1 Sep 2020 20:40:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 41D8D2254FA; Tue,  1 Sep 2020 16:40:55 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 1/2] fuse: Add a flag FUSE_NONSHARED_FS
Date:   Tue,  1 Sep 2020 16:40:44 -0400
Message-Id: <20200901204045.1250822-2-vgoyal@redhat.com>
In-Reply-To: <20200901204045.1250822-1-vgoyal@redhat.com>
References: <20200901204045.1250822-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FUSE_NONSHARED_FS will signify that filesystem is not shared. That is
all fuse modifications are going thourgh this single fuse connection. It
should not happen that file's data/metadata changed without the knowledge
of fuse. Automatic file time stamp changes will probably be an exception
to this rule.

If filesystem is shared between different clients, then this flag should
not be set.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h          | 3 +++
 fs/fuse/inode.c           | 6 +++++-
 include/uapi/linux/fuse.h | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..3ace15488eb6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -720,6 +720,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/** This is not a shared filesystem */
+	unsigned int nonshared_fs:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..088faa3e352c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -965,6 +965,9 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if (arg->flags & FUSE_NONSHARED_FS) {
+				fc->nonshared_fs = 1;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1002,7 +1005,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_NONSHARED_FS;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..bdb106d9f10b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -172,6 +172,8 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *  7.32
+ *  - add FUSE_NONSHARED_FS flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -314,6 +316,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_NONSHARED_FS: Filesystem is not shared.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -342,6 +345,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_NONSHARED_FS	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.25.4

