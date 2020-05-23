Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7321DF412
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbgEWBvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbgEWBvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B8C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so802744pga.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=kBqllv8uys4gT00yGgiunqjeponh5Nq8C8hpBlk3I4cc90Q/f4dSIrnyLUyS/Afz+r
         0RJjV5F56+x6vupgwbgihJ4FmQ+NkFT9yuigJ6Nrmv3UBWv/0wNOHnYiCzYr1tDtGjo4
         9QNHGjZJ73Y4XECmG7jLNdlmlEi4tPrvSdreIls5bnHJThbD/p6olZ03f+MUeQeVDE0I
         fOxDlTpgsFLX4TUxiHF9FjuRx6OsKHlg1Buy7Ts/XS6Ufe5If00TpoJC+Nr3HjuUQ2OT
         CVD6/VP0MSTt+JfzQ458ZhXnJAR2xxZGCO3gBrUjQrNTGpi1xfAoufFvveKQSv3Db8J8
         hfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=HtsjClzWwCUA7A+RKem62f7erbILsGJRneMEg+0QqWgBsgyU+hW/r+xB4OyoeWSyYX
         laDNBZAkCxm7JpNCABbCAEw85T3jSFzQlinRCEwHwUDlPhprpreMhH43PJPJyCsaIa2t
         EalfiO6RCK/Kk3HSHrbViUk2GQUsa21bh6eZUnWpVc9KfhJq378vzGbi+HSN1ecrzP6C
         ZFqwrSEiYFclEwMJKzYHvhQ7fXqP+Txk60sbAuTSGpPg3BhlzHGufTq/XO/BYbmfVfHu
         6nGaAmGbHAC516iLaIX5avD73w81VPDi4fo6kZKw00lnELR3TVAoAioFRXKu8aIVJw6J
         JM/g==
X-Gm-Message-State: AOAM5318wPM8ngwUdC5XRXzbIS7cNYLb4wmJIZUHKDRA1HEqB1pxXtZJ
        7h12rXC/9hbin+Dgj34Ozozb5rsw/4Q=
X-Google-Smtp-Source: ABdhPJwELIq6E78ugR6AHpeggJ/RDId6psVvcflU5HJfCYBxWSeXZtdKisZBE0iaGFRnuziLQ5YBKA==
X-Received: by 2002:a62:754f:: with SMTP id q76mr6783393pfc.14.1590198660209;
        Fri, 22 May 2020 18:51:00 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:50:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Fri, 22 May 2020 19:50:40 -0600
Message-Id: <20200523015049.14808-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The read-ahead shouldn't block, so allow it to be done even if
IOCB_NOWAIT is set in the kiocb.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..80747f1377d5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2031,8 +2031,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.26.2

