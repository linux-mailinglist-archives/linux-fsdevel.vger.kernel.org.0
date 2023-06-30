Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0507443D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjF3VUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjF3VUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3E2686
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704995f964so23256947b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160005; x=1690752005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxpT0wtXiDyXAkq9m4Ft7pVFAXex2TsyXSa3a6xpvEY=;
        b=CmiBSAVOd2SJ9KkajKb82g1sbktJiFYJzW5mhwIbhohJMYg+6NliTNYNRvGr7qH9J3
         DZo+DChiKr23yUB7iM6WjoSuQzJ60wZzKLuuQC3mPPiMY/9zG+OpIZguJ/pnwtM1HRR0
         jBN8ksj8AloU+LK/FwdRLkImKs42oA6n1CCvxR0nsaaBTrAKU+TX0aGyoCQJSV1nSteg
         QfJaV+ROJPuT8NGWeSCLb3CVxDPCwNixwjO7DkBpmWVUjULNQteVd1/J2ReFt69J8GlU
         8FBGmlqRK/+OBL1joScBwgOrtRwZ7y3x0w5Ya6f3GZ8X35wlWUNahWE+vUb7f9HVQmrH
         GL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160005; x=1690752005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxpT0wtXiDyXAkq9m4Ft7pVFAXex2TsyXSa3a6xpvEY=;
        b=IfC9NT/Nz0e3M+gk1Xl/91aPkxQ0aUebGfrstXqX3mZioXHhzyCr8Sm90SLDi8CN8A
         4kOi48DTtFesFLwrANw3xCI3P74s6gIQIWAJC6wny10R0TaHVmxU1QkYmZZyFthFK8sP
         F14sXIm/L4foxpCEBzDDiZ1LFjtnYlQrHwuzG+4FohJZb0gFuZ4fLAHIP8F6xmagj7jk
         +N8uN7pyDivmW/k0TvHeTYpsWxnS4Ys7jmKnAggv99k6XBpdBVqtfchn83TLouG1Tmuv
         6HTeONG3eOSvrrpvAwAi/maVEa80bJWsFOnAF5ZNBU/KOEH1OuasVT2M38wQXKF8XIv5
         ZEQg==
X-Gm-Message-State: ABy/qLYsafcToy+UcZcRjVQBxDNP9x66mz91u8i+Aa4xEfXMRNyVD72F
        yxIjg//6+6i2zGINIyhSilihLONuGns=
X-Google-Smtp-Source: APBJJlF5ztBBwyWteO2XW01iQph/9sOhVVQ5xerSWUbLHw3eJriy3uuhavoxZfleLDq4B516ZDfLMavujZQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a0d:d890:0:b0:565:9bf1:f6b with SMTP id
 a138-20020a0dd890000000b005659bf10f6bmr29618ywe.8.1688160005788; Fri, 30 Jun
 2023 14:20:05 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:53 -0700
In-Reply-To: <20230630211957.1341547-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-3-surenb@google.com>
Subject: [PATCH v7 2/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
to be used as flag_array inside trace_print_flags_seq(). The element
for VM_FAULT_COMPLETED is missing, add it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..39cd34b4dbaa 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1077,7 +1077,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.41.0.255.g8b1d071c50-goog

