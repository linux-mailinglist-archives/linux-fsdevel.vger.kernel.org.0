Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6351795FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgCDQ7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730072AbgCDQ7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6pQ8jsfaduj841lJuAnYCAgbmehnOTdC6Bq+PWck1A=;
        b=GRxiGidzNo0K5ozehXWnphw2W3BEckGxccQ5TVgoE6oKVI7/rL8JUhmdvwsDhjd6vl7o2K
        bc0PaWPlzZ2ClD6GVK3wgSSQJnJu9whNQjFU+tyO36YEV3SG9mehsWupDOPhWtvDzXw7vX
        uKg2B/YkzfWvFS9Kla9VhravAhyRlU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PZVYUYR1NCiIri0PTi6-tg-1; Wed, 04 Mar 2020 11:59:20 -0500
X-MC-Unique: PZVYUYR1NCiIri0PTi6-tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58FF9800D5C;
        Wed,  4 Mar 2020 16:59:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50DC619E9C;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8A0BE225818; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 18/20] fuse: Release file in process context
Date:   Wed,  4 Mar 2020 11:58:43 -0500
Message-Id: <20200304165845.3081-19-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_file_put(sync) can be called with sync=3Dtrue/false. If sync=3Dtrue,
it waits for release request response and then calls iput() in the
caller's context. If sync=3Dfalse, it does not wait for release request
response, frees the fuse_file struct immediately and req->end function
does the iput().

iput() can be a problem with DAX if called in req->end context. If this
is last reference to inode (VFS has let go its reference already), then
iput() will clean DAX mappings as well and send REMOVEMAPPING requests
and wait for completion. (All the the worker thread context which is
processing fuse replies from daemon on the host).

That means it blocks worker thread and it stops processing further
replies and system deadlocks.

So for now, force sync release of file in case of DAX inodes.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index afabeb1acd50..561428b66101 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -543,6 +543,7 @@ void fuse_release_common(struct file *file, bool isdi=
r)
 	struct fuse_file *ff =3D file->private_data;
 	struct fuse_release_args *ra =3D ff->release_args;
 	int opcode =3D isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
+	bool sync =3D false;
=20
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
=20
@@ -562,8 +563,19 @@ void fuse_release_common(struct file *file, bool isd=
ir)
 	 * Make the release synchronous if this is a fuseblk mount,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
+	 *
+	 * For DAX, fuse server is trusted. So it should be fine to
+	 * do a sync file put. Doing async file put is creating
+	 * problems right now because when request finish, iput()
+	 * can lead to freeing of inode. That means it tears down
+	 * mappings backing DAX memory and sends REMOVEMAPPING message
+	 * to server and blocks for completion. Currently, waiting
+	 * in req->end context deadlocks the system as same worker thread
+	 * can't process REMOVEMAPPING reply it is waiting for.
 	 */
-	fuse_file_put(ff, ff->fc->destroy, isdir);
+	if (IS_DAX(file_inode(file)) || ff->fc->destroy)
+		sync =3D true;
+	fuse_file_put(ff, sync, isdir);
 }
=20
 static int fuse_open(struct inode *inode, struct file *file)
--=20
2.20.1

