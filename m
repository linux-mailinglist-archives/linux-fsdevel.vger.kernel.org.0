Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B766A67B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfICLmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfICLmK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:10 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC2614E93D
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b15so10272830wrp.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq6DklOvXBQpcnChGI+5PjZr8M6YoeohLU7OSViViJw=;
        b=KtfIZicdGBuu5nRwGtha9IqR4I+mhbubqV+jaV+zKMLJEMLFc6AM4qhHywaygMctE7
         Yai927SJPl94Ckfc6Bd0gwiDkZX1oGLE/AXI0pvvpfV0Lwx5dtRxXYsL217EDg+R/oZs
         p/QRqWIu+yT03/yvERk/tgFYnemT7SEfSJPP2yjfQjhuiiU/QOcdfhrgmLoZ4+veQzoq
         1QHRlUyubtPOpnKjk4b2tj506+M4TOfOyb7M6tLfEZayWSYQrGJdeJ74jkrl10BT/xfC
         JNkQmOxSqyhLuIUGW1WCBNz+kZsYfHyswAN83MfynJiWeGShagn6bdLv1h8rlxOvA9v2
         puSg==
X-Gm-Message-State: APjAAAWWy+/9GFt4i1H/Pb/hY1hNVEqnp052LQSZ/y8Od6zX2ftH9ygS
        8KmhrPUGp2Ogxy8yGf5Nzbdzt5BnadGAt1b1cKUdrDiITRrvmXxhE/Vy9M4r0wJSKqmNI6FMips
        1oFRwibZZECPJLOqX2Fj/OmHN2A==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr15475620wmi.72.1567510928464;
        Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAd+VVNnldowkP9l4jOCMO8pjBOGYGrhwFwSOLXZizZO/tlwztV+AmVXjYo65zGv8LUNFz4Q==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr15475591wmi.72.1567510928273;
        Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:07 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 08/16] fuse: export fuse_dequeue_forget() function
Date:   Tue,  3 Sep 2019 13:41:55 +0200
Message-Id: <20190903114203.8278-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

File systems like virtio-fs need to do not have to play directly with
forget list data structures. There is a helper function use that instead.

Rename dequeue_forget() to fuse_dequeue_forget() and export it so that
stacked filesystems can use it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 13 +++++++------
 fs/fuse/fuse_i.h |  4 ++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 167f476fbe16..c0c30a225e78 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1185,9 +1185,9 @@ __releases(fiq->waitq.lock)
 	return err ? err : reqsize;
 }
 
-static struct fuse_forget_link *dequeue_forget(struct fuse_iqueue *fiq,
-					       unsigned max,
-					       unsigned *countp)
+struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
+					     unsigned int max,
+					     unsigned int *countp)
 {
 	struct fuse_forget_link *head = fiq->forget_list_head.next;
 	struct fuse_forget_link **newhead = &head;
@@ -1206,6 +1206,7 @@ static struct fuse_forget_link *dequeue_forget(struct fuse_iqueue *fiq,
 
 	return head;
 }
+EXPORT_SYMBOL(fuse_dequeue_forget);
 
 static int fuse_read_single_forget(struct fuse_iqueue *fiq,
 				   struct fuse_copy_state *cs,
@@ -1213,7 +1214,7 @@ static int fuse_read_single_forget(struct fuse_iqueue *fiq,
 __releases(fiq->waitq.lock)
 {
 	int err;
-	struct fuse_forget_link *forget = dequeue_forget(fiq, 1, NULL);
+	struct fuse_forget_link *forget = fuse_dequeue_forget(fiq, 1, NULL);
 	struct fuse_forget_in arg = {
 		.nlookup = forget->forget_one.nlookup,
 	};
@@ -1261,7 +1262,7 @@ __releases(fiq->waitq.lock)
 	}
 
 	max_forgets = (nbytes - ih.len) / sizeof(struct fuse_forget_one);
-	head = dequeue_forget(fiq, max_forgets, &count);
+	head = fuse_dequeue_forget(fiq, max_forgets, &count);
 	spin_unlock(&fiq->waitq.lock);
 
 	arg.count = count;
@@ -2249,7 +2250,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 			clear_bit(FR_PENDING, &req->flags);
 		list_splice_tail_init(&fiq->pending, &to_end);
 		while (forget_pending(fiq))
-			kfree(dequeue_forget(fiq, 1, NULL));
+			kfree(fuse_dequeue_forget(fiq, 1, NULL));
 		wake_up_all_locked(&fiq->waitq);
 		spin_unlock(&fiq->waitq.lock);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e19c936ece8..6533be37873f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -820,6 +820,10 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
+struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
+					     unsigned int max,
+					     unsigned int *countp);
+
 /* Used by READDIRPLUS */
 void fuse_force_forget(struct file *file, u64 nodeid);
 
-- 
2.21.0

