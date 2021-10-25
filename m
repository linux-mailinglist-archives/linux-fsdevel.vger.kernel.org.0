Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE143A4ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhJYUtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230024AbhJYUtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WU2POATQTSBiSWpFN9MEPpa4aO3GGPZu7sHvnBFrprg=;
        b=WpYeH3oeGXkLj3Pw+LdTLygYRwkgIN3OgwqrZP449Aj9d1+E63u3DvRoT4qJzn+1XoD1+F
        pthM8L9mTPAt6Y5eGlEvHrCYZexXerjzUNgXysaVIotJ4qj9gYemEPCr3I+U1U7kVv/eGI
        wsdsQG8LWb01e18lJEqv/pa5K4r/t40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-bTZN7PMbMGOY9WXcaAygJA-1; Mon, 25 Oct 2021 16:47:17 -0400
X-MC-Unique: bTZN7PMbMGOY9WXcaAygJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5130587950C;
        Mon, 25 Oct 2021 20:47:16 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5767360CA1;
        Mon, 25 Oct 2021 20:47:15 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 1/7] FUSE: Add the fsnotify opcode and in/out structs to FUSE
Date:   Mon, 25 Oct 2021 16:46:28 -0400
Message-Id: <20211025204634.2517-2-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since fsnotify is the backend for the inotify subsystem all the backend
code implementation we add is related to fsnotify.

To support an fsnotify request in FUSE and specifically virtiofs we add a
new opcode for the FSNOTIFY (51) operation request in the "fuse.h" header.

Also add the "fuse_notify_fsnotify_in" and "fuse_notify_fsnotify_out"
structs that are responsible for passing the fsnotify/inotify related data
to and from the FUSE server.

Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 include/uapi/linux/fuse.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 46838551ea84..418b7fc72417 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -186,6 +186,9 @@
  *  - add FUSE_SYNCFS
  *  7.35
  *  - add FUSE_NOTIFY_LOCK
+ *  7.36
+ *  - add FUSE_HAVE_FSNOTIFY
+ *  - add fuse_notify_fsnotify_(in,out)
  */
 
 #ifndef _LINUX_FUSE_H
@@ -221,7 +224,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 35
+#define FUSE_KERNEL_MINOR_VERSION 36
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -338,6 +341,7 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_HAVE_FSNOTIFY:	remote fsnotify/inotify event subsystem support
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -369,6 +373,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_HAVE_FSNOTIFY	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
@@ -515,6 +520,7 @@ enum fuse_opcode {
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
+	FUSE_FSNOTIFY		= 51,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -532,6 +538,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_LOCK = 7,
+	FUSE_NOTIFY_FSNOTIFY = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
@@ -571,6 +578,20 @@ struct fuse_getattr_in {
 	uint64_t	fh;
 };
 
+struct fuse_notify_fsnotify_out {
+	uint64_t inode;
+	uint64_t mask;
+	uint32_t namelen;
+	uint32_t cookie;
+};
+
+struct fuse_notify_fsnotify_in {
+	uint64_t mask;
+	uint64_t group;
+	uint32_t action;
+	uint32_t padding;
+};
+
 #define FUSE_COMPAT_ATTR_OUT_SIZE 96
 
 struct fuse_attr_out {
-- 
2.33.0

