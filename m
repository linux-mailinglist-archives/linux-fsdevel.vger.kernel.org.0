Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E94C224CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfERUTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 16:19:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59481 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727620AbfERUTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 16:19:05 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4IKIvcp010106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 May 2019 16:18:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF74E420027; Sat, 18 May 2019 16:18:43 -0400 (EDT)
Date:   Sat, 18 May 2019 16:18:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
Message-ID: <20190518201843.GD14277@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <00000000000014285d05765bf72a@google.com>
 <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk>
 <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
 <20190518162142.GH17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518162142.GH17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 05:21:42PM +0100, Al Viro wrote:
> IOW, Dan's fix folded into the offending commit.  And that kind of
> pattern is not rare; I would argue that appending Dan's patch at
> the end of queue and leaving the crap in between would be a fucking
> bad idea - it would've left a massive bisection hazard *and* made
> life much more unpleasant when the things got to merging into the
> mainline (or reviewing, for that matter).

When this happens in the ext4 git tree, I usually don't worry about
giving credit to whatever system finds the problem, whether coming
from it's Coverity, or someone running sparse, or syzbot, etc.

There will always be issues where there are no way to clear out the
syzbot report via a commit description --- for example, when a patch
gets dropped entirely from linux-next.  With Coverity, the report gets
dropped automatically.  With syzbot, it will have closed out by hand.

> What would you prefer to happen in such situations?  Commit summaries
> modified enough to confuse CI tools into *NOT* noticing that those
> are versions of the same patch?  Some kind of metadata telling the
> same tools that such-and-such commits got folded in (and they might
> have been split in process, with parts folded into different spots
> in the series, at that)?
> 
> Because "never fold in, never reorder, just accumulate patches in
> the end of the series" is not going to fly.  For a lot of reasons.

As far as I'm concerned, this is the tools problem; I don't think it's
worth it for developers to feel they need to twist themselves into
knots just to try to make the CI tools' life easier.

			     	     	- Ted
