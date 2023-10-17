Return-Path: <linux-fsdevel+bounces-565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271887CCE99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578D91C20CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913112E416;
	Tue, 17 Oct 2023 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1692E405
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:23 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887ABA;
	Tue, 17 Oct 2023 13:48:21 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57b8cebf57dso3235119eaf.0;
        Tue, 17 Oct 2023 13:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575701; x=1698180501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oerpJ9CuDBWq3MQr5Gs8nB1eNmQFO47LyUbsIakiSyk=;
        b=uarBHyufmoRNgv+FCRjM0PD8d5MX0iAS8XV72qePPUaK3JI179fP//MUuIGO8kaYpl
         731IlX9ynjYK8QBrnLYca6X0HD10VCnauv73VqgjHp1VXPucE0svq7iQwbUgAUvzx+i1
         mpQZKne9IgqLLTlGy/br3u+X7si/rr5yNVeOdjuid4n8Zkg4TEMjxm5H0Le/ytKUFRA3
         IS4RFosUrqIIPgYaIZQDVydmgPA2zKzP+VyQSCQgVgig1gyHGRu80UNwYD11/Qr8U3HW
         viw7HZUFnuoUOWeJHrLCrGbomywtEmUOsfVnp12+fUgBY0/wBOvPgl4ossLqrZFuWkv5
         au0Q==
X-Gm-Message-State: AOJu0Yy16A0u8WkrqWDrKVYt+3w7qr/MaPz46iRz3c9WwzLVb6F6YEA/
	7Z/PCYbxVDbnu1o1xmpYBSc=
X-Google-Smtp-Source: AGHT+IHSHy1lg+QFVKlHSx9HOjVcNCKEh+vRH955EmvGGpVXCsX5+UmwP8rcx8afz6dKZUCiv8ZpXw==
X-Received: by 2002:a05:6358:3106:b0:166:e1cc:bc27 with SMTP id c6-20020a056358310600b00166e1ccbc27mr2588671rwe.10.1697575701087;
        Tue, 17 Oct 2023 13:48:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:20 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 03/14] fs: Restore write hint support
Date: Tue, 17 Oct 2023 13:47:11 -0700
Message-ID: <20231017204739.3409052-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017204739.3409052-1-bvanassche@acm.org>
References: <20231017204739.3409052-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initialize the bio lifetime to the data lifetime information that is
available in struct inode. This patch reverts a small subset of commit
c75e707fe1aa ("block: remove the per-bio/request write hint").

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/fops.c           | 3 +++
 fs/iomap/buffered-io.c | 2 ++
 fs/iomap/direct-io.c   | 1 +
 fs/mpage.c             | 1 +
 4 files changed, 7 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..c9ca9f0fd48f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -74,6 +74,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	bio.bi_lifetime	= iocb->ki_filp->f_inode->i_write_hint;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -206,6 +207,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
+		bio->bi_lifetime = iocb->ki_filp->f_inode->i_write_hint;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
@@ -323,6 +325,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
+	bio->bi_lifetime = iocb->ki_filp->f_inode->i_write_hint;
 
 	if (iov_iter_is_bvec(iter)) {
 		/*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 644479ccefbd..fe82c8882c62 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1660,6 +1660,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
+	bio->bi_lifetime = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1690,6 +1691,7 @@ iomap_chain_bio(struct bio *prev)
 	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_lifetime = prev->bi_lifetime;
 
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..df095b9700a7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -381,6 +381,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		bio->bi_lifetime = dio->iocb->ki_filp->f_inode->i_write_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..19b7ced1a9aa 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -612,6 +612,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
+		bio->bi_lifetime = inode->i_write_hint;
 	}
 
 	/*

