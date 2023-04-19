Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131A6E7BD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjDSOLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjDSOLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:11:02 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABC414467;
        Wed, 19 Apr 2023 07:10:44 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f1763eea08so21543305e9.2;
        Wed, 19 Apr 2023 07:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913443; x=1684505443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSziFxMRLlc78BEY3ZIcArKRUqB+ur0VzFu/o2eWTQg=;
        b=hsgTS+FG82RjOZbneXd3DxidjeSvY0N/s1UTGQ68lALHwiYdHvzCW9FA4aSclKLuu+
         fQCwEBipitVHmRigVDC51hPJwVMsAm3o3ghb1ZJzg4ZDpdF+2anf2vqNKcCULBsyD/29
         +DdrBwscCFOgTZ4+EF1FSIGTQbdGtLxAR5oYU2mJqQX7NeL89J4y7PnZmmrWJr/jf24t
         f8Vi7UMvNm0CljViT9nFKhZcM8H77ftoSjQ7tsbFx0ufosSeTuIF2zy/zPBDK9lmojMj
         26wdK1P+ZNDyZwcqQTKjG+UrUgFew1ynMaFlx0YApoML8wk4AHVAq5DbnlVUr18AoUf/
         F7wg==
X-Gm-Message-State: AAQBX9c289qHcbqkNI+CtLPP+XHtmtjtlRohbpW/eryoJOmK1I1fmNWf
        ACISegocPk0MWIueYa6Y8mM=
X-Google-Smtp-Source: AKy350ZNLghyp21Md4xzCnKC/CZ1jD7PS3tRxkpm7/A6UV4bbe7dKQsIepFwKTi5j5wXVP+SbzJYCg==
X-Received: by 2002:a5d:6a45:0:b0:2d3:bde8:9ff with SMTP id t5-20020a5d6a45000000b002d3bde809ffmr4938443wrw.34.1681913442744;
        Wed, 19 Apr 2023 07:10:42 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:42 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     axboe@kernel.dk
Cc:     johannes.thumshirn@wdc.com, agruenba@redhat.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 09/19] btrfs: raid56: use __bio_add_page to add single page
Date:   Wed, 19 Apr 2023 16:09:19 +0200
Message-Id: <20230419140929.5924-10-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419140929.5924-1-jth@kernel.org>
References: <20230419140929.5924-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The btrfs raid58 sector submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 fs/btrfs/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 642828c1b299..c8173e003df6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1108,7 +1108,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
-- 
2.39.2

