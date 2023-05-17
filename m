Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E289A705DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 05:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjEQDVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 23:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjEQDUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 23:20:51 -0400
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C33A4213D;
        Tue, 16 May 2023 20:20:48 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id EE655B003507E;
        Wed, 17 May 2023 11:20:43 +0800 (CST)
Received: from localhost.localdomain (10.79.71.101) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 11:20:43 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   chengkaitao <chengkaitao@didiglobal.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <muchun.song@linux.dev>
CC:     <viro@zeniv.linux.org.uk>, <zhengqi.arch@bytedance.com>,
        <ebiederm@xmission.com>, <Liam.Howlett@Oracle.com>,
        <chengzhihao1@huawei.com>, <pilgrimtao@gmail.com>,
        <haolee.swjtu@gmail.com>, <yuzhao@google.com>,
        <willy@infradead.org>, <vasily.averin@linux.dev>, <vbabka@suse.cz>,
        <surenb@google.com>, <sfr@canb.auug.org.au>, <mcgrof@kernel.org>,
        <sujiaxun@uniontech.com>, <feng.tang@intel.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v4 2/2] memcg: add oom_kill_inherit event indicator
Date:   Wed, 17 May 2023 11:20:32 +0800
Message-ID: <20230517032032.76334-3-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230517032032.76334-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.79.71.101]
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chengkaitao <pilgrimtao@gmail.com>

Oom_kill_inherit can reflect the number of child cgroups selected by
the parent cgroup's OOM killer. We can refer to the proportion of the
indicator to adjust the value of oom_protect. The larger oom_protect,
the smaller oom_kill_inherit.

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 include/linux/memcontrol.h              | 1 +
 mm/memcontrol.c                         | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 51e9a84d508a..e6f56443d049 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1358,6 +1358,10 @@ PAGE_SIZE multiple when read back.
 		The number of processes belonging to this cgroup
 		killed by any kind of OOM killer.
 
+	  oom_kill_inherit
+		The number of processes belonging to this cgroup
+		killed by all Ancestral memcg's OOM killer.
+
           oom_group_kill
                 The number of times a group OOM has occurred.
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 23ea28d98c0e..d7797f9a0605 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -46,6 +46,7 @@ enum memcg_memory_event {
 	MEMCG_MAX,
 	MEMCG_OOM,
 	MEMCG_OOM_KILL,
+	MEMCG_OOM_INHERIT,
 	MEMCG_OOM_GROUP_KILL,
 	MEMCG_SWAP_HIGH,
 	MEMCG_SWAP_MAX,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8ee67abb415f..cf3cacf26cec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2129,6 +2129,10 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 
 		if (memcg == oom_domain)
 			break;
+		/* we use oom.group's logic to update the OOM_INHERIT indicator,
+		 * but OOM_INHERIT and oom.group are independent of each other.
+		 */
+		memcg_memory_event(memcg, MEMCG_OOM_INHERIT);
 	}
 
 	if (oom_group)
@@ -6622,6 +6626,8 @@ static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 	seq_printf(m, "oom %lu\n", atomic_long_read(&events[MEMCG_OOM]));
 	seq_printf(m, "oom_kill %lu\n",
 		   atomic_long_read(&events[MEMCG_OOM_KILL]));
+	seq_printf(m, "oom_kill_inherit %lu\n",
+		   atomic_long_read(&events[MEMCG_OOM_INHERIT]));
 	seq_printf(m, "oom_group_kill %lu\n",
 		   atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
 }
-- 
2.14.1

