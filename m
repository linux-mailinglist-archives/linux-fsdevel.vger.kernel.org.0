Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF37544957
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 12:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiFIKld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 06:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiFIKlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:41:24 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0E267CCB
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 03:41:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f9so9470080plg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L4gtE6Nwxhqko2H3PVb/r993pNhceWeKw07NNRQ85Q=;
        b=NrMB5dQ59veFB/XnXQezjBFT8bcCwIl+jP9JXN1LY3wqizYRbZhWCeG2BBxkzHxgKA
         TW9eCxYWQ5pRg2LcWQMuXTOq9cGKeQTSaK6UExTCqC9B0AgJMTcxo10PadO4FY01B8dE
         HHCVZIC4UQ0UOGii059G94L0dyi/EXzmsDHqwzIGVrif4HzFOFuF4zO70v8WaBYuqxoZ
         ItVHkYfr/Ivd3N58JXuzhQ88h8IlrxdP+0Kv4ZMM4dPVqPkHXlz9wXLfpPywaN0m0HLs
         kZJuse1PW00OrZqVYQhnMPQJ/7cf71kZ/KMnOIAFW1xrYKZohKGNsw59OZK1s0LJqXf3
         hMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L4gtE6Nwxhqko2H3PVb/r993pNhceWeKw07NNRQ85Q=;
        b=OXEu6q1bv2F/DyZqJp6zyzHTu1Stpj8cbZcjOlkMgTKF5zqgoa/2xjD5jIXTMBztM/
         YIcSXlTLgSWCquMEeVRwHYVtlQN/0gG2dGsd6MkPxp/morHWVj01rdcVWiRgJdaP00ov
         aQ8dklmJNsWuoV1KjmI9V8xE/BEcrwryNuk8/OF5uc/hjtH/0NrAxFcYRGoJjTAWYC+7
         5STV5MYjxzdrtQKScgzCjkkUdcLHmKAzjqRyWL/9daNr5te3ZZseYVlI+jdJmIt7NSvX
         zhcDFouJYxlUfzWmylb4CembT7bvyDHmUJtIVwHlLeufb3kr2vc3KeRd+6eErndNpmbP
         ux6A==
X-Gm-Message-State: AOAM533h19wOFEjeKpj+5Wvx/ItOeRD1xjZ22QlytcZ/c/I0KQk91g9q
        4ZvwJFp/mCawaGiRpzpulUm0Rg==
X-Google-Smtp-Source: ABdhPJzt6m5YXoPxvbvRGzD1gjnrN+7PwLhdRyVD97c8O32Cyzco5wjx5mltJH0di35bufdVPJ7fhg==
X-Received: by 2002:a17:90b:2404:b0:1e3:4db0:f32a with SMTP id nr4-20020a17090b240400b001e34db0f32amr2828865pjb.201.1654771271434;
        Thu, 09 Jun 2022 03:41:11 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id b127-20020a62cf85000000b0051b9c02e4a3sm17458544pfg.178.2022.06.09.03.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:41:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, peterz@infradead.org,
        dhowells@redhat.com, willy@infradead.org, Liam.Howlett@Oracle.com,
        mhocko@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] mm: sysctl: fix missing numa_stat when !CONFIG_HUGETLB_PAGE
Date:   Thu,  9 Jun 2022 18:40:32 +0800
Message-Id: <20220609104032.18350-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"numa_stat" should not be included in the scope of CONFIG_HUGETLB_PAGE, if
CONFIG_HUGETLB_PAGE is not configured even if CONFIG_NUMA is configured,
"numa_stat" is missed form /proc. Move it out of CONFIG_HUGETLB_PAGE to
fix it.

Fixes: 4518085e127d ("mm, sysctl: make NUMA stats configurable")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org>
---
v2:
 - Simplify the fix, thanks to Michal.

 kernel/sysctl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 50a2c29efc94..485d2b1bc873 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2091,6 +2091,17 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO_HUNDRED,
 	},
+#ifdef CONFIG_NUMA
+	{
+		.procname	= "numa_stat",
+		.data		= &sysctl_vm_numa_stat,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_vm_numa_stat_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	{
 		.procname	= "nr_hugepages",
@@ -2107,15 +2118,6 @@ static struct ctl_table vm_table[] = {
 		.mode           = 0644,
 		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
 	},
-	{
-		.procname		= "numa_stat",
-		.data			= &sysctl_vm_numa_stat,
-		.maxlen			= sizeof(int),
-		.mode			= 0644,
-		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1			= SYSCTL_ZERO,
-		.extra2			= SYSCTL_ONE,
-	},
 #endif
 	 {
 		.procname	= "hugetlb_shm_group",
-- 
2.11.0

