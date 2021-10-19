Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF7433A03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhJSPSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhJSPSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:18:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A7C061746
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 08:16:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g20so272819qka.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z2QCsj8uoI1elGSwjIcPM3flWlmV5asRjFaV2+Zm7wQ=;
        b=P0eGPUE0ED5s2q2cgVj1MBGSU0NFueMDTHHmFRDzaMGveNnY7eva5aqT9YKQ4ywom6
         zIBle47EmTwcAGH0xgKkEuTEMYd+gvhyrjK32+CGng9rdAaUEaGnDlgvj43WQBoC1hUg
         Fp039gNDJQjIHUPuAM6nPkJCi5ezTCcmovk4gOXKIV8ryUuMAN1CxV/T79DoYzhFDQYg
         kbEdvYeuB4IMGQ+vpKB+O6oyDQ80i5ffweK5/54+rpeYMCPUuqWkQM7qDnXrsPY3o+SZ
         tr/dVhtB+oqSceg4VpqqguL/+ocqLY1sTtqlBroX8n/oiI+dlCsxIaaWmMdnwA4tin94
         r+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2QCsj8uoI1elGSwjIcPM3flWlmV5asRjFaV2+Zm7wQ=;
        b=kTnTe7LWC8MA1xdqYRSnyOz2iKsgHelASVMssYP8SqOyCqqFUgHEOPA3vHqvvtMujg
         ajaqMBDmnO+udBzOAH8E8DateFhe/6V81mL1et0Mk3s+HfOrV92pyn4fjRd4wkBUIeKi
         cmn/vzYKczMZEOq0vx8Js8vKXVP4FtO9xZj5nVhuxLCt6bSCWKPpT0uus4m36vtCZ15M
         YvaWB3rZX+ezKpNK76gCsKQvG+W5gs3JZVtfvkkGffh7tq2hvoIrYjA9oPB3kTu1k313
         Akjo0zrS3msSLmDmg6XsNt54+jcwKSH1vuMPjn+kWcvK4QLNVBuVDvt40eBCkvd0x6FF
         Do1A==
X-Gm-Message-State: AOAM531okWX38dL3PmxS+AVvh414aVvPx/40SCBxTDqxbYBbDgZa3yZc
        TXSwcu9tLQQDvX1NfKFHY2tg0A==
X-Google-Smtp-Source: ABdhPJwGYQB/TCQqWjql20jclqCkpzSoRFFVoS5J1OXAL1VgIP3+MgHBaeuDfu3E2NL2tHQgwsHbvg==
X-Received: by 2002:a05:620a:45a4:: with SMTP id bp36mr457879qkb.51.1634656580587;
        Tue, 19 Oct 2021 08:16:20 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id z6sm734425qtj.90.2021.10.19.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:16:19 -0700 (PDT)
Date:   Tue, 19 Oct 2021 11:16:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW7hQlny+Go1K3LT@cmpxchg.org>
References: <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:16:27AM +0300, Kirill A. Shutemov wrote:
> On Mon, Oct 18, 2021 at 05:56:34PM -0400, Johannes Weiner wrote:
> > > I don't think there will ever be consensus as long as you don't take
> > > the concerns of other MM developers seriously.  On Friday's call, several
> > > people working on using large pages for anon memory told you that using
> > > folios for anon memory would make their lives easier, and you didn't care.
> > 
> > Nope, one person claimed that it would help, and I asked how. Not
> > because I'm against typesafety, but because I wanted to know if there
> > is an aspect in there that would specifically benefit from a shared
> > folio type. I don't remember there being one, and I'm not against type
> > safety for anon pages.
> > 
> > What several people *did* say at this meeting was whether you could
> > drop the anon stuff for now until we have consensus.
> 
> My read on the meeting was that most of people had nothing against anon
> stuff, but asked if Willy could drop anon parts to get past your
> objections to move forward.
> 
> You was the only person who was vocal against including anon pars. (Hugh
> nodded to some of your points, but I don't really know his position on
> folios in general and anon stuff in particular).

Nobody likes to be the crazy person on the soapbox, so I asked Hugh in
private a few weeks back. Quoting him, with permission:

: To the first and second order of approximation, you have been
: speaking for me: but in a much more informed and constructive and
: coherent and rational way than I would have managed myself.

It's a broad and open-ended proposal with far reaching consequences,
and not everybody has the time (or foolhardiness) to engage on that. I
wouldn't count silence as approval - just like I don't see approval as
a sign that a person took a hard look at all the implications.

My only effort from the start has been working out unanswered
questions in this proposal: Are compound pages the reliable, scalable,
and memory-efficient way to do bigger page sizes? What's the scope of
remaining tailpages where typesafety will continue to lack? How do we
implement code and properties shared by folios and non-folio types
(like mmap/fault code for folio and network and driver pages)?

There are no satisfying answers to any of these questions, but that
also isn't very surprising: it's a huge scope. Lack of answers isn't
failure, it's just a sign that the step size is too large and too
dependent on a speculative future. It would have been great to whittle
things down to a more incremental and concrete first step, which would
have allowed us to keep testing the project against reality as we go
through all the myriad of uses and cornercases of struct page that no
single person can keep straight in their head.

I'm grateful for the struct slab spinoff, I think it's exactly all of
the above. I'm in full support of it and have dedicated time, effort
and patches to help work out kinks that immediately and inevitably
surfaced around the slab<->page boundary.

I only hoped we could do the same for file pages first, learn from
that, and then do anon pages; if they come out looking the same in the
process, a unified folio would be a great trailing refactoring step.

But alas here we are months later at the same impasse with the same
open questions, and still talking in circles about speculative code.
I don't have more time to invest into this, and I'm tired of the
vitriol and ad-hominems both in public and in private channels.

I'm not really sure how to exit this. The reasons for my NAK are still
there. But I will no longer argue or stand in the way of the patches.
