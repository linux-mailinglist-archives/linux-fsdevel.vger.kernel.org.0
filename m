Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D195240EABA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhIPTRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 15:17:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53293 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230243AbhIPTRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:17:21 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18GJFTw4011993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 15:15:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CBBD115C0098; Thu, 16 Sep 2021 15:15:29 -0400 (EDT)
Date:   Thu, 16 Sep 2021 15:15:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
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
Message-ID: <YUOX0VxkO+/1kT7u@mit.edu>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:11:21PM -0400, James Bottomley wrote:
> 
> Actually, I don't see who should ack being an unknown.  The MAINTAINERS
> file covers most of the kernel and a set of scripts will tell you based
> on your code who the maintainers are ... that would seem to be the
> definitive ack list.

It's *really* not that simple.  It is *not* the case that if a change
touches a single line of fs/ext4 (as well as 60+ other filesystems),
for example:

-       ei = kmem_cache_alloc(ext4_inode_cachep, GFP_NOFS);
+       ei = alloc_inode_sb(sb, ext4_inode_cachep, GFP_NOFS);

that the submitter *must* get a ACK from me --- or that I am entitled
to NACK the entire 79 patch series for any reason I feel like, or to
withhold my ACK as hostage until the submitter does some development
work that I want.

What typically happens is if someone were to try to play games like
this inside, say, the Networking subsystem, past a certain point,
David Miller will just take the patch series, ignoring people who have
NACK's down if they can't be justified.  The difference is that even
though Andrew Morton (the titular maintainer for all of Memory
Management, per the MAINTAINERS file), Andrew seems to have a much
lighter touch on how the mm subsystem is run.

> I think the problem is the ack list for features covering large areas
> is large and the problems come when the acker's don't agree ... some
> like it, some don't.  The only deadlock breaking mechanism we have for
> this is either Linus yelling at everyone or something happening to get
> everyone into alignment (like an MM summit meeting).  Our current model
> seems to be every acker has a foot on the brake, which means a single
> nack can derail the process.  It gets even worse if you get a couple of
> nacks each requesting mutually conflicting things.
> 
> We also have this other problem of subsystems not being entirely
> collaborative.  If one subsystem really likes it and another doesn't,
> there's a fear in the maintainers of simply being overridden by the
> pull request going through the liking subsystem's tree.  This could be
> seen as a deadlock breaking mechanism, but fear of this happening
> drives overreactions.
> 
> We could definitely do a clear definition of who is allowed to nack and
> when can that be overridden.

Well, yes.  And this is why I think there is a process issue here that
*is* within the MAINTAINERS SUMMIT purview, and if we need to
technical BOF to settle the specific question of what needs to happen,
whether it happens at LPC, or it needs to happen after LPC, then let's
have it happen.

I'd be really disappointed if we have to wait until December 2022 for
the next LSF/MM, and if we don't get consensus there, ala DAX, that we
then have to wait until late 2023, etc.  As others have said, this is
holding up some work that file system developers would really like to
see.

					- Ted
