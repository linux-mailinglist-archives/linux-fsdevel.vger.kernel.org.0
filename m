Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872631D4744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEOHlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726624AbgEOHle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:41:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD219C061A0C;
        Fri, 15 May 2020 00:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5F5020LXe/PKeW2E7HP+KIsjpPbHby4z569GcXavvzw=; b=HbpcDNi3cjt95r1YCRFokz/Cxj
        P+8RahgC1lAn/32KwuHkV4Lvhyhsk97XCxxP0im6h+5rMpUaSLveo3+kRZlKvMsoccaigaCPWm1cy
        qLJ0wTKT1MLNqAGARFe/2g2elZChAcggp62D7/BfxeDnVplokiU+xeDaFSkipusQsgp50BZkC4QCs
        1GC5JyHov7b6RP7pfumvwoG8cFIdaqTzqMYYr19s9rekZo9R5CGENqmBlqKBDBqmSGhAo6+3NJkic
        Hk5pup2crDyCB948jsfNP0kCfoLy2tU6hHMpyfWcRcJLPEHubtPFNggqhzA2Eerfysdcuiz7ClvSL
        fAiHMJXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZUyF-0005Jq-7l; Fri, 15 May 2020 07:41:27 +0000
Date:   Fri, 15 May 2020 00:41:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 00/12] Inline Encryption Support
Message-ID: <20200515074127.GA13926@infradead.org>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
 <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 09:48:40AM -0600, Jens Axboe wrote:
> I have applied 1-5 for 5.8. Small tweak needed in patch 3 due to a header
> inclusion, but clean apart from that.

I looked at this a bit more as it clashed with my outstanding
q_usage_counter optimization, and I think we should move the
blk_crypto_bio_prep call into blk-mq, similar to what we do about
the integrity_prep call.  Comments?

---
From b7a78be7de0f39ef972d6a2f97a3982a422bf3ab Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 15 May 2020 09:32:40 +0200
Subject: block: move blk_crypto_bio_prep into blk_mq_make_request

Currently blk_crypto_bio_prep is called for every block driver, including
stacking drivers, which is probably not the right thing to do.  Instead
move it to blk_mq_make_request, similar to how we handle integrity data.
If we ever grow a low-level make_request based driver that wants
encryption it will have to call blk_crypto_bio_prep manually, but I really
hope we don't grow more non-stacking make_request drivers to start with.

This also means we only need to do the crypto preparation after splitting
and bouncing the bio, which means we don't bother allocating the fallback
context for a bio that might only be a dummy and gets split or bounced
later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 13 +++++--------
 block/blk-mq.c   |  2 ++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1e97f99735232..ac59afaa26960 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1131,12 +1131,10 @@ blk_qc_t generic_make_request(struct bio *bio)
 			/* Create a fresh bio_list for all subordinate requests */
 			bio_list_on_stack[1] = bio_list_on_stack[0];
 			bio_list_init(&bio_list_on_stack[0]);
-			if (blk_crypto_bio_prep(&bio)) {
-				if (q->make_request_fn)
-					ret = q->make_request_fn(q, bio);
-				else
-					ret = blk_mq_make_request(q, bio);
-			}
+			if (q->make_request_fn)
+				ret = q->make_request_fn(q, bio);
+			else
+				ret = blk_mq_make_request(q, bio);
 
 			blk_queue_exit(q);
 
@@ -1185,8 +1183,7 @@ blk_qc_t direct_make_request(struct bio *bio)
 		return BLK_QC_T_NONE;
 	if (unlikely(bio_queue_enter(bio)))
 		return BLK_QC_T_NONE;
-	if (blk_crypto_bio_prep(&bio))
-		ret = blk_mq_make_request(q, bio);
+	ret = blk_mq_make_request(q, bio);
 	blk_queue_exit(q);
 	return ret;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2962863e629f..0b5a0fa0d124b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2033,6 +2033,8 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(q, &bio, &nr_segs);
 
+	if (!blk_crypto_bio_prep(&bio))
+		return BLK_QC_T_NONE;
 	if (!bio_integrity_prep(bio))
 		return BLK_QC_T_NONE;
 
-- 
2.26.2

