Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0169562EBC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 03:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiKRCOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 21:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiKRCOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:14:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F190898DF;
        Thu, 17 Nov 2022 18:14:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m14so3308671pji.0;
        Thu, 17 Nov 2022 18:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wss4l8+ki3bcqZpf4pXWKdXS9Ah4/Shxx0wHVdp0ynM=;
        b=BHAg7M5s8r6Zk3gNga8DlzxghZsFB0+gDqhWzAobQ0NDSCnRl+jsxSvoCauCt5pDlV
         FDsWr0LWtE3+ZTY7CQ3LTNxeN3cKijwiRiaNvETjKpEgeeIjaGefYqxrpk0elzNuWxJs
         ZXKMKa/5Iju31VyTJHHA2LNGmdzJjmeLdNHvAI5Fpr2KdzXb90/1Yd/rS/2cqR0oRiiX
         Qk+aUBMrANKZjsd0FyKxxEMA7BhVE+Ewy6TrW4vdV7QCkzGSUwFyFzgsMEX2rjxIgUFR
         Q1A/dW1R3WyV8pkB70F3ahkg7sda6EOcxLWMlweeAzvu72bbCTJs57pkgTpCtPxu7pY6
         T4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wss4l8+ki3bcqZpf4pXWKdXS9Ah4/Shxx0wHVdp0ynM=;
        b=V22Kd81Gc/IKotRtKEFQBL3Og6kSx5OopPpd36cd3riKQ58A9ZghjoGU1IIBiQ5o9t
         rBQb+1XABITRM+m1FRLn8mh1dAWQkn6bZIbkNxG2iJ5aXZWce2le1B/CruCz6UeUwC5O
         TceAgQC//jGWLatn1CW3bRsLc9gczTKsAPeg1lXCvHEyxKQXJPE7qBKJjX33aIfp6rRL
         T2Pi7RlhqqYfiVBu3EBC4a90eu6V3K9Qr8XCU86Ypnf5fw20b1mdxMfHuoev8Y7qSSVK
         eJB7yDT5YCrw4rmb9WnOo0YJ5GySZ62DiFPkawy6VNW8Xm3RzVh2TzbMXNgs7I3/U5Z/
         t+nA==
X-Gm-Message-State: ANoB5pmc3eZFnFNSYnDGjiv2hJvincIWTYgXPNmxdW8NwjKW/qdIyKsk
        bos3FYO75g8e/SS8LW1iJlw=
X-Google-Smtp-Source: AA0mqf7kbAgQClkwM4QeG3emZxM+wBrivG6gwkUc5TdT1Y7K2yhmUkpU4mlPfxxeDly9Q1KMWA0dXQ==
X-Received: by 2002:a17:90b:2542:b0:1fb:e7a:79b with SMTP id nw2-20020a17090b254200b001fb0e7a079bmr11745002pjb.93.1668737660142;
        Thu, 17 Nov 2022 18:14:20 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id ip13-20020a17090b314d00b00212cf2fe8c3sm10678445pjb.1.2022.11.17.18.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:14:19 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/4] memory-failure: Convert truncate_error_page() to use folio
Date:   Thu, 17 Nov 2022 18:14:09 -0800
Message-Id: <20221118021410.24420-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118021410.24420-1-vishal.moola@gmail.com>
References: <20221118021410.24420-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replaces try_to_release_page() with filemap_release_folio(). This change
is in preparation for the removal of the try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 145bb561ddb3..92ec9b0e58a3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -827,12 +827,13 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 	int ret = MF_FAILED;
 
 	if (mapping->a_ops->error_remove_page) {
+		struct folio *folio = page_folio(p);
 		int err = mapping->a_ops->error_remove_page(mapping, p);
 
 		if (err != 0) {
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
-		} else if (page_has_private(p) &&
-			   !try_to_release_page(p, GFP_NOIO)) {
+		} else if (folio_has_private(folio) &&
+			   !filemap_release_folio(folio, GFP_NOIO)) {
 			pr_info("%#lx: failed to release buffers\n", pfn);
 		} else {
 			ret = MF_RECOVERED;
-- 
2.38.1

