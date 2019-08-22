Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD24B9885A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 02:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfHVAKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 20:10:20 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39550 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfHVAKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:10:20 -0400
Received: by mail-qk1-f201.google.com with SMTP id x1so4035323qkn.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P8ssXLKpWz3dO+L/AUmFrcUKfRbWMuHcZo3K2YQxJJ8=;
        b=qcfbni3/3DneHgntzEVhw3wMy55yRm12nJQQTI2ECUtoNhnlw0p3Xee/s1iFbhsoxZ
         9/wpVNPHTm+csKaXOt/kswfSQuOgK/Fc47SexQwN0d55+25O6gPtRnuj8++/MZ2qWdbS
         RlvDltla5e8Fun1G6q7gUU88KT6Sy3vy0zYlcZDrJ3+36jdGAfhBpnowbwqymQJdrNoL
         CzlvzeTABheJWbZP63ujpk+rKvbNYv1CZ1FQrQCCFhlW+GAn/hV0CcRu3/kBZtr5xnpC
         w+CBMcm6kkQpoeomv59Uro1SdEtkAXnZulDlRViukVGGkOErmcoK+r5I1fVq5D5U9OWZ
         agvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P8ssXLKpWz3dO+L/AUmFrcUKfRbWMuHcZo3K2YQxJJ8=;
        b=KLXgKP/nhxPVh+IW5cyWgFq07JsOsrOfC/Rhh9a3ZroZmGVbKWfnDvARUJhLKU0J+h
         a450LsCyL041epN2vFKwLIR8Gf59ndncHAaDbivmIWzVTQft3uQ9dFOi95aboPDSp1MA
         Gz9+vWnlyGALoEcePaJoTodGkh/NEe0ou17Z4+7TwQnnfG6n8A61kIz4V7MgTJThaQ6+
         jc2IAPrUcO6UtEpR2Jyp8RJ54eP8qVCcuxuYAvpehntuNzaretZdK3QK1XcqAdw5Q1tZ
         iDaFDwv6GFGadY6nvS9sQmaCn+zi2IWggdxjpA5NlQXqNeVy34Rh8Ui9Ia2beti5WZo0
         faGQ==
X-Gm-Message-State: APjAAAXE4HpcIHVKDIhNVi386nvZD2Hnn0qjkdusEejyimEpN/YXt0+C
        zMofmDDGSkt2M/RtvehW0UND2+RyzN4=
X-Google-Smtp-Source: APXvYqzxAqXTttLoLGD8f0LIHLw/pQl585k09x/5RK5w7QEfiHv7Gqk9CkT5QYivkFwC+ptUp0kBjRqZDks=
X-Received: by 2002:a37:680e:: with SMTP id d14mr22449033qkc.207.1566432618660;
 Wed, 21 Aug 2019 17:10:18 -0700 (PDT)
Date:   Wed, 21 Aug 2019 17:09:33 -0700
In-Reply-To: <20190822000933.180870-1-khazhy@google.com>
Message-Id: <20190822000933.180870-3-khazhy@google.com>
Mime-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 3/3] fuse: pass gfp flags to fuse_request_alloc
From:   Khazhismel Kumykov <khazhy@google.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shakeelb@google.com, Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of having a helper per flag

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fuse/dev.c    | 22 +++-------------------
 fs/fuse/file.c   |  6 +++---
 fs/fuse/fuse_i.h |  6 +-----
 fs/fuse/inode.c  |  4 ++--
 4 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a0d166a6596f..c957620ce7ba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -66,7 +66,7 @@ static struct page **fuse_req_pages_alloc(unsigned int npages, gfp_t flags,
 	return pages;
 }
 
-static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
+struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags)
 {
 	struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
 	if (req) {
@@ -90,24 +90,8 @@ static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
 	}
 	return req;
 }
-
-struct fuse_req *fuse_request_alloc(unsigned npages)
-{
-	return __fuse_request_alloc(npages, GFP_KERNEL);
-}
 EXPORT_SYMBOL_GPL(fuse_request_alloc);
 
-struct fuse_req *fuse_request_alloc_account(unsigned int npages)
-{
-	return __fuse_request_alloc(npages, GFP_KERNEL_ACCOUNT);
-}
-EXPORT_SYMBOL_GPL(fuse_request_alloc_account);
-
-struct fuse_req *fuse_request_alloc_nofs(unsigned npages)
-{
-	return __fuse_request_alloc(npages, GFP_NOFS);
-}
-
 static void fuse_req_pages_free(struct fuse_req *req)
 {
 	if (req->pages != req->inline_pages)
@@ -207,7 +191,7 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
 	if (fc->conn_error)
 		goto out;
 
-	req = fuse_request_alloc(npages);
+	req = fuse_request_alloc(npages, GFP_KERNEL);
 	err = -ENOMEM;
 	if (!req) {
 		if (for_background)
@@ -316,7 +300,7 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
 	wait_event(fc->blocked_waitq, fc->initialized);
 	/* Matches smp_wmb() in fuse_set_initialized() */
 	smp_rmb();
-	req = fuse_request_alloc(0);
+	req = fuse_request_alloc(0, GFP_KERNEL);
 	if (!req)
 		req = get_reserved_req(fc, file);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c584ad7478b3..ae8c8016bb8e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -50,7 +50,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 		return NULL;
 
 	ff->fc = fc;
-	ff->reserved_req = fuse_request_alloc_account(0);
+	ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!ff->reserved_req)) {
 		kfree(ff);
 		return NULL;
@@ -1703,7 +1703,7 @@ static int fuse_writepage_locked(struct page *page)
 
 	set_page_writeback(page);
 
-	req = fuse_request_alloc_nofs(1);
+	req = fuse_request_alloc(1, GFP_NOFS);
 	if (!req)
 		goto err;
 
@@ -1923,7 +1923,7 @@ static int fuse_writepages_fill(struct page *page,
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		err = -ENOMEM;
-		req = fuse_request_alloc_nofs(FUSE_REQ_INLINE_PAGES);
+		req = fuse_request_alloc(FUSE_REQ_INLINE_PAGES, GFP_NOFS);
 		if (!req) {
 			__free_page(tmp_page);
 			goto out_unlock;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 08161b2d9b08..8080a51096e9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -902,11 +902,7 @@ void __exit fuse_ctl_cleanup(void);
 /**
  * Allocate a request
  */
-struct fuse_req *fuse_request_alloc(unsigned npages);
-
-struct fuse_req *fuse_request_alloc_account(unsigned int npages);
-
-struct fuse_req *fuse_request_alloc_nofs(unsigned npages);
+struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags);
 
 bool fuse_req_realloc_pages(struct fuse_conn *fc, struct fuse_req *req,
 			    gfp_t flags);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index eab44ddc68b9..ad92e93eaddd 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1178,13 +1178,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	init_req = fuse_request_alloc(0);
+	init_req = fuse_request_alloc(0, GFP_KERNEL);
 	if (!init_req)
 		goto err_put_root;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
 	if (is_bdev) {
-		fc->destroy_req = fuse_request_alloc(0);
+		fc->destroy_req = fuse_request_alloc(0, GFP_KERNEL);
 		if (!fc->destroy_req)
 			goto err_free_init_req;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

