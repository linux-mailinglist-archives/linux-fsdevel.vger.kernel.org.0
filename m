Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AFF6BE71B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCQKnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCQKnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:43:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037AF2D70;
        Fri, 17 Mar 2023 03:43:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3ADD1FE62;
        Fri, 17 Mar 2023 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679049802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGaRszx5m5MV4LTvKa8CX10/5dVJHJJrEA3zOyDBp1g=;
        b=rfobxMXNiUA5LdvvrB8bLLFFM8Wu+N4fLxrpje4bcuYb/u8FupYisx5sMUPzVuH331a9tE
        I36yc5FVwct1GS92zDkInL3aZOTmNM4igDLK2BPYh0OyxoLeWKD1wtrATHQGPi7g9bXjfm
        gBFNh1eU0q93yd/fBp8rph+gCsic3qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679049802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGaRszx5m5MV4LTvKa8CX10/5dVJHJJrEA3zOyDBp1g=;
        b=A8esHta5sd4hYruqYcTmfFoQLhufqcN22xpwszK8r3G0ZlJ+1csam4cy+jfRUSjIoi1LuE
        xUptyGgow68Z9hAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FDCF13A3E;
        Fri, 17 Mar 2023 10:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cHhuJkpEFGRgdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Mar 2023 10:43:22 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-doc@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 1/6] mm/slob: remove CONFIG_SLOB
Date:   Fri, 17 Mar 2023 11:43:02 +0100
Message-Id: <20230317104307.29328-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317104307.29328-1-vbabka@suse.cz>
References: <20230317104307.29328-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove SLOB from Kconfig and Makefile. Everything under #ifdef
CONFIG_SLOB, and mm/slob.c is now dead code.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 init/Kconfig               |  2 +-
 kernel/configs/tiny.config |  1 -
 mm/Kconfig                 | 22 ----------------------
 mm/Makefile                |  2 --
 4 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1fb5f313d18f..72ac3f66bc27 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -973,7 +973,7 @@ config MEMCG
 
 config MEMCG_KMEM
 	bool
-	depends on MEMCG && !SLOB
+	depends on MEMCG
 	default y
 
 config BLK_CGROUP
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index c2f9c912df1c..144b2bd86b14 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -7,6 +7,5 @@ CONFIG_KERNEL_XZ=y
 # CONFIG_KERNEL_LZO is not set
 # CONFIG_KERNEL_LZ4 is not set
 # CONFIG_SLAB is not set
-# CONFIG_SLOB_DEPRECATED is not set
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..669399ab693c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -238,30 +238,8 @@ config SLUB
 	   and has enhanced diagnostics. SLUB is the default choice for
 	   a slab allocator.
 
-config SLOB_DEPRECATED
-	depends on EXPERT
-	bool "SLOB (Simple Allocator - DEPRECATED)"
-	depends on !PREEMPT_RT
-	help
-	   Deprecated and scheduled for removal in a few cycles. SLUB
-	   recommended as replacement. CONFIG_SLUB_TINY can be considered
-	   on systems with 16MB or less RAM.
-
-	   If you need SLOB to stay, please contact linux-mm@kvack.org and
-	   people listed in the SLAB ALLOCATOR section of MAINTAINERS file,
-	   with your use case.
-
-	   SLOB replaces the stock allocator with a drastically simpler
-	   allocator. SLOB is generally more space efficient but
-	   does not perform as well on large systems.
-
 endchoice
 
-config SLOB
-	bool
-	default y
-	depends on SLOB_DEPRECATED
-
 config SLUB_TINY
 	bool "Configure SLUB for minimal memory footprint"
 	depends on SLUB && EXPERT
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..e347958fc6b2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -22,7 +22,6 @@ KCSAN_INSTRUMENT_BARRIERS := y
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
 KCOV_INSTRUMENT_slab_common.o := n
-KCOV_INSTRUMENT_slob.o := n
 KCOV_INSTRUMENT_slab.o := n
 KCOV_INSTRUMENT_slub.o := n
 KCOV_INSTRUMENT_page_alloc.o := n
@@ -81,7 +80,6 @@ obj-$(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	+= hugetlb_vmemmap.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
-obj-$(CONFIG_SLOB) += slob.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
-- 
2.39.2

