Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422F349539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhCYPTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231225AbhCYPTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616685551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngHz2qKagXsbyqqzW573XX7EDehDS/8qQ5SoDcQciKI=;
        b=OX/7yvxQ89bBSbUqEkKmFuVZoBwEaRogDl+SpVrkN6Hb8cinptyFuY2dM5xyt7/EDLSw2W
        w/SBMTxQm0JMUJNaHdF5NxzF3Hm2un4nLyz2WwFm5KzdLhb1brDX50BoIcIdDfv3cgQcOy
        6PdaWVt7kmqRyAzUzdKMES+XHfrFZVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-jpuoxVF1P0C_hzLvN1px5g-1; Thu, 25 Mar 2021 11:19:08 -0400
X-MC-Unique: jpuoxVF1P0C_hzLvN1px5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F14C10866A0;
        Thu, 25 Mar 2021 15:18:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-78.rdu2.redhat.com [10.10.118.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9FA9712AC;
        Thu, 25 Mar 2021 15:18:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 78F36223D99; Thu, 25 Mar 2021 11:18:45 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: [PATCH v2 2/2] fuse: Add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID
Date:   Thu, 25 Mar 2021 11:18:23 -0400
Message-Id: <20210325151823.572089-3-vgoyal@redhat.com>
In-Reply-To: <20210325151823.572089-1-vgoyal@redhat.com>
References: <20210325151823.572089-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 fs/fuse/acl.c             | 8 +++++++-
 include/uapi/linux/fuse.h | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index d31260a139d4..8819ceb0a4e5 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -71,6 +71,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		return -EINVAL;
 
 	if (acl) {
+		unsigned extra_flags = 0;
 		/*
 		 * Fuse userspace is responsible for updating access
 		 * permissions in the inode, if needed. fuse_setxattr
@@ -94,7 +95,12 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			return ret;
 		}
 
-		ret = fuse_setxattr(inode, name, value, size, 0, 0);
+		if (fc->setxattr_v2 &&
+		    !in_group_p(i_gid_into_mnt(&init_user_ns, inode)) &&
+		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
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

