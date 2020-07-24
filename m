Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30022CDDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGXSid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:38:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55537 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgGXSid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595615911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Y7R8yC7e8a3wA22JBDo1+psNoRWlIjDrlJjVH3M6pM=;
        b=hEOos2FWS8zD2XMwVlqFUirD5xilQz1AcFO4pIFARFipJ4KXaQZJXeKW1C/FZBwki6U7fy
        44LuaYCCMT/kMQwojivG4b76bZA6VzqrGybx/bGJYIo/f1skWgVJhFkAS3VXa8OZBcGgXx
        tEVQXEVARFTRcNb23+52U06bJGXcy5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-FJdLexSnOC2fJekOeq0Syw-1; Fri, 24 Jul 2020 14:38:30 -0400
X-MC-Unique: FJdLexSnOC2fJekOeq0Syw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EF1A8015F4;
        Fri, 24 Jul 2020 18:38:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-85.rdu2.redhat.com [10.10.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC0A10013C2;
        Fri, 24 Jul 2020 18:38:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3A922223D05; Fri, 24 Jul 2020 14:38:25 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH 3/5] fuse: Add a flag FUSE_SETATTR_KILL_PRIV
Date:   Fri, 24 Jul 2020 14:38:10 -0400
Message-Id: <20200724183812.19573-4-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-1-vgoyal@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With handle_killpriv_v2, server needs to kill suid/sgid on truncate (setattr)
but it does not know if caller has CAP_FSETID or not. So like write, send
killpriv information in fuse_setattr_in and add a flag FUSE_SETATTR_KILL_PRIV.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c             | 11 ++++++++---
 include/uapi/linux/fuse.h | 11 ++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..82747ca4c5c8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1437,13 +1437,15 @@ void fuse_release_nowrite(struct inode *inode)
 static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
 			      struct inode *inode,
 			      struct fuse_setattr_in *inarg_p,
-			      struct fuse_attr_out *outarg_p)
+			      struct fuse_attr_out *outarg_p,
+			      uint32_t setattr_flags)
 {
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
 	args->in_numargs = 1;
 	args->in_args[0].size = sizeof(*inarg_p);
 	args->in_args[0].value = inarg_p;
+	inarg_p->setattr_flags = setattr_flags;
 	args->out_numargs = 1;
 	args->out_args[0].size = sizeof(*outarg_p);
 	args->out_args[0].value = outarg_p;
@@ -1474,7 +1476,7 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 		inarg.valid |= FATTR_FH;
 		inarg.fh = ff->fh;
 	}
-	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
+	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg, 0);
 
 	return fuse_simple_request(fc, &args);
 }
@@ -1501,6 +1503,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb && S_ISREG(inode->i_mode);
+	uint32_t setattr_flags = 0;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -1529,6 +1532,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (attr->ia_valid & ATTR_SIZE) {
 		if (WARN_ON(!S_ISREG(inode->i_mode)))
 			return -EIO;
+		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+			setattr_flags |= FUSE_SETATTR_KILL_PRIV;
 		is_truncate = true;
 	}
 
@@ -1565,7 +1570,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		inarg.valid |= FATTR_LOCKOWNER;
 		inarg.lock_owner = fuse_lock_owner_id(fc, current->files);
 	}
-	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
+	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg, setattr_flags);
 	err = fuse_simple_request(fc, &args);
 	if (err) {
 		if (err == -EINTR)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 960ba8af5cf4..4b275653ac2e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -173,6 +173,7 @@
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
  *  - add FUSE_HANDLE_KILLPRIV_V2
+ *  - add FUSE_SETATTR_KILL_PRIV
  */
 
 #ifndef _LINUX_FUSE_H
@@ -368,6 +369,14 @@ struct fuse_file_lock {
  */
 #define FUSE_GETATTR_FH		(1 << 0)
 
+/**
+ * Setattr flags
+ * FUSE_SETATTR_KILL_PRIV: kill suid and sgid bits. sgid should be killed
+ * only if group execute bit (S_IXGRP) is set. Meant to be used together
+ * with FUSE_HANDLE_KILLPRIV_V2.
+ */
+#define FUSE_SETATTR_KILL_PRIV	(1 << 0)
+
 /**
  * Lock flags
  */
@@ -566,7 +575,7 @@ struct fuse_link_in {
 
 struct fuse_setattr_in {
 	uint32_t	valid;
-	uint32_t	padding;
+	uint32_t	setattr_flags;
 	uint64_t	fh;
 	uint64_t	size;
 	uint64_t	lock_owner;
-- 
2.25.4

