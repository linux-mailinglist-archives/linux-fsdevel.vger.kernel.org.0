Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963C50AC7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442188AbiDUXxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442776AbiDUXvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B2434A5;
        Thu, 21 Apr 2022 16:48:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id hu11so4859464qvb.7;
        Thu, 21 Apr 2022 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PF/Z8BQ8fxOBlrER2fv/400ai3CQSf3kzChsoC/3ncM=;
        b=Fmg9GchsDQjutgHrWM/IG+EZhv+HiZ+dEvnMEDFKb+T+r+Q/Xm1YYliGP71kb6HN+W
         GLqoDr61dXwsDzPdRECJYcQarmk+T6H4rug3ZFdmtLaQYy7lzYaMsCU6dX3rUj64pGr7
         difeOIk+oQYdWGlmXufNianxRUrB5l5qg89ze9Jteco8L9yFCLmSBz6753W5U7GVkTFf
         KV2WBL3T5cbnVEjKBJAhLxSEDGc8wbP1WK3nKE6ceGRyVxh4RU72LEeojkTBoTQAuVll
         0zLDqezyxdzSEYDpBh/5eBMG/x+TQe220iuYVtOgctc18dzhEdeyciNQwMdPaIo0yI2x
         DdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PF/Z8BQ8fxOBlrER2fv/400ai3CQSf3kzChsoC/3ncM=;
        b=P6i+gA/DsL+XmEyamtFY0jBIIrN9d/kl+qiz2uyV9VCwfCe/xNOeG8YgU4n4nTf1Xa
         JRbxqcuLGqAC1wIrNEU+SW7KmBimKFoCxbCBN37paIJoDmsA3SskzygGTRIxSoT7tQQm
         6serWAq3j8c6aCID7x8cr//OLzx88IImOnckVMlkc1dTD6caljaX3GgHK0hcVpcX/A6R
         xi/Oa4jekRBgIRvbpFFrmB4RY3bleooJAlY9HWbW5hMJdhvI8zNONzHfXULKKrRzqa3p
         D55xzESMxviBxVBNZ3hil/UmnjfejmeG709wyVbzB2c+XZYHvSZWDQRmnZMy1s9fSHh8
         vOsA==
X-Gm-Message-State: AOAM533GR4sKfLgLxU1pZavK/8APAiGi3ROe6u2cggbwrJsDdHcmxsPz
        Jz9qjlWVBMrn0OGPai209rZdhviLkHGb
X-Google-Smtp-Source: ABdhPJwDhIK3eHTLsewAwF5FpbZ4NbS8mVZfkNqfhh2q7YLtu3tIrgjsNLqW2nO1uAxRcg8T77R/yw==
X-Received: by 2002:ad4:5caa:0:b0:446:54ef:60d4 with SMTP id q10-20020ad45caa000000b0044654ef60d4mr1790926qvh.86.1650584937815;
        Thu, 21 Apr 2022 16:48:57 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:56 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 4/8] clk: tegra: bpmp: Convert to printbuf
Date:   Thu, 21 Apr 2022 19:48:33 -0400
Message-Id: <20220421234837.3629927-10-kent.overstreet@gmail.com>
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

This converts from seq_buf to printbuf, which is similar but heap
allocates the string buffer.

Previously in this code the string buffer was allocated on the stack;
this means we've added a new potential memory allocation failure. This
is fine though since it's only for a dev_printk() message.

Memory allocation context: printbuf doesn't take gfp flags, instead we
prefer the new memalloc_no*_(save|restore) interfaces to be used. Here
the surrounding code is already allocating with GFP_KERNEL, so
everything is fine.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/clk/tegra/clk-bpmp.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 6ecf18f71c..77a8c47806 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -5,7 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/device.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/slab.h>
 
 #include <soc/tegra/bpmp.h>
@@ -360,39 +360,38 @@ static void tegra_bpmp_clk_info_dump(struct tegra_bpmp *bpmp,
 				     const struct tegra_bpmp_clk_info *info)
 {
 	const char *prefix = "";
-	struct seq_buf buf;
+	struct printbuf buf = PRINTBUF;
 	unsigned int i;
-	char flags[64];
-
-	seq_buf_init(&buf, flags, sizeof(flags));
 
 	if (info->flags)
-		seq_buf_printf(&buf, "(");
+		pr_buf(&buf, "(");
 
 	if (info->flags & TEGRA_BPMP_CLK_HAS_MUX) {
-		seq_buf_printf(&buf, "%smux", prefix);
+		pr_buf(&buf, "%smux", prefix);
 		prefix = ", ";
 	}
 
 	if ((info->flags & TEGRA_BPMP_CLK_HAS_SET_RATE) == 0) {
-		seq_buf_printf(&buf, "%sfixed", prefix);
+		pr_buf(&buf, "%sfixed", prefix);
 		prefix = ", ";
 	}
 
 	if (info->flags & TEGRA_BPMP_CLK_IS_ROOT) {
-		seq_buf_printf(&buf, "%sroot", prefix);
+		pr_buf(&buf, "%sroot", prefix);
 		prefix = ", ";
 	}
 
 	if (info->flags)
-		seq_buf_printf(&buf, ")");
+		pr_buf(&buf, ")");
 
 	dev_printk(level, bpmp->dev, "%03u: %s\n", info->id, info->name);
-	dev_printk(level, bpmp->dev, "  flags: %lx %s\n", info->flags, flags);
+	dev_printk(level, bpmp->dev, "  flags: %lx %s\n", info->flags, printbuf_str(&buf));
 	dev_printk(level, bpmp->dev, "  parents: %u\n", info->num_parents);
 
 	for (i = 0; i < info->num_parents; i++)
 		dev_printk(level, bpmp->dev, "    %03u\n", info->parents[i]);
+
+	printbuf_exit(&buf);
 }
 
 static int tegra_bpmp_probe_clocks(struct tegra_bpmp *bpmp,
-- 
2.35.2

