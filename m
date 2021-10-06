Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07414424160
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhJFPcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:32:53 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52762 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJFPcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:32:52 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY8qb-00AWPX-Kh; Wed, 06 Oct 2021 15:28:45 +0000
Date:   Wed, 6 Oct 2021 15:28:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV3ArQxQ7CFzhBhR@zeniv-ca.linux.org.uk>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
 <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:23:49PM +0200, David Hildenbrand wrote:
> On 06.10.21 17:22, Al Viro wrote:
> > On Wed, Oct 06, 2021 at 03:58:14PM +0100, Matthew Wilcox wrote:
> > > David expressed some unease about the lack of typesafety in patches
> > > 1 & 2 of the page->slab conversion [1], and I'll admit to not being
> > > particularly a fan of passing around an unsigned long.  That crystallised
> > > in a discussion with Kent [2] about how to lock a page when you don't know
> > > its type (solution: every memory descriptor type starts with a
> > > pgflags_t)
> > 
> > Why bother making it a struct?  What's wrong with __bitwise and letting
> > sparse catch conversions?
> > 
> 
> As I raised in my reply, we store all kinds of different things in
> page->flags ... not sure if that could be worked around somehow.

What of that?  Inline helpers with force-casts for accessing those and
that's it...

Use of __bitwise is simply invisible to compiler - it doesn't get past the
preprocessor on non-sparse builds.  So it's not like you'd disrupt the
atomic accesses, layout, etc.
