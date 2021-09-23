Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3434164BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbhIWSAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbhIWSAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:00:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E205C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 10:58:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t4so24710871qkb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7hr09IOKvubmm29o++rFk+/rcGzXjuS4I9xs9JPMjPM=;
        b=xVrtaAV+AsQi2BtDts7Ynr0kR8zUdzyqR/5bsUUkNlbXDC3iRZUM9xhBAOmIhROQ26
         9chb8pmqfl3zsYrh9S56a0JKFfDoFmnpqAiopTSoH9QmLR1iB7T4QdR8XBUh5yAemX3B
         vuIbRXQx5n7OfNqMHJnXjLDG5ERJeqI/LCv5YtFmPQJiw/Ff2CB4XYeSlmQk49oxSg/z
         75M7XyC3NdvdzqYrUCBxRCEK4V1hrbFOfyKijDabbV+JstZPQYgmBFzoEgcb+0aJimr3
         EFxmibhDN2G4nTE7BI0jHL4QcrzcFSN+1Tf8AkVhqAjMC0R5nTZlnI3Fhv3xOJFNN7Qk
         57zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hr09IOKvubmm29o++rFk+/rcGzXjuS4I9xs9JPMjPM=;
        b=dJE0LxH21/tSVENOs0rIVk6mdN9EyeN/e7VewqEHiU3l4boNhta63RDGqY1rBFV7I8
         oYB9SOCbiYp3Z4C11XQEMebr6c98U444PVlNvK7eyVYSkuO/LOcHgyBiAEOHieF1GWhz
         1htMiG0bFuxuJWBufWOBD1m4roIQ8Sj9pbfwNFz7HUOLsx9WP99I9DhapISSn/MEs0Mv
         yOe9CimlhtS2Y8HSbBb/wdmPr1hGEsQC9+K6Hxd+Sn95SMZci10yuH+ZL8Ajv/F7Hhwo
         awiFxSd12ie3EYbBuUjz306mvmfoXYddsWkkFfSDohS1D69naGWld+D9MkKCnrH6Nea2
         b3UQ==
X-Gm-Message-State: AOAM532K8Jg8PzxuDy3i8p8lV2KRSMdQV60pVHJnYi4DxRFTsbbhWt/W
        9Cj0hbgYrCAE/Wcf8r7h9MazEA==
X-Google-Smtp-Source: ABdhPJwXOWvF8OXeFLlBmZ7m3kp313BUPkFU7C1MgqkzrCm19j1rIEy8cN/gIVXkLtERTDASGuR+Pw==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr6019157qke.23.1632419924651;
        Thu, 23 Sep 2021 10:58:44 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t194sm4994003qka.72.2021.09.23.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:58:43 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:00:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUzAzl5iCdfUBJqe@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUwTuaZlzx2WLXcG@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwTuaZlzx2WLXcG@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 01:42:17AM -0400, Kent Overstreet wrote:
> On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> > On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
> > >  - it's become apparent that there haven't been any real objections to the code
> > >    that was queued up for 5.15. There _are_ very real discussions and points of
> > >    contention still to be decided and resolved for the work beyond file backed
> > >    pages, but those discussions were what derailed the more modest, and more
> > >    badly needed, work that affects everyone in filesystem land
> > 
> > Unfortunately, I think this is a result of me wanting to discuss a way
> > forward rather than a way back.
> > 
> > To clarify: I do very much object to the code as currently queued up,
> > and not just to a vague future direction.
> > 
> > The patches add and convert a lot of complicated code to provision for
> > a future we do not agree on. The indirections it adds, and the hybrid
> > state it leaves the tree in, make it directly more difficult to work
> > with and understand the MM code base. Stuff that isn't needed for
> > exposing folios to the filesystems.
> 
> I think something we need is an alternate view - anon_folio, perhaps - and an
> idea of what that would look like. Because you've been saying you don't think
> file pages and anymous pages are similar enough to be the same time - so if
> they're not, how's the code that works on both types of pages going to change to
> accomadate that?
> 
> Do we have if (file_folio) else if (anon_folio) both doing the same thing, but
> operating on different types? Some sort of subclassing going on?

