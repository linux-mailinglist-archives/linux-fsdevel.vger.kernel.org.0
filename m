Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA79315A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 00:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhBIX5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 18:57:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234742AbhBIXNj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612912322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3xYup6+fUliwNHXRfRNC75qwTTnxeVY3Sm2uTdWyx38=;
        b=iFT3k3WV1FH+dgubCPSvdc6Fb/CGpuRryNhZuauxA2sglHRdnzK7DnbmBUdlDdc6jbrScd
        4BFH5wy9jdMak/zXK+eItLVpF02x6klrPP8t8oZGKC0sbsgfLYWvX+GdaOjetd7IzRPWgr
        SIJ/Y+VmRujj9Qi+2vSlGMr7dha9rD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-HTxsA67MPEqqA_6xR36jMw-1; Tue, 09 Feb 2021 17:48:05 -0500
X-MC-Unique: HTxsA67MPEqqA_6xR36jMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142C436496;
        Tue,  9 Feb 2021 22:48:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-3.rdu2.redhat.com [10.10.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 076B55D736;
        Tue,  9 Feb 2021 22:47:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8D701220BCF; Tue,  9 Feb 2021 17:47:54 -0500 (EST)
Date:   Tue, 9 Feb 2021 17:47:54 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtiofs: Fail dax mount if device does not support it
Message-ID: <20210209224754.GG3171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now "mount -t virtiofs -o dax myfs /mnt/virtiofs" succeeds even
if filesystem deivce does not have a cache window and hence DAX can't
be supported.

This gives a false sense to user that they are using DAX with virtiofs
but fact of the matter is that they are not.

Fix this by returning error if dax can't be supported and user has asked
for it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: redhat-linux/fs/fuse/virtio_fs.c
===================================================================
--- redhat-linux.orig/fs/fuse/virtio_fs.c	2021-02-04 10:40:21.704370721 -0500
+++ redhat-linux/fs/fuse/virtio_fs.c	2021-02-09 15:56:45.693653979 -0500
@@ -1324,8 +1324,15 @@ static int virtio_fs_fill_super(struct s
 
 	/* virtiofs allocates and installs its own fuse devices */
 	ctx->fudptr = NULL;
-	if (ctx->dax)
+	if (ctx->dax) {
+		if (!fs->dax_dev) {
+			err = -EINVAL;
+			pr_err("virtio-fs: dax can't be enabled as filesystem"
+			       " device does not support it.\n");
+			goto err_free_fuse_devs;
+		}
 		ctx->dax_dev = fs->dax_dev;
+	}
 	err = fuse_fill_super_common(sb, ctx);
 	if (err < 0)
 		goto err_free_fuse_devs;

