Return-Path: <linux-fsdevel+bounces-17998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF08B49BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECBC282059
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7405664;
	Sun, 28 Apr 2024 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cMW4/Res"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E305321D;
	Sun, 28 Apr 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281262; cv=none; b=N82d8qBnrkwqcSfXlAKo2nv4zv6+1GF3VELAm67vRDQz3uK4vv1bxtlHfnfJ2oW1pArfU6qqSvu07IqiH11vAEAVeHvgU2BJmIuYQBtBj680jHV7+/9UxKNaXWzF6BYGZV3tMF7EmGiu9L1IZ9nMi3uFqrkTfcX2yt6N/fK1FJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281262; c=relaxed/simple;
	bh=vQNaJRrJFrPBj/Dg76/OdGcf68/bXLwjvoY8PfjhDFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU31HJE1KDwhfn3GFWRh3drqHDeJy0J5exNNPTutoEpXRpLjEB82HNHQIMNR3QiQuHJph9pkoXeoijhu4kAe9oi3+rs473BPqiXBGApCLzbOBsDMWmXK7xU4VWv+znTr9B5V9JN2X1kNyEVzPgbw5l9Qdvnq1eYf8FLEWeF5bgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cMW4/Res; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PesFYtl58EzSLjZSdfcbgZBJojO53J2jqBqANYh4gVE=; b=cMW4/ResqEC6crdXAo3VeCvOTl
	d/GeVrede3okbTUwFk+7TGkmeZ8YKAtQWYOPRqcohgVkoISiFpsLouFMLSqsi7MKmjR2b3t70K4wl
	5Xp/oaw3yc6BpywXX1O3v/Y2pw1+AK7nT46+jKeKe1NfMZmqUxF5jxZMkDvBWEhRGi0oGi8J/mhwZ
	KPOzxFkYCSoc0xHRivN2P4bSZwHefXXMiZoJC2kkmFQTgRZFw15BVncSpFDTQGf+gjkwfL6xqKDNo
	EFqyjS9FXTYYG3YJToDGO8/15+UVJfTeq7fLDS0Gq9I4afHtrV9n+BG1xC907XGOFfs8GQ+HdNNm4
	MRxYrFMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wri-006VCo-1F;
	Sun, 28 Apr 2024 05:14:18 +0000
Date: Sun, 28 Apr 2024 06:14:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] Use bdev_is_paritition() instead of open-coding it
Message-ID: <20240428051418.GA1549798@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051232.GU2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/blk-core.c          | 5 +++--
 block/blk-mq.c            | 2 +-
 include/linux/part_stat.h | 2 +-
 lib/vsprintf.c            | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..20322abc6082 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -759,7 +759,8 @@ void submit_bio_noacct(struct bio *bio)
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
-		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+		if (bdev_is_partition(bdev) &&
+		    unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	}
 
@@ -989,7 +990,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-	if (part->bd_partno) {
+	if (bdev_is_partition(part)) {
 		part = bdev_whole(part);
 		goto again;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32afb87efbd0..43bb8f50a07c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -92,7 +92,7 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv)
 	struct mq_inflight *mi = priv;
 
 	if (rq->part && blk_do_io_stat(rq) &&
-	    (!mi->part->bd_partno || rq->part == mi->part) &&
+	    (!bdev_is_partition(mi->part) || rq->part == mi->part) &&
 	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index abeba356bc3f..ac8c44dd8237 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -59,7 +59,7 @@ static inline void part_stat_set_all(struct block_device *part, int value)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
-	if ((part)->bd_partno)						\
+	if (bdev_is_partition(part))					\
 		__part_stat_add(bdev_whole(part), field, addnd);	\
 } while (0)
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275..3f9f1b959ef0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -966,7 +966,7 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
-	if (bdev->bd_partno) {
+	if (bdev_is_partition(bdev)) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
 			if (buf < end)
 				*buf = 'p';
-- 
2.39.2


