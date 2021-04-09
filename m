Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CF359E19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhDIL6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:58:21 -0400
Received: from mx2.veeam.com ([64.129.123.6]:33492 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233874AbhDIL6U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:58:20 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 461554146C;
        Fri,  9 Apr 2021 07:48:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1617968908; bh=rAzHWObjMq2YRLIIgst7bN3x/hlCxuVwlQCV3inUf34=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ThS5DifGAnwZkFT9IE7gR+5ixyCidbcsgXGfpVYTre2ldtcDjo2BuiOMicE0QQtU3
         7jh+RLMBHWqI2Katk8CAIMcrdoL1235uK3klX52Lid9ZR8/K15cHsF7ihl9NEIXzwE
         RNHfdQQEujYp4/WL3bwh93lXJ7OY3p7/CN50ZK7o=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 9 Apr 2021 13:48:21 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v8 4/4] fix origin_map - don't split a bio for the origin device if it does not have registered snapshots.
Date:   Fri, 9 Apr 2021 14:48:04 +0300
Message-ID: <1617968884-15149-5-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
References: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59657262
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-snap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 11890db71f3f..81e8e3bb6d25 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2685,11 +2685,18 @@ static int origin_map(struct dm_target *ti, struct bio *bio)
 	if (bio_data_dir(bio) != WRITE)
 		return DM_MAPIO_REMAPPED;
 
-	available_sectors = o->split_boundary -
-		((unsigned)bio->bi_iter.bi_sector & (o->split_boundary - 1));
+	/*
+	 * If no snapshot is connected to origin, then split_boundary
+	 * will be set to zero. In this case, we don't need to split a bio.
+	 */
+	if (o->split_boundary) {
+		available_sectors = o->split_boundary -
+			((unsigned int)bio->bi_iter.bi_sector &
+				(o->split_boundary - 1));
 
-	if (bio_sectors(bio) > available_sectors)
-		dm_accept_partial_bio(bio, available_sectors);
+		if (bio_sectors(bio) > available_sectors)
+			dm_accept_partial_bio(bio, available_sectors);
+	}
 
 	/* Only tell snapshots if this is a write */
 	return do_origin(o->dev, bio, true);
-- 
2.20.1

