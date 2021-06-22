Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85253B0BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFVRrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFVRrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:06 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E781C061756;
        Tue, 22 Jun 2021 10:44:49 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2A25E2E151F;
        Tue, 22 Jun 2021 20:44:46 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id lbk2NaBVNX-ij0mVmoK;
        Tue, 22 Jun 2021 20:44:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383886; bh=3dmsFnoZBs59fnNg1b+WXCdRqDAR1qofc+8TclCiWa0=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=H6ikhcGp34aAqhWelaSAw3aXcSVykMovLehulNFE4M05dyS5gjRzqvPYSs4wxO1p2
         jxrhd0M4XFT2O0J5zaYvxMh9ZZahorLiTwjvHRpThMLVQLm6G01UAjNKm8uKBbeuMw
         DoNRk2X3/DYeUTczQMjn5jAGvci2unrRGeUTjVGU=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-ij9mwTUr;
        Tue, 22 Jun 2021 20:44:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 02/10] dax: reduce stack footprint dealing with block device names
Date:   Tue, 22 Jun 2021 20:44:16 +0300
Message-Id: <20210622174424.136960-3-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/dax/super.c   __bdev_dax_supported    192     56      -136
./drivers/dax/super.c   __generic_fsdax_supported       344     280     -64

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/dax/super.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..f519e59abf02 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -73,7 +73,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 {
 	bool dax_enabled = false;
 	pgoff_t pgoff, pgoff_end;
-	char buf[BDEVNAME_SIZE];
 	void *kaddr, *end_kaddr;
 	pfn_t pfn, end_pfn;
 	sector_t last_page;
@@ -81,29 +80,25 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	int err, id;
 
 	if (blocksize != PAGE_SIZE) {
-		pr_info("%s: error: unsupported blocksize for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
 		return false;
 	}
 
 	if (!dax_dev) {
-		pr_debug("%s: error: dax unsupported by block device\n",
-				bdevname(bdev, buf));
+		pr_debug("%pg: error: dax unsupported by block device\n", bdev);
 		return false;
 	}
 
 	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
 	if (err) {
-		pr_info("%s: error: unaligned partition for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return false;
 	}
 
 	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
 	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
 	if (err) {
-		pr_info("%s: error: unaligned partition for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return false;
 	}
 
@@ -112,8 +107,8 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
 
 	if (len < 1 || len2 < 1) {
-		pr_info("%s: error: dax access failed (%ld)\n",
-				bdevname(bdev, buf), len < 1 ? len : len2);
+		pr_info("%pg: error: dax access failed (%ld)\n",
+			bdev, len < 1 ? len : len2);
 		dax_read_unlock(id);
 		return false;
 	}
@@ -147,8 +142,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	dax_read_unlock(id);
 
 	if (!dax_enabled) {
-		pr_info("%s: error: dax support not enabled\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: dax support not enabled\n", bdev);
 		return false;
 	}
 	return true;
@@ -169,21 +163,18 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 {
 	struct dax_device *dax_dev;
 	struct request_queue *q;
-	char buf[BDEVNAME_SIZE];
 	bool ret;
 	int id;
 
 	q = bdev_get_queue(bdev);
 	if (!q || !blk_queue_dax(q)) {
-		pr_debug("%s: error: request queue doesn't support dax\n",
-				bdevname(bdev, buf));
+		pr_debug("%pg: error: request queue doesn't support dax\n", bdev);
 		return false;
 	}
 
 	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
 	if (!dax_dev) {
-		pr_debug("%s: error: device does not support dax\n",
-				bdevname(bdev, buf));
+		pr_debug("%pg: error: device does not support dax\n", bdev);
 		return false;
 	}
 
-- 
2.25.1

