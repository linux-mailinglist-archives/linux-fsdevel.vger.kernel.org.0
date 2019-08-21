Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9498176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfHURi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbfHURi0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1E2550F45;
        Wed, 21 Aug 2019 17:38:25 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A290601AF;
        Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BACDB223D02; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH 06/13] fuse: export fuse_get_unique()
Date:   Wed, 21 Aug 2019 13:37:35 -0400
Message-Id: <20190821173742.24574-7-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 21 Aug 2019 17:38:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need unique IDs for FORGET requests from outside
fs/fuse/dev.c.  Make the symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/dev.c    | 3 ++-
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 14c8ea3d189c..6215bc7d4255 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -363,11 +363,12 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique(struct fuse_iqueue *fiq)
+u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
 	fiq->reqctr += FUSE_REQ_ID_STEP;
 	return fiq->reqctr;
 }
+EXPORT_SYMBOL_GPL(fuse_get_unique);
 
 static unsigned int fuse_req_hash(u64 unique)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 49f83f00c79c..7da756e2859e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1104,4 +1104,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
 
+/**
+ * Get the next unique ID for a request
+ */
+u64 fuse_get_unique(struct fuse_iqueue *fiq);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.20.1

