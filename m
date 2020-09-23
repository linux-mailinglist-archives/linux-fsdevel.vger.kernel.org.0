Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B22275751
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIWLov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgIWLou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE843C0613D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so14848169pfg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=bMOj5TthhClhPZZn3/SIzkBPxHYOZH75lTH2CcXUdw8UR/J+FzMyQ/KBz7hKRaA18E
         ZlSjrcfBhq5erVyx0j6CD66VdAJrqX0HfmM/0D3rabD6dkiKizTu6ztq1OKYtWN+y/75
         hQj5pqVDvtbI5d65Og1ytt+GcllEe4wiB2FwEeV7M4suASAr+87Mnpsg8jCUvIhHLba/
         2rB2qF1Ho22sboU++zkzxz4bDO7QX1CKYUDkQ7WSU+5By9kHHdnQOGTW9zbUZWHsyNT1
         2xPMaiq9HaTEvNN1xERZNOYTOplzVwhhoOw9R1DTo/979p3PKQjEeRPE5rznAiGDmRLW
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=Xk9oa4/uuiNSvxWTVxinfyn77XAd8e5t6llwG7VlEdQu5s9xVE5AuU+ZEcm4xDZ2vr
         +ku6vdkIWLEvChjqaVYnrjzfuQgH9wrIdAae3wsUNEWlKKygqdoH+9IV0oLFgLzVKm0u
         62tMM+NXtP1dUuZNlAx7dSP4I01v0HehQZ2hK7PP+rWekwZ8ZTaq2uhccjOM5K3ejuyI
         fvy9TyJvdix+8T3ok8ELZdataOPFZ00AUrIFOS6wRh2z3R1J5n1+1hEjibR4c3RZsi3H
         yONEn4YlWC6yoGC9Lj+0CGSqUt+POOmLNZBnCX1K3O+EvILJPAKe78PqxIFXq2Az25zX
         DivA==
X-Gm-Message-State: AOAM5335EQyzmQazpDFoFk5Wa4oL/9PAGtbV6nNT2dMiMqvaf+125niy
        NH6+LU7GMJHIWDB9LYNtSdf5yQ==
X-Google-Smtp-Source: ABdhPJwPQPmp9mJ3CwnGnJmncLyVBkzdNV9o4SqscJ/GohWXP7zYQ0odT2RerJw29I0rw87VsNdsHw==
X-Received: by 2002:a63:4d02:: with SMTP id a2mr7108482pgb.38.1600861489363;
        Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/5] io_uring: Fix missing smp_mb() in io_cancel_async_work()
Date:   Wed, 23 Sep 2020 19:44:16 +0800
Message-Id: <20200923114419.71218-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The store to req->flags and load req->work_task should not be
reordering in io_cancel_async_work(). We should make sure that
either we store REQ_F_CANCE flag to req->flags or we see the
req->work_task setted in io_sq_wq_submit_work().

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a1350c7c50055..c80c37ef38513 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2252,6 +2252,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		if (!ret) {
 			req->work_task = current;
+
+			/*
+			 * Pairs with the smp_store_mb() (B) in
+			 * io_cancel_async_work().
+			 */
+			smp_mb(); /* A */
 			if (req->flags & REQ_F_CANCEL) {
 				ret = -ECANCELED;
 				goto end_req;
@@ -3728,7 +3734,15 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 
 		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
 		list_del_init(&req->task_list);
-		req->flags |= REQ_F_CANCEL;
+
+		/*
+		 * The below executes an smp_mb(), which matches with the
+		 * smp_mb() (A) in io_sq_wq_submit_work() such that either
+		 * we store REQ_F_CANCEL flag to req->flags or we see the
+		 * req->work_task setted in io_sq_wq_submit_work().
+		 */
+		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
+
 		if (req->work_task && (!files || req->files == files))
 			send_sig(SIGINT, req->work_task, 1);
 	}
-- 
2.11.0

