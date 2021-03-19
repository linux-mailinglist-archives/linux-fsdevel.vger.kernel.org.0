Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A357342688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhCST4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 15:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhCST4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8vf0ntv6vZtHIIlnMnshk7MthH0lMBrpY+YvS+Cm2U=;
        b=UPvFvylaSWzrJDuSD9bigZpVGiL1cssAslUTJxF8Y4wdoJgeuuK6DEye3RBzYVB5KgQ37W
        SeCVAKFfmhLQ6BqCuc0KUa+Cncezh1SzFZSC1F3Syh3xmDO5GQiErqGUlL+WIeiy4qpw55
        0Air7ugSkN8emCyvq9ivJ635/oRS1SI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-aeLBLauOORuScnfHdMkD6w-1; Fri, 19 Mar 2021 15:56:08 -0400
X-MC-Unique: aeLBLauOORuScnfHdMkD6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8270D839A44;
        Fri, 19 Mar 2021 19:56:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-114.rdu2.redhat.com [10.10.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C25D516E3A;
        Fri, 19 Mar 2021 19:56:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3C5D9223D98; Fri, 19 Mar 2021 15:56:02 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com, Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/3] posic_acl: Add a helper determine if SGID should be cleared
Date:   Fri, 19 Mar 2021 15:55:45 -0400
Message-Id: <20210319195547.427371-2-vgoyal@redhat.com>
In-Reply-To: <20210319195547.427371-1-vgoyal@redhat.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

posix_acl_update_mode() determines what's the equivalent mode and if SGID
needs to be cleared or not. I need to make use of this code in fuse
as well. Fuse will send this information to virtiofs file server and
file server will take care of clearing SGID if it needs to be done.

Hence move this code in a separate helper so that more than one place
can call into it.

Cc: Jan Kara <jack@suse.cz>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/posix_acl.c            |  3 +--
 include/linux/posix_acl.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f3309a7edb49..2d62494c4a5b 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -684,8 +684,7 @@ int posix_acl_update_mode(struct user_namespace *mnt_userns,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
-	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+	if (posix_acl_mode_clear_sgid(mnt_userns, inode))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 307094ebb88c..073c5e546de3 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -59,6 +59,17 @@ posix_acl_release(struct posix_acl *acl)
 }
 
 
+static inline bool
+posix_acl_mode_clear_sgid(struct user_namespace *mnt_userns,
+			  struct inode *inode)
+{
+	if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
+	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
+		return true;
+
+	return false;
+}
+
 /* posix_acl.c */
 
 extern void posix_acl_init(struct posix_acl *, int);
-- 
2.25.4

