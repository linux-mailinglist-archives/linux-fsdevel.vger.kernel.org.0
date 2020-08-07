Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9981F23F21C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 19:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGRoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGRoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:44:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1AC061756;
        Fri,  7 Aug 2020 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=309a0tYQ/H/QoByTdSa6AlQ/HwgAtZEIwXD4ho8Mmko=; b=SUQsMjNDzIkZTv3JGFSHO2N2h7
        BEkjwMOjqsvARScHfkAW3sBMMMTcdEfrpuF8Q2H19lcNxqjtoqBEkMotlMJ4siALI1F99Cms2rUjj
        jhZB30w5qlUEpFDOUoNynVxSNVxhp+bfVdmoTfxn66T0gXA+VFLgjdFRt/aaA2ziVXloq/4Uci+hA
        bZISyeeQx0/Go1iSoFoASxZRlbgWnYguqJO0Lmrw795WSmucYUXDpSozdbynBUp4c951f7ENP8odM
        aw3U602/kgaEM6SOJ5YfdMuKGXs2BjWhFvszUeMZXQGVMFoyXYuNng2q+TCSa5+Cz/FrwpGoctIMT
        RZwBJeGg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k46Pg-0006Qw-IV; Fri, 07 Aug 2020 17:44:16 +0000
Date:   Fri, 7 Aug 2020 18:44:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Very slow qemu device access
Message-ID: <20200807174416.GF17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Everything starts going very slowly after this commit:

commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
Author: Ming Lei <ming.lei@redhat.com>
Date:   Tue Jun 30 22:03:57 2020 +0800

    blk-mq: centralise related handling into blk_mq_get_driver_tag
    
    Move .nr_active update and request assignment into blk_mq_get_driver_tag(),
    all are good to do during getting driver tag.
    
    Meantime blk-flush related code is simplified and flush request needn't
    to update the request table manually any more.
    
    Signed-off-by: Ming Lei <ming.lei@redhat.com>
    Cc: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

By the time xfstests gets to generic/007, things are blocking trying
to get tags:

root@bobo-kvm:~# cat /proc/9530/stack
[<0>] blk_mq_get_tag+0x109/0x250
[<0>] __blk_mq_alloc_request+0x67/0xf0
[<0>] blk_mq_submit_bio+0xee/0x560
[<0>] submit_bio_noacct+0x3a3/0x410
[<0>] submit_bio+0x33/0xf0
[<0>] submit_bh_wbc.isra.0+0x139/0x160
[<0>] block_read_full_page+0x357/0x4a0
[<0>] blkdev_readpage+0x13/0x20
[<0>] do_read_cache_page+0x557/0x860
...

maybe tags aren't getting freed properly?  Or things aren't being woken
up promptly?

(that trace is from current linus head; i bisected back to this commit)
