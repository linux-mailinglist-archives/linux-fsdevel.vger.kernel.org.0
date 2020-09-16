Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA8526CCE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgIPUug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgIPQzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gc3HE0beuXKXmjgEJUYd7yqRfe8GH+88a3rPpHc5o9g=;
        b=g2eBIZVKep33mcrgI+wa0yZZUw/i1IPYkerxYRqmWqEshOezLnGLs2hdvuvIVFuvYZdF8t
        EVDKQ2sJ2115uKFBlM0JZ5wJuR2atBOjw29+clG2oOxG41w//3VFQpNfWKJn+FreU5CrRN
        i8koWVbgWy82MHCFi0FVmyV/gVvvykE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-wXXaQ4q2MRqVBLrDCfbOBA-1; Wed, 16 Sep 2020 12:17:59 -0400
X-MC-Unique: wXXaQ4q2MRqVBLrDCfbOBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43F88010C7;
        Wed, 16 Sep 2020 16:17:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-139.rdu2.redhat.com [10.10.116.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A984610F3;
        Wed, 16 Sep 2020 16:17:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 92FBC223D09; Wed, 16 Sep 2020 12:17:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v2 3/6] fuse: setattr should set FATTR_KILL_PRIV upon size change
Date:   Wed, 16 Sep 2020 12:17:34 -0400
Message-Id: <20200916161737.38028-4-vgoyal@redhat.com>
In-Reply-To: <20200916161737.38028-1-vgoyal@redhat.com>
References: <20200916161737.38028-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
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

