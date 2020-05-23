Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC11DFA65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEWS6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgEWS6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB272C061A0E
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so4646278pll.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=dlRhMk444r2/QEHuAZ++S1wyLJ84KnLxTEI64EuE4dN1pFxVgN8A9K0quOu7H4b4Kq
         sjwJUAUsTLCVCGcV3VQIysTW9HiVCJ7sH5euxBGtqJm15I6wEKH3mue/IQD6jbfOMSi7
         Ee6mlXKJeIhli6gCf6YjVyTShL+/w3Hnk2eTqSuVF+zoDvF1MfrGYqyMRFeDjw07L0cs
         Mpg8k135t1sCC7y9Xv6B4U4O7cl9wdgoiTFK8GtgUeb7Kc22w5q0VzvT/2c8RzsYEwH1
         Cn02kuIXs3ldFHF8OFsS7U3UbM4AjfKkDhyZ7OjtrO7ogq6UpJoIBqUQAGUK22qWlIRj
         o4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=s1WHfzT597VBL7sL65caq6eymhMBz048sp0GheM+cjQLZ6L4j1whvrjQMWEFyCApvF
         pi1GRmJV1UTXJ4UB4XgV14oy8TB+4WW1q+82QjjIzJ59ltZ0uGcQmGJojpYuVgmq6yjf
         QIHcwH1fg0GliQ0+9hzIk3j07Cf58KrNC5TaMn8H/3yrOgmiM7gEEI2xmlgntB1jyJu4
         pX9nbHvuN/dEXToI1Glaj+uhkoPBahvm+nwXZruHU0PJrQuKudBJ0VDpSaXyiK6faoHA
         aE35nk5njwWrLUVLtPAttBDjY6EjRwuoDi2+rfIoIGJu2jPLHGTrpS8lx3iDodTQC0Oz
         M5jQ==
X-Gm-Message-State: AOAM531ftL96rgYqDKcsvFtAR9C9NXtchv3n97ZWjMS5BgtuCMz//2UX
        z6oS5toV9oUHU69xM+m4GK8fbQ==
X-Google-Smtp-Source: ABdhPJx4dsrrORWefyOaJaBwml4HUm2oobE0QtXJHHyZSr21A+y8BNmhuTv3ioELhwbbDTv2OiGRNA==
X-Received: by 2002:a17:902:db82:: with SMTP id m2mr21720441pld.14.1590260282249;
        Sat, 23 May 2020 11:58:02 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/12] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Sat, 23 May 2020 12:57:45 -0600
Message-Id: <20200523185755.8494-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

