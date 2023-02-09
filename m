Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE406908E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 13:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBIMc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBIMcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:32:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A55458A8;
        Thu,  9 Feb 2023 04:32:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C14BD5CD3F;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675945928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4YzEDZhbZdKkFvOQCglyrSCzoeelXH4IjxGuMgcIuI=;
        b=pjxawkS2M5eKtz+GvnFcwC3DumjXALkEbDbPF91RQx02g3wjQBIzQi4mCISPDoSsBoL4Xi
        wL0ngBcGrP8a0GtG11zkPsaYhCXxBGa6scHo8BbZ69maWRf4CZMbP0FGw84fD5+jWJhiWE
        2h36ZO528VX7rfBPNOFd03t2UOb/ICA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675945928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4YzEDZhbZdKkFvOQCglyrSCzoeelXH4IjxGuMgcIuI=;
        b=rf210Vg2rgxIgw/9j5VnOvMLK0w+h57Pg9o/62a/gCRrE2cwDHaioTMHTfFKyhK4yfXYFe
        VQ9tKoOkgNBydzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B492B139F2;
        Thu,  9 Feb 2023 12:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 09CUK8jn5GO9WQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 12:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9287CA06E5; Thu,  9 Feb 2023 13:32:06 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] block: Add support for bouncing pinned pages
Date:   Thu,  9 Feb 2023 13:31:56 +0100
Message-Id: <20230209123206.3548-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209121046.25360-1-jack@suse.cz>
References: <20230209121046.25360-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=jack@suse.cz; h=from:subject; bh=ySGZI321J27eApFzVattmpJixQBZTKd7s8yJo1X4JsE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj5Oe8plEW0pwe+Dk1xJcazzMB4gHRAhaEHGaQlPvh 56PwkpSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY+TnvAAKCRCcnaoHP2RA2UHTB/ 0WkGI1SDnTpE9KpeTWCk+9R/550O0Rz5rWMUoBpf1PMa95WCDtrUIkkxJvLNbDnh2x+VWkKkfbjVkG AkM0oPtb2dPBP9NMrcVNUySfE1XzAXtQiRbNFXZ8rg8D6fPFr7YEmIBiXeF4MRrlCoyGiVYe0+zpPP 39+n/mh9zqM5EqZenvv3yVz5DiiEiNvT9BbLA8PXvL/vBHJRPc0sIUG8MvGG3IN0jNU6rJLnekH4pD v7yq4ydH6d5+WJil/eCppbVtvpB4OCJfo6hHlsCRHmRAiZ5GX4avezcyYpdrvDozSpZYvCPbBOiwwO g1Y+iYUj3t99FtvISsIjJWbNAJWYJv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When there is direct IO (or other DMA write) running into a page, it is
not generally safe to submit this page for another IO (such as
writeback) because this can cause checksum failures or similar issues.
However sometimes we cannot avoid writing contents of these pages as
pages can be pinned for extensive amount of time (e.g. for RDMA). For
these cases we need to just bounce the pages if we really need to write
them out. Add support for this type of bouncing into the block layer
infrastructure.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk.h               | 10 +++++++++-
 block/bounce.c            |  9 +++++++--
 include/linux/blk_types.h |  1 +
 mm/Kconfig                |  8 ++++----
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 4c3b3325219a..def7ab8379bc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -384,10 +384,18 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
 		max_low_pfn >= max_pfn;
 }
 
+static inline bool bio_need_pin_bounce(struct bio *bio,
+		struct request_queue *q)
+{
+	return IS_ENABLED(CONFIG_BOUNCE) &&
+		bio->bi_flags & (1 << BIO_NEED_PIN_BOUNCE);
+}
+
 static inline struct bio *blk_queue_bounce(struct bio *bio,
 		struct request_queue *q)
 {
-	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
+	if (unlikely((blk_queue_may_bounce(q) || bio_need_pin_bounce(bio, q)) &&
+		     bio_has_data(bio)))
 		return __blk_queue_bounce(bio, q);
 	return bio;
 }
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9a1..ebda95953d58 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -207,12 +207,16 @@ struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
 	struct bvec_iter iter;
 	unsigned i = 0, bytes = 0;
 	bool bounce = false;
+	bool pinned_bounce = bio_orig->bi_flags & (1 << BIO_NEED_PIN_BOUNCE);
+	bool highmem_bounce = blk_queue_may_bounce(q);
 	int sectors;
 
 	bio_for_each_segment(from, bio_orig, iter) {
 		if (i++ < BIO_MAX_VECS)
 			bytes += from.bv_len;
-		if (PageHighMem(from.bv_page))
+		if (highmem_bounce && PageHighMem(from.bv_page))
+			bounce = true;
+		if (pinned_bounce && page_maybe_dma_pinned(from.bv_page))
 			bounce = true;
 	}
 	if (!bounce)
@@ -241,7 +245,8 @@ struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
 	for (i = 0, to = bio->bi_io_vec; i < bio->bi_vcnt; to++, i++) {
 		struct page *bounce_page;
 
-		if (!PageHighMem(to->bv_page))
+		if (!((highmem_bounce && PageHighMem(to->bv_page)) ||
+		      (pinned_bounce && page_maybe_dma_pinned(to->bv_page))))
 			continue;
 
 		bounce_page = mempool_alloc(&page_pool, GFP_NOIO);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..3aa1dc5d8dc6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -321,6 +321,7 @@ enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
+	BIO_NEED_PIN_BOUNCE,	/* bio needs to bounce pinned pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..eba075e959e8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -659,11 +659,11 @@ config PHYS_ADDR_T_64BIT
 config BOUNCE
 	bool "Enable bounce buffers"
 	default y
-	depends on BLOCK && MMU && HIGHMEM
+	depends on BLOCK && MMU
 	help
-	  Enable bounce buffers for devices that cannot access the full range of
-	  memory available to the CPU. Enabled by default when HIGHMEM is
-	  selected, but you may say n to override this.
+	  Enable bounce buffers. This is used for devices that cannot access
+	  the full range of memory available to the CPU or when DMA can be
+	  modifying pages while they are submitted for writeback.
 
 config MMU_NOTIFIER
 	bool
-- 
2.35.3

