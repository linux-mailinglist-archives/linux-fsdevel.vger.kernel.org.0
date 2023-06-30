Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E740A743278
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjF3CEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjF3CEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9A1991
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-561eb6c66f6so11566637b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090684; x=1690682684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxpT0wtXiDyXAkq9m4Ft7pVFAXex2TsyXSa3a6xpvEY=;
        b=O6qrIABFeVKumQb4z+O4Rwoiry/zCXrDFmQqF+Gf2qqpRo3dr3IuEVNfNulzR2+kK5
         e2f359XuQFnf5KHHVWh0sdLfRObOSqXo2wiGLj6SYF/QVu5Ag1Xc42AsiOD4EFRVI3D/
         6WXUEdxIEuyZ0pcXaLJ6wNwP83t6XrfWjBfwoYQvysnINji0qB8vghNiKOp740Ul7Ukr
         kmeYyHgwQ/HkRJAGRDgQT17Uk6XRL3V+GxjQ5EJ8pKYtf2xZ9C7jcOmmmprH0oLA/TvH
         VfRZ7vZRznwMdcR48dtpA/zVhSiR/0T69uIXQOd6IX6RY44wnsHcF9ERl0Frpjr5dnO5
         f7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090684; x=1690682684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxpT0wtXiDyXAkq9m4Ft7pVFAXex2TsyXSa3a6xpvEY=;
        b=JrlmYfsl066RGSFt+GD5+O18nj4MV2tU9mNezwkLnnI//JhiP/djovhtM+39NXsiG0
         H42BRKOSBUU8kAZoS77s32ca+me0qaahx1jqIugnb4ZC5vpZMCe21aVbD3gIDaGBsQ43
         7CV/icIOojMKZXq/XZwk0SOMrImkjpBwNDYwYorB2GKOmGvbpu/qATf32EyWdN6BZkAV
         hCqRmOmT+QCOgqNAqlXMCIWZjrr1/NdqSRZN+PM0ssnSXNaV/6V8vf+mDu44Fjxp/jgp
         0QfUm30HRhsdaSu3rYVodDLU7AiXC+7Tz9MZfpwTqxVWeItEOmGfJi4eIaNCmflZPv4B
         u2gQ==
X-Gm-Message-State: ABy/qLbKJ02KMrq1W+qP7SlbgNxcR6XknqxcVYLNA9A3dTpNos/1Unkn
        oLtB2SfXsndfUe/BCR0lk2U339YjnF8=
X-Google-Smtp-Source: APBJJlFlO+/FPiatjPAMJcuTJU5ZkETGLKXrSfIwtCQca/pP1cHpPw/0ejIEECjWBi0brJ9r19L8sTxC/BM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a81:d106:0:b0:576:b85b:7bd1 with SMTP id
 w6-20020a81d106000000b00576b85b7bd1mr6970ywi.9.1688090684551; Thu, 29 Jun
 2023 19:04:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:31 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-3-surenb@google.com>
Subject: [PATCH v6 2/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
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

