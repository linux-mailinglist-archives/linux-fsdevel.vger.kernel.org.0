Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5226CCDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIPUue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgIPQzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPVMGnXUbus53BUYRzcYfDom5uZA6HXgKCZ6zjAHQgU=;
        b=BT34tau5XkxnEDQjK4z7lRoUWVXFyMCuNfH8FanT/3HMOabzclB7yRWTY/0nPzA4qF2FPU
        b/I0U/6za89NH6JXNc1UsusboGxJzdUPQLMepqxzwXpvEmgBG4NPgc02lGGzYoslQKEY7i
        gJgNgq7JagEZTzbhs9JnPsTzLpUwNhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-_7xOA8OyMOWh8otskA0xPA-1; Wed, 16 Sep 2020 12:18:01 -0400
X-MC-Unique: _7xOA8OyMOWh8otskA0xPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CB0D802B6C;
        Wed, 16 Sep 2020 16:17:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEF0614F5;
        Wed, 16 Sep 2020 16:17:59 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9A15E223D0B; Wed, 16 Sep 2020 12:17:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v2 5/6] fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
Date:   Wed, 16 Sep 2020 12:17:36 -0400
Message-Id: <20200916161737.38028-6-vgoyal@redhat.com>
In-Reply-To: <20200916161737.38028-1-vgoyal@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With FUSE_HANDLE_KILLPRIV_V2 support, server will need to kill
suid/sgid/security.capability on open(O_TRUNC), if server supports
FUSE_ATOMIC_O_TRUNC.

But server needs to kill suid/sgid only if caller does not have
CAP_FSETID. Given server does not have this information, client
needs to send this info to server.

So add a flag FUSE_OPEN_KILL_PRIV to fuse_open_in request which tells
server to kill suid/sgid(only if group execute is set).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c            |  5 +++++
 include/uapi/linux/fuse.h | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e40428f3d0f1..2853f55fd8f7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -42,6 +42,11 @@ static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
 	if (!fc->atomic_o_trunc)
 		inarg.flags &= ~O_TRUNC;
+
+	if (fc->handle_killpriv_v2 && (inarg.flags & O_TRUNC) &&
+	    !capable(CAP_FSETID))
+		inarg.open_flags |= FUSE_OPEN_KILL_PRIV;
+
 	args.opcode = opcode;
 	args.nodeid = nodeid;
 	args.in_numargs = 1;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 7b8da0a2de0d..e20b3ee9d292 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -173,6 +173,7 @@
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
  *  - add FUSE_HANDLE_KILLPRIV_V2
+ *  - add FUSE_OPEN_KILL_PRIV
  */
 
 #ifndef _LINUX_FUSE_H
@@ -427,6 +428,13 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
+/**
+ * Open flags
+ * FUSE_OPEN_KILL_PRIV: Kill suid/sgid/security.capability. sgid is cleared
+ * 			only if file has group execute permission.
+ */
+#define FUSE_OPEN_KILL_PRIV	(1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -588,7 +596,7 @@ struct fuse_setattr_in {
 
 struct fuse_open_in {
 	uint32_t	flags;
-	uint32_t	unused;
+	uint32_t	open_flags;
 };
 
 struct fuse_create_in {
-- 
2.25.4

