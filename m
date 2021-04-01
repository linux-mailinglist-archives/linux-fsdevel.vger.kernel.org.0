Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236E7352286
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbhDAWNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbhDAWNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:13:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D75C0613A8
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 15:13:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w8so1847332pjf.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gl97oxPIVXZYcwzInna88mJV+71EBUvsRwHZJgUDTHE=;
        b=cjEHKO3ZTN3Ma1U7kUNTQIY3BEyXWR5Oiq3b1Ab399l4RaoR1D9Xfj7jh6gn8uHBc5
         QKViE6iqhBpPP2P5EXXz7dFbfY3p8MmA7Jm5AlM8/D9y/MsBQcFarAjVOYPx0vfWbuj1
         wk6jz/SWx7LmdwRz1IcgUz/6sRonpSFR7ttts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gl97oxPIVXZYcwzInna88mJV+71EBUvsRwHZJgUDTHE=;
        b=mLkhBwO6R/aESSJxy5bmnlL11EZo8R5UnNMKRZW+KmOIqRSSeaajkymLiXLgne4UFq
         qA+UkscfQwN9f7J0XbGYOCi8f/PfuUIfaJ+zuAeddkXt9EmIx5uBsJsGQncjbKZWVDYM
         83njBo1eButSw8qt70apRnXqJX9ngG3y1vnjuiCldR06VAoGzcVhFUuioMd3CRhHZITC
         fDkDE6a22GHRMSkKNPmi203Kjji+JE/0xU/RsQqW8Mcgr+p43psruiMZ47ojgM8AV+Cc
         2Dmr4s8DibyNem7n52Wr0eA0x/WXxRriZUkjvuPL41npkkpuTQc8q5dqtihdZ/Gri+EU
         khPw==
X-Gm-Message-State: AOAM530GIXksb6SJT641pltwnyYcS13zLCBEi9f/jS6C5CGJVD3MTIyj
        +6ZTERA7ZqhYyuFfVXG3vsR//g==
X-Google-Smtp-Source: ABdhPJy9ADuU0excc/0DZGu3CanfDu/XK6zyd+laHOepTuQ25LQdKdnPsZqD7XioexndWEgyKYLoXw==
X-Received: by 2002:a17:902:8f8d:b029:e7:4a2f:1950 with SMTP id z13-20020a1709028f8db02900e74a2f1950mr9634785plo.77.1617315209867;
        Thu, 01 Apr 2021 15:13:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y68sm7022290pgy.5.2021.04.01.15.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:13:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v4 1/3] lkdtm/heap: Add vmalloc linear overflow test
Date:   Thu,  1 Apr 2021 15:13:18 -0700
Message-Id: <20210401221320.2717732-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401221320.2717732-1-keescook@chromium.org>
References: <20210401221320.2717732-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=970fea1dfc54675cf92960ed316cdea27f2a2b55; i=zAev4cjW2dHa2AXn2sZrbiZj58xWVMf9s1WNriwUPTo=; m=qJGeBnIdFmEfwvhoT9HcMsaZ+R0eVHz0QfuZfXAAVFA=; p=jblLmhd9kg9taPt5qJwEBeZbhf2U5OVB9wDFfWdvEwc=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBmRX4ACgkQiXL039xtwCZE+hAAnIT uar89s8tk5F3KllVHos+dD9cu+MxDd8FCSDc61glKeq3AnFikTxoWcqrMRrZ/9bWse2ECMyXcUr2G ysUtjKS1/0RP3B2HvYQGOIaO/wQlNkz+55Tmpg/LjiUClRc1uHo27W/0Eo+MeSq54RpUE068a/df/ KIfZpK5b2kv9CZaIk75ZoMiaZ7v+gXmHhijoDN1CrE0K9OfopKWNCLA3f1bkPoStdaA+NHn6PK9Mo mYXcaOEMWLEtcte1ycFNdGEbsSt5O0uMsWUJRI5/fH6NDdWAReHY4CVTImbMDE7S3a+WkYU/nl5wk //eufaod6uCp7vYgXHvnI1DvVOpP7S7uzvDjvx4rL7r7aAWU3vPdbdntw6NXEchs8JnjAZ4BTLXz4 rEC6x4CcxYx6qoT9wgAgHTWSfhMsjCI13Crr4RLZzGLw9oToL60IEoS/2mlwG/+8DgJpKpdwbZqS4 Ka1j23mSyZksyTlOHM6HifEw1QX9rlB41FXJsVAjQIL/lyx/YAW/sUDccJKR3wqmZuesnTD+RbFZ0 4hlR0Q3INkv8RBBg/+lPd8hb9QwftkOxkGMQV0xqsYC81lN3IS+kAxNdgurRWeQzsOTMML37DD60G P9zP81gb39t43FvyY/LDuT2RKBAHd3ffyG2pbPP3v95Y1LhDRICP60gpJ/j+FQ6I=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to the existing slab overflow and stack exhaustion tests, add
VMALLOC_LINEAR_OVERFLOW (and rename the slab test SLAB_LINEAR_OVERFLOW).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/core.c               |  3 ++-
 drivers/misc/lkdtm/heap.c               | 21 ++++++++++++++++++++-
 drivers/misc/lkdtm/lkdtm.h              |  3 ++-
 tools/testing/selftests/lkdtm/tests.txt |  3 ++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d87c01..c3a5ad21b3d2 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -119,7 +119,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
 	CRASHTYPE(FORTIFY_OBJECT),
 	CRASHTYPE(FORTIFY_SUBOBJECT),
