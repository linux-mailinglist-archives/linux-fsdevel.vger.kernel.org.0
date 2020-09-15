Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197B26A0A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgIOIWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgIOIQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469CC061354
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:16:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so1588051pgd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1giRpRS9X9iGbfoHdaClkksgvnLrTHVH3ZE6EYYf5w=;
        b=NWwEr8pMqoyzgcPCYblukhwGncL3ErPzfQ8LvMA76dimaQ8KPJhV1PTLtZsnyCzjpn
         1QFQfdg/vJbTwQ0QkI01v2u1YmsmK/JkKDAJ5uoeaU244APf6n24YLFhBU+oTIb+cjQW
         E2m1oIXn4tpECXasKAfnuDei89DUXIvoLyYoNYamEH6eeAAHi7EVVU8kyMM/4tdURQrX
         G9/g1qJHIs3SvtE06yIDAwhHbA9S7son6GzN+dhfe+7SLSqCnG329/UI/IdYB2SIhVJo
         IT5LgF2N6UDPabK3DbGyp4j4GIgczouBRCQ5Ir53NHC6HwiFbrQnwoEld9yF+yPGAcDM
         HNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1giRpRS9X9iGbfoHdaClkksgvnLrTHVH3ZE6EYYf5w=;
        b=ZtHBRr5mMGtxyFWA+IiJy3R1+nx3P3NqtcbohgBOfLast9sfcYI/5H6okBr7x46Wob
         eo6YO5oK4hw7x2kfG/9deKN+mjzfW9w+zNerk+6XZutJ68+HLhafTTASAAgil4l9YmX/
         oP797n9Jx1Y7HXgdVX/dRDI3hFylvVIfiepwIHZamogy7jZ09hWUukwwjUafwrsfB+Gx
         PU7GEQgxGXlWfdM0fseguV0aMJDmKlhG27PQzGn9cuWjNM64Daf03qhpx6tFTNv7d7I0
         7MG459zw0E59ayCDtxSm7LDuMT74J3TSbszidGWFqw256n8ICDX9T9jpjDavYe3frlIf
         AKkg==
X-Gm-Message-State: AOAM533y9zsRmiib1kbJtUqiPR/9T4WXPUi5M3Y95PiNbDcN8CuX9xqq
        fktg31I6BgneWTn8mQOj0jCyHQ==
X-Google-Smtp-Source: ABdhPJzG7AfzJNGmWgFgqKx8HHaMlyg8/ehNJvdar6KvrLtmayHh9UsdjQU2dFZEQSj8EMbjp4D9TQ==
X-Received: by 2002:a63:7f59:: with SMTP id p25mr13678448pgn.146.1600157781390;
        Tue, 15 Sep 2020 01:16:21 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id x19sm10539429pge.22.2020.09.15.01.16.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:16:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/3] io_uring: Fix missing smp_mb() in io_cancel_async_work()
Date:   Tue, 15 Sep 2020 16:15:50 +0800
Message-Id: <20200915081551.12140-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915081551.12140-1-songmuchun@bytedance.com>
References: <20200915081551.12140-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index de4f7b3a0d789..adaafe857b074 100644
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
@@ -3719,7 +3725,15 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 
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

