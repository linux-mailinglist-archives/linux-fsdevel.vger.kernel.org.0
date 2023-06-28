Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13177740B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjF1Id5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjF1Ibr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:31:47 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F544BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:23:26 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id ada2fe7eead31-4435dff9f48so486358137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940605; x=1690532605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=EzNVWclc8hF1fZENtSKl9fY1f+KC4OOifE65PJNbJ6nBql2U7FGsy9bJPhB73u9Brl
         3S94bgAVf2FLeRSe6d8vlkbeo1lP1gNFo+NN76W8KsGs/4Bm9p4wr5NSAme9IctEM4oh
         3mf1pSOZ8dyHGUiorfCLU6BaYEz1cjjHEbqv5ZeLIzpU7Ep4LJBHyARMj0FQo3dxGRY5
         EoyXulXe5CazLJ4xT0pC8j38HjzrfMT3mc5E81hFviVDx5t+g9ZSw6Jk6RQJgNh1H7a4
         APnsZ/mTtgdDsGreywJhBWv5sJk+zWfgHws09rBSIx2LWzSX5yA4iToJ/8pKfxVbtGNC
         mIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940605; x=1690532605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=FinOdHUPnpGTTG3sAtbNzApwEl2s7FXW672HUYbSManFB8cHbgY75sQFKt8boSr3KF
         dcxArzMbDwl4hora/NpZUNz/FC5INdGtoeKGLS/y4g5ZjVz2VI3eyN2NKgtFuYJDfXQd
         iW42gFeFjdfoAbtSZJ8kZUwfIdxP5zdDFLjJyC9u6hmzzEAatD9IZJpo41gSwYBU01pQ
         4y1dRWXWo0kDJ73Ve5ALpgf3jUqOTJ2HcbH60FCyLnLL6C/2kg1gHEf3BqtPswCp5PtO
         hbaA37GYewgiyDVw4uwoPXuzODIbYDV7OgHV4jGuFySE3yYs/YRg8R7/6s0FDugkK92p
         HIOw==
X-Gm-Message-State: AC+VfDwTgqI1TkRBqzwuRFbKZeFnkGW+F8lvx+PPL37AjGnpxQLFsfuQ
        X9o/udpavw1ng/tDNeZKZmGcYIay9uI=
X-Google-Smtp-Source: APBJJlEw1+A/dz6nNLU/xIoq936J+gnmtGHgb4WKOZkDIT7PH8urmhAvh0DMqKPzkAG85bCaYotcRGxUtQE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a5b:512:0:b0:c38:993b:3be5 with SMTP id
 o18-20020a5b0512000000b00c38993b3be5mr245ybp.0.1687936689805; Wed, 28 Jun
 2023 00:18:09 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:56 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-3-surenb@google.com>
Subject: [PATCH v4 2/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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

