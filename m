Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB0AAC43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfIETt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbfIETt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECCAB8831E;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C70AA100194E;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1BBEC2253A6; Thu,  5 Sep 2019 15:49:18 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 14/18] virtiofs: Add a fuse_iqueue operation to put() reference
Date:   Thu,  5 Sep 2019 15:48:55 -0400
Message-Id: <20190905194859.16219-15-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 05 Sep 2019 19:49:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Soon I will make virtio_fs object reference counted, where reference will
be taken by device as well as by fuse_conn (fuse_conn->fuse_iqueue->fiq_priv).

When fuse_connection is going away, it should put its reference on virtio_fs
object.

So add a fuse_iqueue method which can be used to call into virtio_fs to
put the reference on the object (fiq_priv).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/fuse_i.h | 5 +++++
 fs/fuse/inode.c  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 85e2dcad68c1..04e2c000d63f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -479,6 +479,11 @@ struct fuse_iqueue_ops {
 	 */
 	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
 		__releases(fiq->waitq.lock);
+
+	/**
+	 * Put a reference on fiq_priv.
+	 */
+	void (*put)(struct fuse_iqueue *fiq);
 };
 
 /** /dev/fuse input queue operations */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7fa0dcc6f565..70a433bdf01f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -631,8 +631,14 @@ EXPORT_SYMBOL_GPL(fuse_conn_init);
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (refcount_dec_and_test(&fc->count)) {
+		struct fuse_iqueue *fiq = &fc->iq;
+
 		if (fc->destroy_req)
 			fuse_request_free(fc->destroy_req);
+		if (fiq->priv && fiq->ops->put) {
+			fiq->ops->put(fiq);
+			fiq->priv = NULL;
+		}
 		put_pid_ns(fc->pid_ns);
 		put_user_ns(fc->user_ns);
 		fc->release(fc);
-- 
2.20.1

