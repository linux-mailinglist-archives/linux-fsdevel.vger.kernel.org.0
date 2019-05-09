Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8B18D51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEIPrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 11:47:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40423 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbfEIPrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 11:47:06 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x49FkZL7007577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 May 2019 11:46:36 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3105D420024; Thu,  9 May 2019 11:46:35 -0400 (EDT)
Date:   Thu, 9 May 2019 11:46:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Vijay Chidambaram <vijay@cs.utexas.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509154635.GF29703@mit.edu>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
 <20190509022013.GC7031@mit.edu>
 <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUVViC_EJm3K7MfvfSQ+G1u=SX=RXAZWPYjZuS16JWxNEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 12:02:17AM -0500, Vijay Chidambaram wrote:
> As we have stated on multiple times on this and other threads, the
> intention is *not* to come up with one set of crash-recovery
> guarantees that every Linux file system must abide by forever. Ted,
> you keep repeating this, though we have never said this was our
> intention.
> 
> The intention behind this effort is to simply document the
> crash-recovery guarantees provided today by different Linux file
> systems. Ted, you question why this is required at all, and why we
> simply can't use POSIX and man pages.

But who is this documentation targeted towards?  Who is it intended to
benefit?  Most application authors do not write applications with
specific file systems in mind.  And even if they do, they can't
control how their users are going to use it.

> FWIW, I think the position of "if we don't write it down, application
> developers can't depend on it" is wrong. Even with nothing written
> down, developers noticed they could skip fsync() in ext3 when
> atomically updating files with rename(). This lead to the whole ext4
> rename-and-delayed-allocation problem. The much better path, IMO, is
> to document the current set of guarantees given by different file
> systems, and talk about what is intended and what is not. This would
> give application developers much better guidance in writing
> applications.

If we were to provide that nuance, that would be much better, I would
agree.  It's not what the current crash consistency guarantees
provides, alas.  I'd also want to talk about what is guaranteed
*first*; documenting the current state of affairs, some of which may
be subject to change and the result of the implementation, is far less
important.  So I'd prefer that "documentation of current behavior" be
the last thing in the document --- perhaps in an appendix --- and not
the headliner.

Indeed, I'd use the ext3 O_PONIES discussion as a prime example of the
risk if we were to just "document current practice" and stop there.
It's the fact that your crash consistency guarantees draft, claims to
"document current practice", and at the same time, uses the word
"guarantee" which causes red flags to go up for me.

If we could separate those two, that would be very helpful.  And if
the current POSIX guarantees are too vague, my preference would be to
first determine what application authors would find more useful in
terms stricter guarantees, and provide those guarantees as we find
them.  We can always add more guarantees later.  Taking guarantees
away is much harder.  And guarantees by defintion always restrict
freedom of action, so this is an engineering tradeoff.  Let's provide
those guarantees when it actually improves application performance,
and not Just Because.

It might also be that defining new system calls, like fbarrier() and
fdatabarrier() is a better approach rather than retconning new
semantics on top of fsync().  I just think a principled design
approach is better rather than taking existing semantics and slapping
the word "guarantee" in the title of said documentation.

I will also say that I have no problems with documenting strong
metadata ordering if it has nothing to do with fsync().  That makes
sense.  The moment that you try to also bring data integrity into the
mix, and give examples of what happens if you call fsync(), that it
goes beyond strong metadata ordering.  So if you want to document what
happens without fsync, ext4 can probably get on board with them.
Unfortuantely, in addition to including the word "guarantee", the
current crash consistency draft also includes the word "fsync".

> 4. Apart from developers, a document like this would also help
> academic researchers understand the current state-of-the-art in
> crash-recovery guarantees and the different choices made by different
> file systems. It is non-trivial to understand this without
> documentation.

It's also very hard to undertand this without taking performance
constraints and implementation choices into account.  It's trivially
easy to give super-strong crash-recovery guarantees.  But if it
sacrifices performance, is it really "state-of-the-art"?

Worse, different applications may want different guarantees, and may
want different crash consistency vs. performance tradeoffs.  This is
why in general, the concept of providing new interfaces where the
application can state more explicitly what they want is much more
appealing to me.

When I have discussions with Amir, he doesn't just want strong
guarantees; he wants specific guarantees with zero overhead, and our
discussions have been in how to we manage that tension between those
two goals.  And it's much easier to achieve this in terms of very
specific cases, such as what happens when you link an O_TMPFILE file
into a directory.

Cheers,

   		     	      	 	   	- Ted
