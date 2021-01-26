Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F108304154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406067AbhAZPCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391173AbhAZPBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:01:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589F8C061A29;
        Tue, 26 Jan 2021 07:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tvv/hngq/dBU/TVoa7iwWv/YX1vhiuaE4wP7JKrNMhk=; b=k+FYANNOZNSV7d80UmzTAyJIKL
        sjR3uLRaK2TwHcBUsVcl9IndBEPxYkEu006OvPkkzK4tvMff5Z+dVhL0IjaUHx8BBuZ0yyw0kvg4G
        U3KPy3sIpICR9kG1TUy5jK8QjcY8sM8tPsbnAwnAg6bU60/F72Zv6QiuZCxnnZ+olHIVHWG6zEu9H
        vbj18B9ZyF73S0P0GskthCvFSLA42B1MNOQoLGT1DCJY5RV9hIWsDq7qtgSf3bFvuu11dMCIUC78m
        O5PhvXXW4p1xsC37+azC3ghr00JUxWPW0MIn1botrn443lpgRWINUt2FYChxfCgxAeBHpwqT6P5I5
        ybwQ3v+w==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Pl3-005mG9-Rr; Tue, 26 Jan 2021 14:56:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/17] btrfs: use bio_kmalloc in __alloc_device
Date:   Tue, 26 Jan 2021 15:52:32 +0100
Message-Id: <20210126145247.1964410-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bio_kmalloc instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0a6de859eb2226..584ba093cf4966 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -421,7 +421,7 @@ static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
 	 * Preallocate a bio that's always going to be used for flushing device
 	 * barriers and matches the device lifespan
 	 */
-	dev->flush_bio = bio_alloc_bioset(GFP_KERNEL, 0, NULL);
+	dev->flush_bio = bio_kmalloc(GFP_KERNEL, 0);
 	if (!dev->flush_bio) {
 		kfree(dev);
 		return ERR_PTR(-ENOMEM);
-- 
2.29.2

