Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1B54E293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377311AbiFPNzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiFPNzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:55:02 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757A4344DD;
        Thu, 16 Jun 2022 06:55:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g186so1323467pgc.1;
        Thu, 16 Jun 2022 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuEwtiDlLgx2R0fhACrXqafzxg/xLHleHmagqvpWBd4=;
        b=W2a2f+bgmGf5MSxLbCrDAvw4WD6l/ix9/M30wYUL1PL+e0RDKK3Yf7JGdTTup2SmC6
         K3BHey51uiYaPCKBB0fQAy4w6HE/bAragushXyXZEyAWqanyb/HR0r6QhAKZaNS5KwzB
         aZattOxmD0IzTNx+h5wdyeYrxl5SVp41M8+It9hqxTYH8/4mZ5v9jfDIWH9dG/X0UzTU
         Exjg8jmpcRRCTu1vuzPZixycRBRQ5exMQSxNxXMyLs1jVH2L7k2vrxiiYLXnx1t91Z7l
         7yokOtKBpqfxLqYhCE58ajzYinQJimiSVAmOrGm0+gNMmzAKC4m7hZ4mHdLFjUn5UVg0
         dN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuEwtiDlLgx2R0fhACrXqafzxg/xLHleHmagqvpWBd4=;
        b=FNq7S+tO93+RR0F/aC5/OxIHQLDUd1lqKys9TrQ6tLfu0Dms4tT/mmbYExejMRpALD
         7zHat3QepDMV0tyB7JZmrAfqcEOM9m3DVuEje2upEbXqKwvB1Sn+wxPXB8KbTz0Z4PHF
         BhB3GZCJqrmkvdYHRxevxo1Jjp+RzSqw6oNWAw0jJCAxt7KlgGXRCVkgCsM37GjIJQlt
         ptYMrbQjlMvx2LOCU6e/1EB8eUdbPUOlztdCuzQQIolLhn0SXxaE7AIJqnN52nfzhIs7
         qG8ii2r0ngae5EBQzO0wRHlmyCssxL43/+OXba0Ao7DD2IvS28nWHzB/ZJMX+fKw49l4
         4d4A==
X-Gm-Message-State: AJIora9t1KfxhXK+E0xI9VBoVWc74+ebkQtPSv1aT617tmeQb7fuVZ1d
        cTCkHtTDbx2SuwDGmUpSOZ4AplfxtA==
X-Google-Smtp-Source: AGRyM1vfD0Uhf+JvOHog/Vh6ERS6IAC7Cuo/d7cY4Bz53t5s0ubo2uSkz1n/jjnHovASvoAa9yWxLA==
X-Received: by 2002:a05:6a00:1a91:b0:51c:2ef4:fa1c with SMTP id e17-20020a056a001a9100b0051c2ef4fa1cmr4852801pfv.75.1655387700839;
        Thu, 16 Jun 2022 06:55:00 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1565149pjn.53.2022.06.16.06.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:55:00 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, djwong@kernel.org, dan.j.williams@intel.com,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 1/2] iomap: set did_zero to true when zeroing successfully
Date:   Thu, 16 Jun 2022 21:54:39 +0800
Message-Id: <1655387680-28058-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655387680-28058-1-git-send-email-kaixuxia@tencent.com>
References: <1655387680-28058-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

It is unnecessary to check and set did_zero value in while() loop
in iomap_zero_iter(), we can set did_zero to true only when zeroing
successfully at last.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d2a9f699e17e..1cadb24a1498 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -917,10 +917,10 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
-		if (did_zero)
-			*did_zero = true;
 	} while (length > 0);
 
+	if (did_zero)
+		*did_zero = true;
 	return written;
 }
 
-- 
2.27.0