Yeah, with subclassing and a generic type for shared code. I outlined
that earlier in the thread:

https://lore.kernel.org/all/YUo20TzAlqz8Tceg@cmpxchg.org/

So you have anon_page and file_page being subclasses of page - similar
to how filesystems have subclasses that inherit from struct inode - to
help refactor what is generic, what isn't, and highlight what should be.

Whether we do anon_page and file_page inheriting from struct page, or
anon_folio and file_folio inheriting from struct folio - either would
work of course. Again I think it comes down to the value proposition
of folio as a means to clean up compound pages inside the MM code.
It's pretty uncontroversial that we want PAGE_SIZE assumptions gone
from the filesystems, networking, drivers and other random code. The
argument for MM code is a different one. We seem to be discussing the
folio abstraction as a binary thing for the Linux kernel, rather than
a selectively applied tool, and I think it prevents us from doing
proper one-by-one cost/benefit analyses on the areas of application.

I suggested the anon/file split as an RFC to sidestep the cost/benefit
question of doing the massive folio change in MM just to cleanup the
compound pages; takeing the idea of redoing the page typing, just in a
way that would maybe benefit MM code more broadly and obviously.

> I was agreeing with you that slab/network pools etc. shouldn't be folios - that
> folios shouldn't be a replacement for compound pages. But I think we're going to
> need a serious alternative proposal for anonymous pages if you're still against
> them becoming folios, especially because according to Kirill they're already
> working on that (and you have to admit transhuge pages did introduce a mess that
> they will help with...)

I think we need a better analysis of that mess and a concept where
tailpages are and should be, if that is the justification for the MM
conversion.

The motivation is that we have a ton of compound_head() calls in
places we don't need them. No argument there, I think.

But the explanation for going with whitelisting - the most invasive
approach possible (and which leaves more than one person "unenthused"
about that part of the patches) - is that it's difficult and error
prone to identify which ones are necessary and which ones are not. And
maybe that we'll continue to have a widespread hybrid existence of
head and tail pages that will continue to require clarification.

But that seems to be an article of faith. It's implied by the
approach, but this may or may not be the case.

I certainly think it used to be messier in the past. But strides have
been made already to narrow the channels through which tail pages can
actually enter the code. Certainly we can rule out entire MM
subsystems and simply declare their compound_head() usage unnecessary
with little risk or ambiguity.

Then the question becomes which ones are legit. Whether anybody
outside the page allocator ever needs to *see* a tailpage struct page
to begin with. (Arguably that bit in __split_huge_page_tail() could be
a page allocator function; the pte handling is pfn-based except for
the mapcount management which could be encapsulated; the collapse code
uses vm_normal_page() but follows it quickly by compound_head() - and
arguably a tailpage generally isn't a "normal" vm page, so a new
pfn_to_normal_page() could encapsulate the compound_head()). Because
if not, seeing struct page in MM code isn't nearly as ambiguous as is
being implied. You would never have to worry about it - unless you are
in fact the page allocator.

So if this problem could be solved by making tail pages an
encapsulated page_alloc thing, and chasing down the rest of
find_subpage() callers (which needs to happen anyway), I don't think a
wholesale folio conversion of this subsystem would be justified.

A more in-depth analyses of where and how we need to deal with
tailpages - laying out the data structures that hold them and code
entry points for them - would go a long way for making the case for
folios. And might convince reluctant people to get behind the effort.

Or show that we don't need it. Either way, it seems like a win-win.

But I do think the onus for explaining why the particular approach was
chosen against much less invasive options is on the person pushing the
changes. And it should be more detailed than "we all know it sucks".
