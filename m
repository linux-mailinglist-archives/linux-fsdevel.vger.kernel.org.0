Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496B731D407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBQCtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:49:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:54813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBQCtR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:49:17 -0500
IronPort-SDR: lEyuVT08owUMycw9JzL008vbOfC1YTohkqcAi8pOTWajr3zlj2fmTfqpgVD3ayoDC5Cf0KWjHc
 RX55TiuUpLTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247152597"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247152597"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:37 -0800
IronPort-SDR: won9GElpyf/mmgQjIw0Bm5UnBTO8WiUreqoAca3j8srJDIXe2GSLkSOQnL3uzXoBtOzvup+3hh
 zMEyPXbpveTQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="384922288"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:36 -0800
From:   ira.weiny@intel.com
To:     David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] fs/btrfs: Use kmap_local_page() in __btrfsic_submit_bio()
Date:   Tue, 16 Feb 2021 18:48:25 -0800
Message-Id: <20210217024826.3466046-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Again there is an array of pointers which must be unmapped in the correct
order.

Convert the kmap()'s to kmap_local_page() and adjust the unmapping
to work backwards through the unmapping loop.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/btrfs/check-integrity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 6ff44e53814c..726eb894be8b 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -2677,7 +2677,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 	dev_state = btrfsic_dev_state_lookup(bio_dev(bio) + bio->bi_partno);
 	if (NULL != dev_state &&
 	    (bio_op(bio) == REQ_OP_WRITE) && bio_has_data(bio)) {
-		unsigned int i = 0;
+		int i = 0;
 		u64 dev_bytenr;
 		u64 cur_bytenr;
 		struct bio_vec bvec;
@@ -2702,7 +2702,7 @@ static void __btrfsic_submit_bio(struct bio *bio)
 
 		bio_for_each_segment(bvec, bio, iter) {
 			BUG_ON(bvec.bv_len != PAGE_SIZE);
-			mapped_datav[i] = kmap(bvec.bv_page);
+			mapped_datav[i] = kmap_local_page(bvec.bv_page);
 			i++;
 
 			if (dev_state->state->print_mask &
@@ -2715,8 +2715,8 @@ static void __btrfsic_submit_bio(struct bio *bio)
 					      mapped_datav, segs,
 					      bio, &bio_is_patched,
 					      bio->bi_opf);
-		bio_for_each_segment(bvec, bio, iter)
-			kunmap(bvec.bv_page);
+		for (--i; i >= 0; i--)
+			kunmap_local(mapped_datav[i]);
 		kfree(mapped_datav);
 	} else if (NULL != dev_state && (bio->bi_opf & REQ_PREFLUSH)) {
 		if (dev_state->state->print_mask &
-- 
2.28.0.rc0.12.gb6a658bd00c9

