Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAEC1E0238
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgEXTXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbgEXTWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2EC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t8so5532769pju.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=gxGduZqosF0z63K53o9awU20QA6ufSZ5TTqRe+tv3AOsZ2QlQ979YXr+1dskXq52Jk
         HS3I9zTGgZsmogN4rJCO292dN+jQ4Bh81nqndOGDqgUTCuNwtxtCzXuJPlAMKQRJ58uA
         DuMNOBDX6nN/HrDjMdSSysjmoxpz5chCYgMsvnmdpOOufOk2jA7gdSzJR/TzXpAMz7Lj
         M0TIw38/7f79f2cKH+xUDuzBnClVTmIWWKOLweF65hex28srdE77jZIapgVeALrqEfAA
         ocGg0o8OhrW4mbtznbLks7cKK3H/ZDmHlmgcJ/0qYgXMDuB9nDi7913IThDZ9hVUMz+H
         0p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=H4E/Hf8SbUE+dcSJECVVrSaBdlJ8Ymok1OST/WEvZLcqXMTvno7FBVBB7PgDWeM015
         0aHPMnlAQi8GubBIY/jWhLi6vv4bvNpik9icTobLSHq8sZ8sTWMHfZ5U+WZQbGpRsHaw
         MIWaw/zDwbP6wl01qCM9OpbAFRmo20kDiYQ5ZDhA9v2ONLMGi4omr17XCVFeKbajSyhY
         OochGhqxNGwxMAd7Ck90Kh5K/9dRstVNKGAe3vGcd9/juYXBHwHYO6dRXMXqSmpzlPHI
         Gd8hq5iMo5nfdp4aoAgouNgd2A6QFaH8338/XsI3FTw9REq1mYlMtp26ny0eyX4o1Z8L
         /v4A==
X-Gm-Message-State: AOAM531MMAWlwyZoeJconwLiymljnH4drwwT8Vv/jPsoOyxwRX9vHcrZ
        72j95HYBqehCfczFzdOeCuFeA/DLki5d5Q==
X-Google-Smtp-Source: ABdhPJyWrtKyXRFlA4SwqdiGTTumD68oCqrgZnBOzPkJTTFSdRxzhdggPB+vLC5MAtEqdrvZvv1y/Q==
X-Received: by 2002:a17:90a:648c:: with SMTP id h12mr17363317pjj.229.1590348133979;
        Sun, 24 May 2020 12:22:13 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/12] block: read-ahead submission should imply no-wait as well
Date:   Sun, 24 May 2020 13:21:55 -0600
Message-Id: <20200524192206.4093-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As read-ahead is opportunistic, don't block for request allocation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..c296463c15eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,7 +374,8 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
+#define REQ_RAHEAD		\
+	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-- 
2.26.2

