Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA252257E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiEJUcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiEJUcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AD4163F66;
        Tue, 10 May 2022 13:32:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so121091pfe.13;
        Tue, 10 May 2022 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/h1Bxfr/jQDa/bJ5pjWluPLjQmyeyytVr0ONMMooUQ=;
        b=Qnmtgk/hCNFFRvhcnYNPCvoSnG/uEqkiWxWsnaMLO9uVBgzw0dKJQy4UeeGQ1riYe7
         yPMyHNjfVgiSL9P2FckFihY2AuZzL3kqf6HHQE9TAwSlW/LhQYrXDEvp+QQfJun0c735
         LCkure5IfIdN5tH4OPuNjmRmdTnhvzZw91UzHnlGKXL0NM7xIRL3LSeIYlTt5vm2z8ZS
         MDARxEwqJPe1PVltyREXaxFKuu+woKn61n++bjPSuRGBHgeDyuUE4zoHvhsgLEx1Lm2d
         +7Wos5EuFrRrkM1FG66Y4V50+ccVz3AgxuLttfAQm154vQH1Re71tw6qroG8NHRWYDjc
         RNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/h1Bxfr/jQDa/bJ5pjWluPLjQmyeyytVr0ONMMooUQ=;
        b=hvBW73PChiSbcmZ6nqN4ls1MawyvtddrJPPwLIkWNSDvMuQeoJKRKDWupiCJU5uCsf
         pfJ8NzYyT65xs4A/4pBCFgMLsvwySH6ebFh/VD6fR/plmKicxMeGhIiiMEtqxyvOCy5d
         yxrXr7EMskMkQombINawEQXI6GbpO82Dswn64k/8ihKOTDAKTnA+R3yiZCnMbiv+LlPq
         0wHyOgQmmqX9+3TXt/6kJHUUBsNDz/geKsFyumfBUxEP7pXQ+aFgVqfB13XNH7DQjMRk
         yTohUMc4M1ZCPB0o3IiaSrOnJjx0Hxvrh63j81nnnP+19rcN+/m29GzRXYThn9sNUOkx
         av6g==
X-Gm-Message-State: AOAM532Tyj/d+g1dmh1WjfQArtLMaATv79snbaCXCF/oG/GcZ4ty5Dy7
        fKZ01v8/e63nKmI7xckDY60=
X-Google-Smtp-Source: ABdhPJwmfDABb4iz4Cc9sy3pydFHFLqsV/JMgsSn7iApJsP4GkgrAs0teyvTfeRic3/HIoQdrtQi7w==
X-Received: by 2002:a63:9d8a:0:b0:3ab:6ae4:fc25 with SMTP id i132-20020a639d8a000000b003ab6ae4fc25mr18336737pgd.496.1652214759743;
        Tue, 10 May 2022 13:32:39 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:39 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
Date:   Tue, 10 May 2022 13:32:15 -0700
Message-Id: <20220510203222.24246-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220510203222.24246-1-shy828301@gmail.com>
References: <20220510203222.24246-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MMF_VM_HUGEPAGE is set as long as the mm is available for khugepaged by
khugepaged_enter(), not only when VM_HUGEPAGE is set on vma.  Correct
the comment to avoid confusion.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/sched/coredump.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..4d0a5be28b70 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -57,7 +57,8 @@ static inline int get_dumpable(struct mm_struct *mm)
 #endif
 					/* leave room for more dump flags */
 #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
-#define MMF_VM_HUGEPAGE		17	/* set when VM_HUGEPAGE is set on vma */
+#define MMF_VM_HUGEPAGE		17	/* set when mm is available for
+					   khugepaged */
 /*
  * This one-shot flag is dropped due to necessity of changing exe once again
  * on NFS restore
-- 
2.26.3

