Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEC6CF07F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjC2RIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjC2RHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5F72A7;
        Wed, 29 Mar 2023 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109628; x=1711645628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iZ22wN2mWRIC3IC0ve2ktcoeKHTOmDQMcv9pQZAGU1o=;
  b=gDrKplb6FOlgRgJ9SnWVaNFiSNY8LVIb0hyYBdCGQPBl1c1xjaJOGaBv
   GRKDdc+JRUJE9g70itEmXR2vJq1dQq9iEz5qsEzutHPkH7bAWUbqpn3zf
   7g5V+K9omT6/XXWLf13UOgy17s5/lztqGX0+vFjEuN+28xtvW8OQ0JLEm
   X68nwFybC3UxLpTIms7F4WLBGCSAd4kzhLAZXJokCFvIUC1CTKst4H2/M
   1wqhcH1UxEykerziOGUMfyewojGmzHqHl76LtLyRXgsqDmFySkLLd/NuO
   E7jygnQNMnnYmHxjwJSUlEX52++KVeHxSvFE58tIFqlZFVxLro19OzARE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:03 +0800
IronPort-SDR: KWmflzYGXO72x16lixIu+mJTR9w/YEYwKOOcwMRkI5cUVPsk7l52EzDEjA48ROcQW5tZi+ocjy
 nevtrTJUQV6n62SWY5qGKiTPfmw/uzruHfBdxrVgdgafhOjGdJcI/y4+a2QyBlB9A0UIqRrKMc
 3JJ8fXHgUjV3NkIhoHgVlkN9ehqEqNMQJbnSgARYi7MtDTvh/W9wBJDkSyu/BLR6rYBil4texd
 vAeJvKO28Xtv+JjJPZ4nVgLALUc+Ez+7ZSatLT2LCCg5JvnRiD/CT2Ts0Ke3TurvegBXTUVyTL
 7OQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:13 -0700
IronPort-SDR: QenhUoCI4gCJokChYIRTxR/AmeR3KMt0i9Ax1ZUEuOE55BQNPmd9r5SN16Ch8MkiJkIpZRNt6I
 qUqUWECToDJ2WJWUpGDVQEaikqB6uT7pLfViFCRAcappfhtVNCd/noIg/ffVrtgTFQXaHZa2+9
 qvf0zarO4BdnnsxEfFyvXa+MLW55EgGw+iqxyMy9lk11OGTrZhPXyK+RBxeQV8dZU6/1rjQcdM
 2AqTxj/IU9pm/2z5SJvCrEd9J0iojU5OMLtUdmwaC41nSBL3uay8UbzV0sr/esbq/6zIeGVC7M
 m7k=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:02 -0700
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/19] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Wed, 29 Mar 2023 10:06:01 -0700
Message-Id: <76f5748e386870c034b46e919101a878b87a79bf.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
is not checking for the return value of bio_add_page() if adding really
succeeded.

Check if the page adding succeeded and if not bail out.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..bd7c339a84a1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1147,7 +1147,8 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 		if (unlikely(!page))
 			goto free_pages;
 
-		bio_add_page(behind_bio, page, len, 0);
+		if (!bio_add_page(behind_bio, page, len, 0))
+			goto free_pages;
 
 		size -= len;
 		i++;
-- 
2.39.2

