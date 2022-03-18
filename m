Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C784DD26E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 02:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiCRBbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:31:11 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4BBD114DDA;
        Thu, 17 Mar 2022 18:29:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5D8DF533D8B;
        Fri, 18 Mar 2022 12:29:50 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nV1R6-006lEJ-WE; Fri, 18 Mar 2022 12:29:49 +1100
Date:   Fri, 18 Mar 2022 12:29:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more
 consistent
Message-ID: <20220318012948.GE1544202@dread.disaster.area>
References: <20220317234827.447799-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6233e091
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=_g2WV56Gx8CI_Xe-bs8A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> 
> Changelog
> v2: * Collected reviewed-by tags from Miaohe Lin.
>     * Fixed build error for patch 4/8.
> 
> The readonly FS THP relies on khugepaged to collapse THP for suitable
> vmas.  But it is kind of "random luck" for khugepaged to see the
> readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
>   - Anon huge pmd page fault
>   - VMA merge
>   - MADV_HUGEPAGE
>   - Shmem mmap
> 
> If the above conditions are not met, even though khugepaged is enabled
> it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
> explicitly to tell khugepaged to collapse this area, but when khugepaged
> mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
> is not set.
> 
> So make sure readonly FS vmas are registered to khugepaged to make the
> behavior more consistent.
> 
> Registering the vmas in mmap path seems more preferred from performance
> point of view since page fault path is definitely hot path.
> 
> 
> The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> but I'd like to hear some comments before doing that.

After reading through the patchset, I have no idea what this is even
doing or enabling. I can't comment on the last patch and it's effect
on XFS because there's no high level explanation of the
functionality or feature to provide me with the context in which I
should be reviewing this patchset.

I understand this has something to do with hugepages, but there's no
explaination of exactly where huge pages are going to be used in the
filesystem, what the problems with khugepaged and filesystems are
that this apparently solves, what constraints it places on
filesystems to enable huge pages to be used, etc.

I'm guessing that the result is that we'll suddenly see huge pages
in the page cache for some undefined set of files in some undefined
set of workloads. But that doesn't help me understand any of the
impacts it may have. e.g:

- how does this relate to the folio conversion and use of large
  pages in the page cache?
- why do we want two completely separate large page mechanisms in
  the page cache?
- why is this limited to "read only VMAs" and how does the
  filesystem actually ensure that the VMAs are read only?
- what happens if we have a file that huge pages mapped into the
  page cache via read only VMAs then has write() called on it via a
  different file descriptor and so we need to dirty the page cache
  that has huge pages in it?

I've got a lot more questions, but to save me having to ask them,
how about you explain what this new functionality actually does, why
we need to support it, and why it is better than the fully writeable
huge page support via folios that we already have in the works...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
