Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5572B5B44BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiIJGvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIJGvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:51:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE8A27B35;
        Fri,  9 Sep 2022 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vqMGMaEkOmTqVQylBL+skkFNuiQaEqBjU4MG7KR5LL0=; b=kqYZ5RijV8voK/z0zN+91658ME
        othEptJ5Jh2KM6dR4Cxso2p8jnG+xQo2M5kHEwh9mo1XVCJT3+LjcQVT86P0gUbIOZqNeFapGyX/h
        /OdgGVYp+QTVSkxLppYxTFUKdb59n7fqclYWiXunNSvOEQZbHZ7Al4fPyqE+Y7niQJCNcFr1QpNzt
        E9JUwcNBCafe3zyNEyvt4LB8sGEahpq/lVI09ZRV8hg7amkemarEy1CYLP/bzYggDRP43uf/Xx2Fa
        L7KwLUlqXcGXEbb1eNQP//XtM7trmDf+dq+zs0ZJyirR+O7PS1uicM9oKe1DTjiDKpApviawkwvvL
        FHmOX0DA==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWuKd-006pZX-Fw; Sat, 10 Sep 2022 06:51:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: [PATCH 2/5] sched/psi: export psi_memstall_{enter,leave}
Date:   Sat, 10 Sep 2022 08:50:55 +0200
Message-Id: <20220910065058.3303831-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
References: <20220910065058.3303831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To properly account for all refaults from file system logic, file systems
need to call psi_memstall_enter directly, so export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/sched/psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ecb4b4ff4ce0a..7f6030091aeee 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -917,6 +917,7 @@ void psi_memstall_enter(unsigned long *flags)
 
 	rq_unlock_irq(rq, &rf);
 }
+EXPORT_SYMBOL_GPL(psi_memstall_enter);
 
 /**
  * psi_memstall_leave - mark the end of an memory stall section
@@ -946,6 +947,7 @@ void psi_memstall_leave(unsigned long *flags)
 
 	rq_unlock_irq(rq, &rf);
 }
+EXPORT_SYMBOL_GPL(psi_memstall_leave);
 
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
-- 
2.30.2

