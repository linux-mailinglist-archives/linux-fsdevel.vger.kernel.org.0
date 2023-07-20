Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4675B234
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGTPPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjGTPPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:15:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B5270C
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:15:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b852785a65so6925505ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689866115; x=1690470915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igmOeAaO/nUKTsFVfVJFzonWyTXDvfkuPJ6/bFmba2Q=;
        b=ifjX9YZCkg2s4O+drZO6YGL7/Lsgz1x+slvY8Cgw55/87DZkfZKcjA7poVCMbh+5yu
         ZgPUB3PlIzjll6WwO8kRw6wk4Xgl1yVBybwpUF2Zu9dRe0ldpUHu2lVsHkjscH4fPV0z
         CTkGCdiot7DvhOgsXAcbi36udOxdwU3PHMysE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866115; x=1690470915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igmOeAaO/nUKTsFVfVJFzonWyTXDvfkuPJ6/bFmba2Q=;
        b=kQx75iGo1uyPQEOYKHQ0DMRwXosRvV2PnqAqvK6gu8iWDJt3LqRAkDgSgg7oTCySnF
         eqjjvg9TBbhuRXlINqoGCx8oZiK66QM6V2Zual95ur9fMPrPdfWXW48LdP0u4EnxA8wA
         yuOjME5clRsvB2A2IGIfLLkfjHn96juqyNmZT5Y5HI/cRfrgO689Qy28I7dBpQhPijNw
         Bbncr1xTZ05UZr0VOtKrlKpXB99vfcsi+FSj/4oH7uJTPAixPseIIvCLIci8mrIZ+N8k
         mnx0fiwpIOwIkqNzSXyatx2STeVmUuB42/LLdtq0q3WYFETIXtAq4N4SYXlvqrptgtSJ
         RiYg==
X-Gm-Message-State: ABy/qLYPkB9aPBHT3tzOH5pBdXYUYv2bbDJH6/b4hcZBHpoMBPd5AquL
        27FJU778NXeuIk9FwiCOXAzf8Q==
X-Google-Smtp-Source: APBJJlGHMyTI1JgQG21Ar8O1aZTXVCNn3SwZQMXEPB/BW8isuZnS7cfokAGhm9KQgXuhxoq6TG8yzw==
X-Received: by 2002:a17:903:41cd:b0:1b8:9846:a3b2 with SMTP id u13-20020a17090341cd00b001b89846a3b2mr7290941ple.14.1689866114697;
        Thu, 20 Jul 2023 08:15:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902b78300b001b88af04175sm1522076pls.41.2023.07.20.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:15:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] vboxsf: Use flexible arrays for trailing string member
Date:   Thu, 20 Jul 2023 08:15:06 -0700
Message-Id: <20230720151458.never.673-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=keescook@chromium.org;
 h=from:subject:message-id; bh=FPWlWMLBWLQk41wEHtF9Aoh4CSJCJMajyADIdaljriw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkuU96kJssYE7C3IMQG/og8R3QooDvyV0Ltszxl
 wFYSldLCqGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZLlPegAKCRCJcvTf3G3A
 Jv+KD/4mMkxhrBH89W97Tm+qKvrzrmOjhG0Y4dB0j6sgNitbBZxCAFMdTAMSXNeK7c6MG8rpk0m
 u8Aq/XYopofblby5FeWyYmYKtxr6fMn0yifFAPOwlv/Y/k0UGAm9KmteX9xrEg/+sL+tH9vDH52
 4PJTLar11KucciW4cdPPWQqdp4nY9H+ONRbKRycWlIXjP4HXFMsU07MioErLoIzJM73VLDOr2nt
 FQQEk5M6q+zmwIsdzheUle0/b79f12dbkD81rEVvFmXv+5mYpBU4tPZyCFEs+CqsjIJENYwGoFM
 F2jkyVp9T6HdBonaiqRRv8++PcExWotGJrHVXeb6tZTtJ+xiUHaHVAO2dbFTCGD8Oq1Qxj8LSR2
 XdEndk3wVvPqs/5hiQB/9hxeL2GRlHBlrvzMvOVG7Ofn3mvpojtAmQbLD9guxt3u/BEXnrLqqxK
 RCESTcBs5Lcy0EcYRBCACtjztpkxF16dwE794hUChM7rxTtdrp2vMEFhPsXxoKgoakdlGbsZDfp
 GgIeLFk5+spiGqODrZXQjQYoLD1vWQdWdEXcdENVN8qddA/cQMMK1kGSgCgso0zl+mvUm+AuLtc
 gtVSOQInlTRfeUsrzoTCCdJi+uvbi4iB2EFYCPWMn76WNSbwb0Z+5zZ/ThQnDRg0h6OPNDe62vm
 FV/WbHK fCuhPHJQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The declaration of struct shfl_string used trailing fake flexible arrays
for the string member. This was tripping FORTIFY_SOURCE since commit
df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"). Replace the
utf8 and utf16 members with actual flexible arrays, drop the unused ucs2
member, and retriain a 2 byte padding to keep the structure size the same.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Closes: https://lore.kernel.org/lkml/ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net/
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/vboxsf/shfl_hostintf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
index aca829062c12..069a019c9247 100644
--- a/fs/vboxsf/shfl_hostintf.h
+++ b/fs/vboxsf/shfl_hostintf.h
@@ -68,9 +68,9 @@ struct shfl_string {
 
 	/** UTF-8 or UTF-16 string. Nul terminated. */
 	union {
-		u8 utf8[2];
-		u16 utf16[1];
-		u16 ucs2[1]; /* misnomer, use utf16. */
+		u8 legacy_padding[2];
+		DECLARE_FLEX_ARRAY(u8, utf8);
+		DECLARE_FLEX_ARRAY(u16, utf16);
 	} string;
 };
 VMMDEV_ASSERT_SIZE(shfl_string, 6);
-- 
2.34.1

