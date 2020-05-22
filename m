Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53C1DF085
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgEVUXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgEVUXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8496C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so4832573plr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97ziPRJaRp61bFALKKVlWwbLPU9AOxDDg9/9arO/CTQ=;
        b=e17fBBsJfZzejhyxzZWQq/0IdfUf4Mo7YkSITiDn2GwpMJENeHLROZ7xtML6c2G5aX
         HuBV1pCq/A8reKOFu/GCRwEdHlbBHMk0eD3XLv44Mw8gTWQh57rFxc1D/CyoZ+dHcP7A
         pd2LqaWGznMbFTRGhHaN0Z7tJizqem0z7kyisPSXDWuoLdV9PeMV9c0Xeb7U+w8UsFC3
         TLKe5LDzzt4+WeD+Gut9wXCq3YC3SBiPiKoYRVu5mWW2dKca2CG6wEu1UBMuCHyqtlOG
         X7/3dWCwp6/uuPicBJJNLWqjdeacU7PZV+7zzos9IrX0bKKBof26X40REjM3sxDBfnuK
         CHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97ziPRJaRp61bFALKKVlWwbLPU9AOxDDg9/9arO/CTQ=;
        b=ZBQM3U59vwinlHXZ6en+qTz9y83ksHX+4YbJkp/LEJn+cQM2w/9f6IDaXQ5Lki+8hq
         btYnjZy6cw7BrSNarYCOxZfuSWHxCzIU8sSXiK/aW0UAWPzd2/tfC8i9C6UGXIWkbMbW
         AUMfYJ2iq2qOj51ozSN1mj9/u86rLfXiOIuVTIZ6noll84In439sFUd8cnMH8UvAyBN8
         rWZZFnppLVpVM5ED7cXcfNFHu0lmBSi+ZZDEACFzposmlSQwFCGs65Z4x1adSrT7Rso7
         zQXfGunmzwpcsWdd60DSUdZgze7n0RbcA9YX3uo5kjVQIkcsmHnr1GnzLG1GI4x2AoiL
         nJdw==
X-Gm-Message-State: AOAM532tiZac5nqQUtddYqzTgLdcNWPmmItpKLag6ls3KPOnA7cJei+w
        Adn+GBFjrTtOzB6rbxxJl203sw==
X-Google-Smtp-Source: ABdhPJz01IRscjgYK73+OikJorEQXyPy9buBD3WYGODAQhQOCBJuBqKGCIESXg0wwn7P+hv3J9t1mg==
X-Received: by 2002:a17:902:6f0f:: with SMTP id w15mr16026547plk.191.1590179011200;
        Fri, 22 May 2020 13:23:31 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/11] mm: add kiocb_wait_page_async_init() helper
Date:   Fri, 22 May 2020 14:23:10 -0600
Message-Id: <20200522202311.10959-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
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
index 39af9f890866..dec61e9e5710 100644
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

