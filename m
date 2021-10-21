Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECE435850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJUBk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJUBk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 21:40:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E0C06161C;
        Wed, 20 Oct 2021 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6sNM52S6yqayIv2yY7yJuKuW9m7X8R2dexRIUmUEaSQ=; b=h5eNVqpjFT832hI3aZzaYiF9k+
        0z301mRAcOVRIZ1kAEnAMi3eCSZokNNxPEvmTBV6UKqmJs8+lXeKPHQZTWbt320ovZ+I7aF0Mr6SC
        uY9+iOYmgC143tI2Nh+rZ4oSzi+aFboK2KYehhE7k4D+XQq3HeXZsBaKogqvnRXSFirjC/wcgdyxW
        4BYM0kfrJRhskwZQH8QftJ8gGqbIvzfphD2yrTAEgyE7NyP39ZxTAkZ2f69+BNZZPGigRc43HrwSY
        2HsVy1lOiRmH6kRALNlU+aYFy8G67Tcf1IiNOOPGdbP7YFn/9Ve369+YRB4kaEdI1/eYwZ9hc1eFD
        yyPs6rvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdN0j-00Cxoq-UE; Thu, 21 Oct 2021 01:37:28 +0000
Date:   Thu, 21 Oct 2021 02:36:49 +0100
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
Message-ID: <YXDEMURz5267/Wv2@casper.infradead.org>
References: <20210917205731.262693-1-shy828301@gmail.com>
 <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
 <YUdL3lFLFHzC80Wt@casper.infradead.org>
 <CAHbLzkrPDDoOsPXQD3Y3Kbmex4ptYH+Ad_P1Ds_ateWb+65Rng@mail.gmail.com>
 <YUkCI2I085Sos/64@casper.infradead.org>
 <CAHbLzkoXrVJOfOrNhd8nQFRPHhRVYfVYSgLAO3DO7ZmvaZtDVw@mail.gmail.com>
 <CAHbLzkrdXQfcudeeDHx8uUD55Rr=Aogi0pnQbBbP8bEZca8-7w@mail.gmail.com>
 <CAHbLzkq2v+xpBweO-XG+uZiF3kvOFodKi4ioX=dzXpBYLtoZcw@mail.gmail.com>
 <YXCrHxMF3ADO0n2x@casper.infradead.org>
 <CAHbLzkqHx=RRXAEjOunVOiJobkvQg0p005-ggSpLgcAn75QkOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqHx=RRXAEjOunVOiJobkvQg0p005-ggSpLgcAn75QkOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:24:09PM -0700, Yang Shi wrote:
> On Wed, Oct 20, 2021 at 4:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Oct 20, 2021 at 04:38:49PM -0700, Yang Shi wrote:
> > > > However, it still doesn't make too much sense to have thp_size passed
> > > > to do_invalidatepage(), then have PAGE_SIZE hardcoded in a BUG
> > > > assertion IMHO. So it seems this patch is still useful because
> > > > block_invalidatepage() is called by a few filesystems as well, for
> > > > example, ext4. Or I'm wondering whether we should call
> > > > do_invalidatepage() for each subpage of THP in truncate_cleanup_page()
> > > > since private is for each subpage IIUC.
> > >
> > > Seems no interest?
> >
> > No.  I have changes in this area as part of the folio patchset (where
> > we end up converting this to invalidate_folio).  I'm not really
> > interested in doing anything before that, since this shouldn't be
> > reachable today.
> 
> Understood. But this is definitely reachable unless Hugh's patch
> (skipping non-regular file) is applied.

Right.  That's the bug that needs to be fixed.  Seeing THPs here is
a symptom.  Getting rid of the error just makes the problem silent.

> > > Anyway the more I was staring at the code the more I thought calling
> > > do_invalidatepage() for each subpage made more sense. So, something
> > > like the below makes sense?
> >
> > Definitely not.  We want to invalidate the entire folio at once.
> 
> I didn't look at the folio patch (on each individual patch level), but
> I'm supposed it still needs to invalidate buffer for each subpage,
> right?

No.  Buffers are tracked for the entire folio, not on each subpage.

Actually, the filesystem people currently believe that the O(n^2) nature
of buffer-head handling mean that it's a bad idea to create multi-page
folios for bufferhead based filesystems (which includes block devices),
and the correct path forward is to migrate away from buffer-heads.
That may change, but it's the current plan.
