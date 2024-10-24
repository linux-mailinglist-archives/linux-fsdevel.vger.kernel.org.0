Return-Path: <linux-fsdevel+bounces-32798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F39AEDC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03630B271E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30A1FC7C4;
	Thu, 24 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJkbt4ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE341FAC51
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790491; cv=none; b=QFPYIpzj1l+6WUoPs1I8muaQTsl7+YJpzuFHB9qSksFU6n3fA2UVCuRAitbdJok947SkaOAdm0QCF4nccd9OGzu2Op5BR0IPQYzCwZF/mUQr+77oPS1PHOxjsRPbetJgl+Gx6rLWSL/7nuEZxZU5Kdmat1oijXa0AbLi8u7ndl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790491; c=relaxed/simple;
	bh=aCBS0E8uI/g2bfKdlxec+OEaLI9quKfamNOOdj4G1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZTNFXMNhDdMcOcu6lywD9rv0s1cQgFkijDjQr2dRsB7DvO8FTTZHarDLwIhYdsci3E9zh220iKHT363DHjkCSQmUh4vHvow521xNxuz49rmIo8Y6Cv/7uAIROUbelJoFKuQv9bnSPYezpFzsoq+hWBWCvivv459ou2PFhQzt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJkbt4ou; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so1281954276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790488; x=1730395288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgB3T3HXxfx+orA1DK8znN5gB3bUWbsMmvZklQRTvig=;
        b=XJkbt4oudLqt5pMbnHnKzkzsgR0e80DwwMeP9aXONcCLCKXNoO5RH+STvEMA2+DN+2
         5iW6VEztKajgl3gUHWyqqru6IqULg4gNeQB5U19mY0R1OjNM89Qu4FB84+f3kJkw2H/M
         7gIunU4jcmZeu6NU9Th1ebRwylcH0uSMe2DsDvAt8PIXt5+1VU+06dihrOGLYd5O01s4
         avbmOBLalvQ7KxtxIlGUjJYrPiuNUPDPjBs6sBucVeVsWsrPJwNFfWn6XU5jA4fvWKx5
         v0Jettpx2+dBfWitK8nrvYEE0kJKVhXYVwgr+AgvPF/2wmvGG3cJs9ykHU9aR7QKgZcw
         ijPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790488; x=1730395288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgB3T3HXxfx+orA1DK8znN5gB3bUWbsMmvZklQRTvig=;
        b=MMiFRl52jQKKjVAmN0ADsW2hTxQjEuIMiEsvoLRTIbR4vsSnZiKFvIgIs0JcYJutJ+
         LkuxUk9op+bMjjx9OXLnl3oHrlNF93VE0w+bDcz3FSWepi6o2IGe6UjqPTcfRPuVes21
         3Z9cy9Li0CeL3v9OVD2fzI/Extu2stAiByqBg04Rin885wwg/dNk8gdhaiDV7+ZwqV+F
         XMcjRDL91+j1JPwv7Wt8FIjMkfcfBzhV9ADQCfCPdhJXYeaEjfvYdd7jJs08W7Pkn0T4
         /PkY0pY45oQadY9n35j/GjHKntrfmmPKsuxslU3wUF05kQXS6KXbZzXU7nDPo03STHHs
         hNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUoamDJZKlXAZZ0I0yMjYakZLYuN3aD4QMBkET392nVdEPDtg0NChQRCzaHUqM06OvV3Tm3Ln7k/JETwrwH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kW2dWcrBtSukl7haavjh7liJ+nnaDPXWa/77nXt7A1VVMVD+
	Xc9ask4dzTdsUPzBxgghaI5gBw/9DdYrXytr/BAKIku784JpqKwIdhztnA==
X-Google-Smtp-Source: AGHT+IGU1hbb/G4Em2EPTA0d7haR3Xley8TW+mtQ9hJCOlR5aHqKlurrwRQEdw7Mh7jKUbPRnmHK0g==
X-Received: by 2002:a05:6902:150f:b0:e2b:9ae5:5bf7 with SMTP id 3f1490d57ef6-e2e3a634fd9mr8073794276.19.1729790488166;
        Thu, 24 Oct 2024 10:21:28 -0700 (PDT)
