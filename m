Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F12890A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgJISQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 14:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732149AbgJISQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602267399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gc3HE0beuXKXmjgEJUYd7yqRfe8GH+88a3rPpHc5o9g=;
        b=PpShMc6ep/KSnDu5aUGIty3qdGk111+oDPxWkNtYK+MBH5xyn5QSE1sNFYa6Kvp9u5alf6
        hJLUB+d4TJeKL6IpIMJStnR7r/fV9kMyUxPNat1DkU3S093s8RZlQtHpDRFmP0TyJwGxTc
        hUOLBGRVwilOlxdkF1wAjvjsjpmip/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-CavirKBBPnWO0aafxnWLxg-1; Fri, 09 Oct 2020 14:16:37 -0400
X-MC-Unique: CavirKBBPnWO0aafxnWLxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB93805F08;
        Fri,  9 Oct 2020 18:16:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-194.rdu2.redhat.com [10.10.115.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55CB66266E;
        Fri,  9 Oct 2020 18:16:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DEA77223D08; Fri,  9 Oct 2020 14:16:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon size change
Date:   Fri,  9 Oct 2020 14:15:09 -0400
Message-Id: <20201009181512.65496-4-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-1-vgoyal@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If fc->handle_killpriv_v2 is enabled, we expect file server to clear
suid/sgid/security.capbility upon chown/truncate/write as appropriate.

Upon truncate (ATTR_SIZE), suid/sgid is cleared only if caller does
not have CAP_FSETID. File server does not know whether caller has
CAP_FSETID or not. Hence set FATTR_KILL_PRIV upon truncate to let
file server know that caller does not have CAP_FSETID and it should
kill suid/sgid as appropriate.

We don't have to send this information for chown (ATTR_UID/ATTR_GID)
as that always clears suid/sgid irrespective of capabilities of
calling process.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c             | 2 ++
 include/uapi/linux/fuse.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c4a01290aec6..ecdb7895c156 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1575,6 +1575,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* For mandatory locking in truncate */
 		inarg.valid |= FATTR_LOCKOWNER;
 		inarg.lock_owner = fuse_lock_owner_id(fc, current->files);
+		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
+			inarg.valid |= FATTR_KILL_PRIV;
 	}
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
 	err = fuse_simple_request(fc, &args);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3ae3f222a0ed..7b8da0a2de0d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -269,6 +269,7 @@ struct fuse_file_lock {
 #define FATTR_MTIME_NOW	(1 << 8)
 #define FATTR_LOCKOWNER	(1 << 9)
 #define FATTR_CTIME	(1 << 10)
+#define FATTR_KILL_PRIV	(1 << 14) /* Matches ATTR_KILL_PRIV */
 
 /**
  * Flags returned by the OPEN request
-- 
2.25.4

