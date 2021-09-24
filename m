Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1E417BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 21:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346699AbhIXT0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 15:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346594AbhIXT0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632511506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZFmdZ4LWa9uT8PNPvB/BKNj7TZotZ+Fld6yJ/gLGwI=;
        b=Uz0vopjXGfaJ/hXayo5H1ww9/5q/VJrvknN7bA2xgHkNBtcmRgawtcYtcBJHjlROSNpgLU
        5GBK4wP8cLRYiuxTfqKSIWF2Zm4xXHzrFNwu9P7y6D/TfXA3AEJxFrUJHNo7txnaqhAKRx
        L2hSJFWKnDGiGW4Vfb5lJFEjiD1ZlO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-M1amJ-LGOX6XVbRdwe7WBg-1; Fri, 24 Sep 2021 15:25:05 -0400
X-MC-Unique: M1amJ-LGOX6XVbRdwe7WBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3493AA40C9;
        Fri, 24 Sep 2021 19:25:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 048415D9DD;
        Fri, 24 Sep 2021 19:24:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 60A29228280; Fri, 24 Sep 2021 15:24:56 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     chirantan@chromium.org, vgoyal@redhat.com, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com
Subject: [PATCH 1/2] fuse: Add a flag FUSE_SECURITY_CTX
Date:   Fri, 24 Sep 2021 15:24:41 -0400
Message-Id: <20210924192442.916927-2-vgoyal@redhat.com>
In-Reply-To: <20210924192442.916927-1-vgoyal@redhat.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the FUSE_SECURITY_CTX flag for the `flags` field of the
fuse_init_out struct.  When this flag is set the kernel will append the
security context for a newly created inode to the request (create,
mkdir, mknod, and symlink).  The server is responsible for ensuring that
the inode appears atomically (preferrably) with the requested security context.

For example, if the server is backed by a "real" linux file system then
it can write the security context value to
/proc/thread-self/attr/fscreate before making the syscall to create the
inode.

Vivek:
This patch is slightly modified version of patch from
Chirantan Ekbote <chirantan@chromium.org>. I made changes so that this
patch applies to latest kernel.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/uapi/linux/fuse.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..2fe54c80051a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -184,6 +184,10 @@
  *
  *  7.34
  *  - add FUSE_SYNCFS
+ *
+ *  7.35
+ *  - add FUSE_SECURITY_CTX flag for fuse_init_out
+ *  - add security context to create, mkdir, symlink, and mknod requests
  */
 
 #ifndef _LINUX_FUSE_H
@@ -219,7 +223,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 34
+#define FUSE_KERNEL_MINOR_VERSION 35
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -336,6 +340,8 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
+ * 			mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -367,6 +373,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_SECURITY_CTX	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.31.1

