Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67282C547C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389836AbgKZNGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbgKZNGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58505C0613D4;
        Thu, 26 Nov 2020 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q/6oPwiIP+97CmAmgE17x+n1vZ9NZz+/8fOXv1YD02c=; b=CKiJTlzf+8VqzQ06ysNrtR/UZw
        TGrKvO+bYRL97+fFPOZguxlu3f26ADKUIfmu0oEem3di997h8Ub0UCo8oi13Km9WZSMkuhBzF2GNm
        mC7nA9oX5yAQJe99SWbeyQh49zghRM+szlWGX11Maalp5prxXm8LKjBkv72zqwGdbUd/5scFs8dr9
        xU/RHo/Cz+itNCJwYjYW8DwqVyGetc+ytcsGb54m1t7S8brnirFPXt4MC9SAHivbZu711cGXa9Qjh
        P0mnigCszHTA4BZVoE4d5157nOEq+IWmWyBZue4PlvBNSTrJKDgwbfTU5Eh7m+YYNQ2ln7dll1cJE
        9lpcLg3Q==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGyq-0003wD-BQ; Thu, 26 Nov 2020 13:06:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/44] blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats
Date:   Thu, 26 Nov 2020 14:03:39 +0100
Message-Id: <20201126130422.92945-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

disk_get_part needs to be paired with a disk_put_part.

Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c68bdf58c9a6e1..54fbe1e80cc41a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -849,6 +849,7 @@ static void blkcg_fill_root_iostats(void)
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
 			u64_stats_update_end(&blkg->iostat.sync);
 		}
+		disk_put_part(part);
 	}
 }
 
-- 
2.29.2

