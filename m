Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6F1DFA7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgEWS6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgEWS6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4009EC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a13so5755252pls.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=bB83Tj0BajwuSjWkcK8ehgNRsKT4dlqQdsgUPSjJiJ2iXaFPJSy+fQuN42JRHiuPAF
         Ds+TSO9sTx+8fbiOAVgtOWX6Sz5lYix1bG9WAh/F71WpAmuz6k6RoGgcULfHqhCzSSGy
         czJK+XJrC+LZTYdNLs5WA1tyopGAN51nNSKpEc4rmPTh+HjK5AUz5guhgngWLdElEoFp
         Y/U216s5zcrGi7OrgxVS0H1boXsUkpjkDmicuLJP4gJCppIK3k1wT0URrgfknJrl22Hn
         CRM8C/QHbp+xO5nT35RB17ABqdwxlpAFz/I5f7IJcf47ml75nwLzUmNlUz5/4oEh0drP
         Oicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=aumFTPyhn+960JKvX+OTS/XQamou3kDqNcwkwOzBbaUQfWaWmCZOLg/ZmpOl6Te0m9
         K/loT2nbUiKgRVKFec/i9wn6LxPRkZTyTTKuCT8C8bM1HNDw5d0jRMnQhyMjgaIi/DUK
         kBFyQn1nEFOsQyACvXmO8oAlOh31002cC+X3EsSWzqDz1ERNd/3HG5lTgl1MKsG4X/sS
         60XPr8Q5FwwGmPYbYMkZdqvZv3IsKwexueJKRsGv4cObCCoEEnX3DVM1JVPfQmOQhiT6
         KrV7O4G/Oa1ebKgIztLrsG43gFTE4vuizb6h9+3y+EalSUp4rd6DWn4V2NLEOXPEGchv
         HW2Q==
X-Gm-Message-State: AOAM533ih69RLft+NFHhPDcVB/6O1JtHk/YFv7zR66ivixVVCK3wiQ1U
        DumSd55tmdriFlNjMNQOP3/KQg==
X-Google-Smtp-Source: ABdhPJxtwoGUVtGeMjBKBqTDc5pH659x6OQMxIcezhl06qMF9UwN+jLw7DQKIdSMErnJ/wvDE2IMpw==
X-Received: by 2002:a17:902:422:: with SMTP id 31mr21310761ple.310.1590260289753;
        Sat, 23 May 2020 11:58:09 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/12] block: flag block devices as supporting IOCB_WAITQ
Date:   Sat, 23 May 2020 12:57:51 -0600
Message-Id: <20200523185755.8494-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 86e2a7134513..ec8dccc81b65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1851,7 +1851,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.26.2

