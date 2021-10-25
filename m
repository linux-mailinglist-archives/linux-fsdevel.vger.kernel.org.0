Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15243A4EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhJYUts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233140AbhJYUtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/U85zqZ/XkK+ZIIOheKp7mZSO7yiQCUzI2C3jDFctvk=;
        b=M3nZ9O+vWZzzglA+GwMV5Y2E8a2Ej8gfxdt/quUJSofCZDnxJO9fLW1rlYYSgqK+InHYgC
        4o5VhAjQAXBK4Nm43t3V45aosH03FG647FP5kixP2C0Oij760dLkdvlcCyKOAB/qbjJG1S
        jgYzYpc+5LbICK6eKqU9g5pX75hu3Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-XEvLu8UbNYuMMbdR09BK1Q-1; Mon, 25 Oct 2021 16:47:21 -0400
X-MC-Unique: XEvLu8UbNYuMMbdR09BK1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B261923761;
        Mon, 25 Oct 2021 20:47:19 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF5E160CC4;
        Mon, 25 Oct 2021 20:47:18 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 2/7] FUSE: Add the remote inotify support capability to FUSE
Date:   Mon, 25 Oct 2021 16:46:29 -0400
Message-Id: <20211025204634.2517-3-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the remote inotify support capability to FUSE init flags, which is
supported by the kernel only when the "CONFIG_INOTIFY_USER" config
option is enabled in the guest kernel.

If virtiofsd wants the remote inotify support feature enabled only then
the guest kernel will enable it. However, this means that the kernel
will suppress the local inotify events related to inodes within the
directory exported through virtiofs. The suppression of local events
prevents the guest from receiving duplicate events; one from the guest
kernel and one from virtiofsd.

Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/fuse_i.h | 7 +++++++
 fs/fuse/inode.c  | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f55f9f94b1a4..c3cebfb936d2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -649,6 +649,13 @@ struct fuse_conn {
 	 */
 	unsigned handle_killpriv_v2:1;
 
+	/* Is the remote inotify capability supported by the filesystem?
+	 * If yes then all the local inotify events related to inodes
+	 * in the FUSE filesystem will be suppressed and only the remote
+	 * events will be let through.
+	 */
+	unsigned no_fsnotify:1;
+
 	/*
 	 * The following bitfields are only for optimization purposes
 	 * and hence races in setting them will not cause malfunction
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 12d49a1914e8..039a040ddc91 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1143,6 +1143,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (arg->flags & FUSE_SETXATTR_EXT)
 				fc->setxattr_ext = 1;
+			if (!(arg->flags & FUSE_HAVE_FSNOTIFY)) {
+				fc->no_fsnotify = 1;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1190,6 +1193,9 @@ void fuse_send_init(struct fuse_mount *fm)
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
+#endif
+#ifdef CONFIG_INOTIFY_USER
+	ia->in.flags |= FUSE_HAVE_FSNOTIFY;
 #endif
 	if (fm->fc->auto_submounts)
 		ia->in.flags |= FUSE_SUBMOUNTS;
-- 
2.33.0

