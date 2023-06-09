Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D917D728C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjFIAwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbjFIAwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:52:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02230DA
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 17:52:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefd3so1691145276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686271930; x=1688863930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqcDdPqSbAUSGbTjmvLRcpjiA0c+o9DbrViIiTIy+Ug=;
        b=zXF0/SOz02AqM5BWf2P/zwcWEHhQEqJOZyXi3UZpbx8VPRWxCUcaRMvo1gco/xsra2
         1KRka8Fv7Cz5TdkzcXaQgC6O85k85tL3gyx/iy3cDrh6mP1AOUruXIGz0ftmdJxZ1KRm
         ZZx2kRtlsPb6qeLOZNriXbpH5lr8UltQBDA01BaTWp8gpunXX21xn4/zrUa5rAnUvMfl
         mCkY25J/3lnSqtjOJla8DOtGiyoeA+L2vJd0IiqnWI7c7ZShrlyswyCHOWMMkPwl9HjW
         QFj7gjWymWSTqWnDk2iKhq+C7yb+32Ze1ontuD7AeEZ5CFFfLh23UfHmunZhj1vbgoCU
         wHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686271930; x=1688863930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqcDdPqSbAUSGbTjmvLRcpjiA0c+o9DbrViIiTIy+Ug=;
        b=hmZqLZ2ZPlu/N/B2caRKPSe1SIIFXn/UWFnFUaW0C8dPB7cfELWCnBi18PSA7Y2vv1
         VJL25n1CXJc5gS6SPwHWFMy1OV2l1soz/I1xQUnwQ7Xf2sZ9zfHmvOFLoi8XvNsX+7Vh
         6qORXkl1aRdK56jFXTJuYCuNLRnXEh6nT9mEWJXJ55t5gZlPHq0KrMqi3JjsCLfZsx89
         BODG515KeaMFIryvJ1HHdn9lvxPuFFq6Aemfuyb27Q81x7NKhQZ0yS3vALvKSKT+zPg6
         gn7mvl+lNI2YOIgjzbiebBMsVXZ2XcxT062kZOpPVDwCUdTepe57OUfyLP5hpSz3chX8
         jxXA==
X-Gm-Message-State: AC+VfDyF0sV9HY51AlBUcoZIVRkpm/xramp3WlPVXfeofMK6jpIMsHOH
        Ud/MO+Y+EA+KZpUVUpmJcQR7+iB40Mw=
X-Google-Smtp-Source: ACHHUZ5YbGKMEwsx1wWALVdFMCpP8nhO2N5qAulNG9AhZTP2wq6KaJAphozg0TQUY00Q3mKklpdD+wtUbrM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:c03e:d3b7:767a:9467])
 (user=surenb job=sendgmr) by 2002:a25:db09:0:b0:bb1:5962:6fde with SMTP id
 g9-20020a25db09000000b00bb159626fdemr677035ybf.13.1686271929776; Thu, 08 Jun
 2023 17:52:09 -0700 (PDT)
Date:   Thu,  8 Jun 2023 17:51:55 -0700
In-Reply-To: <20230609005158.2421285-1-surenb@google.com>
Mime-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230609005158.2421285-4-surenb@google.com>
Subject: [PATCH v2 3/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
to be used as flag_array inside trace_print_flags_seq(). The element
for VM_FAULT_COMPLETED is missing, add it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..79765e3dd8f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,7 +1070,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.41.0.162.gfafddb0af9-goog

