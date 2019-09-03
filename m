Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556D8A679E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfICLkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:40:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfICLku (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:40:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAAF085543
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:40:49 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f10so6875007wmh.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utliAxXHlzv/OkA2fKwkZhMhH80mu0eBxhklhX2mOKE=;
        b=qX/YHKPXWJsuQpN8XMviUbFG7D07zWYyw26b2AucuXxSYtTlMVvUMV25nY98QPtz/S
         HnVzAftVna5ZzswDXMKgHtToWDhpUmCAzjizpHIaYOF9GZjRXd+cR1mhgnt9vycxhFfW
         uFrybOOsaWPYikxUxyRIRGv6HZSEtUCgk11gYltzjuHS6OfHmba9bYBOo+mZGk3dCAxv
         EXWfcQMqHKFtHCsdyPgkecZYlAcCR9sypM3VXaPzmYlJxhgbYz4Rbz5f+2/GYZ5RD74U
         SVL4xVa0XgtgXqsbDGwHJks0iz4hk1qzmaEnFfWf5NhUOgidptvkRwgQUM7MoQyrFVFj
         LT0w==
X-Gm-Message-State: APjAAAXreMU0zwGrIe82bl6KRNUveEQ8OvRY48gXyqMNnChs3zO3E3qv
        BBTkKGDKlzwSrtgFEET9arMxQ3esB7tpamAQmi3IY/J6h2E0Bq9l1/3QUYv6XvGPx6guE5iIdVO
        R4UGPGIyila2yFXJQ1brF7dKIQA==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr43374377wmf.176.1567510847262;
        Tue, 03 Sep 2019 04:40:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMCBM14tG/0MBT/Fvv9aOKldtm4+v9uJCHaNYSDrxbguWdlacEKZgsi+EmXgjnGTm4vUpItQ==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr43374359wmf.176.1567510847039;
        Tue, 03 Sep 2019 04:40:47 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id b3sm9823058wrw.4.2019.09.03.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:40:46 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 05/16] fuse: export fuse_len_args()
Date:   Tue,  3 Sep 2019 13:40:33 +0200
Message-Id: <20190903114044.8201-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need to query the length of fuse_arg lists.  Make the symbol
visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 7 ++++---
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 137b3de511ac..985654560d1a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -350,7 +350,7 @@ void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_put_request);
 
-static unsigned len_args(unsigned numargs, struct fuse_arg *args)
+unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
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
@@ -1912,7 +1913,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 	if (out->h.error)
 		return nbytes != reqsize ? -EINVAL : 0;
 
-	reqsize += len_args(out->numargs, out->args);
+	reqsize += fuse_len_args(out->numargs, out->args);
 
 	if (reqsize < nbytes || (reqsize > nbytes && !out->argvar))
 		return -EINVAL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 67521103d3b2..81e436c9620a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1098,4 +1098,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
+/**
+ * Return the number of bytes in an arguments list
+ */
+unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.21.0

