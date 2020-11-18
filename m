Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E709F2B7934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKRIsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKRIsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE86C061A4D;
        Wed, 18 Nov 2020 00:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yHhXeiyRNaQPcpM2nqUGOQAlRtiBH1PeNN6xDbuA8UE=; b=ZzCRySiTV8SiCXIJ3vfmIUEXvr
        uIJL5nS39gGqLhbC29g9AgM4MwKAtfdRHvWFPaw8smy3i22eU8iUjNKhVCWvGhbBViCoRsKcO6GQU
        SrQ87ktJRa5o18ql91Xe/INMz7nHNZqm8LQea7oI5+JgzZpIdqxe0qq5Ujh4GvgHhDai5SolBAJuU
        l/EDSwn8iwf9v+NLccmqQ0SiSa/CQy9vyIOE8M4CboYWb1kWDaemO8wzQB2ZRBmLrktfDwZWQWu2e
        CuL+t5bFawnPWgtVE7aLR0tFwcZmUHWOkcqi2WOEC8evYMNZjdXQFh3mSoEa6nq87Jj9ktco/+Nkh
        5sAjpgag==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8M-0007ky-MA; Wed, 18 Nov 2020 08:48:11 +0000
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
Subject: [PATCH 05/20] block: use put_device in put_disk
Date:   Wed, 18 Nov 2020 09:47:45 +0100
Message-Id: <20201118084800.2339180-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use put_device to put the device instead of poking into the internals
and using kobject_put.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0bd9c41dd4cb69..f46e89226fdf91 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1803,7 +1803,7 @@ EXPORT_SYMBOL(__alloc_disk_node);
 void put_disk(struct gendisk *disk)
 {
 	if (disk)
-		kobject_put(&disk_to_dev(disk)->kobj);
+		put_device(disk_to_dev(disk));
 }
 EXPORT_SYMBOL(put_disk);
 
-- 
2.29.2