-	CRASHTYPE(OVERWRITE_ALLOCATION),
+	CRASHTYPE(SLAB_LINEAR_OVERFLOW),
+	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
 	CRASHTYPE(WRITE_AFTER_FREE),
 	CRASHTYPE(READ_AFTER_FREE),
 	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 1323bc16f113..5d491c22e09a 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -5,18 +5,37 @@
  */
 #include "lkdtm.h"
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/sched.h>
 
 static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
 
+/*
+ * If there aren't guard pages, it's likely that a consecutive allocation will
+ * let us overflow into the second allocation without overwriting something real.
+ */
+void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
+{
+	char *one, *two;
+
+	one = vzalloc(PAGE_SIZE);
+	two = vzalloc(PAGE_SIZE);
+
+	pr_info("Attempting vmalloc linear overflow ...\n");
+	memset(one, 0xAA, PAGE_SIZE + 1);
+
+	vfree(two);
+	vfree(one);
+}
+
 /*
  * This tries to stay within the next largest power-of-2 kmalloc cache
  * to avoid actually overwriting anything important if it's not detected
  * correctly.
  */
-void lkdtm_OVERWRITE_ALLOCATION(void)
+void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 {
 	size_t len = 1020;
 	u32 *data = kmalloc(len, GFP_KERNEL);
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c64df24..5a852d0beee0 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -38,7 +38,8 @@ void lkdtm_FORTIFY_SUBOBJECT(void);
 /* heap.c */
 void __init lkdtm_heap_init(void);
 void __exit lkdtm_heap_exit(void);
-void lkdtm_OVERWRITE_ALLOCATION(void);
+void lkdtm_VMALLOC_LINEAR_OVERFLOW(void);
+void lkdtm_SLAB_LINEAR_OVERFLOW(void);
 void lkdtm_WRITE_AFTER_FREE(void);
 void lkdtm_READ_AFTER_FREE(void);
 void lkdtm_WRITE_BUDDY_AFTER_FREE(void);
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 11ef159be0fd..322a1d2439e3 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -15,7 +15,8 @@ UNSET_SMEP CR4 bits went missing
 DOUBLE_FAULT
 CORRUPT_PAC
 UNALIGNED_LOAD_STORE_WRITE
-#OVERWRITE_ALLOCATION Corrupts memory on failure
+VMALLOC_LINEAR_OVERFLOW
+SLAB_LINEAR_OVERFLOW
 #WRITE_AFTER_FREE Corrupts memory on failure
 READ_AFTER_FREE
 #WRITE_BUDDY_AFTER_FREE Corrupts memory on failure
-- 
2.25.1

