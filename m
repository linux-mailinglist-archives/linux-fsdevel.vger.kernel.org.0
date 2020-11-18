Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6AD2B7949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKRIss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKRIsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BEC0613D4;
        Wed, 18 Nov 2020 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ax7Ev08zfe+k5fDLujW3aI+bgMMepj+7Q/YK24br9d4=; b=MH4CdclHDFODTjP9xnj5n+SLj0
        KgiBor4Efh0d9jME3EBQSx6adQqstkQTNDaZ2TizC50HfcaRgRLQhFlai8VIjVusfI7Z1sIv/ES2V
        yVYPpyv6TcX6IvPqvrcT6UuNlnH1RiFDoZeB5gewwtGWzxh8hzup0RNJSPK2mZL0Xv6zp19aHzSC6
        FD9BN9wevD0vXr+flfq6Rs+nbACPaGbwFMFYa5Rr9YH61lZzjJ7URnmHIkhz4Av1kbIuigOC3Ufc0
        Qb4rWt3d0clR8N8p05bFTRMhFV3wjTMS4l+SUARMu/uwttgDn3VZ8BLlS2HkkXll+sF4pZ22nbxux
        jd6zetXA==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8l-0007pS-Je; Wed, 18 Nov 2020 08:48:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 19/20] bcache: remove a superflous lookup_bdev all
Date:   Wed, 18 Nov 2020 09:47:59 +0100
Message-Id: <20201118084800.2339180-20-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't bother to call lookup_bdev for just a slightly different error
message without any functional change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 44 +--------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e5db2cdd114112..5c531ed7785280 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2380,40 +2380,6 @@ kobj_attribute_write(register,		register_bcache);
 kobj_attribute_write(register_quiet,	register_bcache);
 kobj_attribute_write(pendings_cleanup,	bch_pending_bdevs_cleanup);
 
-static bool bch_is_open_backing(struct block_device *bdev)
-{
-	struct cache_set *c, *tc;
-	struct cached_dev *dc, *t;
-
-	list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
-		list_for_each_entry_safe(dc, t, &c->cached_devs, list)
-			if (dc->bdev == bdev)
-				return true;
-	list_for_each_entry_safe(dc, t, &uncached_devices, list)
-		if (dc->bdev == bdev)
-			return true;
-	return false;
-}
-
-static bool bch_is_open_cache(struct block_device *bdev)
-{
-	struct cache_set *c, *tc;
-
-	list_for_each_entry_safe(c, tc, &bch_cache_sets, list) {
-		struct cache *ca = c->cache;
-
-		if (ca->bdev == bdev)
-			return true;
-	}
-
-	return false;
-}
-
-static bool bch_is_open(struct block_device *bdev)
-{
-	return bch_is_open_cache(bdev) || bch_is_open_backing(bdev);
-}
-
 struct async_reg_args {
 	struct delayed_work reg_work;
 	char *path;
@@ -2535,15 +2501,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 				  sb);
 	if (IS_ERR(bdev)) {
 		if (bdev == ERR_PTR(-EBUSY)) {
-			bdev = lookup_bdev(strim(path));
-			mutex_lock(&bch_register_lock);
-			if (!IS_ERR(bdev) && bch_is_open(bdev))
-				err = "device already registered";
-			else
-				err = "device busy";
-			mutex_unlock(&bch_register_lock);
-			if (!IS_ERR(bdev))
-				bdput(bdev);
+			err = "device busy";
 			if (attr == &ksysfs_register_quiet)
 				goto done;
 		}
-- 
2.29.2

