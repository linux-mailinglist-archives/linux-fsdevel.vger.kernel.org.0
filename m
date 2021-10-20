Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A116043569C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJTXyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 19:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhJTXyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:54:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DBC06161C;
        Wed, 20 Oct 2021 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Eio57oEZSpnsX9I7fCKLL4P+h3R1RqCxuN4ifMdK4g=; b=k+v5i7ybYI/mDCEVENeKt+R9of
        XGOJ0+COAA1DPOWD/P71NccqSGeWCnnsIqe5kGM+CMi1A1eBB1jmPS4tVee1kC9Ricl6Q8RVHbcdW
        JAzP7f/SjR/y5PkwpokYP0q4PZyAlEaWuu/2ZTOruTzaVJ/9GETnUxxwgq0Vzu4KPnvcX6ce3yRse
        Cvyym9DaATNrvIMzpWiB81zS2g+jQ9MUkw93KnvSg4hOV6tzQZanw2JwDtaBa3L+Ux84dNMogBuSv
        aZcxkehAPS/jy95u/rZUEWWPeVruweGIT7tMcMaP269riU2JQv0j5m0bFRSnDDqnnmVETY+EmJFCy
        3ZLNFdkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdLLD-00CvF6-R8; Wed, 20 Oct 2021 23:50:11 +0000
Date:   Thu, 21 Oct 2021 00:49:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
Message-ID: <YXCrHxMF3ADO0n2x@casper.infradead.org>
References: <20210917205731.262693-1-shy828301@gmail.com>
 <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org>
 <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org>
 <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
 <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
 <CAHbLzkq2v+xpBweO-XG+uZiF3kvOFodKi4ioX=dzXpBYLtoZcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq2v+xpBweO-XG+uZiF3kvOFodKi4ioX=dzXpBYLtoZcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 04:38:49PM -0700, Yang Shi wrote:
> > However, it still doesn't make too much sense to have thp_size passed
> > to do_invalidatepage(), then have PAGE_SIZE hardcoded in a BUG
> > assertion IMHO. So it seems this patch is still useful because
> > block_invalidatepage() is called by a few filesystems as well, for
> > example, ext4. Or I'm wondering whether we should call
> > do_invalidatepage() for each subpage of THP in truncate_cleanup_page()
> > since private is for each subpage IIUC.
> 
> Seems no interest?

No.  I have changes in this area as part of the folio patchset (where
we end up converting this to invalidate_folio).  I'm not really
interested in doing anything before that, since this shouldn't be
reachable today.

> Anyway the more I was staring at the code the more I thought calling
> do_invalidatepage() for each subpage made more sense. So, something
> like the below makes sense?

Definitely not.  We want to invalidate the entire folio at once.
