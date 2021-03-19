Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5834268A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCST4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 15:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhCST4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDhWGmnkBlPVA2wfhVuOmZxNRvF9OYsPldF2ff4rzQI=;
        b=EFXCPpwHyo7h1cyC+gaQBz+Uxs3J0QtOpswvq+qI7vGKiOtEb8cGiOe3xCdQOc2h5KKKiY
        pu4t4e26/3gnP4G/4trVHeItq5sxOz1baJMDfkVICQWxZi7DLB2rsdeSqOp9jfVyBDkJsO
        UiXs8yGDekEFqbZHEIkR8ULwe3kIAZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-323jm4FoMbWKwZPNs9Igug-1; Fri, 19 Mar 2021 15:56:07 -0400
X-MC-Unique: 323jm4FoMbWKwZPNs9Igug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453B7839A43;
        Fri, 19 Mar 2021 19:56:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-114.rdu2.redhat.com [10.10.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C280B10013C1;
        Fri, 19 Mar 2021 19:56:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4AE90225FCD; Fri, 19 Mar 2021 15:56:02 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: [PATCH 3/3] fuse: Add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID
Date:   Fri, 19 Mar 2021 15:55:47 -0400
Message-Id: <20210319195547.427371-4-vgoyal@redhat.com>
In-Reply-To: <20210319195547.427371-1-vgoyal@redhat.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When posix access ACL is set, it can have an effect on file mode and
it can also need to clear SGID if.

- None of caller's group/supplementary groups match file owner group.
AND
- Caller is not priviliged (No CAP_FSETID).

As of now fuser server is responsible for changing the file mode as well. But
it does not know whether to clear SGID or not.

So add a flag FUSE_SETXATTR_ACL_KILL_SGID and send this info with
SETXATTR to let file server know that sgid needs to be cleared as well.

Reported-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/acl.c             | 7 ++++++-
 include/uapi/linux/fuse.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index d31260a139d4..45358124181a 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -71,6 +71,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		return -EINVAL;
 
 	if (acl) {
+		unsigned extra_flags = 0;
 		/*
 		 * Fuse userspace is responsible for updating access
 		 * permissions in the inode, if needed. fuse_setxattr
@@ -94,7 +95,11 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			return ret;
 		}
 
-		ret = fuse_setxattr(inode, name, value, size, 0, 0);
+		if (fc->setxattr_v2 &&
+		    posix_acl_mode_clear_sgid(&init_user_ns, inode))
+			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
+
+		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1bb555c1c117..08c11a7beaa7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -180,6 +180,7 @@
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
  *  - add FUSE_SETXATTR_V2
+ *  - add FUSE_SETXATTR_ACL_KILL_SGID
  */
 
 #ifndef _LINUX_FUSE_H
@@ -454,6 +455,12 @@ struct fuse_file_lock {
  */
 #define FUSE_OPEN_KILL_SUIDGID	(1 << 0)
 
+/**
+ * setxattr flags
+ * FUSE_SETXATTR_ACL_KILL_SGID: Clear SGID when system.posix_acl_access is set
+ */
+#define FUSE_SETXATTR_ACL_KILL_SGID	(1 << 0)
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
-- 
2.25.4

