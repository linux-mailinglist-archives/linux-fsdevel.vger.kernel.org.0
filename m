Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AE50AC80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442857AbiDUXxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442779AbiDUXwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:52:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C047385;
        Thu, 21 Apr 2022 16:49:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id n11so4906889qvl.0;
        Thu, 21 Apr 2022 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeM5bqJiQrm2rh3JILkdt+BZf3iQXt3DndJ5kJUH6VM=;
        b=n/KPNGWJXcs0GJJTYwzELGdDRU26YZeN+AFBdrfivcUmDTFgoEKIyrauqulst14dH0
         VIawqwx2mO79s0OxciEEIzbn1FvG1bH8bG3uS1fw7LT5ALzrMm7yM+uw93vItLfT2nW0
         6vW0ixWFbUjKGZzE54v1t/I3Bb56898l1K1XBAcQabLQzanStxI9UkxPRziU7gkhloaO
         BPYvgr1vJyyfoY4JXraylWH6PYW9y9v+u6E5dvL1U4gTfbVtPd5b01hz0ZuIgSBkAYal
         2vHqlPuenxkKGGJ237DRh/3jonP/A8fdnfy/nV7yUnNdSgA4uOcGoslhIzZ4kevfjAKu
         LBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FeM5bqJiQrm2rh3JILkdt+BZf3iQXt3DndJ5kJUH6VM=;
        b=nOAPxG8xFKfc88RtTdPQ1SPFgF2adwipG9fL2+cI3+G2jrJ5mLdFyvE5GdxI62CAyD
         ldLwHngqJUTsDDh8otfdcKrIH6tphDBANDtcgpVNLLaTaMkmC7cbP+3etELttkaQ5/Iz
         8E9m2u0f11rn7hZFaIh8xdZG3g2ONbcVizl3vc1UnzhFTew/QH9g22ylLG7VQyxSYsWu
         s3/wuxoNZk5R1+/9y3rXySVq4HAP+ig0MxmsAXS91/S8vSl3Ny4/i57/9gW6hdkZT1Pd
         D8kYxwQCwrewL0pIl1nH7g29LHXkMXGcdcDMWUIBZ0fZkossO3sH74G77eq8AwLYL5lu
         3uKg==
X-Gm-Message-State: AOAM530EKcXeKhcShHjP2rVI9zKP+uEYnwlc1kPd9qDWo6YQ5CsZDqUJ
        qgarRLmTkHoYPGIf9GesEzJI0neeXczI
X-Google-Smtp-Source: ABdhPJwIwwSIi9BX9ueYR8W3xLzPDKzGU08fb3TSCEvxc7eNfeoVsUdKsvEsHwvgXeKxMCM8QFg4Jg==
X-Received: by 2002:a05:6214:3006:b0:444:2fa9:9849 with SMTP id ke6-20020a056214300600b004442fa99849mr1462717qvb.101.1650584940771;
        Thu, 21 Apr 2022 16:49:00 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:49:00 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 6/8] mm: Count requests to free & nr freed per shrinker
Date:   Thu, 21 Apr 2022 19:48:35 -0400
Message-Id: <20220421234837.3629927-12-kent.overstreet@gmail.com>
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

The next step in this patch series for improving debugging of shrinker
related issues: keep counts of number of objects we request to free vs.
actually freed, and prints them in shrinker_to_text().

Shrinkers won't necessarily free all objects requested for a variety of
reasons, but if the two counts are wildly different something is likely
amiss.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/shrinker.h |  3 +++
 mm/vmscan.c              | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index b5f411768b..12967748f9 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -79,6 +79,9 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+
+	atomic_long_t objects_requested_to_free;
+	atomic_long_t objects_freed;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 905bc23800..12562546a7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -711,16 +711,22 @@ void shrinker_to_text(struct printbuf *out, struct shrinker *shrinker)
 		pr_buf(out, "%s", shrinker->name);
 	else
 		pr_buf(out, "%ps:", shrinker->scan_objects);
+	pr_newline(out);
+	pr_indent_push(out, 2);
 
-	pr_buf(out, " objects: %lu", shrinker->count_objects(shrinker, &sc));
+	pr_buf(out, "objects:           %lu", shrinker->count_objects(shrinker, &sc));
+	pr_newline(out);
+	pr_buf(out, "requested to free: %lu", atomic_long_read(&shrinker->objects_requested_to_free));
+	pr_newline(out);
+	pr_buf(out, "objects freed:     %lu", atomic_long_read(&shrinker->objects_freed));
 	pr_newline(out);
 
 	if (shrinker->to_text) {
-		pr_indent_push(out, 2);
 		shrinker->to_text(out, shrinker);
-		pr_indent_pop(out, 2);
 		pr_newline(out);
 	}
+
+	pr_indent_pop(out, 2);
 }
 
 /**
@@ -846,12 +852,16 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		unsigned long ret;
 		unsigned long nr_to_scan = min(batch_size, total_scan);
 
+		atomic_long_add(nr_to_scan, &shrinker->objects_requested_to_free);
+
 		shrinkctl->nr_to_scan = nr_to_scan;
 		shrinkctl->nr_scanned = nr_to_scan;
 		ret = shrinker->scan_objects(shrinker, shrinkctl);
 		if (ret == SHRINK_STOP)
 			break;
+
 		freed += ret;
+		atomic_long_add(ret, &shrinker->objects_freed);
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
 		total_scan -= shrinkctl->nr_scanned;
-- 
2.35.2

