Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E4122A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfLQLbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:31:21 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38500 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfLQLbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:21 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so4453328pjt.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpFS4ToaQ+oe6Ip5CmXL+qTNhJ6T5OxwPQOYZvo7h1c=;
        b=o4+ceH3WOEc9xJ6ASmn6cuSNePCY7AIbZkbZjByDUFDLr1Nv28bSA3NdI8FXR9xoxi
         3qgxs0f1HIhpHGG3qotyZRBJdqShtNasVuiSubIk8lJY5L474yxYltqHQnRnYQc9UYbY
         cQVppl4qcmCarMf6Zg0P3J5WqXrUBh5K0NMb2UK8mfNyCQcBtJH6Ha+ZOEpvPV1na6EZ
         Clpr5BZpG8Ihzca+Je2gB3IdTyU/qXkjDMQ5ETI0jaGOyPPvM6lzic/WueiBKB6bR0ka
         5szd6vJA3mt+AuWm4TQf4JAMggWIzTe4bGejVn7JJ5t7EcsBlvKIZxP0S5TXL/1PBceq
         RSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpFS4ToaQ+oe6Ip5CmXL+qTNhJ6T5OxwPQOYZvo7h1c=;
        b=K5Md4zmmdgsPX+aGBrxP3aAXS6VQfAAOHJQUPW39ju4CCLY2SFemyCTd9TAGU2zQjf
         DSji5Xm9gtZSANzzHVLXwklfgJorXJaN1Xvk6RYl4WxJLV6yap2SF7+E+P32/CiKn2fI
         zKJYV7D0TQQ/qwvo59D1bJZFBhwp3/vzsKiJpL1XJlcXyhhlDXy5ErwvyKbXAndDCPFp
         bOKilQIuXmxQG63F9Z8lmoL7zbDFxeQZkMqSWmmmg5fVNqhH8QyTaTfkTPwvEVhmJ/8F
         2Ur0iI7yo6rit8tG2HFtM/vPk+s3g3azjFFvmer9EjPiOosq3ekRw9ZhiRbnE89eoqDh
         sweA==
X-Gm-Message-State: APjAAAXlF5t9dQ2DntXBuv2p1NNiKOaeedn8NPxZ+Z6EPUdPQZSTD2eT
        XyULQUzELAGRvc6e514a2/4=
X-Google-Smtp-Source: APXvYqwmJ9uXmmvZ0m9A7jESIE+N5e4Bnr6zUDk3KHJOdY7miJJNO8rV7iJrrkPEZCWUKLNEAhQ5mw==
X-Received: by 2002:a17:90a:eb06:: with SMTP id j6mr5320406pjz.81.1576582280315;
        Tue, 17 Dec 2019 03:31:20 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm26246460pff.105.2019.12.17.03.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:31:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/4] mm, memcg: reduce size of struct mem_cgroup by using bit field
Date:   Tue, 17 Dec 2019 06:29:16 -0500
Message-Id: <1576582159-5198-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
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

Cc: Aaron Lu <aaron.lu@intel.com>
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

