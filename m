Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF29543027A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbhJPL4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhJPL4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:56:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21AC061570;
        Sat, 16 Oct 2021 04:54:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t11so8068931plq.11;
        Sat, 16 Oct 2021 04:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7ZiqylWutAW8VdmYTQ1mDlLaA2GHbwBPKauI4V9wf0=;
        b=oSVYsUOhtqGy+gdtrDhsdVbv8Uc4lm7hAcUndvKLtlOhzXCKu18YP7WWKsujn0T+tD
         /DCkB68eF3KgWC7yAV5zLS1/QlkfAVPA+Mb0MkLy9EfRb9U6DcaMZ6hnEei3lomeNcC1
         OZacKidy5e702433CBiz5XnjvQtEVWmZVvBB3/Qo0OC14RwSkox2FZsspbUyCU3gxqow
         0iQMxI7ORYblXXboumRMafRk/UitUNAY2I5dn+ja7a2Y+dRH3tdCZ8EgJge7G9YkT/xO
         sE5kxYjynFXBlPg3u+RS48LhYowlH7BEGOVhvR5Bc86jfhGH8/LKRu3cup+sxzR6FVfS
         9tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7ZiqylWutAW8VdmYTQ1mDlLaA2GHbwBPKauI4V9wf0=;
        b=jFnnK9qLHtA9Iwwevp9UzWNMn5aR/9cXpBK0PTif2XbkQ+nCYczCIUqZritAmCZByQ
         sHXtO65WxazhZuyLEr2N+Y+HHfjNn/p1NJcDqBogzUwq7Cw6/K/64mJ8+4fd6s2ftkwh
         7WFCnYDig6xUrxoGw8z/8z2DYQ8piLfuBQYBalG9bPXsOen/DDxh6ly4AFI26+AiHPpa
         FpNbzDIiyOCDLpCnGSOyywNhnry4/3j9Eus434msCcTxLbiGprG0BIUE41Iq4oNfxaGe
         2ifTpeLDywM8LfTtelTLHnignKGHO+rpI5apobO3BTZ5GOe3crc7xZwzWkU37syCps3l
         fC3Q==
X-Gm-Message-State: AOAM532NQGygUii02PJHKIWDzbGpij2tdTQTERD+IR/cLxwbwKlKMgM8
        Lw+OtShyH/781vqJtaJHV04tLYM7iDM=
X-Google-Smtp-Source: ABdhPJw1IMRjeuaj0z7tb7OLpIE+enDeo2LWvLBTVyw4Iv0KsbHv5EIva7vqY/jNiovb6zGNE1FmFw==
X-Received: by 2002:a17:903:4042:b0:13f:a8ef:7334 with SMTP id n2-20020a170903404200b0013fa8ef7334mr1004324pla.43.1634385276956;
        Sat, 16 Oct 2021 04:54:36 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id d71sm3588414pga.67.2021.10.16.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:54:36 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Unit mismatch (Slab/SReclaimable/SUnreclaim) in meminfo
Date:   Sat, 16 Oct 2021 11:54:29 +0000
Message-Id: <20211016115429.17226-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, it seems there's mismatch in unit (byte and kB) in meminfo.
Would something like this will be acceptable?

commit d42f3245c7e2 ("mm: memcg: convert vmstat slab counters
to bytes") changed it to bytes but proc seems to print everything in
kilobytes.

---
 fs/proc/meminfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..182376582076 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -52,8 +52,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
 	available = si_mem_available();
-	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
-	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
+	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) / 1024;
+	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) / 1024;
 
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
-- 
2.27.0

