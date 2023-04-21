Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03816EB0C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjDURkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjDURkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:40:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AB125B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bb11770bso1473409a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098828; x=1684690828;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwYNf0IQKL13Uvalja3XtUe1fz98Sj9XyCNuQ2xKGcs=;
        b=Vz7q7OzmTKVhjKuL1Z10tx4sjzaZzQc1RfkV5JIKDa4QF+qc7PE1nRpKj4JbTW26CL
         6HWg0Bk/Qn7IeGOg2v+aAU068B55qLODSnp8tJGuESSICbp+6Gjpfa3HASvT4P/INIIX
         FNJAyhgiBW8P7szSQRrC+9yXtrHR4LwEf5c+uGkIF6nWGq5t81yHqYblmUSNV6/Pj4a5
         x4hPCDxoK7EryyUSzUifkrvbv6JClx5/LSyTe0bPdsXuYCvvh5cuu7sfplfgaUZyWnve
         cPw/375qmd31nmxG3Xi1PRi7CTxei8qHjgER9ienP6JVZlSSk1rMC1yFsifBD6+eDFuk
         /A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098828; x=1684690828;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwYNf0IQKL13Uvalja3XtUe1fz98Sj9XyCNuQ2xKGcs=;
        b=PHHlqUuw0L8wGeyfUfKhIRpCy61Vk3YUc0zCG+n+zsehT1MYCNI1zOJBPwsgY92WSz
         XEaGKoHh72wWghldroNfsr7MkxE8e9TJsrDlJvVLt5hKrB6gkUQr62ebeG+pS8YFIDep
         OVTOPzUqZc0rv+b5vu3NpDX+Zx5gV++OHLjsRaMJYG97M+5KOJ1/LRzQB1o/MqDV3O6x
         wcwhwqaBqt6ylhswkjsOc0PTkqz/a4GBvlqG3tytysZ3IMd5gn37ySxUzMEk0W5x6ABR
         ddoj3fughUeo2figOdhIMNha7cNqRL0jjHEyKbjuq2Dk0ro6Q2JErHbef8Zzb9tCiezk
         h9Uw==
X-Gm-Message-State: AAQBX9cEDirGIQ96KQnyYd5UMjKIDLEQCtQy51U/ivabpnBLJDXiNUHq
        /e7Y33CXczyd3Dx6x8+wdEmwm3CLUwH1lWkI
X-Google-Smtp-Source: AKy350aINzx6WzxMD77WpFdXBe8LNCyI2424id24uJ5dWpjeDUwupScbzRciRo/Uc9LOO+muamaNQYT7/vZDgFTY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:2447:b0:1a9:2c3e:b087 with SMTP
 id l7-20020a170903244700b001a92c3eb087mr1970101pls.0.1682098828387; Fri, 21
 Apr 2023 10:40:28 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:18 +0000
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-4-yosryahmed@google.com>
Subject: [PATCH v5 3/5] memcg: calculate root usage from global state
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, we approximate the root usage by adding the memcg stats for
anon, file, and conditionally swap (for memsw). To read the memcg stats
we need to invoke an rstat flush. rstat flushes can be expensive, they
scale with the number of cpus and cgroups on the system.

mem_cgroup_usage() is called by memcg_events()->mem_cgroup_threshold()
with irqs disabled, so such an expensive operation with irqs disabled
can cause problems.

Instead, approximate the root usage from global state. This is not 100%
accurate, but the root usage has always been ill-defined anyway.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e79fdf8442b..cb78bba5b4a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3699,27 +3699,13 @@ static unsigned long mem_cgroup_usage(struct mem_cg=
roup *memcg, bool swap)
=20
 	if (mem_cgroup_is_root(memcg)) {
 		/*
-		 * We can reach here from irq context through:
-		 * uncharge_batch()
-		 * |--memcg_check_events()
-		 *    |--mem_cgroup_threshold()
-		 *       |--__mem_cgroup_threshold()
-		 *          |--mem_cgroup_usage
-		 *
-		 * rstat flushing is an expensive operation that should not be
-		 * done from irq context; use stale stats in this case.
-		 * Arguably, usage threshold events are not reliable on the root
-		 * memcg anyway since its usage is ill-defined.
-		 *
-		 * Additionally, other call paths through memcg_check_events()
-		 * disable irqs, so make sure we are flushing stats atomically.
+		 * Approximate root's usage from global state. This isn't
+		 * perfect, but the root usage was always an approximation.
 		 */
-		if (in_task())
-			mem_cgroup_flush_stats_atomic();
-		val =3D memcg_page_state(memcg, NR_FILE_PAGES) +
-			memcg_page_state(memcg, NR_ANON_MAPPED);
+		val =3D global_node_page_state(NR_FILE_PAGES) +
+			global_node_page_state(NR_ANON_MAPPED);
 		if (swap)
-			val +=3D memcg_page_state(memcg, MEMCG_SWAP);
+			val +=3D total_swap_pages - get_nr_swap_pages();
 	} else {
 		if (!swap)
 			val =3D page_counter_read(&memcg->memory);
--=20
2.40.0.634.g4ca3ef3211-goog

