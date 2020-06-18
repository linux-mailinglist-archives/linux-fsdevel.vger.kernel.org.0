Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1781FF54A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgFROq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbgFROoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67047C0613EF
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so2641774pju.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=AMBC//GM9TUmKqc/Ee7MUTX4MVxXaivvBIm8XTKWtjI=;
        b=XjGUImD9rS9VeH3ATYR5UN46KsG/kGd5i8ObOVULAJ3bWbAHLUKz+Nt/bzRQeCC7k+
         q4pmWPc7rGRsnlJnmLarBBAj7QbxKCn+OtJBti2v/itk1DKcuvDFfV26CpsOgPwwVj46
         oKdSZT+E6O3bgsFXk2UysYjSDRy6zj4yUK78Rv1eqtIwgcAQ5nn/tpiH68Y8GD4/iHUw
         3O1/2ihPs06whdoc10VZDpvDnnO0QVgM3L+4vMq/X6KTuGPCEjHx9ydMZTrOPjVK9Bkv
         Qkf+MhMg3TkdzkCd8QX51qCa7+tmj/0j1O1H3Kj4Zv1sGjsxfa6mxtY9/zGOSIjiER3+
         piRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=AMBC//GM9TUmKqc/Ee7MUTX4MVxXaivvBIm8XTKWtjI=;
        b=odpzdXd0Dx0jtaiEAP72AooAF2Szu9jPW9wTBljpLx8AiemLHumtl5F/sh2Mc+33ij
         3vedHzk6nwlsKQD2Pf7s/4TqWd0TuQhv4PULIXqxHkBODnjMF4RxGgcFWypMk3Q5kZ5X
         5M63jn5rToQID8F7lfYv9nze67i5K1uUpuBONieNDRlhtEbMYrfJdiUpz1pFaTEjisS7
         lfkO7wRJxLZ462u8qWIVXKDokfwVxCiGrYleP45X/0a9tzvqzS9yhpmVkgfS5/jrFcpr
         rmZFmLH0/9HxInafa0W3rJ/qBIUH+R2iQ6VGw3FIjAu5FyzaxWofTNtpJ/D005LztFCM
         wFqw==
X-Gm-Message-State: AOAM533ZL48gNmjzwQZ9epbYwDuo8R4FHEweM1aqH/0y1K/3b0QlM9Sd
        fL6z37lD96W8wGy1oR5YkW1SsA==
X-Google-Smtp-Source: ABdhPJxPg9RpVdrGQ4Z6ww3Iq/Db4vGVv54cHwt8FNsBk1NOsUw3hrbUnoL/Xc/AmyjDRE+S7btjoQ==
X-Received: by 2002:a17:90b:3004:: with SMTP id hg4mr5050010pjb.208.1592491440947;
        Thu, 18 Jun 2020 07:44:00 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/15] block: provide plug based way of signaling forced no-wait semantics
Date:   Thu, 18 Jun 2020 08:43:41 -0600
Message-Id: <20200618144355.17324-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a way for the caller to specify that IO should be marked
with REQ_NOWAIT to avoid blocking on allocation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       | 6 ++++++
 include/linux/blkdev.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 03252af8c82c..62a4904db921 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -958,6 +958,7 @@ generic_make_request_checks(struct bio *bio)
 	struct request_queue *q;
 	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
+	struct blk_plug *plug;
 	char b[BDEVNAME_SIZE];
 
 	might_sleep();
@@ -971,6 +972,10 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	plug = blk_mq_plug(q, bio);
+	if (plug && plug->nowait)
+		bio->bi_opf |= REQ_NOWAIT;
+
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
@@ -1800,6 +1805,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
+	plug->nowait = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..6e067dca94cf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1189,6 +1189,7 @@ struct blk_plug {
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
 	bool multiple_queues;
+	bool nowait;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)
-- 
2.27.0

