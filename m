Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F171676459
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjAUGvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjAUGvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C276AF7A;
        Fri, 20 Jan 2023 22:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=39g0q2GMkNoet87PSAKRXEi57Kz06JxJxed5jImNYqs=; b=scfHmbkpJOLfYvXGcV6I2DfMd5
        LQrdEvNfU1eTndGNfskx0pdds1Y8ipWwDFlDGycNthu5iQxk/ouyFBjyIFk9CZKS0+WonU45VfqeY
        m+VdmxOOfOu10RfWw+Q1f0xfKdK0eJ4MtHEWVpeooo7lDwTXU9Fwmz6jqqJNfJZ6qaggD2B/mmA1P
        bwOdrDKGn6U898zPnaX2DY+/mIqCVO6Pv50PB11E6vNIt3PfnHI4DMFmVNv0iCYL9fQ04x1I3Yfot
        IwtTxanUk8Z5nf63xKby5Ut3gcNr2yqeAWkWTYsd+2fH/W/yl596Z+cQhjqgD+Qf9afLeXEKZNG9a
        E/4WCpTg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iQ-00DROU-Jz; Sat, 21 Jan 2023 06:51:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/34] btrfs: remove btrfs_bio_free_csum
Date:   Sat, 21 Jan 2023 07:50:08 +0100
Message-Id: <20230121065031.1139353-12-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_bio_free_csum has only one caller left, and that calle is always
for an data inode and doesn't need zeroing of the csum pointer as that
pointer will never be touched again.  Just open code the conditional
kfree there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c |  3 ++-
 fs/btrfs/bio.h | 10 ----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index d1a545158bb0a0..cdee76e3a6121a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -226,7 +226,8 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio,
 		offset += sectorsize;
 	}
 
-	btrfs_bio_free_csum(bbio);
+	if (bbio->csum != bbio->csum_inline)
+		kfree(bbio->csum);
 
 	if (unlikely(fbio))
 		btrfs_repair_done(fbio);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 8d69d0b226d99b..996275eb106260 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -94,16 +94,6 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	bbio->end_io(bbio);
 }
 
-static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-{
-	if (bbio->is_metadata)
-		return;
-	if (bbio->csum != bbio->csum_inline) {
-		kfree(bbio->csum);
-		bbio->csum = NULL;
-	}
-}
-
 /*
  * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
  *
-- 
2.39.0

