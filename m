Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F8E1FADE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfEOTak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfEOT1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56312C0624A1;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C759519C71;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9F35D22547E; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 10/30] fuse: Separate fuse device allocation and installation in fuse_conn
Date:   Wed, 15 May 2019 15:26:55 -0400
Message-Id: <20190515192715.18000-11-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now fuse_dev_alloc() both allocates a fuse device and installs it
in fuse_conn list. fuse_dev_alloc() can fail if fuse_device allocation
fails.

virtio-fs needs to initialize multiple fuse devices (one per virtio
queue). It initializes one fuse device as part of call to
fuse_fill_super_common() and rest of the devices are allocated and
installed after that.

But, we can't affort to fail after calling fuse_fill_super_common() as
we don't have a way to undo all the actions done by fuse_fill_super_common().
So to avoid failures after the call to fuse_fill_super_common(),
pre-allocate all fuse devices early and install them into fuse connection
later.

This patch provides two separate helpers for fuse device allocation and
fuse device installation in fuse_conn.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/cuse.c   |  2 +-
 fs/fuse/dev.c    |  2 +-
 fs/fuse/fuse_i.h |  4 +++-
 fs/fuse/inode.c  | 25 ++++++++++++++++++++-----
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index a6ed7a036b50..a509747153a7 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -506,7 +506,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 */
 	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
 
-	fud = fuse_dev_alloc(&cc->fc);
+	fud = fuse_dev_alloc_install(&cc->fc);
 	if (!fud) {
 		kfree(cc);
 		return -ENOMEM;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ef489beadf58..ee9dd38bc0f0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2318,7 +2318,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	if (new->private_data)
 		return -EINVAL;
 
-	fud = fuse_dev_alloc(fc);
+	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
 		return -ENOMEM;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0b578e07156d..4008ed65a48d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1050,7 +1050,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
  */
 void fuse_conn_put(struct fuse_conn *fc);
 
-struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc(void);
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 126e77854dac..9b0114437a14 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1027,8 +1027,7 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	return 0;
 }
 
-struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc)
-{
+struct fuse_dev *fuse_dev_alloc(void) {
 	struct fuse_dev *fud;
 	struct list_head *pq;
 
@@ -1043,16 +1042,32 @@ struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc)
 	}
 
 	fud->pq.processing = pq;
-	fud->fc = fuse_conn_get(fc);
 	fuse_pqueue_init(&fud->pq);
 
+	return fud;
+}
+EXPORT_SYMBOL_GPL(fuse_dev_alloc);
+
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc) {
+	fud->fc = fuse_conn_get(fc);
 	spin_lock(&fc->lock);
 	list_add_tail(&fud->entry, &fc->devices);
 	spin_unlock(&fc->lock);
+}
+EXPORT_SYMBOL_GPL(fuse_dev_install);
 
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
+{
+	struct fuse_dev *fud;
+
+	fud = fuse_dev_alloc();
+	if (!fud)
+		return NULL;
+
+	fuse_dev_install(fud, fc);
 	return fud;
 }
-EXPORT_SYMBOL_GPL(fuse_dev_alloc);
+EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
 void fuse_dev_free(struct fuse_dev *fud)
 {
@@ -1122,7 +1137,7 @@ int fuse_fill_super_common(struct super_block *sb,
 		       mount_data->fiq_priv);
 	fc->release = fuse_free_conn;
 
-	fud = fuse_dev_alloc(fc);
+	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
 		goto err_put_conn;
 
-- 
2.20.1

