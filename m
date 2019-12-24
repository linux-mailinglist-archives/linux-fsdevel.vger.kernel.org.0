Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB533129EB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfLXHzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45756 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXHzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so8170439pls.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1NIvureCn33Tn3ECKZBbHdYOKZ0mZ/srBiMlz7CqOo=;
        b=vaUVC/DHZHrYVeAmeVTVNycr7RSOOShtL0anFZVIrQTDBEW6y4NcDlgg06k3VdlMIU
         y28LQYrFnfOe3w4bYy/fP5H1Wr9BNt3v9Udg4OxWCmBsiVVEzFOMYYSZwNNc4zFaL23D
         X6x4xJJMalWRbUFVaHb4p9ulQUHFOe0aCozmWYUnrMKU8jAADiqGkKTc4KtipzY9oGNn
         WCPkB/aRAcxCJixLDhLreuTSNJcahFoVfD3fVsUXqZleggWrFMalGnuRnenh2aMf6QcQ
         GaL/cpTjS9exDf0ECPYMAoEynr5LzVDZyAReYOFPaBIraG7+bf4BvxP40Kmn00cAkuT8
         qkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1NIvureCn33Tn3ECKZBbHdYOKZ0mZ/srBiMlz7CqOo=;
        b=XH//M5TKoSuT5NCj9zrEzQLti7y0X8o/cO6+EtruGSIgrJO/KCoX1pIO13B0E2PEda
         5ihEcn3Ca1Wfq+HS0em0N3adir+HEKEHQi3A2a9if39Vsf8XdXQd56x83DPB6S2Z4Eri
         t7/OAn7oWlewJrlUIUDJyNL5AxFtI5ZGdR2j2bYesWf1E88ruq+9bG04wDQjJXoihU30
         WhH0x3PWpGeUgkucD0YqIJyRUzBE6nP0gsj57ILJCF6Epu6fisKodGxjZjxcw574pW4i
         7/gCdga8mUhAI0fsUQvFjWprAAGCUkZgD3C7Dqq294imCHzF2P1zwRpYUsxhsVo1H6hI
         8viw==
X-Gm-Message-State: APjAAAUSXHRLBbIManu+OaKUId3IX1W0pA8DRG5Idn9JadIjezv2wRmu
        6TPHI56WupFsbB6g5BGa3zw=
X-Google-Smtp-Source: APXvYqyT8qOnAq66pXq7Xp1RgbKisswZoZED+pR98Qm34GbQU76x3QyoL8MQF2ZduR4HUfbhrLxMpA==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr4174688pjb.125.1577174116520;
        Mon, 23 Dec 2019 23:55:16 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:15 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 1/5] mm, memcg: reduce size of struct mem_cgroup by using bit field
Date:   Tue, 24 Dec 2019 02:53:22 -0500
Message-Id: <1577174006-13025-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are some members in struct mem_group can be either 0(false) or
1(true), so we can define them using bit field to reduce size. With this
patch, the size of struct mem_cgroup can be reduced by 64 bytes in theory,
but as there're some MEMCG_PADDING()s, the real number may be different,
which is relate with the cacheline size. Anyway, this patch could reduce
the size of struct mem_cgroup more or less.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5..612a457 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -229,20 +229,26 @@ struct mem_cgroup {
 	/*
 	 * Should the accounting and control be hierarchical, per subtree?
 	 */
-	bool use_hierarchy;
+	unsigned int use_hierarchy : 1;
 
 	/*
 	 * Should the OOM killer kill all belonging tasks, had it kill one?
 	 */
-	bool oom_group;
+	unsigned int  oom_group : 1;
 
 	/* protected by memcg_oom_lock */
-	bool		oom_lock;
-	int		under_oom;
+	unsigned int oom_lock : 1;
 
-	int	swappiness;
 	/* OOM-Killer disable */
-	int		oom_kill_disable;
+	unsigned int oom_kill_disable : 1;
+
+	/* Legacy tcp memory accounting */
+	unsigned int tcpmem_active : 1;
+	unsigned int tcpmem_pressure : 1;
+
+	int under_oom;
+
+	int	swappiness;
 
 	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
@@ -297,9 +303,6 @@ struct mem_cgroup {
 
 	unsigned long		socket_pressure;
 
-	/* Legacy tcp memory accounting */
-	bool			tcpmem_active;
-	int			tcpmem_pressure;
 
 #ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
-- 
1.8.3.1

