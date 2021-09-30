Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEB41DC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbhI3OlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349279AbhI3OlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgAYzhk++zDg+2draM1yDlVHhr5FM6w/twV29vqzoks=;
        b=ED7dkOGbOqde5fkWj5ZGj+5Ju4SjXwnA2PBPmPz8rdztGAbWORxyQLFra1cTpXCXUwJuK8
        wQ+lCJfrALu6nr4Zas8I8SWfkYxlZt7D4YLCr1LIuz/jrRl4oogtHR3c5jBTX8PgH3TrX/
        vbqAzsnnubhDDKm8WhvIAqysOJHe/Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-PZjaIFS5PO6-FEdphC70SQ-1; Thu, 30 Sep 2021 10:39:28 -0400
X-MC-Unique: PZjaIFS5PO6-FEdphC70SQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9D6192376D;
        Thu, 30 Sep 2021 14:39:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38675100760B;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BCF12228280; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 1/8] virtiofs: Disable interrupt requests properly
Date:   Thu, 30 Sep 2021 10:38:43 -0400
Message-Id: <20210930143850.1188628-2-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs does not support dealing with fuse INTERRUPT requests at all.
But still we set can clear FR_SENT bit which is needed only if INTERRUPT
requests are being handled.

Also, given current code it is possible that virtiofs server is handling
a request and in guest a signal comes, it will wake up process and
queue existing request to fiq->interrupts and never remove it.

request_wait_answer()
{
	if (!fc->no_interupt) {
                if (test_bit(FR_SENT, &req->flags))
                        queue_interrupt(req);
	}
}

Given virtiofs does not support interrupt requests at this point of
time, disable it (Set fc->no_interrupt = 1). This should make sure
requests can't be queued on fiq->interrupts.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0ad89c6629d7..b9256b8f277f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -545,7 +545,6 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 static void virtio_fs_request_complete(struct fuse_req *req,
 				       struct virtio_fs_vq *fsvq)
 {
-	struct fuse_pqueue *fpq = &fsvq->fud->pq;
 	struct fuse_args *args;
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
@@ -574,10 +573,6 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	spin_lock(&fpq->lock);
-	clear_bit(FR_SENT, &req->flags);
-	spin_unlock(&fpq->lock);
-
 	fuse_request_end(req);
 	spin_lock(&fsvq->lock);
 	dec_in_flight_req(fsvq);
@@ -1196,9 +1191,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	spin_lock(&fpq->lock);
 	list_add_tail(&req->list, fpq->processing);
 	spin_unlock(&fpq->lock);
-	set_bit(FR_SENT, &req->flags);
-	/* matches barrier in request_wait_answer() */
-	smp_mb__after_atomic();
 
 	if (!in_flight)
 		inc_in_flight_req(fsvq);
@@ -1448,6 +1440,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
 	fc->sync_fs = true;
+	fc->no_interrupt = true;
 
 	/* Tell FUSE to split requests that exceed the virtqueue's size */
 	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
-- 
2.31.1

