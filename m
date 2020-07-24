Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67E22CDE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgGXSih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726676AbgGXSig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GNSW95GGKShebNtAUWbT47/rlR8zDxszAF5AVLBvrwM=;
        b=LZsBBli9gfWDZiOZfGBijJH+usaMpuxLYEui4sjAb7NXICbFKJpAVRc6b3Urj4g4Qv84gR
        4V4110Qa8hKMMFIfHrzFqh1YXl5s2zUH5Nef5XncvpaMJw2kAoQL0fFPp+Ll7KbXEzUq9G
        vZ9GaLO/ySJZqwOfeaSH02K3hoMWlr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-5c_rYiaPOL69p136Iq73pA-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: 5c_rYiaPOL69p136Iq73pA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3601D80183C;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10245C1BB;
        Fri, 24 Jul 2020 18:38:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2B23F223D03; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH 1/5] fuse: Introduce the notion of FUSE_HANDLE_KILLPRIV_V2
Date:   Fri, 24 Jul 2020 14:38:08 -0400
Message-Id: <20200724183812.19573-2-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FUSE_HANDLE_KILLPRIV flag says that file server will remove suid/sgid/caps
on truncate/chown/write.

But to be consistent with VFS behavior what we want is.

- caps are always cleared on chown/write/truncate
- suid is always cleared on chown, while for truncate/write it is cleared
  only if caller does not have CAP_FSETID.
- sgid is always cleared on chown, while for truncate/write it is cleared
  only if caller does not have CAP_FSETID as well as file has group execute
  permission.

As previous flag did not provide above semantics. Implement a V2 of the
protocol with above said constraints.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h          | 6 ++++++
 fs/fuse/inode.c           | 5 ++++-
 include/uapi/linux/fuse.h | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..71bede0a57c9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -610,6 +610,12 @@ struct fuse_conn {
 	/** cache READLINK responses in page cache */
 	unsigned cache_symlinks:1;
 
+	/** fs kills suid/sgid/cap on write/chown/trunc. suid is
+	    killed on write/trunc only if caller did not have CAP_FSETID.
+	    sgid is killed on write/truncate only if caller did not have
+	    CAP_FSETID as well as file has group execute permission. */
+	unsigned handle_killpriv_v2:1;
+
 	/*
 	 * The following bitfields are only for optimization purposes
 	 * and hence races in setting them will not cause malfunction
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..113ba149e08d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -965,6 +965,8 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2)
+				fc->handle_killpriv_v2 = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1002,7 +1004,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_HANDLE_KILLPRIV_V2;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..960ba8af5cf4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -172,6 +172,7 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *  - add FUSE_HANDLE_KILLPRIV_V2
  */
 
 #ifndef _LINUX_FUSE_H
@@ -314,6 +315,11 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_HANDLE_KILLPRIV_V2: fs kills suid/sgid/cap on write/chown/trunc.
+ * 			Upon write/truncate suid/sgid is only killed if caller
+ * 			does not have CAP_FSETID. Additionally upon
+ * 			write/truncate sgid is killed only if file has group
+ * 			execute permission. (Same as Linux VFS behavior).
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -342,6 +348,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_HANDLE_KILLPRIV_V2	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.25.4

