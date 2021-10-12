Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F061342A358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhJLLck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhJLLck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:32:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81AC061570;
        Tue, 12 Oct 2021 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6aKAlknRtTYudyciTb9hYnKNaSyFywMQWl+eoT3Sg+c=; b=cLSNe6fg79xtA3VM5dLFe3Bubv
        MnbuV2WjtWPLLZYein4IcXChjBnIDF0UWBNw0sK7Km6nHJk5+H7ehkrt5pnIjnnuBhIBqbW4Blz2W
        G4bHx2yrQXomKrGoVIXl0L6PGyKKQsHQemtapvv7LDk8XXUdvPhkDdP+njy2XAz38iPZuasb6dSbf
        A/vENYz3L/A8shKU8JPEyvpG1UrPXUn76EsuhZv21nTrZbeJJxJ6/gV8Ih/UbwpVPGHSjLGDuCzhm
        FhbWV8+bsi1aHSEjE0l5vGugntVUMx/dP4Gw+dFLE+O+UNkp6Mgpu6cBtS1A1DoNcft2glNntnthl
        5o6I1HGg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFwA-006SBs-Qr; Tue, 12 Oct 2021 11:27:39 +0000
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
Subject: [PATCH 12/16] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date:   Tue, 12 Oct 2021 13:12:22 +0200
Message-Id: <20211012111226.760968-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
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
index a6fb6a0b42955..a48cf9d04b3c1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -87,7 +87,8 @@ static struct bio_slab *create_bio_slab(unsigned int size)
 
 	snprintf(bslab->name, sizeof(bslab->name), "bio-%d", size);
 	bslab->slab = kmem_cache_create(bslab->name, size,
-			ARCH_KMALLOC_MINALIGN, SLAB_HWCACHE_ALIGN, NULL);
+			ARCH_KMALLOC_MINALIGN,
+			SLAB_HWCACHE_ALIGN | SLAB_TYPESAFE_BY_RCU, NULL);
 	if (!bslab->slab)
 		goto fail_alloc_slab;
 
-- 
2.30.2

