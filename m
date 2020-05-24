Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17721E0223
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgEXTWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbgEXTW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC94C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f4so7764330pgi.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egusxH2Kf4IsegITvpm+Q3F8VxKliDk7k1e8lkissGM=;
        b=TglGLCKYUK3IUheNw2tbkabE4Tsvn6fX7wkDCP1B329i3fyJ7ym0/4jC6PlxFEJkCh
         xq1XNX2hwngAJ5RcbIVexVcP9jjvdaD9osyY+kMe+yMGUekQEI9NIpkmMfLWwshr5yaT
         9x1b/h2VkjbTsRSyVybp3IKTaneYp2AbkvguvjSaI6bwG+QNsK/bdCW5gf+XuRt4xgqE
         Ve96sQETJ61P1rmIYCDy5zh+xyCExYatJgRwEB3WAFACCj4ZKPLryT+2Z3vNLi5FK4vI
         pcc4/jxFI1Biav3NYID6de289fcInGHFS4DS31EtXvYZlBGY5Kh1XFpLtfn3lKFAilan
         CVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egusxH2Kf4IsegITvpm+Q3F8VxKliDk7k1e8lkissGM=;
        b=X+c7stXaDYaQca8v5Yh7cdc214AjG9YuiFlUJwCYMNyHJDOJIWflRjTylhVFobXmFh
         +4Yi96O/9qMTFo+PPy1rNGUzIL6OIwejw63lybO1qUDv0kxTEs0xj+3lSOc3lPcQBPNF
         0x/cN6m5VoFMGPyFk5WO/goTtQ1vntqmXI7v0mD1JeIJcvzIzfBoiDl06uR48d27HoIq
         nHYSvsz+UCQLOd+yF55Et2AFd2aMBdJYMq3bJzUXv250vr2pfD9s+syxcL8Qb9RbOBV1
         UL4aiv2JCKUE5ijrxhDD70cVKNfkcHypOzgrniL0pqCkUtwfTqE7VxNN1ut1GghdobLh
         dR6A==
X-Gm-Message-State: AOAM5314y5151EYrBrvQTiO8H45wyJRZEn01gLD02u5zROf8VIwMqW9V
        We11v+zQuGB+muex0q0U/kCJhL8eygs6MA==
X-Google-Smtp-Source: ABdhPJxKr0QyshEARDFf894CnVwX/DlbGPjUKUr7q571X3XzSjjUdNUUq4yA3N0OBw7dm2okvEdSNw==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr22607763pgb.74.1590348147189;
        Sun, 24 May 2020 12:22:27 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Date:   Sun, 24 May 2020 13:22:05 -0600
Message-Id: <20200524192206.4093-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checks if the file supports it, and initializes the values that we need.
Caller passes in 'data' pointer, if any, and the callback function to
be used.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d3e63c9c61ae..8b65420410ee 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -493,6 +493,27 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 	return 1;
 }
 
+static inline int kiocb_wait_page_queue_init(struct kiocb *kiocb,
+					     struct wait_page_queue *wait,
+					     wait_queue_func_t func,
+					     void *data)
+{
+	/* Can't support async wakeup with polled IO */
+	if (kiocb->ki_flags & IOCB_HIPRI)
+		return -EINVAL;
+	if (kiocb->ki_filp->f_mode & FMODE_BUF_RASYNC) {
+		wait->wait.func = func;
+		wait->wait.private = data;
+		wait->wait.flags = 0;
+		INIT_LIST_HEAD(&wait->wait.entry);
+		kiocb->ki_flags |= IOCB_WAITQ;
+		kiocb->ki_waitq = wait;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
-- 
2.26.2

