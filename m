Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C56E7BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjDSOML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjDSOLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:11:22 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFB16F89;
        Wed, 19 Apr 2023 07:11:01 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f17b967bfbso33329165e9.1;
        Wed, 19 Apr 2023 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681913460; x=1684505460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExnlLXqiP3hLS8bpFiqaYIxJLAKQF5DCX5VPxtSPsPo=;
        b=C1F7xo/X//QRE7wFkbsq/0iZKIo0+cdZKuXXwnQGlDVBJt2v9FvzQw/lRZnX63rlS3
         HUBPsQyPdYDDcdenJ+vjfGWnm5l6RuX2Mw/LR4RuistP4HTs5RcfBCCuBKOfni4CRmAy
         qOYiBn0f1HL3kdei94VjP/gIUkeYTxMx8Fkv5bMNLB7EROFm3vN4ORVLjMXnFoyB06F8
         c9SdI+1hrjKe7FSSQxP2QeG4d5W/P8LXdDU9XtLhalwryc5uOkLGZlv2pKVp5Bk0XAfv
         B65JfZkLjgaEQuNz5LPVQ/nOR4p6/KMZIHD8KxY32wcyO85uqZmhb65VeFFuVKFhDnqs
         SFdQ==
X-Gm-Message-State: AAQBX9dGKcRLAgHL6YUIuBt6D8no4LgUsVNW9xP/zJsWW8hB64IqXbvO
        D/IyaSK74uPywIsqNzUInik=
X-Google-Smtp-Source: AKy350a8brYKmUYvrzlJUafn/qJwxJEsZNYSYhzDz8VqjHAs/A8j+oRFG+qGVgXdrE5NcZ5HHKx+1Q==
X-Received: by 2002:adf:f111:0:b0:2fa:2f1e:c1a8 with SMTP id r17-20020adff111000000b002fa2f1ec1a8mr2109123wro.3.1681913460203;
        Wed, 19 Apr 2023 07:11:00 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm7612089wrv.58.2023.04.19.07.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:10:59 -0700 (PDT)
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
Subject: [PATCH v3 19/19] block: mark bio_add_page as __must_check
Date:   Wed, 19 Apr 2023 16:09:29 +0200
Message-Id: <20230419140929.5924-20-jth@kernel.org>
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

Now that all users of bio_add_page check for the return value, mark
bio_add_page as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..0f8a8d7a6384 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -465,7 +465,7 @@ extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
-int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
 bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-- 
2.39.2

