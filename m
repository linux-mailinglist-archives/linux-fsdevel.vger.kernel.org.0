Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766271E2F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbgEZTwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390092AbgEZTv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A5C03E979
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so262158pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=OuGZsDadMk0ouSxBbagElzrDsOFsdbddmk5eH65ga2Wxc3HZgfLVLJcFyhEw8usAcZ
         HTB+HylhbVE98IfGgUAnUH7V2yMwJESFU4207FlXryYh0fm8menLFq7jByDucoN4/oPf
         rJyxXSFaoAe7D9VKjzoCoCQGXgjxaau5MP+A01WQYIW/16fxIm7sCIPAjYEsvtXGsM60
         0/ikp/pt7voJ76qWQsjOrJT4Xr0rTeQIodW8eo5MyOLN0+AY4TmYJZDl/Sm0O9y1vtWI
         bc7fhd+puE49SaeiR2JWPdxtuJM7gyKt8uZOc2YIZRlech7S/BIEWD8kxVapjAUHpLtp
         dpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DT9kV8IQxC/D+uhFJsefv+iJT3TxYB4ReZ7s4ZFOil0=;
        b=qinK5XpgYU5cf5nDRWsq95VP7pyxGG4LRsg1o48yzM4U0Pf+1TRw8knZuWoloP3n6e
         oP8GR9ClSVaHWkHdl04eVQPhAZ9JBzZdlvPnNWVALhveRs/nRGRtBLQtZj9uBQZMEERG
         CVUSxbQWflrpV/1BKunwJ+iVagAZ+gUabNlIH2Yz0qs40iq0MeBykHm1Jmr5JDJjtMtO
         iUnucgMOLH3Ra4zAvhkRciYWQeCAhWImwUiAJY3n2G1zu6a8dXuNUU9J8tbQEz1wIYus
         KpyiiJ3u6ZKxxySqKDVoujH7HYqBogI+++bb6dsYX0/+7N1QtBRS1I2iyLY1sWD4RYUW
         lwOA==
X-Gm-Message-State: AOAM532dA0f3YdlexsOJJIRDMM6qLhDvsY07EjSvceUlnvuK9emXOxDV
        3wjNACeGydwLzDOx2DDLogTZvQ==
X-Google-Smtp-Source: ABdhPJz8Ax0r8XMmPGcDuG+vpoiMfRCzG//xGTpSe/ZiXq6nh5Ywfeb0pH34jS4EKxW64rcgwO66Uw==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id j14mr894757pjd.136.1590522687551;
        Tue, 26 May 2020 12:51:27 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/12] block: read-ahead submission should imply no-wait as well
Date:   Tue, 26 May 2020 13:51:12 -0600
Message-Id: <20200526195123.29053-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
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

