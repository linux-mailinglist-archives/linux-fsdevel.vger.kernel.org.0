Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF86E7BBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjDSOLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjDSOLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:11:02 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7078AF0C;
        Wed, 19 Apr 2023 07:10:42 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f17f31c258so6349815e9.0;
        Wed, 19 Apr 2023 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913441; x=1684505441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHB27r2VAJYtptv/DszRuaYXLzHwMALFS99ixQeQIrk=;
        b=FWG2Jhwog7lwdl/FDPUPAzxhiMkNoJe+QiboItemkqc4nvihGFt2GQ0e3x+guShgfJ
         InyzpPjguhyVYBBo2Yboe8wYy58qQUFPd0+4p2jditMtzt7FKnzQ+x4+2IvtAyw99iKy
         GufYomgBU02/JnAm2O+NOCfHy+yXcViKX5N+oxA+RaTabMXiQ1yAUHmN3+EjUj5ZPct4
         QQYS3JENCmFgkX3sHkAKOdK9vJlUZh4SHUF8UXDONBQ/cnXKrl/44PIoQ+k9F2FHcCQL
         zescnmyq1vtPLbNHaiebUCBSmyIgx76Uh4hfEbdWc6adzxcg40VFiOOZfYj/nLHfe+7/
         gIXA==
X-Gm-Message-State: AAQBX9esJ9r35vZAhp8FVigKZFUqmmciSTnXZq3/Ouq2VYOPGSGrV6Gk
        /FImx60hSptoHtfTmStZfwk=
X-Google-Smtp-Source: AKy350Yzi76bXam/T5ppDWB23h4mS+GurlXtWZ/gJi0rAcUNNcaqO1+varQiNYt0Qa9LFt3v3G5TJA==
X-Received: by 2002:a5d:4411:0:b0:2cf:e517:c138 with SMTP id z17-20020a5d4411000000b002cfe517c138mr4900340wrq.66.1681913441132;
        Wed, 19 Apr 2023 07:10:41 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:40 -0700 (PDT)
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
Subject: [PATCH v3 08/19] btrfs: repair: use __bio_add_page for adding single page
Date:   Wed, 19 Apr 2023 16:09:18 +0200
Message-Id: <20230419140929.5924-9-jth@kernel.org>
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

The btrfs repair bio submission code uses bio_add_page() to add a page to
a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

