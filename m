Return-Path: <linux-fsdevel+bounces-78676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBv/NC4IoWlXpwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06E1B222C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4289730649C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4D2FE589;
	Fri, 27 Feb 2026 02:57:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A22FE59A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161041; cv=none; b=EDF5EY/WBZjmFaBewp/SvATpxMy2GEwLL/RcgyDW4xZas7Vc0udTNF9wDt8PcSwfqwSFGd2zcIyyY0iudYzXR+Z4YZuMsskBGgozREA71OCw1c2R9HpuXPghXnIt2+0fWHfStnIJstpxu5gpXYbZTGyIGxIGx81lQf+4KNtZ9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161041; c=relaxed/simple;
	bh=ddLNyHjDLzGS+UCPAxPHSmMv6NcWH2rQTi6C6ekt+Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biUN8bkGFcjH2eHe6jPE/nr8HfIaMdmzOMOHN/EFlgZi/X7vvJiAfkvo8VeyOtuz5J3YXFy3M6RRN1DfM7tZsXzdptiPmYGfHccoEbhGFuazz/mibXXNTX5PEW626uMH4V6Ags4751jVr4icHZgKqj1TUV/JpBSExTHgOp/VRvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fMXym5VRKzKHMQW
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:56:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 086F84058C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:57:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPgJCKFpsEGdIw--.32070S5;
	Fri, 27 Feb 2026 10:57:14 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	yebin10@huawei.com
Subject: [PATCH v3 1/3] mm/vmscan: introduce drop_sb_dentry_inode() helper
Date: Fri, 27 Feb 2026 10:55:46 +0800
Message-Id: <20260227025548.2252380-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227025548.2252380-1-yebin@huaweicloud.com>
References: <20260227025548.2252380-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXuPgJCKFpsEGdIw--.32070S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fGFW7JFy3Cw4DGw4fuFg_yoW5ZFWfpF
	ZxG34fJrWrZrnFgryfZFWUZa43t3y0yayxGrZ7W34Yy3Waqa45Xr12yr45tFyUCayrWFy7
	trWaqr1Uur1UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7mLv
	DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78676-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 3A06E1B222C
X-Rspamd-Action: no action

From: Ye Bin <yebin10@huawei.com>

This patch is prepare for support drop_caches for specify file system.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/mm.h |  1 +
 mm/internal.h      |  3 +++
 mm/shrinker.c      |  4 ++--
 mm/vmscan.c        | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..5bab9472a758 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4470,6 +4470,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
+void drop_sb_dentry_inode(struct super_block *sb);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..4690a58c4820 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1662,6 +1662,9 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
+			     struct shrinker *shrinker, int priority);
+
 int shmem_add_to_page_cache(struct folio *folio,
 			    struct address_space *mapping,
 			    pgoff_t index, void *expected, gfp_t gfp);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4a93fd433689..075e4393da9c 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -368,8 +368,8 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 
 #define SHRINK_BATCH 128
 
-static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
-				    struct shrinker *shrinker, int priority)
+unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
+			     struct shrinker *shrinker, int priority)
 {
 	unsigned long freed = 0;
 	unsigned long long delta;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 01d3364fe506..310bed25df78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -455,6 +455,56 @@ void drop_slab(void)
 	} while ((freed >> shift++) > 1);
 }
 
+static unsigned long drop_shrinker_node(int nid, struct shrinker *shrinker)
+{
+	unsigned long freed = 0;
+	struct mem_cgroup *memcg = NULL;
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		unsigned long ret;
+
+		struct shrink_control sc = {
+			.gfp_mask = GFP_KERNEL,
+			.nid = nid,
+			.memcg = memcg,
+		};
+
+		if (!mem_cgroup_disabled() &&
+		    !mem_cgroup_is_root(memcg) &&
+		    !mem_cgroup_online(memcg))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, 0);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
+	return freed;
+}
+
+void drop_sb_dentry_inode(struct super_block *sb)
+{
+	int nid;
+	int shift = 0;
+	unsigned long freed;
+
+	if (!sb || !sb->s_shrink)
+		return;
+
+	do {
+		freed = 0;
+
+		for_each_online_node(nid) {
+			if (fatal_signal_pending(current))
+				return;
+			freed += drop_shrinker_node(nid, sb->s_shrink);
+		}
+	} while ((freed >> shift++) > 1);
+}
+
 #define CHECK_RECLAIMER_OFFSET(type)					\
 	do {								\
 		BUILD_BUG_ON(PGSTEAL_##type - PGSTEAL_KSWAPD !=		\
-- 
2.34.1


