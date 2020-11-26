Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32002C53CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgKZMPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 07:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgKZMPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:15:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCEDC0613D4;
        Thu, 26 Nov 2020 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bwE3ntsWwlmjPInYkgT+nMI6emH/bLopsilbB9Xfo0k=; b=EW1GywcfwLEnGDTSbbRk3iX/fu
        vMLSY16+iniAcBp5/Q9wBUI/garKVHl2j6/XASpTq8Hry7PGTTJjIdm2tuekGe5cG9WBo2nzg8hr2
        g2VpVUEwUR6NauZ8klKaQOD6Ha1+rjJtL4oN9NNQJeI/Wb2m4CJrabTAkEEKRfjuAk2SJNRYCbVcO
        45UFPkNWFKhMt81CD4/KFoh3beaDayv+ifK+lhedpUjINOr04s3nl5J/7q1vHul/OvBQAY6kA3jik
        mEbbpmdNkhoZG6NY84MEDGiWFnvgtLjfFEgE4k8hS8kG/BOxB77tNrYYxMWfmDKNfsC55iCKshKYB
        V+YH1OhA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGBe-0000jE-QC; Thu, 26 Nov 2020 12:15:46 +0000
Date:   Thu, 26 Nov 2020 12:15:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, dchinner@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201126121546.GN4327@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
 <20201117153947.GL29991@casper.infradead.org>
 <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
 <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org>
 <20201125023234.GH4327@casper.infradead.org>
 <20201125150859.25adad8ff64db312681184bd@linux-foundation.org>
 <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:11:57PM -0800, Hugh Dickins wrote:
> The little fix definitely needed was shown by generic/083: each
> fsstress waiting for page lock, happens even without forcing huge
> pages. See below...

Huh ... I need to look into why my xfstests run is skipping generic/083:

0006 generic/083 3s ... run fstests generic/083 at 2020-11-26 12:11:52
0006 [not run] this test requires a valid $SCRATCH_MNT and unique 
0006 Ran: generic/083
0006 Not run: generic/083

> >                         if (!unfalloc || !PageUptodate(page)) {
> >                                 if (page_mapping(page) != mapping) {
> >                                         /* Page was replaced by swap: retry */
> >                                         unlock_page(page);
> > -                                       index--;
> > +                                       put_page(page);
> >                                         break;
> >                                 }
> >                                 VM_BUG_ON_PAGE(PageWriteback(page), page);
> > -                               if (shmem_punch_compound(page, start, end))
> > -                                       truncate_inode_page(mapping, page);
> > -                               else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > -                                       /* Wipe the page and don't get stuck */
> > -                                       clear_highpage(page);
> > -                                       flush_dcache_page(page);
> > -                                       set_page_dirty(page);
> > -                                       if (index <
> > -                                           round_up(start, HPAGE_PMD_NR))
> > -                                               start = index + 1;
> > -                               }
> > +                               index = truncate_inode_partial_page(mapping,
> > +                                               page, lstart, lend);
> > +                               if (index > end)
> > +                                       end = indices[i] - 1;
> >                         }
> > -                       unlock_page(page);
> 
> The fix needed is here: instead of deleting that unlock_page(page)
> line, it needs to be } else { unlock_page(page); }

It also needs a put_page(page);

That's now taken care of by truncate_inode_partial_page(), so if we're
not calling that, we need to put the page as well.  ie this:

+++ b/mm/shmem.c
@@ -954,6 +954,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
                                                page, lstart, lend);
                                if (index > end)
                                        end = indices[i] - 1;
+                       } else {
+                               unlock_page(page);
+                               put_page(page);
                        }
                }
                index = indices[i - 1] + 1;

> >                 }
> > +               index = indices[i - 1] + 1;
> >                 pagevec_remove_exceptionals(&pvec);
> > -               pagevec_release(&pvec);
> > -               index++;
> > +               pagevec_reinit(&pvec);
