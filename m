Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35074DD39F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 04:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiCRDkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 23:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiCRDkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:40:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CEE97280;
        Thu, 17 Mar 2022 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RTCKKVxUpw1x9XRyIgUv1ZDhnrDBa0F9uoZcShZ5ROQ=; b=JkfWFbAv+F+G3EEQW2UTFpEasA
        r1gBB7a+YbWHLd8cgnXvMP274qmJ7C7O4D/t/DSbeWHBa3meJy0nEyoLCqjWMeYipV5OwVDLjXBnG
        XVYnMWrQicyrl+fWSrxSnBm7q+o8t6stf2Q1zg5VSVsNU2uCqed2HI/zv15i1Dnv7XNCYzOs7HRQL
        Po++RG7VxNoybZvUtHVTSQpGB1UwMgLRG2MTszHT6PRzzgGB50QAyD1ROQC1WmrEFwMqDA64t4Mmn
        z/dGjCLOAgodZY2o63IhZ4p25lyQk3BOaf/8Lem13MwuWvPbCZ1T1T/Krymttu+NQzppJLBO3XoOG
        tVzRF0Dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nV3RL-007aVA-Dh; Fri, 18 Mar 2022 03:38:11 +0000
Date:   Fri, 18 Mar 2022 03:38:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yang Shi <shy828301@gmail.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        songliubraving@fb.com, riel@surriel.com, ziy@nvidia.com,
        akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <YjP+oyoT9Y2SFt8L@casper.infradead.org>
References: <20220317234827.447799-1-shy828301@gmail.com>
 <20220318012948.GE1544202@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318012948.GE1544202@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 12:29:48PM +1100, Dave Chinner wrote:
> On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> > 
> > Changelog
> > v2: * Collected reviewed-by tags from Miaohe Lin.
> >     * Fixed build error for patch 4/8.
> > 
> > The readonly FS THP relies on khugepaged to collapse THP for suitable
> > vmas.  But it is kind of "random luck" for khugepaged to see the
> > readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
> >   - Anon huge pmd page fault
> >   - VMA merge
> >   - MADV_HUGEPAGE
> >   - Shmem mmap
> > 
> > If the above conditions are not met, even though khugepaged is enabled
> > it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> > explicitly to tell khugepaged to collapse this area, but when khugepaged
> > mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> > is not set.
> > 
> > So make sure readonly FS vmas are registered to khugepaged to make the
> > behavior more consistent.
> > 
> > Registering the vmas in mmap path seems more preferred from performance
> > point of view since page fault path is definitely hot path.
> > 
> > 
> > The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> > The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> > but I'd like to hear some comments before doing that.
> 
> After reading through the patchset, I have no idea what this is even
> doing or enabling. I can't comment on the last patch and it's effect
> on XFS because there's no high level explanation of the
> functionality or feature to provide me with the context in which I
> should be reviewing this patchset.
> 
> I understand this has something to do with hugepages, but there's no
> explaination of exactly where huge pages are going to be used in the
> filesystem, what the problems with khugepaged and filesystems are
> that this apparently solves, what constraints it places on
> filesystems to enable huge pages to be used, etc.
> 
> I'm guessing that the result is that we'll suddenly see huge pages
> in the page cache for some undefined set of files in some undefined
> set of workloads. But that doesn't help me understand any of the
> impacts it may have. e.g:
> 
> - how does this relate to the folio conversion and use of large
>   pages in the page cache?
> - why do we want two completely separate large page mechanisms in
>   the page cache?
> - why is this limited to "read only VMAs" and how does the
>   filesystem actually ensure that the VMAs are read only?
> - what happens if we have a file that huge pages mapped into the
>   page cache via read only VMAs then has write() called on it via a
>   different file descriptor and so we need to dirty the page cache
>   that has huge pages in it?
> 
> I've got a lot more questions, but to save me having to ask them,
> how about you explain what this new functionality actually does, why
> we need to support it, and why it is better than the fully writeable
> huge page support via folios that we already have in the works...

Back in Puerto Rico when we set up the THP Cabal, we had two competing
approaches for using larger pages in the page cache; mine (which turned
into folios after I realised that THPs were the wrong model) and Song
Liu's CONFIG_READ_ONLY_THP_FOR_FS.  Song's patches were ready earlier
(2019) and were helpful in unveiling some of the problems which needed
to be fixed.  The filesystem never sees the large pages because they're
only used for read-only files, and the pages are already Uptodate at
the point they're collapsed into a THP.  So there's no changes needed
to the filesystem.

This collection of patches I'm agnostic about.  As far as I can
tell, they're a way to improve how often the ROTHP feature gets used.
That doesn't really interest me since we're so close to having proper
support for large pages/folios in filesystems.  So I'm not particularly
interested in improving a feature that we're about to delete.  But I also
don't like it that the filesystem now has to do something; the ROTHP
feature is supposed to be completely transparent from the point of view
of the filesystem.

