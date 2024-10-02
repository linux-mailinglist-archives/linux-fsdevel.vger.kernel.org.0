Return-Path: <linux-fsdevel+bounces-30740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4898E136
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168DC28498D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E41D131B;
	Wed,  2 Oct 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia9V4N9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1B1D1301
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888119; cv=none; b=fFNMrJWZpL4Fgo/Psf5yqwU/4uiD4I78pKAkrmvwH1RVSSmOOfdxV4JWELhWk70CHFOz0TGqOx91szqVe2gw3jFh5JgMtpqzA2GMi4Qj2m/6LpI2n35y7A9ndLpOnTZPmMP3AHTX8xsvyeJ2wxQgnNWf7A4TIYq1fCuK90GDxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888119; c=relaxed/simple;
	bh=l9SQoCnqugBgtH/PEt+VJ1NiVP7UHeztDZw3D/QVpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUxK58Vm5BJRoMQU3a84M2YWW+1dqFDBfOlfvCxK4QJKlrd8P1JoqkTgrb8nvsNDtjq0TlPtsogpas0AW2T1oHxY0u8IFksRG6uZcb+U5GuQOjYjFmKNVijRSh4aLjm1/5t2zXLxy66OU2KGZtPSEpIDOK5y+K7iLydYoaYUWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia9V4N9o; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d9f65f9e3eso3617b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888116; x=1728492916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4avwJEXSEhYWk8UCdqe98s7a8vD3BhZ3iPofebhRy8=;
        b=Ia9V4N9oBRkRTf90sgdqjqYGRxiXAx2bpm2O5tmO+MQ6YG+UTAcQKFuzCNeZTx4u0g
         2MUG5hhg7pwRnpJAfnYQHohNy1trK/c+/0lVnLZytl829PeHRlr/p7A76JVq2S0VnCvW
         r8rw6tChvzLZy5KczQJyJiIwdyfvl0QXbyjYE/AL4+VFAPogM9XO4RS+Uo34QWGpaLB3
         7XpICatnSudj4QMdwJw4vn0xMF6+JUncNYR0V8qwrdEy4RJrvy4PxK2TH37mCeBvG2WM
         bhXY46rL0SFiBrUeh7TuzhJxpSQDbde7YHUMwMfqeEvbf8es8BNQ8Q1iVjcNYAFf+Ked
         GFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888116; x=1728492916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4avwJEXSEhYWk8UCdqe98s7a8vD3BhZ3iPofebhRy8=;
        b=EBZ07PaI+uE+Ef1XaijrrtKPpcmsMhDDaYPWDO1wkPKzVewrokFP3M2r3GUsp57c0E
         Ijzo574nO+HX2rfIRty8PYJ4wtTbTAWu2/i7rcAE4UNv/zqjZpILyQZf5cimyayvk7Kn
         +1oGPWBlv0xy4h7Pzwxd4knmCrnYFzVdgnCxb8ixG7AFtlTy2Fij/KFj/8lLrNr+nvbe
         yAWNeDV4ZV4VKDt2UPiLs5nKQqbkcy7hKzd+hHQfEqWQNFKdzEQzAbAhbIIujhlRmxr9
         jWV6Le9oqPR3/se/ayw/hKU4Gqb5CCOrfJiDoS8ARXdoR4Iy7zZd4aDz+oh6ZMVbwxBk
         ZO3A==
X-Forwarded-Encrypted: i=1; AJvYcCWdSXuRhtzCHZJgPjW6vthjCo0IChE7rw/0WjxnBOOi+3lGSsIN8fk/gbsFeG4oCusk4pdvsXrWXBYkJMUc@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9LJX3ftxHIBNjz5fqHaO9VLTwLXWBvbL7SB+NB2jP4yfCr1e
	XYLm6WPzO7GeO4LbNl1JmJ0YFIeTx7aMsQl8MnrVXDQiLrO7VRzQ
X-Google-Smtp-Source: AGHT+IGcbtA7gjI1SrFPUARFfIG7ikRljNnNHbdWXIfc0Icutx/srZ7+q1Dw2e1aRdja4AkDri4c3A==
X-Received: by 2002:a05:690c:5c06:b0:6db:e280:a3ae with SMTP id 00721157ae682-6e2a2e3f65amr34326927b3.23.1727888116326;
        Wed, 02 Oct 2024 09:55:16 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536d075sm25691387b3.82.2024.10.02.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 02/13] fuse: add support in virtio for requests using folios
Date: Wed,  2 Oct 2024 09:52:42 -0700
Message-ID: <20241002165253.3872513-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
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
---
 fs/fuse/virtio_fs.c | 87 +++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6404a189e989..5e7262c93590 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -761,6 +761,7 @@ static void virtio_fs_request_complete(struct fuse_req *req,
 	struct fuse_args_pages *ap;
 	unsigned int len, i, thislen;
 	struct page *page;
+	struct folio *folio;
 
 	/*
 	 * TODO verify that server properly follows FUSE protocol
@@ -772,15 +773,29 @@ static void virtio_fs_request_complete(struct fuse_req *req,
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
@@ -1267,16 +1282,22 @@ static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct fuse_req *r
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
@@ -1294,8 +1315,7 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
 	if (args->in_pages) {
 		size = args->in_args[args->in_numargs - 1].size;
-		total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
-						 size);
+		total_sgs += sg_count_fuse_pages(ap, size);
 	}
 
 	if (!test_bit(FR_ISREPLY, &req->flags))
@@ -1308,28 +1328,35 @@ static unsigned int sg_count_fuse_req(struct fuse_req *req)
 
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
@@ -1353,9 +1380,7 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
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


