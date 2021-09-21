Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C6413D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhIUV7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhIUV7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:59:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3890C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:57:33 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e16so683926qte.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Sep 2021 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVeSCGRKIiyvWycmoGx6GlZVf+OBysJsxMROIYkTp+E=;
        b=VoYhdhCluGoYbkdSs9ZviRrXOCFdtZ5H099jEvPGW5j298L+m7OYhjvZTXrWQEpzuH
         IqHC5TNqkf0Ig6ZGyOuZ4kHUFiv3leqg6iJTAxKfm8dnORvZKQZE/2gtybjrS2srK1Wt
         FLF9r5VMSDiIZy+Sh4FL0V9blVUOrfIjCIoJjsPyMIsGf53hSsbu9wxQQDsCJ1q0voF2
         zrm1tT25pHefoQTyqIFKfFXdnuEZ3cGQHC/hJOeaT7pu3YklcjJn+eB7FzXRx/JMsPZc
         v82mao0R5OX4ZnE+11YHpJuLTpr2LjTcTC5fCet6NvV+ofdj53hv8sWr3fUwPTiRLnCU
         on8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVeSCGRKIiyvWycmoGx6GlZVf+OBysJsxMROIYkTp+E=;
        b=eRuifwZW0EAm0Eb00CwwHhiO2Hy1gGlThE7L0dHff2+xj29l+woWEBla+gzOi4ErbB
         cbMJ4HNNTdF1I1PxjmpjtXDK3isIbchB5627+XdWYdRbNZRzu6y2aXajz3V65ncb7f3c
         J7TpHqpcgVeILHCx959wgZHIGAhXKh4NIczT3PWyMl3xjAkf2zs/ZfT3YPJIrVqDSkS8
         EWpKnwP7EfTAm4WR3ed5MDdl5H+8TJGygfxUkiMI9lmAyykCUjmfTUkK7URCsJu9Jljv
         OlBWv/V5uF26GpVT/ScSCirmiq6/l0DZPkphY9s130wOEvyeyNeFP3wP+wZHkMYLqudD
         3wZg==
X-Gm-Message-State: AOAM532M0zT0ndFQMH4/JPKQnFgVf9ntLKWp9iYW8PMdtnxz91u/+0t4
        BpkxyPu0s8VYtpmcL+Ix339vfw==
X-Google-Smtp-Source: ABdhPJxKO5CZhPNluh8HozyZ0PrmHrVvmnYlcPVGIoDlha+Wmwkfv0kh/u+uKkiXQYXa/nyXEWp8sw==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr20150301qta.378.1632261452739;
        Tue, 21 Sep 2021 14:57:32 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id k17sm176027qtx.67.2021.09.21.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:57:32 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:59:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUpVxZnfskGcJHbD@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpC3oV4II+u+lzQ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:38:54PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 21, 2021 at 03:47:29PM -0400, Johannes Weiner wrote:
> > This discussion is now about whether folio are suitable for anon pages
> > as well. I'd like to reiterate that regardless of the outcome of this
> > discussion I think we should probably move ahead with the page cache
> > bits, since people are specifically blocked on those and there is no
> > dependency on the anon stuff, as the conversion is incremental.
> 
> So you withdraw your NAK for the 5.15 pull request which is now four
> weeks old and has utterly missed the merge window?

Once you drop the bits that convert shared anon and file
infrastructure, yes. Because we haven't discussed yet, nor agree on,
that folio are the way forward for anon pages.

> > and so the justification for replacing page with folio *below* those
> > entry points to address tailpage confusion becomes nil: there is no
> > confusion. Move the anon bits to anon_page and leave the shared bits
> > in page. That's 912 lines of swap_state.c we could mostly leave alone.
> 
> Your argument seems to be based on "minimising churn". Which is certainly
> a goal that one could have, but I think in this case is actually harmful.
> There are hundreds, maybe thousands, of functions throughout the kernel
> (certainly throughout filesystems) which assume that a struct page is
> PAGE_SIZE bytes.  Yes, every single one of them is buggy to assume that,
> but tracking them all down is a never-ending task as new ones will be
> added as fast as they can be removed.

What does that have to do with anon pages?

> > The same is true for the LRU code in swap.c. Conceptually, already no
> > tailpages *should* make it onto the LRU. Once the high-level page
> > instantiation functions - add_to_page_cache_lru, do_anonymous_page -
> > have type safety, you really do not need to worry about tail pages
> > deep in the LRU code. 1155 more lines of swap.c.
> 
> It's actually impossible in practice as well as conceptually.  The list
> LRU is in the union with compound_head, so you cannot put a tail page
> onto the LRU.  But yet we call compound_head() on every one of them
> multiple times because our current type system does not allow us to
> express "this is not a tail page".

No, because we haven't identified *who actually needs* these calls
and move them up and out of the low-level helpers.

It was a mistake to add them there, yes. But they were added recently
for rather few callers. And we've had people send patches already to
move them where they are actually needed.

Of course converting *absolutely everybody else* to not-tailpage
instead will also fix the problem... I just don't agree that this is
an appropriate response to the issue.

Asking again: who conceptually deals with tail pages in MM? LRU and
reclaim don't. The page cache doesn't. Compaction doesn't. Migration
doesn't. All these data structures and operations are structured
around headpages, because that's the logical unit they operate on. The
notable exception, of course, are the page tables because they map the
pfns of tail pages. But is that it?  Does it come down to page table
walkers encountering pte-mapped tailpages? And needing compound_head()
before calling mark_page_accessed() or set_page_dirty()?

We couldn't fix vm_normal_page() to handle this? And switch khugepaged
to a new vm_raw_page() or whatever?

It should be possible to answer this question as part of the case for
converting tens of thousands of lines of code to folio.
