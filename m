Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD88B50AC74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442865AbiDUXwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442809AbiDUXvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AE8434B5;
        Thu, 21 Apr 2022 16:49:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ke5so2635997qvb.5;
        Thu, 21 Apr 2022 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gx/pEzK/Si3DJxK25M0+mRodztZR2hxnPp00eWVAa1k=;
        b=Md/LjYEF9f+pRuz8KZH8oR8ODzAl6LE1NdwDO9B7yhhTbHjC1XjY6StBiio3j2Nvo1
         JelKkMUZhH6wK9SIieCBlHRjkPiXecMX7lbXfg/XqFWogYyaitQ4MdWK8BXZq7mkhu1O
         OFnyhM+ibntll36tPPZSueMUXCwouOzvP6eHH1utH55G/gzIVvvomUfh32hDdsmMbf5j
         ior9XaGlQzyXxpuadInYd2sY51uzIco7yCLiu8jNyncc1IUMQD2y1/lU0BMZz4BOsCG/
         YfI4zjIBitflaOo7HONdKt45CVTiopIOyKsTTpjmD6y0c5WL8ulhg5/2E53m0J0N/wOI
         +Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gx/pEzK/Si3DJxK25M0+mRodztZR2hxnPp00eWVAa1k=;
        b=SpsmedleUlNsICzdnEvYumm35OBa5oSpxxBCG6LU4eWfN8S43dnrXBYaHIksYEMEsA
         /X4o6rdX2gPDDmnEoFDV0dBg+AdFSDXACyLFWI0N4F3Ox73rShQCBx+Er+9zsvAHsYfc
         A+aDTgqGeGLXVoM5MOizIeMvcBhcyrbstOX7fLPBIZAIb4JKLd6Mu/iaDyj4YeEXW+Vo
         KjK/q/NtODtV0opmODsmLBU3XIiXj28ZgSJQHYlurNfjaC1iJcPyy9ctcQVVrgvJLPr8
         dIKyNPUrdFtanfi5Fn7IxHoRkEwrJGuIg9f+oH/zz0MCAm5EyD+4FobyB8mDSnjYTth8
         6Xug==
X-Gm-Message-State: AOAM530a89CvO2mrP+SMOw2boDCMYmnTAIdImUV4P8GWf1ft5+Hx5lNR
        1LaPy1F+AxsoXyz/T7qaO2EhMUo3ytFZ
X-Google-Smtp-Source: ABdhPJy1nyPXDBoL0+vXyPBBH/+kX8pkeabBh3Ms+kkb3pWns3FlAR3mANJ7k+SatBCK1YhmRDDm8g==
X-Received: by 2002:a05:6214:262c:b0:446:3464:57cd with SMTP id gv12-20020a056214262c00b00446346457cdmr1758402qvb.89.1650584939257;
        Thu, 21 Apr 2022 16:48:59 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:58 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 5/8] mm: Add a .to_text() method for shrinkers
Date:   Thu, 21 Apr 2022 19:48:34 -0400
Message-Id: <20220421234837.3629927-11-kent.overstreet@gmail.com>
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

This adds a new callback method to shrinkers which they can use to
describe anything relevant to memory reclaim about their internal state,
for example object dirtyness.

This uses the new printbufs to output to heap allocated strings, so that
the .to_text() methods can be used both for messages logged to the
console, and also sysfs/debugfs.

This patch also adds shrinkers_to_text(), which reports on the top 10
shrinkers - by object count - in sorted order, to be used in OOM
reporting.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/shrinker.h |  5 +++
 mm/vmscan.c              | 78 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 76fbf92b04..b5f411768b 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_SHRINKER_H
 #define _LINUX_SHRINKER_H
 
+struct printbuf;
+
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
  * We consolidate the values for easier extension later.
@@ -58,10 +60,12 @@ struct shrink_control {
  * @flags determine the shrinker abilities, like numa awareness
  */
 struct shrinker {
+	char name[32];
 	unsigned long (*count_objects)(struct shrinker *,
 				       struct shrink_control *sc);
 	unsigned long (*scan_objects)(struct shrinker *,
 				      struct shrink_control *sc);
+	void (*to_text)(struct printbuf *, struct shrinker *);
 
 	long batch;	/* reclaim batch size, 0 = default */
 	int seeks;	/* seeks to recreate an obj */
@@ -94,4 +98,5 @@ extern int register_shrinker(struct shrinker *shrinker);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
+void shrinkers_to_text(struct printbuf *);
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b14e0d69..905bc23800 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -50,6 +50,7 @@
 #include <linux/printk.h>
 #include <linux/dax.h>
 #include <linux/psi.h>
+#include <linux/printbuf.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -702,6 +703,83 @@ void synchronize_shrinkers(void)
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
+void shrinker_to_text(struct printbuf *out, struct shrinker *shrinker)
+{
+	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+
+	if (shrinker->name[0])
+		pr_buf(out, "%s", shrinker->name);
+	else
+		pr_buf(out, "%ps:", shrinker->scan_objects);
+
+	pr_buf(out, " objects: %lu", shrinker->count_objects(shrinker, &sc));
+	pr_newline(out);
+
+	if (shrinker->to_text) {
+		pr_indent_push(out, 2);
+		shrinker->to_text(out, shrinker);
+		pr_indent_pop(out, 2);
+		pr_newline(out);
+	}
+}
+
+/**
+ * shrinkers_to_text - Report on shrinkers with highest usage
+ *
+ * This reports on the top 10 shrinkers, by object counts, in sorted order:
+ * intended to be used for OOM reporting.
+ */
+void shrinkers_to_text(struct printbuf *out)
+{
+	struct shrinker *shrinker;
+	struct shrinker_by_mem {
+		struct shrinker	*shrinker;
+		unsigned long	mem;
+	} shrinkers_by_mem[10];
+	int i, nr = 0;
+
+	if (!down_read_trylock(&shrinker_rwsem)) {
+		pr_buf(out, "(couldn't take shrinker lock)");
+		return;
+	}
+
+	list_for_each_entry(shrinker, &shrinker_list, list) {
+		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+		unsigned long mem = shrinker->count_objects(shrinker, &sc);
+
+		if (!mem || mem == SHRINK_STOP || mem == SHRINK_EMPTY)
+			continue;
+
+		for (i = 0; i < nr; i++)
+			if (mem < shrinkers_by_mem[i].mem)
+				break;
+
+		if (nr < ARRAY_SIZE(shrinkers_by_mem)) {
+			memmove(&shrinkers_by_mem[i + 1],
+				&shrinkers_by_mem[i],
+				sizeof(shrinkers_by_mem[0]) * (nr - i));
+			nr++;
+		} else if (i) {
+			i--;
+			memmove(&shrinkers_by_mem[0],
+				&shrinkers_by_mem[1],
+				sizeof(shrinkers_by_mem[0]) * i);
+		} else {
+			continue;
+		}
+
+		shrinkers_by_mem[i] = (struct shrinker_by_mem) {
+			.shrinker = shrinker,
+			.mem = mem,
+		};
+	}
+
+	for (i = nr - 1; i >= 0; --i)
+		shrinker_to_text(out, shrinkers_by_mem[i].shrinker);
+
+	up_read(&shrinker_rwsem);
+}
+
 #define SHRINK_BATCH 128
 
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-- 
2.35.2

