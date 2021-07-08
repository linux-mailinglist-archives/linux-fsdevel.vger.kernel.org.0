Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC23C18CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGHSDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 14:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhGHSDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625767223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNdGapRBRJZQ1Z2SOCf4wMd2iR2TD2nNsiYZrAOlxeo=;
        b=d3ONow0FZ+0BeuDHj8fr5Jxrowcz7I790h1RJPK4KWRg0F55FzKwFs0/5im5dJgvQe9Klg
        2PfqC/bJfbZgBCmAraU464A86f4sTzF4brPtw5ryl6ZNEpCt4yxFbvGKgOGRrd91DT8fff
        9eZ89NePCe7m4Qda7qnrESdA2Rid6bQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Pm6cBVeaPwyaJ5CA6J_ONg-1; Thu, 08 Jul 2021 14:00:19 -0400
X-MC-Unique: Pm6cBVeaPwyaJ5CA6J_ONg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BD080006E;
        Thu,  8 Jul 2021 18:00:17 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-175.rdu2.redhat.com [10.10.114.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38ED65D9FC;
        Thu,  8 Jul 2021 18:00:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9FC13223D99; Thu,  8 Jul 2021 14:00:09 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        vgoyal@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, jack@suse.cz
Subject: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special files
Date:   Thu,  8 Jul 2021 13:57:38 -0400
Message-Id: <20210708175738.360757-2-vgoyal@redhat.com>
In-Reply-To: <20210708175738.360757-1-vgoyal@redhat.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently user.* xattr are not allowed on symlink and special files.

man xattr and recent discussion suggested that primary reason for this
restriction is how file permissions for symlinks and special files
are little different from regular files and directories.

For symlinks, they are world readable/writable and if user xattr were
to be permitted, it will allow unpriviliged users to dump a huge amount
of user.* xattrs on symlinks without any control.

For special files, permissions typically control capability to read/write
from devices (and not necessarily from filesystem). So if a user can
write to device (/dev/null), does not necessarily mean it should be allowed
to write large number of user.* xattrs on the filesystem device node is
residing in.

This patch proposes to relax the restrictions a bit and allow file owner
or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
on symlink and special files.

virtiofs daemon has a need to store user.* xatrrs on all the files
(including symlinks and special files), and currently that fails. This
patch should help.

Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/xattr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..2f1855c8b620 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -120,12 +120,14 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
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
+		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
+		    !inode_owner_or_capable(mnt_userns, inode))
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
 		    (mask & MAY_WRITE) &&
-- 
2.25.4

