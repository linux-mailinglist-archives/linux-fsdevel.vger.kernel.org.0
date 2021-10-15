Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727B42EAED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhJOIFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 04:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhJOIFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:05:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704BDC061570;
        Fri, 15 Oct 2021 01:02:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c4so846575pgv.11;
        Fri, 15 Oct 2021 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=L9Ru3wsmlafUCw2Zta9Zt80re6BQq/s7mp+4/+KVG7w=;
        b=b85yHrpKQyF5yRq0mLhBdwZtaQGMWcLJgPOclCotqiYwA/d3ScLCwDxWRq/eizUcPW
         k+PWcY2KJ+K0sfUN4B26KzmeBZNheuAwjo23YvnCRuymEh65GPX7uznNbNbzbqfri1BP
         qBHrZ31loLO2S38gkfGD4c7pw7y5sU9du2ZeGFHuIyGcn0PhNMKaGPZsirSFK2NDslxQ
         05F5yISHFnN1zQSf2v+FyBlcaIOPDCB0oUk4EyJ85jvzi25zX+++kP+l/OyZBh9J5U+G
         9Dcfyn+Jn9lw0Y4ydQ7L4aoX1o+vnZRl3ohoBSUAavkPXLwJ7G7w6PjBE9C51Az54lr3
         vdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L9Ru3wsmlafUCw2Zta9Zt80re6BQq/s7mp+4/+KVG7w=;
        b=HauHvr3yoxLH3BlKMDnX+YJhPJzP15IjnuWh3FdXoWsnfxZYDN7blULKCxy8HqHzeQ
         UtNqawDDd7mXKTpiSSPxXiZiKQKFIn/kDT0AN2daR/zj74drmKfHJKGRLF6AFeRQq3VJ
         Rzujck5L3RAsi+6VyQaDUUtyi2LH76VDVMmNmc2VIHcgHPZtvKgnVhoy3K7y/D6y7t9+
         XiQFu93BaWA2/ETUs7i/FZgeLDs8wGCOAVHrl585ndLeIYHXpE5suLba8Qs/xSaJMGfM
         7fsyN6grgZqR2BOom7lpbk1ycDe6wDJrbrRURyW+H6CiPMwzK/gOOgS3+90MvVB8nhKo
         1hIw==
X-Gm-Message-State: AOAM531mmnQg+nZH7fGRrAUFBD9Gmh8TyzP65I3RH1IzcWXROiDSEnij
        I/cIjHOUZt8HsAYdqTUjKBQ=
X-Google-Smtp-Source: ABdhPJxRgfRCtVQLnb2+7T4+ECFt0uCdSNVD+LfHi87DMWGPf/pxrbvviST/HXKs20jgUcdXByGi0g==
X-Received: by 2002:a62:3102:0:b0:44b:63db:fc88 with SMTP id x2-20020a623102000000b0044b63dbfc88mr10356279pfx.75.1634284941799;
        Fri, 15 Oct 2021 01:02:21 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id v21sm4037024pgo.35.2021.10.15.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:02:21 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     willy@infradead.org, hch@infradead.org, akpm@linux-foundation.org,
        sunhao.th@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] fs: inode: use queue_rcu_work() instead of call_rcu()
Date:   Fri, 15 Oct 2021 16:02:16 +0800
Message-Id: <20211015080216.4871-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call Trace:
 <IRQ>
 __init_work+0x2d/0x50 kernel/workqueue.c:519
 synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
 bdi_remove_from_list mm/backing-dev.c:938 [inline]
 bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
 release_bdi+0xa1/0xc0 mm/backing-dev.c:968
 kref_put include/linux/kref.h:65 [inline]
 bdi_put+0x72/0xa0 mm/backing-dev.c:976
 bdev_free_inode+0x11e/0x220 block/bdev.c:408
 i_callback+0x3f/0x70 fs/inode.c:226
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097

The bdi_put() be called in RCU softirq, however the
synchronize_rcu_expedited() and flush_delayed_work() that be called
when wb shutdown, will trigger sleep action, use queue_rcu_work()
instead of call_rcu(), the release operation be executed in task context.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 fs/inode.c         | 9 +++++----
 include/linux/fs.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a49695f57e1e..300beb19aed6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -219,9 +219,9 @@ void free_inode_nonrcu(struct inode *inode)
 }
 EXPORT_SYMBOL(free_inode_nonrcu);
 
-static void i_callback(struct rcu_head *head)
+static void i_callback(struct work_struct *work)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
+	struct inode *inode = container_of(to_rcu_work(work), struct inode, rwork);
 	if (inode->free_inode)
 		inode->free_inode(inode);
 	else
@@ -248,7 +248,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 				return NULL;
 		}
 		inode->free_inode = ops->free_inode;
-		i_callback(&inode->i_rcu);
+		i_callback(&inode->rwork.work);
 		return NULL;
 	}
 
@@ -289,7 +289,8 @@ static void destroy_inode(struct inode *inode)
 			return;
 	}
 	inode->free_inode = ops->free_inode;
-	call_rcu(&inode->i_rcu, i_callback);
+	INIT_RCU_WORK(&inode->rwork, i_callback);
+	queue_rcu_work(system_wq, &inode->rwork);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8903a95611a2..006d769791a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -686,7 +686,7 @@ struct inode {
 	struct list_head	i_wb_list;	/* backing dev writeback list */
 	union {
 		struct hlist_head	i_dentry;
-		struct rcu_head		i_rcu;
+		struct rcu_work         rwork;
 	};
 	atomic64_t		i_version;
 	atomic64_t		i_sequence; /* see futex */
-- 
2.17.1

