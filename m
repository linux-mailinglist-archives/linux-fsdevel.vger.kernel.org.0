Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37D22D029F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLFKSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLFKSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:41 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDADCC08E9AA
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:18:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so7024349pfu.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzVbUHzHNutFlJQXX/d4rCoABm7bks/8Sv9HD05GfEo=;
        b=poeTINc8GQTJYdjLzUjOwVcyWKpDqMJuexxM4Jb6DPltaseMinhqh/fI4za09P7SpJ
         ueTfpbdcaNT8FRgCzXBnvchsMG19r9qFb6dmWplY0+dV4prCug2v2aNQDXQeD4f4ITSk
         EoVkV9OIP/YW0/Sa7OyTso7ZG60JcGENiXRqAvbK4UuODW674qsOoXE/pNVvUrmgshUS
         85409VfqkcMfK8Xr4ByeyYmoKcONo5Ce9w22Krdh3gyADCxxiAkKBnxjcsgF8uV5S52E
         vCvZZh3sftwph8jcw8YfxrYT88oU5Tt46j5Q212IwnFvnbLVED2uTA1ydilqWk7ajFo5
         i5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzVbUHzHNutFlJQXX/d4rCoABm7bks/8Sv9HD05GfEo=;
        b=fsYCWIE20dUCi/InaQQfH+T1hw/B1RcDqYmMr4nkyc3yO6bpOIhKfK7TfhU07SAMMF
         wa0YhkynlyJe+UuzlXBFW3fOs6SXX44oLdaYok1QIL572AQxN7d+lJ1rvOjiRIqVh/e6
         QjFP9WJOVlRJmLV42hRSLhYL893LjjGp1o+7SyoieZfxgCuFfq7nbWGGHlg1ExB96Tt8
         IPsPclnpqxq/upk7JjWwFHI00xm0xTnUqpid9806uHlHvN+G7gM4ztXW4NOkaXotlwWB
         ypS86WcakTzmKI8506d3zvM7e7jxZcW4cpfccrUizp/wP2XfIk3f8Su1A5egWFSan/z8
         SmUg==
X-Gm-Message-State: AOAM533s3ZQciI3PwUdrWKEPkEZuzqxKxNdPniHPhY7M9+nAckVoGfeg
        KB7MPE1UeWitqvDXjrUQi691Xw==
X-Google-Smtp-Source: ABdhPJwOE+mifEeZdUynoRMflnzW+cfbd7QXeq8UPaKhUO7NDUpn7fwwqZ66YSE0/Dk/xryAVB2Udg==
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id b1-20020aa795010000b02901553b11d5c4mr11232823pfp.76.1607249883472;
        Sun, 06 Dec 2020 02:18:03 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.17.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:18:02 -0800 (PST)
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
Subject: [RESEND PATCH v2 08/12] mm: memcontrol: convert NR_KERNEL_SCS_KB account to bytes
Date:   Sun,  6 Dec 2020 18:14:47 +0800
Message-Id: <20201206101451.14706-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert NR_KERNEL_SCS_KB account to bytes

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 2 +-
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 2 +-
 kernel/scs.c           | 4 ++--
 mm/page_alloc.c        | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 92a75bad35c9..bc01ce0b2fcd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -448,7 +448,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(i.sharedram),
 			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
-			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
+			     nid, node_page_state(pgdat, NR_KERNEL_SCS_B) / SZ_1K,
 #endif
 			     nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
 			     nid, 0UL,
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 799a537d4218..69895e83d4fc 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -104,7 +104,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		   global_node_page_state(NR_KERNEL_STACK_B) / SZ_1K);
 #ifdef CONFIG_SHADOW_CALL_STACK
 	seq_printf(m, "ShadowCallStack:%8lu kB\n",
-		   global_node_page_state(NR_KERNEL_SCS_KB));
+		   global_node_page_state(NR_KERNEL_SCS_B) / SZ_1K);
 #endif
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bd34416293ec..1f9c83778629 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -204,7 +204,7 @@ enum node_stat_item {
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
 	NR_KERNEL_STACK_B,	/* measured in byte */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
-	NR_KERNEL_SCS_KB,	/* measured in KiB */
+	NR_KERNEL_SCS_B,	/* measured in byte */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/kernel/scs.c b/kernel/scs.c
index 4ff4a7ba0094..8db89c932ddc 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -17,8 +17,8 @@ static void __scs_account(void *s, int account)
 {
 	struct page *scs_page = virt_to_page(s);
 
-	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
-			    account * (SCS_SIZE / SZ_1K));
+	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_B,
+			    account * SCS_SIZE);
 }
 
 static void *scs_alloc(int node)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d2821ba7f682..58916b3afdab 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5574,7 +5574,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
 #ifdef CONFIG_SHADOW_CALL_STACK
-			node_page_state(pgdat, NR_KERNEL_SCS_KB),
+			node_page_state(pgdat, NR_KERNEL_SCS_B) / SZ_1K,
 #endif
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
-- 
2.11.0

