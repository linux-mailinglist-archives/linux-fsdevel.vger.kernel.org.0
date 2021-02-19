Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97C31FCE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSQNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 11:13:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36286 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229691AbhBSQNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:13:13 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11JGCIH7009032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 11:12:18 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DE64715C39E2; Fri, 19 Feb 2021 11:12:17 -0500 (EST)
Date:   Fri, 19 Feb 2021 11:12:17 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <YC/jYW/K9krbfnfl@mit.edu>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 08:37:30AM +0800, Qu Wenruo wrote:
> So it means the 32bit archs are already 2nd tier targets for at least
> upstream linux kernel?

At least as far as btrfs is concerned, anyway....

> Or would it be possible to make it an option to make the index u64?
> So guys who really wants large file support can enable it while most
> other 32bit guys can just keep the existing behavior?

I think if this is going to be done at all, it would need to be a
compile-time CONFIG option to make the index be 64-bits.  That's
because there are a huge number of low-end Android devices (retail
price ~$30 USD in India, for example --- this set of customers is
sometimes called "the next billion users" by some folks) that are
using 32-bit ARM systems.  And they will be using ext4 or f2fs, and it
would be massively unfortunate/unfair/etc. to impose that performance
penalty on them.

It sounds like what Willy is saying is that supporting a 64-bit page
index on 32-bit platforms is going to be have a lot of downsides, and
not just the performance / memory overhead issue.  It's also a code
mainteinance concern, and that tax would land on the mm developers.
And if it's not well-maintained, without regular testing, it's likely
to be heavily subject to bitrot.  (Although I suppose if we don't mind
doubling the number of configs that kernelci has to test, this could
be mitigated.)

In contrast, changing btrfs to not depend on a single address space
for all of its metadata might be a lot of work, but it's something
which lands on the btrfs developers, as opposed to a another (perhaps
more central) kernel subsystem.  Managing at this tradeoff is
something that is going to be between the mm developers and the btrfs
developers, but as someone who doesn't do any work on either of these
subsystems, it seems like a pretty obvious choice.

The final observation I'll make is that if we know which NAS box
vendor can (properly) support volumes > 16 TB, we can probably find
the 64-bit page index patch.  It'll probably be against a fairly old
kernel, so it might not all _that_ helpful, but it might give folks a
bit of a head start.

I can tell you that the NAS box vendor that it _isn't_ is Synology.
Synology boxes uses btrfs, and on 32-bit processors, they have a 16TB
volume size limit, and this is enforced by the Synology NAS
software[1].  However, Synology NAS boxes can support multiple
volumes; until today, I never understood why, since it seemed to be
unnecessary complexity, but I suspect the real answer was this was how
Synology handled storage array sizes > 16TB on their older systems.
(All of their new NAS boxes use 64-bit processors.)

[1] https://www.reddit.com/r/synology/comments/a62xrx/max_volume_size_of_16tb/

Cheers,

					- Ted
