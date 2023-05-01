Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D86F348E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjEARBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjEAQ7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:59:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE73A8C
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99ef860a40so4734434276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960172; x=1685552172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3+CZtZwJ9/tSYfHBM/2MHA9DEGGjB4zlxzO096/9Q=;
        b=Glr4JSHsTmaAPI0AWP0PWNaIttgzeyDzPQx4tjZhzhm0zZ4p+1GCcCC3c3r4aXKXSp
         WIW7l4ONjqrOBXvjUIVll03e3w9s+YRWlCSxmsKNK9xzzAcM54D0O3+CWQoKF/ytzIvC
         kOX+0OA2rpltLDjWT1I86SdUtJ7gM1/iT7nXNjbfE5eIm0GIboQlBljhXdjDloTQNmLw
         70IARjApWsmBCF7eSF3LKPA2bTZVurXLcycCJn2u8FXoQc4EQGTI1K+d32OJcow714/u
         3R8ajXD58HPiHypeEQaSKmOGWRsxZiDT+trPafMrQwqkk9Lr9LEGmo4kscoUpmICusqi
         Lbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960172; x=1685552172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3+CZtZwJ9/tSYfHBM/2MHA9DEGGjB4zlxzO096/9Q=;
        b=SZ4ThGHSM2OeeQENZqQa9TPe1dgKHq/A13q+4f3S1Cx7spdbLhqQrYeL+u7tgfVQwn
         eLBY0alic1VkyWgrJAfNvFc8A0VO/4S1BmHVp9Pl/Z5bCGXafpdxV9m6TntsOLCRc3Bi
         kUEJrAaG4yAhmjtE+9FBNxqFKYwUc9rosboKhw8bcX679eEEF3QwY4spE25RevxAl4Ys
         EI+qXByseb+ZJoNDolmRZvS4SVx44R4rSgzBAF6PN/EP3rb35t9yF+iWWeBZd939b8Ng
         8yeYR3gtrnfMGcip6EHPsF8Xgzcs450sH88/aivk/RFeHv4Pi7NgbzfuE/qlc4nxI//m
         HJ2w==
X-Gm-Message-State: AC+VfDzXS0/IarL+bj/i9ouljdtxIzD11QIvK+O9HTzojeMhJZOO+OXk
        q+xadg43DGJ6J/FelDyD1ouY2IykITQ=
X-Google-Smtp-Source: ACHHUZ6QTE71DtRYGwVPEik8Avnxkjne4lD1OdWVt1RsKvPsz461K/ZnyuUPS3XSYPpuvwa5uVYwtV8n9po=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:1388:0:b0:b95:ecc5:5796 with SMTP id
 130-20020a251388000000b00b95ecc55796mr5071137ybt.12.1682960171977; Mon, 01
 May 2023 09:56:11 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:38 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-29-surenb@google.com>
Subject: [PATCH 28/40] timekeeping: Fix a circular include dependency
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

This avoids a circular header dependency in an upcoming patch by only
making hrtimer.h depend on percpu-defs.h

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h        | 2 +-
 include/linux/time_namespace.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..e67349e84364 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -16,7 +16,7 @@
 #include <linux/rbtree.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/percpu.h>
+#include <linux/percpu-defs.h>
 #include <linux/seqlock.h>
 #include <linux/timer.h>
 #include <linux/timerqueue.h>
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb9d3f5542f8..d8e0cacfcae5 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -11,6 +11,8 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct vm_area_struct;
+
 struct timens_offsets {
 	struct timespec64 monotonic;
 	struct timespec64 boottime;
-- 
2.40.1.495.gc816e09b53d-goog

