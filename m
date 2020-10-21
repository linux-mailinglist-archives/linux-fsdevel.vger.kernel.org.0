Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01556294D35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 15:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442694AbgJUNIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 09:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441152AbgJUNIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:08:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE2C0613CE;
        Wed, 21 Oct 2020 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ADGY6lUGFmeFYihjY6pvVYGb53tiaxI+m52PCdpV6o=; b=ValVWrF82iOnfhZJWq+OXSlUA4
        Bp6JHUMpHs4bxa4Nqsd4U+O/qKSp3dCjwhD0i+Sw/ZSemSXVkyVcYUuqsOFQUhkTCj2DRw89BmCvq
        simA6KOcCspTWlzzKiTt5we7CqK3NrRvndVvw9uPLhsx8OkaLdG+O5MCApjBrs/lZkpFbujY9gLie
        Il9EURdEdW+VUIUNCF3njnXzP88c0wV3mubpN8fGiEE5s7DpwAZ0a+PSh1BoiMxQZrRwcqvR00DOd
        uQx2atMCd446mt6+ZYKx2kx2aYRcQUe/3XjESH2lfjMSx0coQ8Fwy4LXsI1/Hf5F6bNcF1MzVyC3O
        d3cYBlSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVDqL-00088e-4V; Wed, 21 Oct 2020 13:07:53 +0000
Date:   Wed, 21 Oct 2020 14:07:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Message-ID: <20201021130753.GM20115@casper.infradead.org>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
 <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201021114438.GK20115@casper.infradead.org>
 <20201021125555.GE20749@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021125555.GE20749@veeam.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 03:55:55PM +0300, Sergei Shtepa wrote:
> The 10/21/2020 14:44, Matthew Wilcox wrote:
> > I don't understand why O_DIRECT gets to bypass the block filter.  Nor do
> > I understand why anybody would place a block filter on the swap device.
> > But if somebody did place a filter on the swap device, why should swap
> > be able to bypass the filter?
> 
> Yes, intercepting the swap partition is absurd. But we can't guarantee
> that the filter won't intercept swap.
> 
> Swap operation is related to the memory allocation logic. If a swap on
> the block device are accessed during memory allocation from filter,
> a deadlock occurs. We can allow filters to occasionally shoot off their
> feet, especially under high load. But I think it's better not to do it.

We already have logic to prevent this in Linux.  Filters need to
call memalloc_noio_save() while they might cause swap to happen and
memalloc_noio_restore() once it's safe for them to cause swap again.

> "directly access" - it is not O_DIRECT. This means (I think) direct
> reading from the device file, like "dd if=/dev/sda1".
> As for intercepting direct reading, I don't know how to do the right thing.
> 
> The problem here is that in fs/block_dev.c in function __blkdev_direct_IO()
> uses the qc - value returned by the submit_bio() function.
> This value is used below when calling 
> blk_poll(bdev_get_queue(dev), qc, true).
> The filter cannot return a meaningful value of the blk_qc_t type when
> intercepting a request, because at that time it does not know which queue
> the request will fall into.
> 
> If function submit_bio() will always return BLK_QC_T_NONE - I think the
> algorithm of the __blk dev_direct_IO() will not work correctly.
> If we need to intercept direct access to a block device, we need to at
> least redo the __blkdev_direct_IO function, getting rid of blk_pool.
> I'm not sure it's necessary yet.

This isn't part of the block layer that I'm familiar with, so I can't
help solve this problem, but allowing O_DIRECT to bypass the block filter
is a hole that needs to be fixed before these patches can be considered.
