Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107621FAA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfEOT2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfEOT1f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7771931760ED;
        Wed, 15 May 2019 19:27:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98F13608AB;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 823A022547B; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 07/30] fuse: export fuse_get_unique()
Date:   Wed, 15 May 2019 15:26:52 -0400
Message-Id: <20190515192715.18000-8-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 15 May 2019 19:27:35 +0000 (UTC)
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
index 40eb827caa10..42fd3b576686 100644
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
index 16f238d7f624..38a572ba650d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1097,4 +1097,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
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

