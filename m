Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B894537BDE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhELNRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhELNRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D39C061574;
        Wed, 12 May 2021 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bco/Dc5NOlfO0gbeRuz1xmWQ5rDoBprwVddNApuJIrQ=; b=ZG/Y11TRYlBgwmkgGZJrWZ8dz5
        MdaGSEALUsAf7HHtOFkBuBcVeFoW3Wu7awQKILH4cOXDt1She7nubo/0wUXWtOqn//6Tx6Nu2GtPr
        Xpf+KtZvX0gUuVrfNDYTzqPyYgWr8OaUxqJI+P3VunqVfvRBVGq1JA/zmIMvGD/3Yu1JsLrFZrjat
        DW/DOKkKCp9OUzfAoUfzxdPBc8CT2G0WymUYIExxrBu6onr0FFy22Tgw6oC+PlTR+PesxzKy8ZSH5
        GZhGFnvs9jVNCXIHIXE/okvDEz9CLUN/GEUcFe8+4TPao778oQZCbl2PitW1Z+kf+9JwcY9IcBXDf
        3DtpqJsQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoik-00AO4b-RS; Wed, 12 May 2021 13:16:15 +0000
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
Subject: [PATCH 10/15] block: use SLAB_TYPESAFE_BY_RCU for the bio slab
Date:   Wed, 12 May 2021 15:15:40 +0200
Message-Id: <20210512131545.495160-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
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
2.30.2

