Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A734241D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhJFPwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:52:41 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:53050 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJFPwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:52:40 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mY99o-00AWbb-GU; Wed, 06 Oct 2021 15:48:36 +0000
Date:   Wed, 6 Oct 2021 15:48:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] pgflags_t
Message-ID: <YV3FVNARU1Xv80oM@zeniv-ca.linux.org.uk>
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
 <YV3DCX92lvOA4fni@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV3DCX92lvOA4fni@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 06, 2021 at 04:38:49PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 06, 2021 at 03:22:29PM +0000, Al Viro wrote:
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
> 
> People don't run sparse.  I happen to have a built allmodconfig tree
> here and running make C=2 fs/ gives 1147 lines of warnings.  Why would
> adding more warnings help?

First of all, they are easy to grep for (they'll mention pgflags_t in
warning message).  What's more, we ought to reduce the amount of noise,
rather than giving up on the tool and going for contortions like that...
