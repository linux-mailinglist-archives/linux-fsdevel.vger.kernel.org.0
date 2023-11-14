Return-Path: <linux-fsdevel+bounces-2859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116787EB8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 22:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4286B1C204F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 21:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACF033072;
	Tue, 14 Nov 2023 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC92FC58;
	Tue, 14 Nov 2023 21:42:10 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A1D6;
	Tue, 14 Nov 2023 13:42:07 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc34c3420bso48061205ad.3;
        Tue, 14 Nov 2023 13:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998126; x=1700602926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zKJwlNU37xBJ2eHozPULDjMADCdbgGWOVklVioEvRw=;
        b=XIwRWPdxScx8za+3JjGFIVQBLSoFpP/zEZOYdV5la19yK4h9FC9mCpxeJH6L9/7TS5
         tVBBFOsHQEJM/puzSz+fedASXCOM5zGSi1OwH9m6SbmUaaViZ1DkfKRB+SlYSI4lWK9A
         BbVuMkIt5bC+ZeDXExzW+ubbWLbC2EnwF2RFfB1ccOAaqGeR10jjjyNvmKFTXYhPkxJ8
         whuL34YrrDA5bLVYUB5UPMw5VIGcQ4rrxrv8d9bPfqERi6C4S0VxSiUsmFVv8rLdTrAF
         YAG+KidFcp/55HLx3FvAylKg2b4cHCatlPIBTd5bEeUi+j0ajWKpWHnwWQdR/M4BzJRp
         /3+Q==
X-Gm-Message-State: AOJu0Yxlf16JosGKHkyMwa7Oyxw44rMhZ3u9vw+iGwurcXAXLwpwSy7r
	kte4bYTPhJUKQ8UcqwcmZvo=
X-Google-Smtp-Source: AGHT+IH6rizr6jRAtVoQLL5iUZbC62CB0GXCab5dtLe57kKVDjwQDE4tkYks8Vi2ockeBxftj+Fz8g==
X-Received: by 2002:a17:902:c943:b0:1cc:23ea:47b2 with SMTP id i3-20020a170902c94300b001cc23ea47b2mr3777929pla.37.1699998126395;
        Tue, 14 Nov 2023 13:42:06 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:05 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v4 03/15] block: Restore data lifetime support in struct bio and struct request
Date: Tue, 14 Nov 2023 13:40:58 -0800
Message-ID: <20231114214132.1486867-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114214132.1486867-1-bvanassche@acm.org>
References: <20231114214132.1486867-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a mechanism for filesystems to pass data lifetime information
to block drivers. Data lifetime information can be used by block devices
with append/erase storage technology (NAND flash) to reduce garbage
collection activity.

This patch restores a subset of the functionality that was removed by
commit c75e707fe1aa ("block: remove the per-bio/request write hint").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c                 | 2 ++
 block/blk-crypto-fallback.c | 1 +
 block/blk-merge.c           | 6 ++++++
 block/blk-mq.c              | 1 +
 block/bounce.c              | 1 +
 include/linux/blk-mq.h      | 2 ++
 include/linux/blk_types.h   | 2 ++
 7 files changed, 15 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..1a3733635079 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_opf = opf;
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
+	bio->bi_lifetime = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -813,6 +814,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
+	bio->bi_lifetime = bio_src->bi_lifetime;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..e25a6d551594 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -172,6 +172,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_lifetime	= bio_src->bi_lifetime;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..62718cc871bd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -814,6 +814,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (rq_data_dir(req) != rq_data_dir(next))
 		return NULL;
 
+	if (req->lifetime != next->lifetime)
+		return NULL;
+
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -941,6 +944,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
 
+	if (rq->lifetime != bio->bi_lifetime)
+		return NULL;
+
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a815403f375c..10540a3b3c49 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3148,6 +3148,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
 	rq->ioprio = rq_src->ioprio;
+	rq->lifetime = rq_src->lifetime;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9a1..b03e4944ace8 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -169,6 +169,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_lifetime	= bio_src->bi_lifetime;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..1afd731432fe 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -136,6 +136,7 @@ struct request {
 #endif
 
 	unsigned short ioprio;
+	enum rw_hint lifetime;
 
 	enum mq_rq_state state;
 	atomic_t ref;
@@ -957,6 +958,7 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
 	rq->ioprio = bio_prio(bio);
+	rq->lifetime = bio->bi_lifetime;
 }
 
 void blk_mq_hctx_set_fq_lock_class(struct blk_mq_hw_ctx *hctx,
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..5e21f44141fb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,6 +10,7 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
+#include <linux/rw_hint.h>
 
 struct bio_set;
 struct bio;
@@ -269,6 +270,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
+	enum rw_hint		bi_lifetime;	/* data lifetime */
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 

