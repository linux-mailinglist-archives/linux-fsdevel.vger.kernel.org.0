Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580AB3FF00E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbhIBPXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345725AbhIBPXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630596165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjAGCB+wUR9bfmDDGweER9kazklYGOtSqRBC47EM9+I=;
        b=Mv9PW4232vxdHPb97diMT5dJll1X0LmKC5lWk7CKGNwqnehgst6zTxZ9pq7HeJoBhAkKL+
        9t3xGpr6qhzUDNCCuHHLgAlFwZLYqYe1qGoArhYlGStPREtsyhrJLem/rNkBCMr4uMskmx
        aWvVTDktZ99olo5gqHhISQx2UzMs++w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-pt0Vm-YRN3S039kDJd623Q-1; Thu, 02 Sep 2021 11:22:44 -0400
X-MC-Unique: pt0Vm-YRN3S039kDJd623Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 157C8802C89;
        Thu,  2 Sep 2021 15:22:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D17A60657;
        Thu,  2 Sep 2021 15:22:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C97D32281B4; Thu,  2 Sep 2021 11:22:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        vgoyal@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, bfields@redhat.com,
        stephen.smalley.work@gmail.com, agruenba@redhat.com,
        david@fromorbit.com
Subject: [PATCH v3 1/1] xattr: Allow user.* xattr on symlink and special files
Date:   Thu,  2 Sep 2021 11:22:28 -0400
Message-Id: <20210902152228.665959-2-vgoyal@redhat.com>
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently user.* xattr are not allowed on symlink and special files.

man xattr and recent discussion suggested that primary reason for this
restriction is how file permissions for symlinks and special files
are little different from regular files and directories.

For symlinks, they are world readable/writable and if user xattr were
to be permitted, it will allow unpriviliged users to dump a huge amount
of user.* xattrs on symlinks without any control. (I think quota control
still works with symlinks, just that quota is not typically deployed).

For special files, permissions typically control capability to read/write
from devices (and not necessarily from filesystem). So if a user can
write to device (/dev/null), does not necessarily mean it should be allowed
to write large number of user.* xattrs on the filesystem device node is
residing in.

This patch proposes to relax the restrictions a bit and allow file owner
or privileged user (CAP_FOWNER), to be able to read/write user.* xattrs
on symlink and special files.

Note, for special files, file mode bits represent permission to access
device and not necessarily permission to read/write xattrs.
Hence, inode_permission() is not called on special files and just
being owner (or CAP_FOWNER) is enough to read/write user extended
xattrs on special files.

LSM will still get a chance to allow/deny this operation as xattr
related security hooks are still called. (security_inode_setxattr(),
security_inode_getxattr(), security_inode_removexattr(),
security_inode_listxattr())

virtiofs daemon has a need to store user.* xatrrs on all the files
(including symlinks and special files), and currently that fails. This
patch should help.

Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/xattr.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..69be1681477f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -120,13 +120,26 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 
 	/*
-	 * In the user.* namespace, only regular files and directories can have
-	 * extended attributes. For sticky directories, only the owner and
-	 * privileged users can write attributes.
+	 * In the user.* namespace, for symlinks and special files, only
+	 * the owner and priviliged users can read/write attributes.
+	 * For sticky directories, only the owner and privileged users can
+	 * write attributes.
 	 */
 	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
-		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
+		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
+			if (!inode_owner_or_capable(mnt_userns, inode)) {
+				return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
+			}
+			/*
+			 * This is special file and file mode bits represent
+			 * permission to access device and not
+			 * necessarily permission to read/write xattrs.
+			 * Hence do not call inode_permission() and return
+			 * success.
+			 */
+			if (!S_ISLNK(inode->i_mode))
+				return 0;
+		}
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
 		    (mask & MAY_WRITE) &&
 		    !inode_owner_or_capable(mnt_userns, inode))
-- 
2.31.1

