Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD631AF5B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgDRWvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgDRWvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0CBC0610D6
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g16so4391280eds.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hL6p6zRwYRA8CkbRJsKJgrHbaaCXLqCx5oMrPjaFW4Q=;
        b=YIJwwQnMLeEO1MmhiXMMg2q4Jy+N/8huIrljqa3VGIl5RwQUL4vBgWq9lK2vWImONh
         jWSOhP8RMEvHfb+GZexYyHOPRiKSPLIJnRhINkYKgcrpkThi9io5dqEvw0HPvJJpRs4B
         HxArufN8+hphijbsEfJXX2AKrXXOvenOPFu1SGXxBJJhu02+SHsNDtORcnxJU3kivGq7
         9IcsOz0Ra+Zmtj7CJ4JwJtIQG4Te4CS7DF4eM+fMaZku8D7MoRhlN4IfUNZktWmc4ZNS
         +RVBa3fNdE6MKNX4Bs12OkzqEAqVNXT5qO2HK9yDakaOnvAyJTLvXAqrq0fb1woTcN+K
         FJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hL6p6zRwYRA8CkbRJsKJgrHbaaCXLqCx5oMrPjaFW4Q=;
        b=L/TEiYH5ostHvq3ynKmomWGDRm9HidN9KvoU0UJUSVY7v4Q3uf4ETC5CksZJSP+YRm
         Y7NWwMIne2hCHHKQ5qnOge1/QLp2Ghx3S6Jda9+f+usEl+8a5DTDSZTeRi/VnT1ia2qM
         mYU6Ofq+TPfcG1A6Ay0zULK+AVpVmpbp1AxWr1huJy8SDxMestzy/bBMQUkguDCf2XJ9
         4NO4k9Jz/UtbNkydLs/VqpxZn/saEYCd1a4SKgbujr95O0je3QkMTnUGqIxF62E8zc1/
         brcaqU4ridBLVtgJ9cTfTyHJnhGMhSeC231vrN+Wu7Zp2jzBNUjyFu2CszsGEqPrabty
         PZkg==
X-Gm-Message-State: AGi0PuaKC2U7z6BikTGtNNNeIQOfZR3x4GoicrIkLpJgKvKaU3ZibQkU
        T2T9salYVGL/WMWctPWeqPkGNKedtDDkKQ==
X-Google-Smtp-Source: APiQypLpKv/mTEh9SN92IJaogbdrwreOw8sLFoEw7Zo0QJRoelWBcQh18FKDlsMwRdrWQm2i7h2N+w==
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr8164945edv.207.1587250292396;
        Sat, 18 Apr 2020 15:51:32 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:31 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH 5/5] md-bitmap: don't duplicate code for __clear_page_buffers
Date:   Sun, 19 Apr 2020 00:51:23 +0200
Message-Id: <20200418225123.31850-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After __clear_page_buffers is exported, we can use it directly instead of
copy the implementation.

Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/md/md-bitmap.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b952bd45bd6a..a1464417ada6 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -324,14 +324,6 @@ static void end_bitmap_write(struct buffer_head *bh, int uptodate)
 		wake_up(&bitmap->write_wait);
 }
 
-/* copied from buffer.c */
-static void
-__clear_page_buffers(struct page *page)
-{
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
-}
 static void free_buffers(struct page *page)
 {
 	struct buffer_head *bh;
-- 
2.17.1

