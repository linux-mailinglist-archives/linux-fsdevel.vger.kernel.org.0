Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA96CF058
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjC2RH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjC2RHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCD6A4F;
        Wed, 29 Mar 2023 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109603; x=1711645603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wcbMmuj5KLOp188zkhhO4UTGZgDj+uEBsLMZXWyJQ1M=;
  b=O+q6VPzhmhRlwRjIGIRBN4ur4lBOM6QjmWqdRvAEU53PaCsGkgm/A216
   iityqhkqIfX3MeuudrRGjksg9TdDH8L8xiytInd2cJuuzbjennJ3Z+e3V
   yqPXGuhxnOhD9ItiyRFMNC6D492v0Ptjl7/CwdfvBL6t6FgTtH1J66BuS
   0VUzYeIu/qwrafoVKV3bFg59tZANAWT1rGEM4yAjW/+PmLM9J527GH7ln
   iFVX2zwOZbInDYFY98i99HOdYllPDM9OwpZKh6/SbQdxPFo3fbde3rsut
   oqAJhgHEeem0HUWg0aMw1Yu79D2iJdlrb+P9lkrCbZbdShQ9X9yULWcKj
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092861"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:43 +0800
IronPort-SDR: Y77goxYdN8GidsVbj/KOZzQ3U/6TqJNxSrD0GVs4QKOAlZNnGx6ZtqGLo5B2Lqd9lnZ9Ogq/HK
 rhr5YsdNiEQuWh7pfffT2dlZg0ud68Rhx5/xA+jtZYWdgkzGibtPHcRRERZUjjdO4Ab4Q1l5pq
 tlYvSo9zYnb6mTPhiRCjFwGmSZ1EG6spADjNhKTQZD5O+7BXp9xyL5tO+KnmkRYZyfZSw7/wCI
 wJTnJHOsVBzLWi+iHioYduaz5ckxBn5X1Vwf2+u3tH9X52DGfmhUPWc9oAqoNWK/e7yMook3a6
 X7Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:53 -0700
IronPort-SDR: K3LvTn2mgS4z3aUZiHti9nEkM7pjvbBH6ZS/kYcx3E/VzjPdX+tted0ood1vYEc+vc7pbp55fL
 71ZnHrIDtp/LZ0g7xWSsFjKZVDSjmWu1MIOcddLaQ0QQ8DiFvqGt1SHDGt+30EdZYwUUss3ZJ5
 KHpYJp5gqdZMg4wYwQ+fxuyfJ4v5Ag1shD0OnVsp1Xt+MyUCPRAm3nfZVTezAdIkfloHRGP7Kb
 R4SjVt0dhflNVTvL7W5jpm1ArkajddHLuecePRmkHp+nFFOhkLEqvaqFM/RyBRB4b76XC4/FNz
 P4E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/19] btrfs: repair: use __bio_add_page for adding single page
Date:   Wed, 29 Mar 2023 10:05:54 -0700
Message-Id: <faae16612c163bd6e65cf3d629b0a3c65666821b.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The btrfs repair bio submission code uses bio_add_page() to add a page to
a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 726592868e9c..73220a219c91 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -224,7 +224,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 	repair_bio = bio_alloc_bioset(NULL, 1, REQ_OP_READ, GFP_NOFS,
 				      &btrfs_repair_bioset);
 	repair_bio->bi_iter.bi_sector = failed_bbio->saved_iter.bi_sector;
-	bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
+	__bio_add_page(repair_bio, bv->bv_page, bv->bv_len, bv->bv_offset);
 
 	repair_bbio = btrfs_bio(repair_bio);
 	btrfs_bio_init(repair_bbio, failed_bbio->inode, NULL, fbio);
-- 
2.39.2

