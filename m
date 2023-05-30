Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496357167E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjE3Pvm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjE3Puy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:54 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD611C;
        Tue, 30 May 2023 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461825; x=1716997825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wr+M2zDQXb1A/M8JUY7t1USwG0IIo/LDQXKOrkxoR08=;
  b=QSJMo5XpoNnAQGoDNxkamwqVQnMHQfdJ0TDjpmDpdpYq/lcKcnbeFnK0
   T2Q4vv/i3xInZiIRUOBz51PZfB0NnqgugF6EX0de/BKG+iaI+gwfS/OW5
   7r3sswKCItAw5Wmqbpqf509cLsdjXiIWF5OHKkTN4234bzZtaEsYnMaaM
   IQTEMoOKjE/ShH3GXxw17r4WpqBxzUmfpBbTYuLSnVSWlNxt9QI5ImGVO
   f2OcggSd2AdZTh0TOmtdwVj3eRVMjm0JloQ79NbZaJm/HiI0MuBhSQBac
   +2xthwvVtHieyUVvKD6Fw2Lk6Wy+mnV5tEp/pX2r+wHvxb9L1bc8qdQle
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129886"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:25 +0800
IronPort-SDR: qdovWz0j7zcTR1bkylCQiRKBjWIOtBNmoU6eNp2HpasxcowKRNf1fCVcnLfND7iq1jnCxRHFXl
 Dr4CP2hTc82QNPSHdAxZCO1GEWBgYY84IyTKmu8Nq2WhA916sPwVWAnE6Ja2zGXyBoVgFPlPmT
 vCToUeWV59j61NwPALba6U384ndgSRMVrVCxcyVwxjC1FSmmcIFFN/pynC1U+kHeqX2mnJ/aGS
 +fa6jnBVgBog84RfHxz/knvHKbjYujazcX3rRnC71MeHIMTt5e2VBa5zGDnG+VPvB8ULgYTUyU
 oc0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:19 -0700
IronPort-SDR: ZseWV5fWdzcZGsBvaK1MnzJbe6LJ/RDHXZo6rvQuZIvPrGhH7sOBfNMut82zppqTmYnoXKTB7z
 QrMk0hDekgJdL7i7w/cfcGZBQUO8WxGw7qvwaCfyj9g9v8vpCBL79fSHs9c7ocbmkyi+tKeTnl
 5yWwIot/krgGKEZrPU2K+W7DW94upy4aq9B0nKyn95xRamrF3GJ6KUciaCyMyK5wqC2s2vs9RF
 va9UVub6OltLs9qszN3A4HrAJxFVHZVWU6ZfU0MHB8DAntksi1VUcnPRTCZpwc76EDliVEcshA
 NQc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:21 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 18/20] block: add __bio_add_folio
Date:   Tue, 30 May 2023 08:49:21 -0700
Message-Id: <5a142a7663a4beb2966d82f25708a9f22316117c.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like for bio_add_pages() add a no-fail variant for bio_add_folio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 8 ++++++++
 include/linux/bio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46eb..350c653d4a57 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+void __bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		     size_t off)
+{
+	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(off > UINT_MAX);
+	__bio_add_page(bio, &folio->page, len, off);
+}
+
 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
  * @bio: BIO to add to.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5d5b081ee062..4232a17e6b10 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,6 +473,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+void __bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.40.1

