Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AAC1DF400
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgEWBvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgEWBvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7FC05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so5999249pfb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH4qffDw1bR16LSZOmXHQ8vTjhgFWUTnPL/hN0raEaw=;
        b=ETmKby8pAAIxY9U6WKn9CNosQ44mYgxTdTEtopdfdIDXO+NjGX+ifvqGeQRY+HJLIA
         zY/uuUSY7ifcyny8cCud0KJJtWED2SwscDrPgSbt9iDpo6l5rWhZ/iWY3YeImMCN8iMw
         L/7j62wezVNEzhqDM3bI8PBpBnkH7SjhNbw41sQr28LB9x44BGLyFn6rdBNi9M1yaRJJ
         XZU/iC4PhJhfemfcMMM8/912GLbEFK+hudvmr0EFF29TKybjESBwie4GPrS5paBlNGpI
         +3XhOzxy9MSMPaP2RNYzlt8xEZiiLsPjce+rDPBpL7L7WQNe5ic1esa1XcBzqGkfkR/u
         tRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH4qffDw1bR16LSZOmXHQ8vTjhgFWUTnPL/hN0raEaw=;
        b=aLWRaiRaaEv6BTAnLAEElPMskgZwKvnU9fYPHaj8BBAc4T6G2s0NEEbxG0TttCg4N0
         tSpJUiwXIhzD41zazwLOb0AeLIejWXJVeFx3pbO8n7n91l2n3+LRN215tkBnOox9s+5F
         oUjt+S+Ku1JHYalEee5oTrhRabKmMYVfTp3S4S6dVOIOGgt4DV/oM9S6VUv0DqTlHZJ1
         Yh6y41tmAo7YV6waf0CB65EXsWQIUa7frlytd66e7VXrTO2Sew0RG9N4G+4vKocMnxlC
         Q1sSLQrfeMm8YugvuLTsYrbwB+wl4Qr9aa3FaEQEiDWiQ3rY+sBQW+A4V7zycAV2l+Rv
         KIFg==
X-Gm-Message-State: AOAM530LDEZjXUxeDN6AgrCWiHQCNowWsmCd/coyLW8/nKSbbL9qy/VD
        IFCrqDaNK4COc9C5DB0FihhMUQxZ+og=
X-Google-Smtp-Source: ABdhPJz0nFKgn1N3JiIfLboWuIb5grjg380HgPkl+kUx5EXcYlCR6fXRG759tLrdb0IJ28scGhXSoQ==
X-Received: by 2002:a62:641:: with SMTP id 62mr6411983pfg.283.1590198669882;
        Fri, 22 May 2020 18:51:09 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] mm: add kiocb_wait_page_async_init() helper
Date:   Fri, 22 May 2020 19:50:48 -0600
Message-Id: <20200523015049.14808-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
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
index e260bcd071e4..21ced353310a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -468,6 +468,24 @@ struct wait_page_async {
 	struct wait_page_key key;
 };
 
+static inline int kiocb_wait_page_async_init(struct kiocb *kiocb,
+					     struct wait_page_async *wait,
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
 extern int __lock_page_async(struct page *page, struct wait_page_async *wait);
-- 
2.26.2

