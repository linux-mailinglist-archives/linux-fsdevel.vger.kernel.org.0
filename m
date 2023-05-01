Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E86F34BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjEARDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjEARB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:01:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112219BE
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:57:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559deafac49so47807047b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960190; x=1685552190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2YZ+zSEbu/k1s4F5etygangPIkg0EznnOkCCfoew4=;
        b=y9PADbKNRkycgFljwwW4rqucG3eA68YCKeeZo3WcsU1FmoEQqcIFYkjuX0vuBDZ+Ql
         NTwaESSbp1RZc7LHc0KY8IZ9ABdUTaz7iD+fqU6hTkv+OjleRGkRYXEn3mmMGDZeb37K
         RR5c6bta6TNyvXnvanAVd7N5usS73yNUZBprdVddhAocVImGlGKImrhAPkg7FdlsDO1g
         0/gV7SzEHyQ+UDygmg90PVZ1tDJNusamWgID4ov2qqJT8Mlk7B+3jkcThGeG+RtvCTCf
         JdDB5SJtODP6opHYk8cvNwCb/U4pdSF9HDKWf6Vbz1ntZy0fwly+Flt/OMhilMEsPt5F
         Cb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960190; x=1685552190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2YZ+zSEbu/k1s4F5etygangPIkg0EznnOkCCfoew4=;
        b=FEaGlW+chVURvSwHFqyN6EqsGJ8RA+w9R/NzwSslvLaLTJDy+UWYACo3OMSLwr3PwS
         +XrfLVk6+bT1KUjlQ6aJSnOog4FerGKT9dOhwdJTDQKpW6IubXLC9iAtBgiY+2mzq8GD
         5MPK2aCN79hSsHeKRsMZcn4nVuGhUabvSneyqPUVPPVWzJXwf6thV8QWSwEz1wOWraH/
         sAc9y9cKquPja/YZHNFo3zJq00vi5Rrbm+luogTDPXbzQFerS0AjImCo/I28Z2/myZ7t
         qrrczU+A/Qb8tmHaX4msoVR16rg6EvaV6NNe0utGkFNrhdw6RcRWB8hozNT5Dq6JpIeA
         meug==
X-Gm-Message-State: AC+VfDyMLi/LKFcBse0sqLTeB5VQ1WuB7qnvDmVqNfls4UycQS2BeJRS
        U0siqZrkB4hfiyG79m0LqJFhh/OFDuk=
X-Google-Smtp-Source: ACHHUZ4bAJGviPj6gi0jXXmQNcf1vAdyBJ0X5d7ddmrZp75YBKgThQIRi2xp+pDFZfbHaui7RkEBtZ2XytA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:a8c4:0:b0:54d:3afc:d503 with SMTP id
 f187-20020a81a8c4000000b0054d3afcd503mr8631819ywh.8.1682960190091; Mon, 01
 May 2023 09:56:30 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:46 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-37-surenb@google.com>
Subject: [PATCH 36/40] lib: add memory allocations report in show_mem()
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

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h |  2 ++
 lib/alloc_tag.c           | 48 +++++++++++++++++++++++++++++++++++----
 lib/show_mem.c            | 15 ++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 2a3d248aae10..190ab793f7e5 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -23,6 +23,8 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+void alloc_tags_show_mem_report(struct seq_buf *s);
+
 static inline struct alloc_tag *ctc_to_alloc_tag(struct codetag_with_ctx *ctc)
 {
 	return container_of(ctc, struct alloc_tag, ctc);
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 675c7a08e38b..e2ebab8999a9 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -13,6 +13,8 @@
 
 #define STACK_BUF_SIZE 1024
 
+static struct codetag_type *alloc_tag_cttype;
+
 DEFINE_STATIC_KEY_TRUE(mem_alloc_profiling_key);
 
 /*
@@ -133,6 +135,43 @@ static ssize_t allocations_file_read(struct file *file, char __user *ubuf,
 	return err ? : buf.ret;
 }
 
+void alloc_tags_show_mem_report(struct seq_buf *s)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct {
+		struct codetag		*tag;
+		size_t			bytes;
+	} tags[10], n;
+	unsigned int i, nr = 0;
+
+	codetag_init_iter(&iter, alloc_tag_cttype);
+
+	codetag_lock_module_list(alloc_tag_cttype, true);
+	while ((ct = codetag_next_ct(&iter))) {
+		n.tag	= ct;
+		n.bytes = lazy_percpu_counter_read(&ct_to_alloc_tag(ct)->bytes_allocated);
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < ARRAY_SIZE(tags)) {
+			nr -= nr == ARRAY_SIZE(tags);
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	for (i = 0; i < nr; i++)
+		alloc_tag_to_text(s, tags[i].tag);
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+}
+
 static const struct file_operations allocations_file_ops = {
 	.owner	= THIS_MODULE,
 	.open	= allocations_file_open,
@@ -409,7 +448,6 @@ EXPORT_SYMBOL(page_alloc_tagging_ops);
 
 static int __init alloc_tag_init(void)
 {
-	struct codetag_type *cttype;
 	const struct codetag_type_desc desc = {
 		.section	= "alloc_tags",
 		.tag_size	= sizeof(struct alloc_tag),
@@ -417,10 +455,10 @@ static int __init alloc_tag_init(void)
 		.free_ctx	= alloc_tag_ops_free_ctx,
 	};
 
-	cttype = codetag_register_type(&desc);
-	if (IS_ERR_OR_NULL(cttype))
-		return PTR_ERR(cttype);
+	alloc_tag_cttype = codetag_register_type(&desc);
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return PTR_ERR(alloc_tag_cttype);
 
-	return dbgfs_init(cttype);
+	return dbgfs_init(alloc_tag_cttype);
 }
 module_init(alloc_tag_init);
diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1485c87be935..5c82f29168e3 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -7,6 +7,7 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#include <linux/seq_buf.h>
 
 void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
@@ -34,4 +35,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct seq_buf s;
+		char *buf = kmalloc(4096, GFP_ATOMIC);
+
+		if (buf) {
+			printk("Memory allocations:\n");
+			seq_buf_init(&s, buf, 4096);
+			alloc_tags_show_mem_report(&s);
+			printk("%s", buf);
+			kfree(buf);
+		}
+	}
+#endif
 }
-- 
2.40.1.495.gc816e09b53d-goog

