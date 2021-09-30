Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2B41DC7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbhI3OlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350747AbhI3OlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvqSbl75duLv3ADG85bHjzf/xYZ44FjWfaebFV5SmIg=;
        b=F9bm8lsO1EreMLD37oMNYTjDRZSLbWMN2tlEDKIbDo2aUIjOJZxN/6p9WgkbclPLKbHFbR
        QZpOPHFCGUkBqD3LHKV318/4NDTf+DpxBfmGwQkoXMMvSctBL8jeTP5mqcacFKdVUhDKgX
        FkObjfvR2Ah8Ds+9IoVHV5jLI2o0fzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-TVxHZ3i4MHujIPRaIurg2w-1; Thu, 30 Sep 2021 10:39:28 -0400
X-MC-Unique: TVxHZ3i4MHujIPRaIurg2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88169824FB0;
        Thu, 30 Sep 2021 14:39:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCED9100AE2C;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D6354228285; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 6/8] virtiofs: Add a helper to end request and decrement inflight number
Date:   Thu, 30 Sep 2021 10:38:48 -0400
Message-Id: <20210930143850.1188628-7-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper function to end fuse request and decrement number of
inflight requests. This pattern is already used at two places and
I am planning to use it two more times in later patches. Adding
a helper reduces number of lines of code and improves readability.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b70a22a79901..8d33879d62fb 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -380,6 +380,15 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	spin_unlock(&fsvq->lock);
 }
 
+static void end_req_dec_in_flight(struct fuse_req *req,
+				  struct virtio_fs_vq *fsvq)
+{
+	fuse_request_end(req);
+	spin_lock(&fsvq->lock);
+	dec_in_flight_req(fsvq);
+	spin_unlock(&fsvq->lock);
+}
+
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
 	struct fuse_req *req;
@@ -425,12 +434,9 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 				return;
 			}
 			req->out.h.error = ret;
-			spin_lock(&fsvq->lock);
-			dec_in_flight_req(fsvq);
-			spin_unlock(&fsvq->lock);
 			pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n",
 			       ret);
-			fuse_request_end(req);
+			end_req_dec_in_flight(req, fsvq);
 		}
 	}
 }
@@ -709,10 +715,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 		}
 	}
 
-	fuse_request_end(req);
-	spin_lock(&fsvq->lock);
-	dec_in_flight_req(fsvq);
-	spin_unlock(&fsvq->lock);
+	end_req_dec_in_flight(req, fsvq);
 }
 
 static void virtio_fs_complete_req_work(struct work_struct *work)
-- 
2.31.1

