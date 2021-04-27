Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8C36C935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhD0QVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhD0QTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38AC061342;
        Tue, 27 Apr 2021 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QPTpS5s0fUYR+1QqobLHklvCGfS9dVC8BfnJQZtbCQk=; b=ul+0VdZVYoXar6xgqAY9m0LEQw
        pRNEsz57RJCq+Vl8Ixk8+VCjkNgw9ARKTPYKnY065IDNuHwbQiJ9Hl/HLyo2X2OT15R73RdCtYfmh
        jwYBzCE6acziGGH8JZ2CjA3bWBpf/JkNIG3YCoAQYv4ToqaNwBUwcqHXkJUq7S1upZaQzSzW0Ofij
        RqDP96uEcn+igyPYXIJlhHHnvUUZzL1hbmBlvcyokuO8DCI6GlHamgaPwyHsIkH2verHUHtU+xTKi
        nQSuJi7CeNZ7w/UTfwi+QxHynuXAepB18bIIaufQUst/BlZccH5/AdyB5+GO4ouYi20+DFfJ1UDIS
        DIvlnetw==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQR-00Gr5b-OL; Tue, 27 Apr 2021 16:19:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/15] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date:   Tue, 27 Apr 2021 18:16:14 +0200
Message-Id: <20210427161619.1294399-11-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This flags ensures that the pages will not be reused for non-bio
allocations before the end of an RCU grace period.  With that we can
safely use a RCU lookup for bio polling as long as we are fine with
occasionally polling the wrong device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..de5505d7018e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -82,7 +82,8 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 
 	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
 	bslab->slab = kmem_cache_create(bslab->name, size,
-			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
+			ARCH_KMALLOC_MINALIGN,
+			SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
 	if (!bslab->slab)
 		goto fail_alloc_slab;
 
-- 
2.30.1

