Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE342440C8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 03:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhJaCel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Oct 2021 22:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhJaCel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Oct 2021 22:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C5C061570;
        Sat, 30 Oct 2021 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YdEhdcEX2r4TtLJMXFuodi5EJcFx7uX9qTnwsGSmkFc=; b=Js+H5NBNANgCRDVhQvqX7o9WBJ
        tJiGk78fRMliMjwpZYRG+H4LIkaXtpMHRWVCd4hI2uYlLCswVBiUIAyocU0K3mpGwQV1u9bf68ewq
        NauIaae2zwunD264xCR5WaKInAQQo6+SHKgkMT0YS6bmBBVnnFe5qYpkAICpY8cBmOkUEdw3E8jC+
        Ch0SIHEvPhQGaOdwSH5/1RS1YU0yfr2LGvXcU/NxZ8Yhv1xI2cXF6OPzsbcMUxWXgFkp7e/XRYzwI
        i1wJGufjNl9ue1IlIJAbYn2y/bBroKKQZwBy3XMf2yiAvhqV8a3eyr3Yse5Dle2mgN40nX+qxmjUa
        5QMHuZBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mh0ae-002neL-Qn; Sun, 31 Oct 2021 02:29:25 +0000
Date:   Sun, 31 Oct 2021 02:28:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nathan Lewis <npl@google.com>, Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
Message-ID: <YX3/aAYxsOey4FBS@casper.infradead.org>
References: <20211028205854.830200-1-almasrymina@google.com>
 <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com>
 <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
 <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com>
 <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 30, 2021 at 03:06:31PM -0700, Mina Almasry wrote:
> Not quite sufficient, no. The process may have lots of non performance
> critical memory. The network service cares about specific memory
> ranges and wants to know if those are backed by hugepages.

Would it make sense to extend mincore() instead?  We have 7 remaining
bits per byte.

But my question is, what information do you really want?  Do you want
to know if the memory range is backed by huge pages, or do you want to
know if PMDs are being used to map the backing memory?

What information would you want to see if, say, 64kB entries are being
used on a 4kB ARM system where there's hardware support for those.
Other architectures also have support for TLB entries that are
intermediate between PTE and PMD sizes.

