Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585DE30681E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhA0XkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhA0Xfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:33 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D1C061794;
        Wed, 27 Jan 2021 15:34:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e9so2691934pjj.0;
        Wed, 27 Jan 2021 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A25C2yzorA2J3gVn3nsaaXJeMnBXVSTs3vvI0YY4hDA=;
        b=WiNuvn47Mp5t41ts2kRKGgt9BbuxXM5u4SJJ63aPMMDxGo8sV5xwtpPfaFHY67SRgm
         HCycw0iUMUzn2SEgIiJA0Vc9VR8Gkq4lIujR53Wch3vwGYsYA8xixp2q1bRMmxREGOjM
         pedM0KFhy8EXOBdZVz/9meVGcVEGvtOjOHETUPg6HV2ZucFrpv11jKWNKFYMtnqcvUB8
         +yckZbVdTj6oK4S7hSnrLLfyycArgFKh3BCtD15MzK7QMmlZbza0OnD6suquKbs+C4N9
         QmbhTijxgXEzmpH/DMB2hLGDgJ9cDMX6EvIVZq6vZTvxicbzc/Dkq+PbZUFfJsYDPVwh
         Bd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A25C2yzorA2J3gVn3nsaaXJeMnBXVSTs3vvI0YY4hDA=;
        b=Idy7rTTHAPYsEKDQyabU6zgQ7c9LDry7I2lS5Fi0KAAjPj1aC8nEpQadkAHEIQGd0V
         S5er162ZwbSYVOEgjC7Ue3I8Bpf/MrO4yJOu2LbFuyaAzToV6fBzVibM9jQlyZgoLaTp
         HDlyyE38Pl71Z+ms5bVEj9ItQG4xcEni7Gif29tb34IMlNP7wWCToOXkhfriwSbEfilY
         NBbyj+Tw5r/LO0oF8HlgF/PTOhaysvoCdoAv//OuDv0P1ISBzhKWxebP2igba2PrHJog
         BY7DORgf4BHaARJMPeEB8nx2pAt7AnOgGOw+rri1yIKnoZjQniCC8cHJf9FgzklJ+/9w
         ctmQ==
X-Gm-Message-State: AOAM53260ns8jmixhUEGlCGw647xevLfX6kApLuosdRXq+C7Z7EE1t0i
        IvNPyHJyE9d4N9zGaGMD9+Q=
X-Google-Smtp-Source: ABdhPJxcg6SxlofTZRZskbI8gjSTaNdJroCzzy078FkO4MpMnwzQMsW/UX1X0UAWCI7/gCFeJql8iQ==
X-Received: by 2002:a17:90b:60c:: with SMTP id gb12mr8128306pjb.125.1611790451282;
        Wed, 27 Jan 2021 15:34:11 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:34:10 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 09/11] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Wed, 27 Jan 2021 15:33:43 -0800
Message-Id: <20210127233345.339910-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
This makes the implementation of this patch simpler.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e1f8960f5cf6..0373d7619d7b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -332,6 +332,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
@@ -414,7 +417,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -525,8 +528,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (!err)
+			return 0;
+		if (err != -ENOSYS)
+			return err;
+
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
 
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -534,26 +549,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
 
 	return 0;
-
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		return unregister_memcg_shrinker(shrinker);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

