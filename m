Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39441FAD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEOT3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17A6144FB1;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E58975D723;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1EF9022548F; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 27/30] fuse: Release file in process context
Date:   Wed, 15 May 2019 15:27:12 -0400
Message-Id: <20190515192715.18000-28-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
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
 fs/fuse/file.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 87fc2b5e0a3a..b0293a308b5e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -475,6 +475,7 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_file *ff = file->private_data;
 	struct fuse_req *req = ff->reserved_req;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
+	bool sync = false;
 
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
@@ -495,8 +496,20 @@ void fuse_release_common(struct file *file, bool isdir)
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
-	fuse_file_put(ff, ff->fc->destroy_req != NULL, isdir);
+	if (IS_DAX(req->misc.release.inode) || ff->fc->destroy_req != NULL)
+		sync = true;
+
+	fuse_file_put(ff, sync, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
-- 
2.20.1

