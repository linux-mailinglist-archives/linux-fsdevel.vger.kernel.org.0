Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2146122A15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLQLbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 06:31:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41285 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLQLbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:31:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so4449801pjb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 03:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mUxzvwjgO2ZHffdQyZgrVhwhMVrr5KtTx2eyM983GSE=;
        b=ZyV99MTr7TRmBgXevNorWGAiLdpHGh5vhPG68r3LAmi3qW5mszrDUnC/nemNzdlGba
         9gziqICgCOonEX3+3FqBCM/7nGUqtkOluvGIH08bkbH1VtljgDj6aGPb8QwkvdPWuU3Z
         9sRTh3xgtAAq1SD1qQ/RVPtDPmjAHnhMjUM+nChqOQ4jz6qLeqpYdvyq1d86gr+eQLi4
         JOj3m983q9z1A0D+hUJ3E9fxVpat52/bcanlQMQo6N/Lw3jcKIcS2Dxghd/8TKp8iNr4
         Zoa094mEFPJqHxh+p2FfxPVu/+lWkWfaCxgXzDGGPnHnYMUHopz21/RBJ6f7Qhg/czUd
         XcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mUxzvwjgO2ZHffdQyZgrVhwhMVrr5KtTx2eyM983GSE=;
        b=LK67imlXpd7bw53vWlLR/zS6PU2dFhKECFoLYhSkv/AVIW+sfNgKyoj0Owplr5AvJX
         5tIgJBL2CgPzrOSmWc8XzEmNt4IPAZzrmkam2Dx2lgT0LdSdSLfeB0J6QQAU5jcDogG6
         lrZpSeIBt/MBv3uGzARoDk3LnGxBjP5B/9kqY+9+pvoAOeUQ6Q1YhAxy24Oe9qOXNxhM
         3z/ku3u9uMBRAaH4NoTgt0WNQ31ERb6fRgp1956raAH+D4HbZ8tXPLEzZ+6IRDf4p41E
         +F7lJK1ROlGpSA+EOSTp/R++YWN05PNAR0GyTiIP6ISd8HUq8d+SIxbZvjyDAOr+pWom
         n8IA==
X-Gm-Message-State: APjAAAWpdles9gkcWvufJb9oAhxS+6tHOdn/SR9umDH+RwqAerVzD+PM
        utk/GfURkIVMqw/qmltzL+w=
X-Google-Smtp-Source: APXvYqxenXdKMwF1wXuyr9N43cbveSFn99SPjKOUFQEVuvOKGVqYmKHFw15XIdQBlplXGhUHN/nbSw==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr7059647plp.149.1576582290689;
        Tue, 17 Dec 2019 03:31:30 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q21sm26246460pff.105.2019.12.17.03.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:31:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 4/4] memcg, inode: protect page cache from freeing inode
Date:   Tue, 17 Dec 2019 06:29:19 -0500
Message-Id: <1576582159-5198-5-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On my server there're some running MEMCGs protected by memory.{min, low},
but I found the usage of these MEMCGs abruptly became very small, which
were far less than the protect limit. It confused me and finally I
found that was because of inode stealing.
Once an inode is freed, all its belonging page caches will be dropped as
well, no matter how may page caches it has. So if we intend to protect the
page caches in a memcg, we must protect their host (the inode) first.
Otherwise the memcg protection can be easily bypassed with freeing inode,
especially if there're big files in this memcg.
The inherent mismatch between memcg and inode is a trouble. One inode can
be shared by different MEMCGs, but it is a very rare case. If an inode is
shared, its belonging page caches may be charged to different MEMCGs.
Currently there's no perfect solution to fix this kind of issue, but the
inode majority-writer ownership switching can help it more or less.

Cc: Roman Gushchin <guro@fb.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/inode.c                 |  9 +++++++++
 include/linux/memcontrol.h | 15 +++++++++++++++
 mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  4 ++++
 4 files changed, 74 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index fef457a..b022447 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -734,6 +734,15 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+
+	/* Page protection only works in reclaimer */
+	if (inode->i_data.nrpages && current->reclaim_state) {
+		if (mem_cgroup_inode_protected(inode)) {
+			spin_unlock(&inode->i_lock);
+			return LRU_ROTATE;
+		}
+	}
+
 	/*
 	 * Referenced or dirty inodes are still in use. Give them another pass
 	 * through the LRU as we canot reclaim them now.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1a315c7..21338f0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -247,6 +247,9 @@ struct mem_cgroup {
 	unsigned int tcpmem_active : 1;
 	unsigned int tcpmem_pressure : 1;
 
+	/* Soft protection will be ignored if it's true */
+	unsigned int in_low_reclaim : 1;
+
 	int under_oom;
 
 	int	swappiness;
@@ -363,6 +366,7 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
+unsigned long mem_cgroup_inode_protected(struct inode *inode);
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -850,6 +854,11 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
 	return MEMCG_PROT_NONE;
 }
 
+static inline unsigned long mem_cgroup_inode_protected(struct inode *inode)
+{
+	return 0;
+}
+
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 					gfp_t gfp_mask,
 					struct mem_cgroup **memcgp,
@@ -926,6 +935,12 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *
+mem_cgroup_from_css(struct cgroup_subsys_state *css)
+{
+	return NULL;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 234370c..efb53f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6355,6 +6355,52 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 }
 
 /**
+ * Once an inode is freed, all its belonging page caches will be dropped as
+ * well, even if there're lots of page caches. So if we intend to protect
+ * page caches in a memcg, we must protect their host first. Otherwise the
+ * memory usage can be dropped abruptly if there're big files in this
+ * memcg. IOW the memcy protection can be easily bypassed with freeing
+ * inode. We should prevent it.
+ * The inherent mismatch between memcg and inode is a trouble. One inode
+ * can be shared by different MEMCGs, but it is a very rare case. If
+ * an inode is shared, its belonging page caches may be charged to
+ * different MEMCGs. Currently there's no perfect solution to fix this
+ * kind of issue, but the inode majority-writer ownership switching can
+ * help it more or less.
+ */
+unsigned long mem_cgroup_inode_protected(struct inode *inode)
+{
+	unsigned long cgroup_size;
+	unsigned long protect = 0;
+	struct bdi_writeback *wb;
+	struct mem_cgroup *memcg;
+
+	wb = inode_to_wb(inode);
+	if (!wb)
+		goto out;
+
+	memcg = mem_cgroup_from_css(wb->memcg_css);
+	if (!memcg || memcg == root_mem_cgroup)
+		goto out;
+
+	protect = mem_cgroup_protection(memcg, memcg->in_low_reclaim);
+	if (!protect)
+		goto out;
+
+	cgroup_size = mem_cgroup_size(memcg);
+	/*
+	 * Don't need to protect this inode, if the usage is still above
+	 * the limit after reclaiming this inode and its belonging page
+	 * caches.
+	 */
+	if (inode->i_data.nrpages + protect < cgroup_size)
+		protect = 0;
+
+out:
+	return protect;
+}
+
+/**
  * mem_cgroup_try_charge - try charging a page
  * @page: page to charge
  * @mm: mm context of the victim
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3c4c2da..1cc7fc2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2666,6 +2666,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				sc->memcg_low_skipped = 1;
 				continue;
 			}
+			memcg->in_low_reclaim = 1;
 			memcg_memory_event(memcg, MEMCG_LOW);
 			break;
 		case MEMCG_PROT_NONE:
@@ -2693,6 +2694,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+		if (memcg->in_low_reclaim)
+			memcg->in_low_reclaim = 0;
+
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
 			   sc->nr_scanned - scanned,
-- 
1.8.3.1

