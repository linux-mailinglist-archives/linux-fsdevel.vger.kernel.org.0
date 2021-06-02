Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE9398EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhFBPdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhFBPdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:33:06 -0400
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Jun 2021 08:31:22 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7432C06174A;
        Wed,  2 Jun 2021 08:31:22 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 1C6472E1D2E;
        Wed,  2 Jun 2021 18:29:22 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id XrUECaB8IF-TL1qV7d2;
        Wed, 02 Jun 2021 18:29:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647762; bh=8wJcLLg+BillrJ9UHnzlrqTLTSwh0Y5dlFFF7RlJ/k4=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=Ka38oQsGBLcIKLSPnYT9CKvdUTpqODcyH83nm/tW55bqB1fLgFyEMvE93Bg1J2RfN
         mAh1XrdUTD/4uSn/EJLjE6QMP13ies7cLWxGqYqF1dYITDOUNZYE9ZuArAOPE3ITya
         Jsoxr2dKyrADsXrOJctGPdwYdm9BKrfCstTDmfcA=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TLoinGKp;
        Wed, 02 Jun 2021 18:29:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 08/10] ext4: reduce stack footprint in ext4_end_bio()
Date:   Wed,  2 Jun 2021 18:29:01 +0300
Message-Id: <20210602152903.910190-9-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./fs/ext4/page-io.c     ext4_end_bio    224     88      -136

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 fs/ext4/page-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index f038d578d8d8..56074f2f5e63 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -323,10 +323,9 @@ static void ext4_end_bio(struct bio *bio)
 {
 	ext4_io_end_t *io_end = bio->bi_private;
 	sector_t bi_sector = bio->bi_iter.bi_sector;
-	char b[BDEVNAME_SIZE];
 
-	if (WARN_ONCE(!io_end, "io_end is NULL: %s: sector %Lu len %u err %d\n",
-		      bio_devname(bio, b),
+	if (WARN_ONCE(!io_end, "io_end is NULL: %pg: sector %llu len %u err %d\n",
+		      bio->bi_bdev,
 		      (long long) bio->bi_iter.bi_sector,
 		      (unsigned) bio_sectors(bio),
 		      bio->bi_status)) {
-- 
2.25.1

