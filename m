Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B160916F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 08:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJWGZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJWGZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:25:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B054F1A0;
        Sat, 22 Oct 2022 23:25:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a13so20469368edj.0;
        Sat, 22 Oct 2022 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gKCq5XIPW2RbA8+dolTmjgUeHqY5AM7kH+URnmauJs=;
        b=KJ0U8DfLDa42PcgMBXYHocV4qMWNRxAHrrMfBqCzJDo0M9joeOc9iAknwrOtx3o4Fk
         I7yeRFOx+Zt/vj+axNAP9juvC8480eYXdBUcTcRN/YGHfqTksljKaQTuCQLaSUrRwc3Z
         PUUnwlLWAnW5oNQFYCOnlFRJ3ezH2kt1vH7cEK5Lsc01xMPh3JbvUsg0megN3E5Q02i6
         5QJja2Eo+py0kUHU0eiTLT9DRnUmm/l1+EsYP37TcfMZambPgZPpr1zKjZOKlDguzSOQ
         PlO0FaK/ubmPORsHyWg9eup/REjQSSErR+dlBgQ2JMiB79fHTAu8NDL7GN6VpklOzc0H
         CKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gKCq5XIPW2RbA8+dolTmjgUeHqY5AM7kH+URnmauJs=;
        b=2PKj8V8XgTnjsBSW3L1R0Y2TNjPmXhBh88TXeOjhbO2JrSPm6IYnITPqrz3ItrnbiB
         a/0mir0V9KEN0n0+sT5PXnRSmAQplRbvo12Z16qpFPWJfdnPxUMwmpS63+7wN4q06jPU
         RG1RGe8Lqy29RFAbbpOKZ95ZVdftKJsnZns1+Pndl6TFjGCLg8Wu9s83Qsnp0J/GWat8
         Jec4P0u2+G/x3JQkZJozFqGIIBCMBw0euUnzAWcc4Z72vQAkDD9X5vFFYbt1J7BBmLgV
         LBIZrbX3X1GfhG3spSoPZehNtC4P6I4tBlA2Is9ddk1/1aob7OtUKLrqNErCJ30g4YEx
         TzOA==
X-Gm-Message-State: ACrzQf3grQBvqqZhMGv21gzBZKCVrNqRc56ogLYRPZTwfODY9rfkoicQ
        ZyF5I87XjRUuADl7+Qrc/OE=
X-Google-Smtp-Source: AMsMyM435+Nkq3HHE/YtP/ntcXnP0jd57ntCHTtDEOsxtPrNClVovAKBuN4lYfxiiq8UXZ1dDGNHnw==
X-Received: by 2002:a17:907:d10:b0:79a:a1fe:8be5 with SMTP id gn16-20020a1709070d1000b0079aa1fe8be5mr9526927ejc.125.1666506336562;
        Sat, 22 Oct 2022 23:25:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm13583140ejf.208.2022.10.22.23.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Oct 2022 23:25:35 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, shakeelb@google.com,
        Wei Yang <richard.weiyang@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] XArray: fix xas_split_alloc() on checking split limit
Date:   Sun, 23 Oct 2022 06:25:02 +0000
Message-Id: <20221023062502.29429-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We limit the range on split, so that we can just allocate (sibs + 1)
nodes to meet the need. This means new order at most could be on the
next level of old order. But current range check doesn't cover the case
well.

For example, if old order is (3 * XA_CHUNK_SHIFT), new order with
XA_CHUNK_SHIFT could pass the check now. This means new order is on the
second level of old order.

This patch do the check on shift directly to make sure the range is in
limit.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Johannes Weiner <hannes@cmpxchg.org>
CC: Shakeel Butt <shakeelb@google.com>
CC: Muchun Song <songmuchun@bytedance.com>
CC: Vlastimil Babka <vbabka@suse.cz>
---
 lib/xarray.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index aa9dc9b9417f..2c13fd9a9cf2 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1019,10 +1019,11 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int xa_shift = order - (order % XA_CHUNK_SHIFT);
 	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
-	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT < order))
+	if (WARN_ON(xas->xa_shift + XA_CHUNK_SHIFT < xa_shift))
 		goto nomem;
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
-- 
2.33.1

