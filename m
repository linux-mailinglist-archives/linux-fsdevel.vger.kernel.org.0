Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F297A3F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 04:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjIRCFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 22:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbjIRCEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:04:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED3F12A;
        Sun, 17 Sep 2023 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KqQ/QYkzoA6iiYkHXcsQez0zjLQ2/Y9CTcBq2HhMheY=; b=3zIISxp33DxakmM4bv+pOsTPtw
        WoGWkER9yy3i+jAiKvT5JkmDmNyyBXWrluAq9epBzWkszCpRONGatWah1PgQ0A4W1bMphZ8RMM6AN
        iSW0xC2tuFzOYlgQK+wbOqkmZHoPSHFlL7+emPX0KB8KHiEh1e0SWhuoMfas9h0ooD8W7PimHSrAT
        ZxmCuNzq9Yl4CEbaFqXBni76lvbtf7/jBl5fzrpme1dosz0/q90D+YHyHKKpK6amlLaxT8q0Pmc2J
        jJB2MH15bvOSfszYcfxlRqTjQMYBmX3wonLhJXtGX2Lz7bVDcpl8Ecw66Koa/kLB706NO1kMuI/ug
        gTgnotKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qi3ce-00EDre-1D;
        Mon, 18 Sep 2023 02:04:24 +0000
Date:   Sun, 17 Sep 2023 19:04:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQewKIfRYcApEYXt@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <ZQd4IPeVI+o6M38W@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQd4IPeVI+o6M38W@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:05:20AM +1000, Dave Chinner wrote:
> On Fri, Sep 15, 2023 at 08:38:25PM +0200, Pankaj Raghav wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > There has been efforts over the last 16 years to enable enable Large
> > Block Sizes (LBS), that is block sizes in filesystems where bs > page
> > size [1] [2]. Through these efforts we have learned that one of the
> > main blockers to supporting bs > ps in fiesystems has been a way to
> > allocate pages that are at least the filesystem block size on the page
> > cache where bs > ps [3]. Another blocker was changed in filesystems due to
> > buffer-heads. Thanks to these previous efforts, the surgery by Matthew
> > Willcox in the page cache for adopting xarray's multi-index support, and
> > iomap support, it makes supporting bs > ps in XFS possible with only a few
> > line change to XFS. Most of changes are to the page cache to support minimum
> > order folio support for the target block size on the filesystem.
> > 
> > A new motivation for LBS today is to support high-capacity (large amount
> > of Terabytes) QLC SSDs where the internal Indirection Unit (IU) are
> > typically greater than 4k [4] to help reduce DRAM and so in turn cost
> > and space. In practice this then allows different architectures to use a
> > base page size of 4k while still enabling support for block sizes
> > aligned to the larger IUs by relying on high order folios on the page
> > cache when needed. It also enables to take advantage of these same
> > drive's support for larger atomics than 4k with buffered IO support in
> > Linux. As described this year at LSFMM, supporting large atomics greater
> > than 4k enables databases to remove the need to rely on their own
> > journaling, so they can disable double buffered writes [5], which is a
> > feature different cloud providers are already innovating and enabling
> > customers for through custom storage solutions.
> > 
> > This series still needs some polishing and fixing some crashes, but it is
> > mainly targeted to get initial feedback from the community, enable initial
> > experimentation, hence the RFC. It's being posted now given the results from
> > our testing are proving much better results than expected and we hope to
> > polish this up together with the community. After all, this has been a 16
> > year old effort and none of this could have been possible without that effort.
> > 
> > Implementation:
> > 
> > This series only adds the notion of a minimum order of a folio in the
> > page cache that was initially proposed by Willy. The minimum folio order
> > requirement is set during inode creation. The minimum order will
> > typically correspond to the filesystem block size. The page cache will
> > in turn respect the minimum folio order requirement while allocating a
> > folio. This series mainly changes the page cache's filemap, readahead, and
> > truncation code to allocate and align the folios to the minimum order set for the
> > filesystem's inode's respective address space mapping.
> > 
> > Only XFS was enabled and tested as a part of this series as it has
> > supported block sizes up to 64k and sector sizes up to 32k for years.
> > The only thing missing was the page cache magic to enable bs > ps. However any filesystem
> > that doesn't depend on buffer-heads and support larger block sizes
> > already should be able to leverage this effort to also support LBS,
> > bs > ps.
> > 
> > This also paves the way for supporting block devices where their logical
> > block size > page size in the future by leveraging iomap's address space
> > operation added to the block device cache by Christoph Hellwig [6]. We
> > have work to enable support for this, enabling LBAs > 4k on NVME,  and
> > at the same time allow coexistence with buffer-heads on the same block
> > device so to enable support allow for a drive to use filesystem's to
> > switch between filesystem's which may depend on buffer-heads or need the
> > iomap address space operations for the block device cache. Patches for
> > this will be posted shortly after this patch series.
> 
> Do you have a git tree branch that I can pull this from
> somewhere?
> 
> As it is, I'd really prefer stuff that adds significant XFS
> functionality that we need to test to be based on a current Linus
> TOT kernel so that we can test it without being impacted by all
> the random unrelated breakages that regularly happen in linux-next
> kernels....

That's understandable! I just rebased onto Linus' tree, this only
has the bs > ps support on 4k sector size:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=v6.6-rc2-lbs-nobdev

I just did a cursory build / boot / fsx with 16k block size / 4k sector size
test with this tree only. I havne't ran fstests on it.

Just a heads up, using 512 byte sector size will fail for now, it's a
regression we have to fix. Likewise using block sizes 1k, 2k will also
regress on fsx right now. These are regressions we are aware of but
haven't had time yet to bisect / fix.

  Luis
