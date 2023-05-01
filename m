Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B376F34C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjEARDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjEARB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:01:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB940D7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:57:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115e69e1eso23348157b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960195; x=1685552195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHz3gIMQ14LMAlJH3BHlupoStZ8/+BrUL09pT+1nDVs=;
        b=cL9ulyr1TZmloHcY9ZAQt2916/Hy8kFnLfCTiFsQOyXG21mKZDk2kVsVGS3swW/o9A
         lmsPI4V+ni8bJ2cDmSOvMhTe7jiZncm+a+dX+h32N0c6xUNbGxEO59xGx2raskwk+yE+
         EY40N2q/B5lxnqf+wqKkKUxKcIxmFMWDeQ/MPMZ5UoklVL3SBusyJB6cuGrGjrAev2jt
         I6daIpOCKx+oNZEO+zjvrtYAnmo4PPKmPdsrXndRo+l1Ieu4A+pt+fjUYtVugs+1Ncqh
         keNiqCygIJKFaCxV1denDbSpt/uk9T3I2i0PdEP0vYROV8UgAo/d+Ogm15HjT6dg+WeL
         DFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960195; x=1685552195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHz3gIMQ14LMAlJH3BHlupoStZ8/+BrUL09pT+1nDVs=;
        b=k+Bwwb+/S85EKC6d8S+Pkbofz0LqJGkuTAJ/qSI85U/tdq6Z+29x9kwPpvZiWUN+EQ
         Qvwnfigy3EoFQuKiCkjnd5jt2UbaW1CQnWzXzuWM8b5NCxiyyZVvzSr4RTdVXqJSMZzd
         XcIPVtn+qUUaJtOMlZUpWEUr37qrlKGig3NpkFdllJKYLmpHI3jzIEN9QdPouFu3L9Pi
         oAMZOXHTaDwaLKMI2fBoDyk4wXf7ITsXYOeZrQYJNMPkFz4qRLVhyzspuUWxeCb8MSxp
         l96BGLJAnQJ4BnlF5Kq/3kgWX1uNIBwZTpUHbgFIJjzD5ptZZQySk0R8eGvQplSN30GF
         1cTA==
X-Gm-Message-State: AC+VfDwnKiN7Ns8wWk4aqUE/w1gvf+ZO4FiZpEaGF5Um3S2/hDypd5GT
        KZTkezqW/N5EVdI9bOb44hEeQSjlnfs=
X-Google-Smtp-Source: ACHHUZ7qtjt6xJv0/W6KanE/G1kJWq4JffXkn4YmB84VAxkpL2X6o57PZ5XdLwRiQeUXxZyrcuCDjEjhXCs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:90a:5105:b0:244:9620:c114 with SMTP id
 t5-20020a17090a510500b002449620c114mr3673305pjh.1.1682960194723; Mon, 01 May
 2023 09:56:34 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:48 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-39-surenb@google.com>
Subject: [PATCH 38/40] codetag: debug: mark codetags for reserved pages as empty
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.
Maybe we can annotate reserved pages correctly and avoid this?

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..f5969cb85879 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -2920,6 +2921,13 @@ extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	union codetag_ref *ref;
+
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
-- 
2.40.1.495.gc816e09b53d-goog

