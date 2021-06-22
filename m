Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B283B0BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhFVRrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhFVRrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:07 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E33C061766;
        Tue, 22 Jun 2021 10:44:50 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 371D02E1A84;
        Tue, 22 Jun 2021 20:44:49 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id u2gW1tUW5o-imRewnqE;
        Tue, 22 Jun 2021 20:44:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383889; bh=pJdpM41/lRGWNn5L3siwgS3p6/bflozzXqO8KOwPPnk=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=lfWxnxrM+bqlQdsjGwdYg6JN4gqiOiOcduWgHIeHiD4U0JEjqXqA3WDumc/aKwOUz
         2j/p68+oUUcJ6TdzBJV+4CbEUSrD3L3i5JolYTTNAY5/6WPftbC8xWO1EkYz0YilDL
         1eBfvbNC5UDP0a48gegG6LVIdc3Dawv76kkfYA1U=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-im9mVNEO;
        Tue, 22 Jun 2021 20:44:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 07/10] vfs: reduce stack footprint in __blkdev_put()
Date:   Tue, 22 Jun 2021 20:44:21 +0300
Message-Id: <20210622174424.136960-8-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./fs/block_dev.c        __blkdev_put    224     80      -144

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 fs/block_dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7dad51878dfc..3adadb981777 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -64,10 +64,8 @@ static void bdev_write_inode(struct block_device *bdev)
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
 		if (ret) {
-			char name[BDEVNAME_SIZE];
-			pr_warn_ratelimited("VFS: Dirty inode writeback failed "
-					    "for block device %s (err=%d).\n",
-					    bdevname(bdev, name), ret);
+			pr_warn_ratelimited("VFS: Dirty inode writeback failed for block device %pg (err=%d).\n",
+					    bdev, ret);
 		}
 		spin_lock(&inode->i_lock);
 	}
-- 
2.25.1

