Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFDB3A7EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFONQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFONQW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:16:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B03C061574;
        Tue, 15 Jun 2021 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gAw+EDJapOH99CiLXwhTpHsII+/WeUYXvhWh+ymJSpQ=; b=fE2431uQ0PQ9viz/cOBwY0PrjN
        ks6P7qyrkv1LNvZpcWXOpRZKca3Mxx0paPyzwKMwRfnZ7uI/8cIZVRsdjScgjVNN7pS8op/ufmUVq
        joclDJNzlITVS0SbpludUS30uhNp1JHV32pVWdltUGn/kG9z9Bg/Vdlnlsh/yKuoppUprZSU03YR6
        YZEj+zfgt1YoF4ulGpf9NMs/VrsuhxjppI9kKZI35fGvWKfURueH8O38zCMTkETBL97eyBrFG2IZV
        hbsBMaQgst63NGQputk/S5qrjINQxdePumTqwF6KEQRbpBDIE59jXEgAO7P7CwtUnol4NkZ0FhOZ5
        rtI5GfRw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8sy-006nNp-Cz; Tue, 15 Jun 2021 13:13:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 11/16] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date:   Tue, 15 Jun 2021 15:10:29 +0200
Message-Id: <20210615131034.752623-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This flags ensures that the pages will not be reused for non-bio
allocations before the end of an RCU grace period.  With that we can
safely use a RCU lookup for bio polling as long as we are fine with
occasionally polling the wrong device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
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
2.30.2

