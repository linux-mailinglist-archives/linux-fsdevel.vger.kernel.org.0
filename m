Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358F81DFA76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbgEWS62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgEWS6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2FC05BD43
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so6573771pgb.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dAoC2D0g8n2nB3lVHnvM8l1E4Q5NdmCRN9F9KiRIdEU=;
        b=YC2VfzsnPeRpcE5DvmH1q7hRFR3ktyWmEBg1dhSrxX6BFoyD3fKdg4R2GLI95N/SE0
         13pLuYLICLL5TpTf7k8tOQCbfcWAg+LSSWYlWJ1suwm0ov6o2L9xiYsqhC/dE4f5VSym
         icycAN5rixlSrfpPHHd9LLwl47FKj5W+W548LOgLrXWRYNWFtPZlt+gcRvbc5/F/zgL6
         1FxFTEntDu/QcaUTMefGTsOHV6kxxyLa9N7whilVJyvdprYWKH11tzgAocRoJwCMs5sJ
         ORD5W6XVt276+iM8eGWGAHYZvutwMyV1kO9mZPyzKTsoS0Iqcx9DKWbS0Jhs1iPon9fh
         nHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dAoC2D0g8n2nB3lVHnvM8l1E4Q5NdmCRN9F9KiRIdEU=;
        b=eQ7aodgfvzR6jLODJwXn0P/9E0Fyndiz5skIEe3Jcwy/lukXqz6ONGG2oo6PXxG1li
         pjzC73AqtlSX2v1mTDjEgZvjzi2EWtgO9c+9RZ5YDfM6cYBoZl0ky5/M/ozSRR+JDvaE
         nqhsRNd8qBaN5mxVuC9JNKD3Pq6iSsjYYVtf+d6QQ4/vpLGi6myd9HUgd6DpmhEEtmpm
         rV2xRU1TeIjKzGSJ5HEH7YxFcqWIYl6cMwJRnOxF7CsEFMHA3I2pfuiqixcy5YaSV2fs
         3czA+4nh+T/pK2/eDTmltgOAmsJdJZYAhn4PLlzHtSptvgdhTIhag6mF9gTMExkY9PQc
         5RLg==
X-Gm-Message-State: AOAM531SFwzo26BwpalqZzcQ+tKQ0eMjz9xdftzqGe7OVHIotxJsseCC
        /Ud00Dpswmjf4Nk6N11d9vunnA==
X-Google-Smtp-Source: ABdhPJzl0A8QaNkybc86UdHrH0/anQq6XTkgCYB3IwOB3AK5hnXDj+grn+woPDxbu3W68oqJ/gnDQg==
X-Received: by 2002:a62:b618:: with SMTP id j24mr9943370pff.16.1590260293462;
        Sat, 23 May 2020 11:58:13 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/12] mm: add kiocb_wait_page_queue_init() helper
Date:   Sat, 23 May 2020 12:57:54 -0600
Message-Id: <20200523185755.8494-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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
 include/linux/pagemap.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d3e63c9c61ae..def58de92053 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -493,6 +493,24 @@ static inline int wake_page_match(struct wait_page_queue *wait_page,
 	return 1;
 }
 
+static inline int kiocb_wait_page_queue_init(struct kiocb *kiocb,
+					     struct wait_page_queue *wait,
+					     wait_queue_func_t func,
+					     void *data)
+{
+	if (kiocb->ki_filp->f_mode & FMODE_BUF_RASYNC) {
+		wait->wait.func = func;
+		wait->wait.private = data;
+		wait->wait.flags = 0;
+		INIT_LIST_HEAD(&wait->wait.entry);
+		kiocb->ki_flags |= IOCB_WAITQ;
+		kiocb->private = wait;
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