Received: from localhost (fwdproxy-nha-010.fbsv.net. [2a03:2880:25ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaebe52sm1933585276.41.2024.10.24.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 02/13] fuse: add support in virtio for requests using folios
Date: Thu, 24 Oct 2024 10:17:58 -0700
Message-ID: <20241024171809.3142801-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until all requests have been converted to use folios instead of pages,
virtio will need to support both types. Once all requests have been
converted, then virtio will support just folios.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/virtio_fs.c | 87 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f68527891929..9f0d98cc20d3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -766,6 +766,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
 	struct page *page;
+	struct folio *folio;
 
 	/*
 	 * TODO verify that server properly follows FUSE protocol
@@ -777,15 +778,29 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	if (args->out_pages && args->page_zeroing) {
 		len = args->out_args[args->out_numargs - 1].size;
 		ap = container_of(args, typeof(*ap), args);
-		for (i = 0; i < ap->num_pages; i++) {
-			thislen = ap->descs[i].length;
-			if (len < thislen) {
-				WARN_ON(ap->descs[i].offset);
-				page = ap->pages[i];
-				zero_user_segment(page, len, thislen);
-				len = 0;
-			} else {
-				len -= thislen;
+		if (ap->uses_folios) {
+			for (i = 0; i < ap->num_folios; i++) {
+				thislen = ap->folio_descs[i].length;
+				if (len < thislen) {
+					WARN_ON(ap->folio_descs[i].offset);
+					folio = ap->folios[i];
+					folio_zero_segment(folio, len, thislen);
+					len = 0;
+				} else {
+					len -= thislen;
+				}
+			}
+		} else {
+			for (i = 0; i < ap->num_pages; i++) {
+				thislen = ap->descs[i].length;
+				if (len < thislen) {
+					WARN_ON(ap->descs[i].offset);
+					page = ap->pages[i];
+					zero_user_segment(page, len, thislen);
+					len = 0;
+				} else {
+					len -= thislen;
+				}
 			}
 		}
 	}
@@ -1272,16 +1287,22 @@ static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *r
 }
 
 /* Count number of scatter-gather elements required */
-static unsigned int sg_count_fuse_pages(struct fuse_page_desc *page_descs,
-				       unsigned int num_pages,
-				       unsigned int total_len)
+static unsigned int sg_count_fuse_pages(struct fuse_args_pages *ap,
+					unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	for (i = 0; i < num_pages && total_len; i++) {
-		this_len =  min(page_descs[i].length, total_len);
-		total_len -= this_len;
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && total_len; i++) {
+			this_len =  min(ap->folio_descs[i].length, total_len);
+			total_len -= this_len;
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && total_len; i++) {
+			this_len =  min(ap->descs[i].length, total_len);
+			total_len -= this_len;
+		}
 	}
 
 	return i;
@@ -1299,8 +1320,7 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
-						 size);
+		total_sgs += sg_count_fuse_pages(ap, size);
 	}
 
 	if (!test_bit(FR_ISREPLY, &req->flags))
@@ -1313,28 +1333,35 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->out_pages) {
 		size = args->out_args[args->out_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
-						 size);
+		total_sgs += sg_count_fuse_pages(ap, size);
 	}
 
 	return total_sgs;
 }
 
-/* Add pages to scatter-gather list and return number of elements used */
+/* Add pages/folios to scatter-gather list and return number of elements used */
 static unsigned int sg_init_fuse_pages(struct scatterlist *sg,
-				       struct page **pages,
-				       struct fuse_page_desc *page_descs,
-				       unsigned int num_pages,
+				       struct fuse_args_pages *ap,
 				       unsigned int total_len)
 {
 	unsigned int i;
 	unsigned int this_len;
 
-	for (i = 0; i < num_pages && total_len; i++) {
-		sg_init_table(&sg[i], 1);
-		this_len =  min(page_descs[i].length, total_len);
-		sg_set_page(&sg[i], pages[i], this_len, page_descs[i].offset);
-		total_len -= this_len;
+	if (ap->uses_folios) {
+		for (i = 0; i < ap->num_folios && total_len; i++) {
+			sg_init_table(&sg[i], 1);
+			this_len =  min(ap->folio_descs[i].length, total_len);
+			sg_set_folio(&sg[i], ap->folios[i], this_len,
+				     ap->folio_descs[i].offset);
+			total_len -= this_len;
+		}
+	} else {
+		for (i = 0; i < ap->num_pages && total_len; i++) {
+			sg_init_table(&sg[i], 1);
+			this_len =  min(ap->descs[i].length, total_len);
+			sg_set_page(&sg[i], ap->pages[i], this_len, ap->descs[i].offset);
+			total_len -= this_len;
+		}
 	}
 
 	return i;
@@ -1358,9 +1385,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 		sg_init_one(&sg[total_sgs++], argbuf, len);
 
 	if (argpages)
-		total_sgs += sg_init_fuse_pages(&sg[total_sgs],
-						ap->pages, ap->descs,
-						ap->num_pages,
+		total_sgs += sg_init_fuse_pages(&sg[total_sgs], ap,
 						args[numargs - 1].size);
 
 	if (len_used)
-- 
2.43.5


