Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0558223F345
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHGTz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:55:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23414 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726965AbgHGTz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6JUyG/bf2+dwOM6AHu3hayOozdITAyDx7At5vTKLkw=;
        b=H4mMytjMXG4dT4X5vQ6FspXSEXUMugZchqJi73s+9ajkjA+T1DKWlI80KU5Nra+mvMjVEY
        hxWsWYdFkozuY4hA2/5P6phJz3aU4iSUnPDZIGYDSXGquJFvpe9aUIgEGxE0016zSYmvnX
        3XOsTj6xXuTL1UJTS7R6jaeO+fcxPhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-rgZc1ktAMj-7QPss3k7dow-1; Fri, 07 Aug 2020 15:55:53 -0400
X-MC-Unique: rgZc1ktAMj-7QPss3k7dow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A5EA1DE1;
        Fri,  7 Aug 2020 19:55:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DF215D9FC;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 30843222E60; Fri,  7 Aug 2020 15:55:39 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 18/20] fuse: Release file in process context
Date:   Fri,  7 Aug 2020 15:55:24 -0400
Message-Id: <20200807195526.426056-19-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_file_put(sync) can be called with sync=true/false. If sync=true,
it waits for release request response and then calls iput() in the
caller's context. If sync=false, it does not wait for release request
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
index ecd2a42f6e30..605976a586c2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -527,6 +527,7 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
+	bool sync = false;
 
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
@@ -546,8 +547,19 @@ void fuse_release_common(struct file *file, bool isdir)
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
+		sync = true;
+	fuse_file_put(ff, sync, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
-- 
2.25.4

