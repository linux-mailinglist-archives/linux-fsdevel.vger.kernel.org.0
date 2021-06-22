Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1E43B0BB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhFVRrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhFVRrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:07 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02728C061767;
        Tue, 22 Jun 2021 10:44:50 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 6C8892E1A8A;
        Tue, 22 Jun 2021 20:44:49 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id mMf377KU0E-in0aZkOd;
        Tue, 22 Jun 2021 20:44:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383889; bh=8wJcLLg+BillrJ9UHnzlrqTLTSwh0Y5dlFFF7RlJ/k4=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=gtp/XLWY9rS/nO1rw1U81GJcsGRmr1+XqJguPHF4K6141fjpwiaSqr9VmjMcOJMV8
         OnJ/uJm3Vbq3fIvqXn4VaI6N1H+mtekXtBjj8bf776u7075QW8+SgFIYcAQPQ2rWIR
         7RtAg6ZsO6a9w7EDfMQ9ehHNb1xq6vBe/pArGW+o=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-in9m6KCR;
        Tue, 22 Jun 2021 20:44:49 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 08/10] ext4: reduce stack footprint in ext4_end_bio()
Date:   Tue, 22 Jun 2021 20:44:22 +0300
Message-Id: <20210622174424.136960-9-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
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

