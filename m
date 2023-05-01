Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB866F3481
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjEARAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjEAQ7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:59:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF771986
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso4868331276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=Db2dTvDWbMM6MtFyLXOOyG+p1K651ww8uL+kJDohPMMG6EWYrhfJFGluhHEW0wqXl5
         UKPrByNQ1Z4QXnisfDyfKX7dbeY+3mxaMGuFVRBjDUr3JiqQISt6WeUr2I6JPah8BGyR
         FjdvJFEuIXgNlkkoVLLQxMPMSKPuyrjPesVcRR9te3ugJsI7tT+EXrko3AZ8ov2CcY8R
         JR28aghvPN6+RkIPURXyrGkWco+xEzOLoyotOADRZq9o/XJ68RcgnDEgHpMVXMMei422
         +DGh+VKx3LXxPBgO4eeggvJc6/61DcK7Fvg52O8gRCKPK/nk5YYM+Q4LDqT5D1RFb4LF
         rBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960167; x=1685552167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfoToyHVT1LJlGJVQ6MuRV3hbhaLXh5d5qfc4HkIPik=;
        b=Qx15u/X/jtcZgBI8bty5zF9/21EmC1+579rKBn2ZXC7Uj/rfzKlbGHnVQL5VubIZEq
         lCOnSLjMwVrPZM28t3G9ZrE6DC9pk1TmlJcuvpkdf+R/DfPMoqtEfBJb7NfKY7lmTpnI
         lsxDwfOFlDJ56B1pK10WEKQeyEeV6Si+jxq9qtvE9PyGEcb2upYYdX4pq85rcu3smuiE
         N9I1jgHfsr5OlvZ7xj1rukppkFYHcoRGH0C1qZ6NmOEf49W7UhQXgLGcpqQKdvRJht54
         GP+uYtgKOypIE86LBel3u3Vq5xHOCPUBpeGWfpBFNkFsPSZwsYSGX9UbYP5U0eNmCTS3
         OWjw==
X-Gm-Message-State: AC+VfDyJH7GI26hA8wakI1pbIAmG5c5+OFicgvLp5A/Xrj7eAVhQMEQO
        yzoAN47VW751mKlcNwKwBPD2nBYfqp4=
X-Google-Smtp-Source: ACHHUZ40g7B5Nzrue3Inkynn2rCW8wBzh6gvt9xgi1/WmwP7LCTtOXWTAuDa8Mc648etXigh7Ci0w5kPSCE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:c0ca:0:b0:b9a:7cd6:ba7a with SMTP id
 c193-20020a25c0ca000000b00b9a7cd6ba7amr5449586ybf.12.1682960167516; Mon, 01
 May 2023 09:56:07 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:36 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-27-surenb@google.com>
Subject: [PATCH 26/40] mm/slub: Mark slab_free_freelist_hook() __always_inline
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8f57fd086f69..9dd57b3384a1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1781,7 +1781,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	return kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.40.1.495.gc816e09b53d-goog

