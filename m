Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319D850AC68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442844AbiDUXwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442779AbiDUXvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7565C42A1E;
        Thu, 21 Apr 2022 16:48:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so4753186qkp.9;
        Thu, 21 Apr 2022 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+6QqEX2/fgk530CjQfyw22ixS6gH/22/NxatjEsE7U=;
        b=Piq4cGEnKIYkeK5yEy1v2UexgRA+klnfryaBWZhkBupuYhBIN2XFcsCr/AaH52FE8d
         0JEeXqf4Zq7HsG13fmFy4/2mFPqqz7rKZatDWMCYVdnRBHgG6rgfOgrOQHT/GVvIvdUf
         wsU28fJ4WSETTWK8Qg0O8saCEIIie3SaDaIHYbYAvz6DgcuMPQ3p71RE6tc8leNehciN
         mRO85fjyes4oVWSJFVlSIAnLK9flxPklVtPhoULVPgaguai70ROKTnCM/ymp+zIfWIfT
         Sc7Bv4DgOO1Af7Llus43kg4AUlS9Uw0odTji6nK7vtAut6O7Z76r0LJ651UVN/paMo0b
         1RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+6QqEX2/fgk530CjQfyw22ixS6gH/22/NxatjEsE7U=;
        b=XvSzxHpmnPiz/Izt/odwH9KfS3YkciS4zNMkBwnZbuDiIRnAR1PYNW6Mf5fc4ugGhF
         JoXZnH4hepo+QMH9ff3wGfAjXiqT/738VEv/tU7NZsKUD+lMdBASReMwzGkpm+0tRToB
         EPQo1cTU3HWkYh/mYY9ladEjC154WMe/DkZJ99QrANLWHlpuGJVp1MCSE+usjnhyAVs6
         hLwXmU+wJhXkJin1Tk3GGyZtaWywKr3PYuKhEHkY62ohc8eq1wxBqucMO4YREPUz9tX+
         GgT4HDLUkokx9bWkop1lAoKiy+c9N8S32qn6z6GSqOHOKCOPTGLEQGVyWKUbji+oWjfq
         wDfw==
X-Gm-Message-State: AOAM530JBgetKWHO3h31512mhXQNTZ+Xos53qDE13svUtiLis5oGQT7Y
        /R+TJKBxhLvSFgn4g0OcY98gZiMDkaqk
X-Google-Smtp-Source: ABdhPJxpYT8g1HdDWANIVxroce92VLtnIjLTEtakAXl78RZEeLWPyMTLx9X4IHkCH/A+O9FtQPwCpQ==
X-Received: by 2002:a05:620a:17a0:b0:69e:e769:48fd with SMTP id ay32-20020a05620a17a000b0069ee76948fdmr1213264qkb.382.1650584936061;
        Thu, 21 Apr 2022 16:48:56 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:55 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 3/8] mm/memcontrol.c: Convert to printbuf
Date:   Thu, 21 Apr 2022 19:48:32 -0400
Message-Id: <20220421234837.3629927-9-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
simalar to seq_buf except that it heap allocates the string buffer:
here, we were already heap allocating the buffer with kmalloc() so the
conversion is trivial.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/memcontrol.c | 68 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 36e9f38c91..4cb0b7bc1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -61,7 +61,7 @@
 #include <linux/file.h>
 #include <linux/tracehook.h>
 #include <linux/psi.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -1436,13 +1436,9 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF;
 	int i;
 
-	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
-	if (!s.buffer)
-		return NULL;
-
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -1459,49 +1455,51 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		pr_buf(&buf, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			pr_buf(&buf, "slab %llu\n", size);
 		}
 	}
 
 	/* Accumulated memory events */
 
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
-		       memcg_events(memcg, PGFAULT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
-		       memcg_events(memcg, PGMAJFAULT));
-	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
-		       memcg_events(memcg, PGREFILL));
-	seq_buf_printf(&s, "pgscan %lu\n",
-		       memcg_events(memcg, PGSCAN_KSWAPD) +
-		       memcg_events(memcg, PGSCAN_DIRECT));
-	seq_buf_printf(&s, "pgsteal %lu\n",
-		       memcg_events(memcg, PGSTEAL_KSWAPD) +
-		       memcg_events(memcg, PGSTEAL_DIRECT));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
-		       memcg_events(memcg, PGACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
-		       memcg_events(memcg, PGDEACTIVATE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
-		       memcg_events(memcg, PGLAZYFREE));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
-		       memcg_events(memcg, PGLAZYFREED));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGFAULT),
+	       memcg_events(memcg, PGFAULT));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGMAJFAULT),
+	       memcg_events(memcg, PGMAJFAULT));
+	pr_buf(&buf, "%s %lu\n",  vm_event_name(PGREFILL),
+	       memcg_events(memcg, PGREFILL));
+	pr_buf(&buf, "pgscan %lu\n",
+	       memcg_events(memcg, PGSCAN_KSWAPD) +
+	       memcg_events(memcg, PGSCAN_DIRECT));
+	pr_buf(&buf, "pgsteal %lu\n",
+	       memcg_events(memcg, PGSTEAL_KSWAPD) +
+	       memcg_events(memcg, PGSTEAL_DIRECT));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGACTIVATE),
+	       memcg_events(memcg, PGACTIVATE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGDEACTIVATE),
+	       memcg_events(memcg, PGDEACTIVATE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREE),
+	       memcg_events(memcg, PGLAZYFREE));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREED),
+	       memcg_events(memcg, PGLAZYFREED));
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
-		       memcg_events(memcg, THP_FAULT_ALLOC));
-	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
-		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
+	       memcg_events(memcg, THP_FAULT_ALLOC));
+	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
+	       memcg_events(memcg, THP_COLLAPSE_ALLOC));
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	if (buf.allocation_failure) {
+		printbuf_exit(&buf);
+		return NULL;
+	}
 
-	return s.buffer;
+	return buf.buf;
 }
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
-- 
2.35.2

