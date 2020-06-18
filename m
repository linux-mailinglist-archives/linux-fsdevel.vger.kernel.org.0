Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7691FF514
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgFROo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbgFROoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95FDC061797
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so2511690plb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=kQSBvSrh7q7DQwM3udW0mgxqiTGah8xT/7K+LzTiHfI=;
        b=TF887Y4cr//mvXhTI5c5VEIRfZElOkM2eJr4igs7tYzM3I8rEROoL5414jXEsJNQ1d
         6jCCrNh5fQhPQ07otOWMKTLuwned62gpZzcQSnGz+AtcAsFIRf8kVJYMZrFYkSHJEstI
         EF+Ln2Q+pUkq3tXurup9X6YD2LWffkOldc8tPFPnSONqddrmM/DgTfaNjc16nR3q5d4t
         hPjBvp3o4ycBlrYr8QUDl2U7jqa+BlqD3TbE19T3/QnC95yw4ECXM/85GcpiBdM2DbqP
         8OM2osLFz5ebGolhbCSR09DpxT7wJ8dhnp+kF1wWM32/wq3hn9RugfvhthZyfIx3RxdO
         JS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=kQSBvSrh7q7DQwM3udW0mgxqiTGah8xT/7K+LzTiHfI=;
        b=jF6uE6TehWXwzo/YydT8Rd4WyG5e4t2+WU6W6Bt0MRQR+QSsQ+RhjaWliqH9+ItoAW
         nyhhKRmJpUQyk8gvfTLbwWM33E3ZkqF98P7qxEGV/5smkZaKvhA87vNonfqRiUa6Wzgg
         tLFAp++utLjHazZT4IgcDs6seXYYcQDU4gxe/HKyLpe+ML9sBUTweFMX38epoDXgSEQD
         iHPTE3tjXPL633l8n+NdmM38o12Cmmq77Gm1hj5oRmqB73WpRaFH4pM9u4BTcUjbqFGS
         AbnRGSFdHiyYk6lKigs7cr6wvTNVsz6Eal+nQjY7AGRvU3T1Bc8oKJIg5cC1uf5QTNxd
         exZQ==
X-Gm-Message-State: AOAM533bvb8zy8kf/Lyrbm915ZuXWa+9AeSE8eLOkm5OzHk+YULmMB3Y
        5oE7FB1X5pbsV5WZj8elTclWm4jhjf78Tg==
X-Google-Smtp-Source: ABdhPJxFiInSxSM7iPuZuYhM5oN9cIihl9Wh6hIowfIxeUrII9w3vL4Xc8G06h5ebNdfyunElMZGlg==
X-Received: by 2002:a17:902:eed1:: with SMTP id h17mr4012771plb.172.1592491446303;
        Thu, 18 Jun 2020 07:44:06 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Thu, 18 Jun 2020 08:43:45 -0600
Message-Id: <20200618144355.17324-6-axboe@kernel.dk>
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

The read-ahead shouldn't block, so allow it to be done even if
IOCB_NOWAIT is set in the kiocb.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..3378d4fca883 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2028,8 +2028,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.27.0

