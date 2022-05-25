Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE253385D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiEYI0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiEYI0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 04:26:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841DA9FC3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 01:26:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e4so23101633ljb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=TROhytUCmYi1+1zbJFOBdbpnjKvBFc00UACuo78Blu0=;
        b=t7AXHImYt88F4yFcoFo/qiLCJPnM1PNNZclSW8YTDTfk0sG5d/ZeaKK/dKfcy4dkwO
         m+7UDPXDNxmpmmTghEnV/L3JOGc6DgyEBn4FBQ1QVEV3PBPP7KeS30IkhMdfrA93FYp8
         PLy0TxtWuwWlqGG3f/LH4bbArkBwE8muI0nLZSTBzkX6Zcch2vGKOR/gJv3Lpklnfg9Q
         S924EuMCX97wqhm2YucSMxJEMYugXOIVDrEPipfoDCXxzyLxzenQEIy2ikIVQfGkdDjo
         IUtvoRKID6OBzFaJ1EqKw6XtStq6bc9kax0JGmM3/XKnJ8INcBu3va9x6rXUG5alpisq
         KyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=TROhytUCmYi1+1zbJFOBdbpnjKvBFc00UACuo78Blu0=;
        b=WRkgHbBecT1fw+n6ynntkZzxdSJk/fTooUGtScMNoHSd+rgmxzpxda482+VLF8I3Tg
         vEq7eVXd5zQFnC0yYviApHeW3xCrNVR3nKa18OCH10JW/cQO/pbP1TUei1ilt0IHRbJH
         //XrPo/LdLhNmoLP8Day+C7vhzi1fyGi6HIMV0ZTxDgtikQZOplNMHbXNz6lfw4P4kM9
         CdXMt2t2MG2pPKt8iUn7c/77Be16pn73yUpOYqlkoKNBDoX+Kn+HX7s7rxoy3FCYbw3P
         myvBbkmyJxgLL5VFVSndceNO/iLpD0JmtNBwgBqKgRmfbwJEZLY0WINGq13cVqGZje28
         TTwg==
X-Gm-Message-State: AOAM532MU0PksIH0XfEFCUKPwE6Lem4HW0YZvZ3r5P2RZcy4wbX3H8/p
        cpJtP5Yy7P1nfQl2ax3dwaLyvw==
X-Google-Smtp-Source: ABdhPJyDCQbgxiitG7pP3j+6MDNq9Z3uJ1djPx06ET2ui6tpQIRa8zNilbO2coRGhFru9YrSGRlLjA==
X-Received: by 2002:a2e:894a:0:b0:253:e36b:83c1 with SMTP id b10-20020a2e894a000000b00253e36b83c1mr11560558ljk.520.1653467198883;
        Wed, 25 May 2022 01:26:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id f24-20020a19ae18000000b0047255d2111dsm2971117lfc.76.2022.05.25.01.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:26:38 -0700 (PDT)
Message-ID: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
Date:   Wed, 25 May 2022 11:26:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
processing.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 lib/xarray.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 54e646e8e6ee..5f5b42e6f842 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1013,6 +1013,8 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
 
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
 	do {
 		unsigned int i;
 		void *sibling = NULL;
-- 
2.31.1

