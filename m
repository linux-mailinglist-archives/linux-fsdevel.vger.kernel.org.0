Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C650033AF33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCOJrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:59336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCOJqc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:46:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D97FDAD74;
        Mon, 15 Mar 2021 09:46:30 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 335e3db6;
        Mon, 15 Mar 2021 09:47:45 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:47:45 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <YE8tQc66C6MW7EqY@suse.de>
References: <YEsryBEFq4HuLKBs@suse.de>
 <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de>
 <20210312131123.GZ3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312131123.GZ3479805@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 01:11:23PM +0000, Matthew Wilcox wrote:
> On Fri, Mar 12, 2021 at 12:21:59PM +0000, Luis Henriques wrote:
> > > > I've seen a bug report (5.10.16 kernel splat below) that seems to be
> > > > reproducible in kernels as early as 5.4.
> 
> If this is reproducible, can you turn this BUG_ON into a VM_BUG_ON_PAGE()
> so we know what kind of problem we're dealing with?  Assuming the SUSE
> tumbleweed kernels enable CONFIG_DEBUG_VM, which I'm sure they do.

Just to make sure I got this right, you want to test something like this:

 				}
 			}
-			BUG_ON(page_mapped(page));
+			VM_BUG_ON_PAGE(page_mapped(page), page);
 			ret2 = do_launder_page(mapping, page);
 			if (ret2 == 0) {
 				if (!invalidate_complete_page2(mapping, page))

Cheers,
--
Luís

> 
> > > Page fault locks the page before installing a new pte, at least
> > > AFAICS, so the BUG looks impossible.  The referenced commits only
> > > touch very high level control of writeback, so they may well increase
> > > the chance of a bug triggering, but very unlikely to be the actual
> > > cause of the bug.   I'm guessing this to be an MM issue.
> > 
> > Ok, thank you for having a look at it.
> > 
> > Interestingly, there's a single commit to mm/truncate.c in 5.4:
> > ef18a1ca847b ("mm/thp: allow dropping THP from page cache").  I'm Cc'ing
> > Andrew and Kirill, maybe they have some ideas.
> 
> That's probably not it; unless FUSE has developed the ability to insert
> compound pages into the page cache without me noticing.
> 
> (if it had, that would absolutely explain it -- i have a fix in my thp
> tree for this case, but it doesn't affect any existing filesystem
> because only shmem uses compound pages and it doesn't call
> invalidate_inode_pages2_range)
