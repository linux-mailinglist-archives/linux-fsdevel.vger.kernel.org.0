Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134DF367991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhDVF42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhDVF41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:56:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD9C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 22:55:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e13so35431519qkl.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 22:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Yd2gs0ulaQk3ryBAG/T9ZY2Wi9SgLd9cQYKXihYv8FY=;
        b=qgLnNEFAyhsCr5cTqAilhCCR88xu+Lo0ZCHkoYuo9qoV9qF5+bl0g2GDlTmSFyksax
         ac+CqrVtJ4ALOfyvVhbTdPiah0c0VuiBGi8wYRpGPinVYsDjJbXJE5s//i9QIYjdeYdU
         LM0uyBCx6cLA8P4esZfCYogttHX/0pJrFcX9MeLotQzuNT4H7z7XqntpI2jcW//5pxdq
         3jWYc4yiEbbY365WjsxyBm81g2fUS35RYgRJRARaOalJlPngmh2neZzzi4sa0NUbmRUj
         F50jwME1yvUTFGtN9FO4UmbErfRtmFuW77Q9nsSBUeJGvk9mVMXDyipPC9PhhiGmcRu9
         xEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Yd2gs0ulaQk3ryBAG/T9ZY2Wi9SgLd9cQYKXihYv8FY=;
        b=RHwde9TbvkDaHxIttotcdbOP9BzBHEAQkC7+rTn1JM+8QaD/i9lzHOuw1kDNIiYtkA
         5d8JrEgu/wDrcSmKxdD7nL4qmqRsVS8JLc6XtUAaXCYhMdr5keLavHd4Qp9xjnN0WGms
         +PB+kXo5wD+2qe8naZU5lsh858e0LXe+ChJpWKnzLGMU8BKZ3KFtTr6PKwMqSL6cqmTz
         66Ei9XFU584ag5ABtx9Ogu1/OqpkURuQQb9SqH83KbHnv5Ymv1io3fBrCojmQHkIWjDG
         9YJtyRMOPMnTDEJcl8DsGtTGSVppKdKMx23rpUz1nXF+FHGM0byIkxC/pxzftbkm6hpE
         Vy4Q==
X-Gm-Message-State: AOAM533OLQ8mLUeIPKDObi0NxbooXVe2ccSlgzMRRARe/GAUeJN2uN0H
        fpN6yFpp5nY3U8frgqbfp5A5ew==
X-Google-Smtp-Source: ABdhPJwTn+aHqXWQgw/QpAWr54vJAvqSR/wNms5ahjY3dZ7KwzD9PAegW91quU4DGMZ0H997GGZ9kQ==
X-Received: by 2002:a05:620a:4143:: with SMTP id k3mr1849181qko.497.1619070950786;
        Wed, 21 Apr 2021 22:55:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i21sm1505944qtr.94.2021.04.21.22.55.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 21 Apr 2021 22:55:50 -0700 (PDT)
Date:   Wed, 21 Apr 2021 22:55:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
In-Reply-To: <20210422011631.GL3596236@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2104212253000.4412@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils> <alpine.LSU.2.11.2104211737410.3299@eggly.anvils> <20210422011631.GL3596236@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Apr 2021, Matthew Wilcox wrote:
> On Wed, Apr 21, 2021 at 05:39:14PM -0700, Hugh Dickins wrote:
> > No problem on 64-bit without huge pages, but xfstests generic/285
> > and other SEEK_HOLE/SEEK_DATA tests have regressed on huge tmpfs,
> > and on 32-bit architectures, with the new mapping_seek_hole_data().
> > Several different bugs turned out to need fixing.
> > 
> > u64 casts added to stop unfortunate sign-extension when shifting
> > (and let's use shifts throughout, rather than mixed with * and /).
> 
> That confuses me.  loff_t is a signed long long, but it can't be negative
> (... right?)  So how does casting it to an u64 before dividing by
> PAGE_SIZE help?

That is a good question. Sprinkling u64s was the first thing I tried,
and I'd swear that it made a good difference at the time; but perhaps
that was all down to just the one on xas.xa_index << PAGE_SHIFT. Or
is it possible that one of the other bugs led to a negative loff_t,
and the casts got better behaviour out of that? Doubtful.

What I certainly recall from yesterday was leaving out one (which?)
of the casts as unnecessary, and wasting quite a bit of time until I
put it back in. Did I really choose precisely the only one necessary?

Taking most of them out did give me good quick runs just now: I'll
go over them again and try full runs on all machines. You'll think me
crazy, but yesterday's experience leaves me reluctant to change without
full testing - but agree it's not good to leave ignorant magic in.

> 
> > Use round_up() when advancing pos, to stop assuming that pos was
> > already THP-aligned when advancing it by THP-size.  (But I believe
> > this use of round_up() assumes that any THP must be THP-aligned:
> > true while tmpfs enforces that alignment, and is the only fs with
> > FS_THP_SUPPORT; but might need to be generalized in the future?
> > If I try to generalize it right now, I'm sure to get it wrong!)
> 
> No generalisation needed in future.  Folios must be naturally aligned
> within a file.

Thanks for the info: I did search around in your various patch series
from last October, and failed to find a decider there: I imagined that
when you started on compound pages for more efficient I/O, there would
be no necessity to align them (whereas huge pmd mappings of shared
files make the alignment important). Anyway, assuming natural alignment
is easiest - but it's remarkable how few places need to rely on it.

> 
> > @@ -2681,7 +2681,8 @@ loff_t mapping_seek_hole_data(struct add
> >  
> >  	rcu_read_lock();
> >  	while ((page = find_get_entry(&xas, max, XA_PRESENT))) {
> > -		loff_t pos = xas.xa_index * PAGE_SIZE;
> > +		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
> > +		unsigned int seek_size;
> 
> I've been preferring size_t for 'number of bytes in a page' because
> I'm sure somebody is going to want a page larger than 2GB in the next
> ten years.

Ah, there I was simply following what the author of seek_page_size()
had chosen, and I think that's the right thing to do in today's tree:
let's see who that author was... hmm, someone called Matthew Wilcox :)
