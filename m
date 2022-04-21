Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4450AC88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442922AbiDUXxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442855AbiDUXwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:52:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76347541;
        Thu, 21 Apr 2022 16:49:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b68so4762799qkc.4;
        Thu, 21 Apr 2022 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX+ZZxfUCa6AeznhtMYBa3lbAYkGql05KEYmpApGJvc=;
        b=fWoFdNFoTzuTeyd37gJBh3UEJqZnL5c7olLDqlVchiUDB4EfzgpzArPgDksaoxFYSV
         lFcwfvuY2O4d+01Q5Zj7FApRfnsx10MrvqIQjieDrYqKS8oTMogkpDCLe6b+tIvGeoDg
         oZ25deodeMYYdcb4msCQZ95tNwqLOpZL1GqFWlCJbzyzHA0RXWkB1OWPmvNGxWqOFk0Z
         NMobe8u2+R7aXU1cBxhn6C/5a3nl/GRTkhDG3IY39MAnvrmCeWGVgd8OH0FEk9JXcTV+
         sT/ZRPNX+2nh2YnvFSNMks5fpzsFDvBjYXVsugVKFszq5lRjdggcfrPmLI1vTlpoRedw
         R7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX+ZZxfUCa6AeznhtMYBa3lbAYkGql05KEYmpApGJvc=;
        b=nMilll6iPLoM+F+QT3W8u2m/mt9pOQQ+r+uClq6+uxtqAsTZHZsi3mubEJq80i/3rW
         92p/R1IxcuNU3NOxPJLFta3QIlZ5FXa0+yW9lfj6Pob7UadwO6veTKjz0ESnboTA7oRz
         K0cUUazZ8jEAPuMiFqwFwqqtypPDCZAQKFE0Cw+9MRC+5qqAvgESV3rO0OV02zyOvuVf
         7OYo3zvhSr2/j7rgAYhCxzohUrpuXhTXzyTuX2Ph8kw6T3R5VPZ2wcv6xQsTAflE4TDY
         s8pPm0unxCaDvIbQEfpW3qZUrtFlhT8f6+rpoPf4umy2GChXQmnUJm6a1IUuHv/IZR8W
         VYvg==
X-Gm-Message-State: AOAM532Kk/qKbRjROAObwT3eLJ8R7VN8CV0T+ouaAkDKc3i6ZMwyJzMM
        rpseF8w2ZwpqEb4uiWXBlsUPfsyodICm
X-Google-Smtp-Source: ABdhPJy4AfRMSM5fE/ShUTn41jLAMSbQ5zXgowJp+WmfgN33q5UIkYcEB9ug5C7qJVU5PFjSL7Hzbg==
X-Received: by 2002:a05:620a:2805:b0:67d:5c7e:c43a with SMTP id f5-20020a05620a280500b0067d5c7ec43amr1216746qkp.84.1650584942298;
        Thu, 21 Apr 2022 16:49:02 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:49:01 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 7/8] mm: Move lib/show_mem.c to mm/
Date:   Thu, 21 Apr 2022 19:48:36 -0400
Message-Id: <20220421234837.3629927-13-kent.overstreet@gmail.com>
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

show_mem.c is really mm specific, and the next patch in the series is
going to require mm/slab.h, so let's move it before doing more work on
it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 lib/Makefile           | 2 +-
 mm/Makefile            | 2 +-
 {lib => mm}/show_mem.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {lib => mm}/show_mem.c (100%)

diff --git a/lib/Makefile b/lib/Makefile
index 31a3904eda..c5041d33d0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -30,7 +30,7 @@ endif
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
-	 flex_proportions.o ratelimit.o show_mem.o \
+	 flex_proportions.o ratelimit.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
diff --git a/mm/Makefile b/mm/Makefile
index 70d4309c9c..97c0be12f3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o show_mem.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/lib/show_mem.c b/mm/show_mem.c
similarity index 100%
rename from lib/show_mem.c
rename to mm/show_mem.c
-- 
2.35.2

