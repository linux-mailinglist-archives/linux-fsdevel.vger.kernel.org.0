Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B731530
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfEaTVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:21:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53601 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726808AbfEaTVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:21:33 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4VJLJYS021826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 May 2019 15:21:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5EE8C420481; Fri, 31 May 2019 15:21:19 -0400 (EDT)
Date:   Fri, 31 May 2019 15:21:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190531192119.GB3066@mit.edu>
References: <20190527172655.9287-1-amir73il@gmail.com>
 <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu>
 <CAOQ4uxjp5psDBLXBu+26xRLpV50txqksVFe6ZhUo0io8kgoH4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjp5psDBLXBu+26xRLpV50txqksVFe6ZhUo0io8kgoH4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 08:22:06PM +0300, Amir Goldstein wrote:
> >
> > This is I think more precise:
> >
> >     This guarantee can be achieved by calling fsync(2) before linking
> >     the file, but there may be more performant ways to provide these
> >     semantics.  In particular, note that the use of the AT_ATOMIC_DATA
> >     flag does *not* guarantee that the new link created by linkat(2)
> >     will be persisted after a crash.
> 
> OK. Just to be clear, mentioning hardlinks and st_link is not needed
> in your opinion?

Your previous text stated that it was undefined what would happen to
all hardlinks belonging to the file, and that would imply that if a
file had N hard links, some in the directory which we are modifying,
and some in other directories, that somehow any of them might not be
present after the crash.  And that's not the case.  Suppose the file
currently has hardlinks test1/foo, test1/quux, and test2/baz --- and
we've called syncfs(2) on the file system so everything is persisted,
and then linkat(2) is used to create a new hardlink, test1/bar.

After a crash, the existence of test1/foo, test1/quux, and test2/baz
are not in question.  It's only unclear whether or not test1/bar
exists after the crash.

As far as st_nlink is concerned, the presumption is that the file
system itself will be consistent after the crash.  So if the hard link
has been persisted, then st_nlink will be incremented, if it has not,
it won't be.

Finally, one thing which gets hard about trying to state these sorts
of things as guarantees.  Sometimes, the file system won't *know*
whether or not it can make these guarantees.  For example what should
we do if the file system is mounted with nobarrier?  If the overall
hardware design includes UPS's or some other kind of battery backup,
the guarantee may very well exist.  But the file system code can't
know whether or not that is the case.  So my inclination is to allow
the file system to accept the flag even if the mount option nobarrier
is in play --- but in that case, the guarantee is only if the rest of
the system is designed appropriately.

(For that matter, it used to be that there existed hard drives that
lied about whether they had a writeback cache, and/or made the CACHE
FLUSH a no-op so they could win the Winbench benchmarketing wars,
which was worth millions and millions of dollars in sales.  So we can
only assume that the hardware isn't lying to us when we use words like
"guarantee".)

						- Ted
