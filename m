Return-Path: <linux-fsdevel+bounces-26567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C695A821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CFB21AAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A17176FAC;
	Wed, 21 Aug 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHTs+8hS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B65170A1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282715; cv=none; b=b1aKb5MMxJTehitiU5b3ibjthyiPCGwf0F9djVo4s9BDfT4/YWnObuECMSP+jFCGvPddPa67iBOkJ8duy+0Ko4JBBMRyne7CGjLiwPahj6GpyPD3LtICu5GR0NgwbCoKTWWkWMmy8vEvX3ZHapyc6Vl7aRq9eH7PICqoWTANakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282715; c=relaxed/simple;
	bh=UWKsRqn8KEexlFybvj1D8QiH7e2TeVsMe7AUmeAODaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMkFChjVWQ+HOWv4gfW4KA4ErS4Sy0gJj+yAikE1SDIPcIRJ9S563YUO2H8rxprrGSGyx/kCibrGqfM5HuWDr64RuwXLwRWs11Lxe7WLs4efqQ/YDEfltFBqY8e5Q0htgHR72zn+WKXOgj7oduGaDxweIK+lIgvkwbpixDcdfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHTs+8hS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b99988b6ceso3328377b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282713; x=1724887513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=YHTs+8hSlRhfhNmRfm8tt5OPhCZWypQKDsHqeZT3dtjSi67TtMY0Ra0AnX+52SGbLU
         dZACARvGzeDmNiKfbFjeh9vvqaag9HrTPQeWJfYXr8HXj+IVaAmu7m09F4aFqIUu3Aiq
         TdOZWfnv/2QG7wlEpVo3jWXxjl+FI23BG+yCFM8CEfzHgaYKDnYwWwqOK9qqELwOBeLd
         phO9gHMpod9WmnSAArDM+Lnf9vja3sG+6eWfVvoYLp+q5j+RQeBlHC0guK9Prn8Dy+0R
         v5WLFM+P1YhT7ceVKtq1a64Eub/kNprkNFBsP5B0mj91P0zRGdDoQUMV42Z0aKRHaMS4
         62EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282713; x=1724887513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOZ2xVfOWbanp17fZvu+t8asvkce+rrQYJ7+TXN5jw8=;
        b=I+QB7fAU8YV/AW+esrxecwis9Q6l0P3979vgYL887rLlRdvS2usbtH77tyToT77/sq
         q/J1cFjn3mNtKOA+PrGxQkCQVPkeSLOI4KqF67gEUR8njVYbv0nzGGUNaa9JIual6DFz
         BrDY4CBv0hJEuFaBopW+juw+tzU/plB6azqZ+RKwm3nnQr9QhCNM7qXZuVqgmoS2wL1Y
         X4ht3v0EHs99QaeNFuiRrFym8ycLAJ1CMC15aUudYiD9feDMQa0ZT3gjSnRIp1VBH8cL
         g825fpmfstkwGZAGPsEX+2aF1nJDf059eETILSUMtzGaBwVh31ipbnmcqg0uUDfjKJOo
         TikQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWq2yao5je4AYgBjqRaVovXKke0vj5/TyifKSBQ/f5dabFNbhnhpgpNCI00p6ze/vKaqn/PjCHLddgXmjP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yEcsPoq/h0mPe1OMWae5rLCtgTlMESfJOxkHYELSVOOtxFVr
	VNd3Cen8DBbZCv7hQiTbbDR0Tr9yeQ3y98+TbD0pLQRxzszdxyT2
X-Google-Smtp-Source: AGHT+IHbAVsleOn+fOSVF50yjVBAd27OnAHiT26U0ZWK1/+h5Oq6DSWTNjsR1z4H+0SLLlq8oxJ6Qg==
X-Received: by 2002:a05:690c:d93:b0:64b:2665:f92c with SMTP id 00721157ae682-6c0f937b4ebmr46798587b3.8.1724282712671;
        Wed, 21 Aug 2024 16:25:12 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b00746csm383427b3.67.2024.08.21.16.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 2/9] fuse: refactor finished writeback stats updates into helper function
Date: Wed, 21 Aug 2024 16:22:34 -0700
Message-ID: <20240821232241.3573997-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the logic for updating the bdi and page stats for a finished
writeback into a separate helper function, where it can be called from
both fuse_writepage_finish() and fuse_writepage_add() (in the case
where there is already an auxiliary write request for the page).

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Suggested by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 63fd5fc6872e..320fa26b23e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,19 +1769,25 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
+static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+
+	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	wb_writeout_inc(&bdi->wb);
+}
+
 static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_pages; i++) {
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(ap->pages[i], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
-	}
+	for (i = 0; i < ap->num_pages; i++)
+		fuse_writepage_finish_stat(inode, ap->pages[i]);
+
 	wake_up(&fi->page_waitq);
 }
 
@@ -2203,11 +2209,7 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		struct backing_dev_info *bdi = inode_to_bdi(new_wpa->inode);
-
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		dec_node_page_state(new_ap->pages[0], NR_WRITEBACK_TEMP);
-		wb_writeout_inc(&bdi->wb);
+		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.5


