Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A32EB5A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbhAEW7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 17:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbhAEW7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:59:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E5C06179E;
        Tue,  5 Jan 2021 14:58:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n25so901283pgb.0;
        Tue, 05 Jan 2021 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tp6nvSnYfrzas6KqqlhHOeDbjFx3dmjGnjHn57+Ml3M=;
        b=PyPds34cq+wU8WRce7eiKrTHVg4GL0fiJGZFtk6LMlqEKH+nyE7Fhz06jcvZRyPtBk
         SXhTYB9blJzG2KdJybceWKTb4YDswXlPgl3+AevqIKkvN+DqtKgprLV9vo/GAfhTMCIM
         O6oBzeUXmWibHUWsgztMowdInRXjYHZ6zTyLq9/TbWrY4Yw+wmjhJGpfheFRA5zBOdrE
         Luq9/kyI1G3ESeXwrinAPZejWjoXUWXPOLUwbwfIWf20Cx7ryPM+WLgXzFe9Iml/yM45
         SX5gPCNVw/Subk6EGZgiYnpomhUGMIoA4BNXAklySPPJ5rxchEIJ9Y7UdlMD2nvHCUHy
         l1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tp6nvSnYfrzas6KqqlhHOeDbjFx3dmjGnjHn57+Ml3M=;
        b=el+YpDJck4exGTCCfKA175qANzQaQKogjdNBpF1c9O2c/XhJ71W+koIcykGYujYZYT
         34cZ3FecjOqcwo+xn9GoLNlHjGGcfIpSD4dbUzPwxYf6M/CWIZIIcdu01dHWT4Al3UXQ
         VAE/dHmk3OgBlDG2+YJ+hgFz+5YsabmkReIubgIu6yM5Gq1jS+rVvTx2JdjV8FYqqzw0
         2dVKI50hPnbGYE0Wrxv0l4OP0Yy9s+X2FY9crZ46sfrY3PUuCALYkiPVxzSlZHpKPFtZ
         GbTMbPwMvw4Eg5nq7kRaa0k4Lo3h16ajAtX7TnIE4oR8fwTWxYdLqxpe7zheaoF9CDt3
         BH4A==
X-Gm-Message-State: AOAM5309aNVYiStAaYWoLErAVsH9VYhA+pSRxdDLrXbDPpcQ6SY2qGsR
        GXE44r44ZVmx3qZnxqo9LyB9bsNKLuEAr4lh
X-Google-Smtp-Source: ABdhPJzb6Ix4JjXnWhJWl2DmIhFwzSRpr9MVjwmdlocKRbwrUon4tQzHVJKvCNxw+akSjZj81zWglQ==
X-Received: by 2002:a63:da4f:: with SMTP id l15mr1397712pgj.22.1609887533410;
        Tue, 05 Jan 2021 14:58:53 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:58:52 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
Date:   Tue,  5 Jan 2021 14:58:10 -0800
Message-Id: <20210105225817.1036378-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
bit map.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ddb9f972f856..8da765a85569 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
-
-static int memcg_shrinker_map_size;
+static int shrinker_nr_max;
 
 static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -248,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_read(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
 	for_each_node(nid) {
 		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
 		if (!map) {
@@ -269,7 +268,7 @@ static int memcg_expand_shrinker_maps(int new_id)
 	struct mem_cgroup *memcg;
 
 	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	old_size = DIV_ROUND_UP(shrinker_nr_max, BITS_PER_LONG) * sizeof(unsigned long);
 	if (size <= old_size)
 		return 0;
 
@@ -286,10 +285,8 @@ static int memcg_expand_shrinker_maps(int new_id)
 			goto out;
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
-out:
-	if (!ret)
-		memcg_shrinker_map_size = size;
 
+out:
 	return ret;
 }
 
@@ -321,7 +318,6 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-- 
2.26.2

