Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBE37BDEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhELNRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhELNRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74DC06175F;
        Wed, 12 May 2021 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cip8QuGapJKK/MhB2XsoYdZA3zqeZUY0CVfq2URO9Xg=; b=I9bq6HHATiJjZhPNPHbuetFzEG
        tRlh9gDciQmLIsfWsrtD4IqdtjdqZvyfR9/l8ycOajh0hsZgSJFwwbw93Ujrh57kzKiDRx7qznEe+
        McjVaK7cTZfhY2g3GL2MzYcpfQVco0ZoDUgdc2i9/M0S0qT/3yuXzMLP+JxJkyXptE6iAngogIwEs
        UsvCbNm9cTPSjlMpWhC+8r3kZu/zycKip9/ibXfJZbJCD6WhHUzYwBn4sbWuVXGceSOCklrJWe469
        ErohXSD5afx47eKryjsNjGrfeza5pfAZO49t+j4xssN2Spr0/gsOlExTB1q1w/zNpmKvW/s64+zf4
        18HgtwZQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoin-00AO4l-Ky; Wed, 12 May 2021 13:16:18 +0000
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
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/15] block: define 'struct bvec_iter' as packed
Date:   Wed, 12 May 2021 15:15:41 +0200
Message-Id: <20210512131545.495160-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

'struct bvec_iter' is embedded into 'struct bio', define it as packed
so that we can get one extra 4bytes for other uses without expanding
bio.

'struct bvec_iter' is often allocated on stack, so making it packed
doesn't affect performance. Also I have run io_uring on both
nvme/null_blk, and not observe performance effect in this way.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0c4f41dfc83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,7 +43,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-};
+} __packed;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.30.2

