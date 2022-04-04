Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB284F1B1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiDDVTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380404AbiDDUFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014E30F6A;
        Mon,  4 Apr 2022 13:03:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so396610pjb.0;
        Mon, 04 Apr 2022 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCkHW7qdKf6bzLGj3j7v6pAZ5FXathduMO1XmoapD2w=;
        b=NCYcMbdBRvRn+XRjiGfIxN2tcqtf3m28j6Ss9IzYKdTVClDjf3RZa3dGeoRDcblFz7
         lpG/BEu5k3wkLaxvKPQeQaLes4MrBITFco3y2M+Kp347fIot9hIiXvKKmF+dJigCPYG4
         B/q/jRSOjGQXfPhlJmn3+5voL7xHCn5jGOPR8dpHxjDGbtAlGbfMNyDprgwmJKVJm4zv
         PHkwsPH645GSCAosRwop6qgP6Nb5WtrIINCwtfEALkz+5PaTyaRoMErryMtRF30s22oU
         EDxOpJKcFLVvu9HhhIjSytflYUAOLG73XjN8C5QEmVPurGV9Incx69Dw9oqg2WXRtzQE
         Rjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCkHW7qdKf6bzLGj3j7v6pAZ5FXathduMO1XmoapD2w=;
        b=vZBvg8M0BhC4VwlSp9BiwplDKsNOn8WqUWGO6hQasPiPJxOwNJpTwXV5KfFx8b4Mal
         O2j2VUf0vYTVmECbF5NJdeBT/zv2slsNgK2NytBNU6b6zEV8yIJwKIn15ayXY6300UHM
         9MwjG37yDsYaa9TRJkIeGWirEyDrIJf3unoVrnCkNIcMNE7tkZ43CSUkhzRoAmfDx2NZ
         jYRDttqNqzDBOK2ne7c3NzsK/sSp/43f67BT8U2bHBULPimiqlTrjZ2U3xGroWivvb3P
         5mXLJC2DuUlGCrBKy/gEtiq4z7mNxO9xqWrmZqwr/VM/gxRe9kbQDmDmf+cbF/aMr9Xy
         +kKg==
X-Gm-Message-State: AOAM5339geaSuOXWF2j4nZkt1mbDhJi6euW0RFmRD+Ox8dtedF4o0e2a
        1gElhO7G8S6p1gog5sfryN0=
X-Google-Smtp-Source: ABdhPJwwyRU/9G37xXjcgkqkjgM4U7jgrGc/4YgXWVgLfx/3lCnWccRDoLxMFlr3jYl/E2J/XSzSHw==
X-Received: by 2002:a17:902:bf07:b0:150:9b8a:a14f with SMTP id bi7-20020a170902bf0700b001509b8aa14fmr1450757plb.127.1649102584016;
        Mon, 04 Apr 2022 13:03:04 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:03 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
Date:   Mon,  4 Apr 2022 13:02:43 -0700
Message-Id: <20220404200250.321455-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220404200250.321455-1-shy828301@gmail.com>
References: <20220404200250.321455-1-shy828301@gmail.com>
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

