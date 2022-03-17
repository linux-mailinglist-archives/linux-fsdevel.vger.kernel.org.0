Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE14DD149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiCQXt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCQXty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:49:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BF1A844F;
        Thu, 17 Mar 2022 16:48:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p5so2001637pfo.5;
        Thu, 17 Mar 2022 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUyPpt9yITb+v7E1k0NmB1H1X1O1cjuxJvXjp7qmzqs=;
        b=KGAXD1pdDKssYLDVJnzInpkYLVCjld8aQdSBPEtJyRYQAiZw78n32N/TO102SQyHmf
         yOjOvBMg/wJhYADen1q6xkUT8Kar/VUyxw5Gau+O7qYozSjj73pdubTi8sBu+AXtmQ9w
         xHDtlPvykFut8SJqHAJvJG8KZXZEgPAfadKVFTIJbw8dVHx1yzTemBdDvujvug/x2qut
         eix5xqdQfVaM/rl64UUQMBtdNSpAx+pya3QxiaWXDfnBGfWayz7Mc6b1ZgeEJOtJBr9L
         vkOMQEbHQ2bn1ECcRnsEg3MzTu+Log1ScTC8rww7WRae0dOAlzhO2LwjprdtM/HKhCXP
         sqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUyPpt9yITb+v7E1k0NmB1H1X1O1cjuxJvXjp7qmzqs=;
        b=GuyWLhm0W5J1lEq7dOiKdIuVCFNP+u1tI5WeJRpPO478sQbsuA8lhWPz4mjOavkeHa
         JiW0Estc1OOVqYsM4VtWZqRJ2pvfYxnFj/81+LIzcTWI72UbsdLH63g+8S5qK4193YoW
         hLcg+u4clV9MsVmcSbJpSVEqMExZXwDRQHhgY3KlIBLQagXwnvpJ5C/l5uLcj3ibCG6a
         0o1KuYQ6qp8ViGh/qfeQdST1ofOt4NN9+ifMcwfmv0Nt8uL3GoUg4eIh8DBZUTjDiFI5
         UHjA+g22y2QViloi2zAGVBo27/jlS/sXcdnhu20J6+7Nb0a9pWj7IjNje4XZYC5MflKA
         lPNQ==
X-Gm-Message-State: AOAM5336Nwhc+TS+lKiRIpcuf9kav0LX1y3pMqY9YkrV89gCksvKh//e
        KsaNvCQCo2QSN9khD6NGjCc=
X-Google-Smtp-Source: ABdhPJy/71kNE1QNAXF397FsY5nOp4oXeRKHByVUgbhgNMHcH+U1wY50LwEcOseYcTKRNJDA4ZMvIg==
X-Received: by 2002:a63:4e41:0:b0:381:7d61:ed68 with SMTP id o1-20020a634e41000000b003817d61ed68mr5651161pgl.132.1647560917456;
        Thu, 17 Mar 2022 16:48:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:37 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
Date:   Thu, 17 Mar 2022 16:48:20 -0700
Message-Id: <20220317234827.447799-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
References: <20220317234827.447799-1-shy828301@gmail.com>
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

