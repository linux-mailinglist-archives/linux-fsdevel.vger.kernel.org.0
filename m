Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC582D029A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLFKSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgLFKSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:33 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B8C061A4F
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:17:52 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id m5so5744018pjv.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OffO4J0XNbKZKsjRiAzQ4jXTCwqv9VY0gL30Fq4+1Jk=;
        b=H94p/twke3EGgzTfnzLG5zYHpHqM5U9I4h/8S6xaN8YSvCZ9DO+xCRNJwC6Z/juFsl
         M6Tsvms6S5YZ3AfjawkS+pa4BYclyYqZ7ErIOUHfuViHuPEQJKE7YUPDUVxKXrSe9f+W
         /RfGFNjF/dCQOKuXuj5rOX6YluRTAYjaWtfsjUt0UVOlFiCQyJQdkNVKiKC+nmLF4x2S
         t+ClAU7xY+b1CeVAoG4FMpAXmde0vMVwPKAXitdvLV6I6kKeLmjwwcVcjKO7y8jbA/++
         6pgQQpVzBIBijbMxqL/JI/EWPnG4lZP2c+/SrwDWsGQ9CTdpscRKJYHtqtnwm4wK7gPA
         DPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OffO4J0XNbKZKsjRiAzQ4jXTCwqv9VY0gL30Fq4+1Jk=;
        b=NkWrJMVHUeIMcAX5hihWUpLoFMn6kzBhMk+o+4OjEeiRL4ODFTrCe+UHyPEo54Z6xa
         PfWRWxCl/AB2c6l6aMi82F/CLhtaeRlyFTw/PWxHrwKjwxPz0DYxrI5J9KWKPv+BMTYa
         o12AFpIGdMUo0iBYoyqfdPV2DoUJHSHMPD1AhIb6zYIAGuR9nCQECYV+yUoWAWZANBCg
         1NTjX3lFCzUdl/7kyhpZKFopO5cgDv68Sjgl/+9ceMtm/IkFb3ccaTGCAQ/nUgOmhkXT
         AeZaVUnaHdG7OMvCVXCAB5IT5bnd4u6WDXEpgUUvBbT+FtglI/kgBhwcOiSbPoDy3H2K
         tlGg==
X-Gm-Message-State: AOAM530qOO2sziGnOCpVewmxaGGCvAkbGucjwiazxRxJwga1gEgOzc8O
        C7zjW4KA4a6OXU9WsBlY6mrQpQ==
X-Google-Smtp-Source: ABdhPJyaSoVwqS1hV86Jy9HYtaaTN3KW8cLPtOEHhySz3KTEmRALmhiqeeK5DCu0P0C+H1csGtcR0Q==
X-Received: by 2002:a17:90a:e386:: with SMTP id b6mr11649470pjz.134.1607249871646;
        Sun, 06 Dec 2020 02:17:51 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.17.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:17:51 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 07/12] mm: memcontrol: convert kernel stack account to bytes
Date:   Sun,  6 Dec 2020 18:14:46 +0800
Message-Id: <20201206101451.14706-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel stack account is the one that counts in KiB. This patch
convert it from KiB to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 2 +-
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 kernel/fork.c          | 8 ++++----
 mm/memcontrol.c        | 2 +-
 mm/page_alloc.c        | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f77652e6339f..92a75bad35c9 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -446,7 +446,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
-			     nid, node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 5a83012d8b72..799a537d4218 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -101,7 +101,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_node_page_state(NR_KERNEL_STACK_KB));
+		   global_node_page_state(NR_KERNEL_STACK_B) / SZ_1K);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
 		   global_node_page_state(NR_KERNEL_SCS_KB));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 15132adaa233..bd34416293ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -202,7 +202,7 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
-	NR_KERNEL_STACK_KB,	/* measured in KiB */
+	NR_KERNEL_STACK_B,	/* measured in byte */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 345f378e104d..2913d7c43dcb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -382,11 +382,11 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 
 	/* All stack pages are in the same node. */
 	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 	else
-		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
+		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_B,
+				      account * THREAD_SIZE);
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6d4365d2fd1c..48d70c1ad301 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1500,7 +1500,7 @@ struct memory_stat {
 static const struct memory_stat memory_stats[] = {
 	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
 	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
 	{ "percpu", 1, MEMCG_PERCPU_B },
 	{ "sock", PAGE_SIZE, MEMCG_SOCK },
 	{ "shmem", PAGE_SIZE, NR_SHMEM },
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d103513b3e4f..d2821ba7f682 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5572,7 +5572,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+			node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
-- 
2.11.0

