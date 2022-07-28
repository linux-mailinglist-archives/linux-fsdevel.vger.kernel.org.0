Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430345840E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiG1OSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1OSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:18:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E9252DDA;
        Thu, 28 Jul 2022 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6yJFmCjq7j3EiYzdT5riiMxTlawWcPIvBh3hMXTowos=; b=tDxZoPKAWg0/dgNc8WPgDxg/GU
        Cqip0gnoyz6wHT16FW+cISsYnciiRhJQJoGBhyEmDgr10vWdGHxQXgbeDwINuXO1kbuYeC/sjZeP2
        YL5Bpzb4pLuVMHRMIHWGx6dbCQi7z1ISYzcN47FWNn18S3/wfhc0CFZHU9ceHq/TicqjYXSfKnnCt
        I0DHO+icFRZdgyIVmdT2GTmVVBn7V03KFoXARG+dX9D58LufJWqhEowXnKE+LUR4DRG9po0cLJxOp
        TYaxF9dYUmUynkBu2lr+XSm3QjPMO+x2rTqUDBoj57SfwUhRSelbReS+MITKMnHaLp4cre6i304W5
        NZ9iEqTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oH4Kx-003toI-8v; Thu, 28 Jul 2022 14:18:03 +0000
Date:   Thu, 28 Jul 2022 15:18:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: remove iomap_writepage v2
Message-ID: <YuKam52dkTGycay2@casper.infradead.org>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728111016.uwbaywprzkzne7ib@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:10:16PM +0200, Jan Kara wrote:
> Hi Christoph!
> 
> On Tue 19-07-22 06:13:07, Christoph Hellwig wrote:
> > this series removes iomap_writepage and it's callers, following what xfs
> > has been doing for a long time.
> 
> So this effectively means "no writeback from page reclaim for these
> filesystems" AFAICT (page migration of dirty pages seems to be handled by
> iomap_migrate_page()) which is going to make life somewhat harder for
> memory reclaim when memory pressure is high enough that dirty pages are
> reaching end of the LRU list. I don't expect this to be a problem on big
> machines but it could have some undesirable effects for small ones
> (embedded, small VMs). I agree per-page writeback has been a bad idea for
> efficiency reasons for at least last 10-15 years and most filesystems
> stopped dealing with more complex situations (like block allocation) from
> ->writepage() already quite a few years ago without any bug reports AFAIK.
> So it all seems like a sensible idea from FS POV but are MM people on board
> or at least aware of this movement in the fs land?

I mentioned it during my folio session at LSFMM, but didn't put a huge
emphasis on it.

For XFS, writeback should already be in progress on other pages if
we're getting to the point of trying to call ->writepage() in vmscan.
Surely this is also true for other filesystems?
