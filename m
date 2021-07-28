Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA93D8E32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhG1Mrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 08:47:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236197AbhG1Mrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627476459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgpKgCfg3K4XMuNm688Mi45wMV2YtR53OmRiwINwIY4=;
        b=I8qPmrIIO2vZ/6WAefGZMfzSARWWz+fy6d3xQjuXwzoCUpKlrkYmfHtDxDoe8nKS6/IbEc
        hk7cBPiWBaeHlNfMAGAORbVBZrq+J6XolXoIWJquLJ8KVBleIXgVsfGLJ/dbbIMj1EqDNe
        sUKi98sgDT2eD/GP/40N9UKIZL/rdPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-WuVV65EEMCq5wmTndJ1nUA-1; Wed, 28 Jul 2021 08:47:37 -0400
X-MC-Unique: WuVV65EEMCq5wmTndJ1nUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E72180196C;
        Wed, 28 Jul 2021 12:47:36 +0000 (UTC)
Received: from vishnu.redhat.com (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DB135C1BB;
        Wed, 28 Jul 2021 12:47:36 +0000 (UTC)
From:   Bob Peterson <rpeterso@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [vfs PATCH 1/2] fs: Move notify_change permission checks into may_setattr
Date:   Wed, 28 Jul 2021 07:47:33 -0500
Message-Id: <20210728124734.227375-2-rpeterso@redhat.com>
In-Reply-To: <20210728124734.227375-1-rpeterso@redhat.com>
References: <20210728124734.227375-1-rpeterso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

Move the permission checks in notify_change into a separate function to
make them available to filesystems.

When notify_change is called, the vfs performs those checks before
calling into iop->setattr.  However, a filesystem like gfs2 can only
lock and revalidate the inode inside ->setattr, and it must then repeat
those checks to err on the safe side.

It would be nice to get rid of the double checking, but moving the
permission check into iop->setattr altogether isn't really an option.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/attr.c          | 50 ++++++++++++++++++++++++++++------------------
 include/linux/fs.h |  2 ++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 87ef39db1c34..473d21b3a86d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -249,6 +249,34 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 }
 EXPORT_SYMBOL(setattr_copy);
 
+int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
+		unsigned int ia_valid)
+{
+	int error;
+
+	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) {
+		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+			return -EPERM;
+	}
+
+	/*
+	 * If utimes(2) and friends are called with times == NULL (or both
+	 * times are UTIME_NOW), then we need to check for write permission
+	 */
+	if (ia_valid & ATTR_TOUCH) {
+		if (IS_IMMUTABLE(inode))
+			return -EPERM;
+
+		if (!inode_owner_or_capable(mnt_userns, inode)) {
+			error = inode_permission(mnt_userns, inode, MAY_WRITE);
+			if (error)
+				return error;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(may_setattr);
+
 /**
  * notify_change - modify attributes of a filesytem object
  * @mnt_userns:	user namespace of the mount the inode was found from
@@ -290,25 +318,9 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_TIMES_SET)) {
-		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-			return -EPERM;
-	}
-
-	/*
-	 * If utimes(2) and friends are called with times == NULL (or both
-	 * times are UTIME_NOW), then we need to check for write permission
-	 */
-	if (ia_valid & ATTR_TOUCH) {
-		if (IS_IMMUTABLE(inode))
-			return -EPERM;
-
-		if (!inode_owner_or_capable(mnt_userns, inode)) {
-			error = inode_permission(mnt_userns, inode, MAY_WRITE);
-			if (error)
-				return error;
-		}
-	}
+	error = may_setattr(mnt_userns, inode, ia_valid);
+	if (error)
+		return error;
 
 	if ((ia_valid & ATTR_MODE)) {
 		umode_t amode = attr->ia_mode;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..50192964bf6b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3469,6 +3469,8 @@ extern int buffer_migrate_page_norefs(struct address_space *,
 #define buffer_migrate_page_norefs NULL
 #endif
 
+int may_setattr(struct user_namespace *mnt_userns, struct inode *inode,
+		unsigned int ia_valid);
 int setattr_prepare(struct user_namespace *, struct dentry *, struct iattr *);
 extern int inode_newsize_ok(const struct inode *, loff_t offset);
 void setattr_copy(struct user_namespace *, struct inode *inode,
-- 
2.31.1

