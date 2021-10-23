Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67C54385CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJWW0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWW0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 18:26:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12EC061714;
        Sat, 23 Oct 2021 15:23:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h65so8366478qke.0;
        Sat, 23 Oct 2021 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/iY4mkP5CITw30ncTBqe0r7VHjZK/w2eKc4vTccqfLc=;
        b=gh/3JLk/ek1VRq0um4wQVJYOtNPOizsFL4Nyqh6Tkrr9ppVbg+rMXBdbaS7Dw0xdiJ
         VAMBHml6WguGG1oA8yCXyzmJRnSy068h356uvWaBmAruMb3a76LOKSI7zSwEqVme2NGP
         yG7eIDwPrZ1MlCeqltZI1Afp2HT7PNPFpg1Rzr3fZTMchPRMUrTwoqFgXinJ2ugXztgm
         oeCB+NzT/+snZeJ5CD8+zzFPqoVpArUaNM+JTIwKksWGKJzO6t2uyzHwXEMy11ZB/LmA
         w8Ls0Qh2lOo6fROGgwvtSCRukVUIsr8K3k/Su7aIRbW69wldtz5mFkfAdz7X6mSck0tu
         jH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/iY4mkP5CITw30ncTBqe0r7VHjZK/w2eKc4vTccqfLc=;
        b=FgtLIlixjf9s39iLjzbp6BTXwX5b3HtUtN2rueU/qnWzCXJ9eE8oFyRXhlZ+vsKvQw
         OEy1xhMJjPrHNIs4WGP6riEe4M7Y57o63O+RJsFT7FKX+CbQJIQshwxxeCdJfxgjB0Qn
         Q/bA8OCqWD9bZASun75nAhz+EkR9hO/KuuQMFKRao14CSsHadp7QCKjoibgaA9Y9t4qj
         M0Zgs/ToR262MtnNQULUglfVEP8h6T79tBlgxoEi0ujWBqFZWu78s+nYpXpm+PpXWrN+
         BfdL1sYz2iypqBH10YmWbGN0KaXO7b8jehTnrHsmwsU4cUuMobM2VfRskH7TfVMO6WwA
         hZqA==
X-Gm-Message-State: AOAM530D7fP7nOfdYOKWDTyHNqZ99kvrUuPbg7gWJ4HtR1spVEAKQkiT
        2hj/RD/GQ337X3ostpBhvg==
X-Google-Smtp-Source: ABdhPJy1pkWM2MjtfxwtMIzluJqqKJiRCgDwA5NlxXOF6DHDGY0KNqcRRiBzHRc+/mnxrhyRPbgqHg==
X-Received: by 2002:a05:620a:6bd:: with SMTP id i29mr6366027qkh.121.1635027820776;
        Sat, 23 Oct 2021 15:23:40 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id k8sm6263868qkk.37.2021.10.23.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 15:23:39 -0700 (PDT)
Date:   Sat, 23 Oct 2021 18:23:37 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXSLaQKJH+rvleBJ@moria.home.lan>
References: <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
 <YXNx686gvsJMgS+z@casper.infradead.org>
 <404bdc05-487f-3d47-6b30-0687b74c2f2f@redhat.com>
 <YXQxptoPALVHHPCU@moria.home.lan>
 <YXSBlfLsOi2WzR72@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXSBlfLsOi2WzR72@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 10:41:41PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 23, 2021 at 12:00:38PM -0400, Kent Overstreet wrote:
> > I ran into a major roadblock when I tried converting buddy allocator freelists
> > to radix trees: freeing a page may require allocating a new page for the radix
> > tree freelist, which is fine normally - we're freeing a page after all - but not
> > if it's highmem. So right now I'm not sure if getting struct page down to two
> > words is even possible. Oh well.
> 
> I have a design in mind that I think avoids the problem.  It's somewhat
> based on Bonwick's vmem paper, but not exactly.  I need to write it up.

I am intruiged... Care to drop some hints?

> Right.  Folios are for unspecialised head pages.  If we decide
> to specialise further in the future, that's great!  I think David
> misunderstood me slightly; I don't know that specialising file + anon
> pages (the aforementioned lru_mem) is the right approach.  It might be!
> But it needs someone to try it, and find the advantages & disadvantages.

Well, that's where your current patches are basically headed, aren't they? As I
understand it it's just file and some of the anon code that's converted so far.

Are you thinking more along the lines of converting everything that can be
mapped to userspace to folios? I think that would make a lot of sense given that
converting the weird things to file pages isn't likely to happen any time soon,
and it would us convert gup() to return folios, as Christoph noted.

> 
> > Also introducing new types to be describing our current using of struct page
> > isn't the only thing we should be doing - as we do that, that will (is!) uncover
> > a lot of places where our ontology of struct page uses is just nonsensical (all
> > the types of pages mapped into userspace!) - and part of our mission should be
> > to clean those up.
> > 
> > That does turn things into a much bigger project than what Matthew signed up
> > for, but we shouldn't all be sitting on the sidelines here...
> 
> I'm happy to help.  Indeed I may take on some of these sub-projects
> myself.  I just don't want the perfect to be the enemy of the good.

Agreed!
