Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF698191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfHURiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfHURiU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28CC0300308B;
        Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A2B760603;
        Wed, 21 Aug 2019 17:38:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B0B95223D00; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH 04/13] fuse: export fuse_len_args()
Date:   Wed, 21 Aug 2019 13:37:33 -0400
Message-Id: <20190821173742.24574-5-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need to query the length of fuse_arg lists.  Make the
symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/dev.c    | 7 ++++---
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 34dd1436cec2..d90dba54f0d4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -350,7 +350,7 @@ void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_put_request);
 
-static unsigned len_args(unsigned numargs, struct fuse_arg *args)
+unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args)
 {
 	unsigned nbytes = 0;
 	unsigned i;
@@ -360,6 +360,7 @@ static unsigned len_args(unsigned numargs, struct fuse_arg *args)
 
 	return nbytes;
 }
+EXPORT_SYMBOL_GPL(fuse_len_args);
 
 static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
@@ -375,7 +376,7 @@ static unsigned int fuse_req_hash(u64 unique)
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
-		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
+		fuse_len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fiq->pending);
 	wake_up_locked(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
@@ -1894,7 +1895,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 	if (out->h.error)
 		return nbytes != reqsize ? -EINVAL : 0;
 
-	reqsize += len_args(out->numargs, out->args);
+	reqsize += fuse_len_args(out->numargs, out->args);
 
 	if (reqsize < nbytes || (reqsize > nbytes && !out->argvar))
 		return -EINVAL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 67521103d3b2..f41ce8f39006 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1098,4 +1098,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
+/**
+ * Return the number of bytes in an arguments list
+ */
+unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.20.1

