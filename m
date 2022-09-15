Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827F5B97B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIOJmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIOJmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:42:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729C8993E;
        Thu, 15 Sep 2022 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f10ud+4Yk8zuOd0FwaSc+xsLEXHksvzyDOLFsDza1gY=; b=Z0mbKLDUJODd7WIJH7zNtS2L90
        vOmMj4hDPPXiSDw+aMBTpUxgy0asgtgfV+4+J+l4oS+R2K/YUyuJ8I/elEQRBtiYerT7+cF5+veE0
        As2MLe9Jh+crJYKoXZY8Yx6HDQSgstxsDLr8ptgQnaOoxvx+vyNis0c4HBZ1yJWMJml91LbKDJ6sT
        o8ABQhBEkp2KFWBYACzfFvirFth7WnnmAhhowLIfySIykeZwWp4JCLieTfsniUw4AZwmamm7MT3nC
        xxaJOz0cCYfhy3q/EURHz/sxkq0xwdjKLYezjVO8xCGkodJzvbpVbeUUBWYy02JEErH3z9SzjWEdA
        jKe0ukpg==;
Received: from [185.122.133.20] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYlNn-005b1k-MR; Thu, 15 Sep 2022 09:42:08 +0000
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
Date:   Thu, 15 Sep 2022 10:41:57 +0100
Message-Id: <20220915094200.139713-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220915094200.139713-1-hch@lst.de>
References: <20220915094200.139713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To properly account for all refaults from file system logic, file systems
need to call psi_memstall_enter directly, so export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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

