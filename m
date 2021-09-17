Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFFA40EEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 03:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhIQBoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 21:44:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45160 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242430AbhIQBo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:44:26 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18H1gLWH003228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 21:42:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4DEA515C0098; Thu, 16 Sep 2021 21:42:21 -0400 (EDT)
Date:   Thu, 16 Sep 2021 21:42:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-ID: <YUPyfWKG3CG8+zkn@mit.edu>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <YUOX0VxkO+/1kT7u@mit.edu>
 <YUOmG+qNxAxI9Kyn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUOmG+qNxAxI9Kyn@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:16:27PM -0400, Kent Overstreet wrote:
> So I think we're still trying to answer the "what exactly is a folio"
> question....

> However, Johannes has been pointing out that it's a real open
> question as to whether anonymous pages should be folios! Willy's
> current code seems to leave things in a somewhat intermediate state
> - some mm/ code treats anonymous pages as folios, but it's not clear
> to me how much....

Kent, you raise some good questions, and good points.  However, it
seems to me that one of the other sources of the disagreement is the
question of whether this question needs to be answered at all before
the Folios patch can get merged.

We could engage in a process such as what Chris Mason has suggested,
with a more formal design doc, with stakeholders who have to review,
comment, and explicitly give their LGTM's.  We do that sort of thing
quite often at Google (and probably at many other companies), so it's
a familiar approach.  That would be a fine way of trying to come to a
formal agreement on that question.

What comes to my mind, though, is the quote, originally made by Linus,
"Linux is evolution, not Intelligent Design".  Greg K-H requoted Linus
in his 2006 Ottawa Linux Symposium[1], “Myths, Lies, and Truths about
the Linux Kernel”, and further claimed, "The kernel is not developed
with big design documents, feature requests and so on."

[1] http://www.kroah.com/log/linux/ols_2006_keynote.html

Of course, that was 15 years ago, and things have gotten a lot more
complex.  And when things get more complex, a certain amount of
agreement ahead of time between developers, memorialized by Design
Docs, does become more and more inevitable.  The source of friction,
then is how *much* pre-design and consensus is needed in a particular
case.

After all, as you said:

   ".... folios are a start on cutting up the unholy mess that is
   struct page into separate data types. In struct page, we have a big
   nested union of structs, for different types of pages."

So one could argue that folio makes things better.  It's not an 100%
solution, and perhaps it's unfortunate that it leaves things "in a
somewhat intermediate state".  But if it's better than what we
currently have, perhaps we should land this patch set, and if we need
to make further evolutionary changes, is that really such a tragedy?

After all, we've never guaranteed stable API's (another thing which
Greg foot-stomped in his 2006 keynote).  Maybe after we live with
folios, we'll learn more about the benefits and downsides, we can make
further changes --- evolution, as we might say.

Quoting further from Greg K-H:

    "The Linux USB code has been rewritten at least three times. We've
    done this over time in order to handle things that we didn't
    originally need to handle, like high speed devices, and just
    because we learned the problems of our first design, and to fix
    bugs and security issues. Each time we made changes in our api, we
    updated all of the kernel drivers that used the apis, so nothing
    would break. And we deleted the old functions as they were no
    longer needed, and did things wrong. Because of this, Linux now
    has the fastest USB bus speeds when you test out all of the
    different operating systems....."[1]

(And it's not just the USB subsystem that has been rewritten three
times; our networking stack has been rewritten at least 3 times as
well.)

It seems that part of the frustration is that people seem to agree
that Folios does make things better, and yet they *still* are NACK'ing
the patch series.  The argument for why it should not be merged yet
seems to be that it should be doing *more* --- that it doesn't go far
enough.

The opposing argument would be, "if folios improves things, and
doesn't introduce any bugs, why shouldn't we merge it, reap the
benefits, and then we can further evolve things?"

As Linus said, "Linux is evolution, not intelligent design."

	      	      	  	  	 - Ted
