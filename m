Return-Path: <linux-fsdevel+bounces-18547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67F8BA44B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F03F1F23E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3E1367;
	Fri,  3 May 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Hn0LB+0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200D363;
	Fri,  3 May 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694849; cv=none; b=YbsNf0+o8+gO3vvIz41jjT5r14znTwh8KJif9weunBhstvP98zY+QDc8rJQKfnjpRdc0tV8bU6vxSNDXZyjQdi4wjOgjvMQ2Ok3qi7ofLCnR40TkSsy1ZKfszn0iZ0MCmPBO0emy0UBcDezMTWYtDyRhlKNmx6f7mtIC683VKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694849; c=relaxed/simple;
	bh=LFrJDxmKj9w6ynN8mcUGqPilpYVqB1/3O06eZI980b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yra6OrFCC+H2eQHYK69jpqVLr2e7kpRAtwbdySb5Bg70agCogabpGU4jSzfaxiTOVXz9yvlJu6khlxymnadXQ6UU03AGrD2jyT4ZClXZeoDH4bDbV9QkGxJmXLMG7JQtwx7Bi7jVAzjvQdGaWqEEufzl/UcHxZpQj9cK9DYWq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Hn0LB+0C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ys4a7CLJtVETbT20zG171QwSQa3BYsZmIsfgyhTcRXw=; b=Hn0LB+0CPYMxaSnDHwmrqWfZfu
	7l4BeWkE/UokBL3hFDDWCXZMJh25TCm1VpC0yhjDbcapcHyoURiH/kJW3K8vGKvIzUS8gFQ5yjY9A
	oXPkfinF3xwDRk/4mVKK+vXLB5yKDPZ+JM1hVpe3xSL2bATgw4gOGcOQ1NvHUvLFdEMznP0gq2gWz
	NstQgVcpytj4f2JuPMD/zynf3/d3uzquIJVHRsmpIRwb4Tpd5W7yojHjupWJSiZmUvTys1LuFj3MY
	drSp9Si7mmMSgTOKJpvsSFbNNZB26ytqRNlOxhb3o6P4zDNDV/SvlaPX5RnFLedmoQgJitm4Pf2Zf
	HgfZshvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gST-009tG1-0W;
	Fri, 03 May 2024 00:07:25 +0000
Date: Fri, 3 May 2024 01:07:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] Use bdev_is_paritition() instead of open-coding it
Message-ID: <20240503000725.GA2357260@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
 <20240503000647.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503000647.GQ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christoph Hellwig <hch@lst.de>
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


