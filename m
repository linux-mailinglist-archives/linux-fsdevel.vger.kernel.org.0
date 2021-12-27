Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF047FA1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 05:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhL0EjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 23:39:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53023 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232532AbhL0EjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 23:39:22 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR4d5kI029959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Dec 2021 23:39:06 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 64FC215C33A3; Sun, 26 Dec 2021 23:39:05 -0500 (EST)
Date:   Sun, 26 Dec 2021 23:39:05 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: super: possible ABBA deadlocks in
 do_thaw_all_callback() and freeze_bdev()
Message-ID: <YclDafAwrN0TkhCi@mit.edu>
References: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
 <YckgOocIWOrOoRvf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YckgOocIWOrOoRvf@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 27, 2021 at 02:08:58AM +0000, Matthew Wilcox wrote:
> On Mon, Dec 27, 2021 at 10:03:35AM +0800, Jia-Ju Bai wrote:
> > My static analysis tool reports several possible ABBA deadlocks in Linux
> > 5.10:
> > 
> > do_thaw_all_callback()
> >   down_write(&sb->s_umount); --> Line 1028 (Lock A)
> >   emergency_thaw_bdev()
> >     thaw_bdev()
> >       mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 602 (Lock B)
> > 
> > freeze_bdev()
> >   mutex_lock(&bdev->bd_fsfreeze_mutex); --> Line 556 (Lock B)
> >   freeze_super()
> >     down_write(&sb->s_umount); --> Line 1716 (Lock A)
> >     down_write(&sb->s_umount); --> Line 1738 (Lock A)
> >   deactivate_super()
> >     down_write(&s->s_umount); --> Line 365 (Lock A)
> > 
> > When do_thaw_all_callback() and freeze_bdev() are concurrently executed, the
> > deadlocks can occur.
> > 
> > I am not quite sure whether these possible deadlocks are real and how to fix
> > them if them are real.
> > Any feedback would be appreciated, thanks :)
> 
> As a rule, ABBA deadlocks that can actually occur are already found by
> lockdep.    Tools that think they've found something are generally wrong.
> I'm not inclined to look in detail to find out why this tool is wrong
> because lockdep is so effective.

Well, to be fair, lockdep will only find problems if both code paths
are actually executed during a boot session where lockdep is active.

In this particular case, "do_thaw_all_callback()" is called only from
emergency_thaw_all(), which is executed via a magic-sysrq.  (Sysrq-j).
In practice, this sysrq is almost never used except to work around
userspace bugs where a particular block device is frozen via the
FIFREEZE ioctl, and never thawed via the FITHAW ioctl.

So unless we had, say, an xfstest which tried to simulate triggering
sysrq-j (e.g., via "echo j > /proc/sysrq-trigger"), lockdep would
never find it.  Of course, how likely is it that a user would try to
trigger sysrq-j, because the user was trying to debug a buggy program
that froze a block device and then, say, crashed before it had a
chance to thaw it?  It's probably pretty darned unlikely.

So as to whether or not it's real, I'm sure we could probably trigger
the deadlock using an artificial workload if you had one process
constantly calling FIFREEZE and FITHAW on a block device, and other
process constantly triggering "echo j > /proc/sysrq-trigger".  So it
*technically* could happen.  Is it *likely* to happen under any kind
of normal workload?  Not hardly....

This makes it fall in the category of, "patch to fix something that
never happens in real life, and would require root privs to trigger,
and root can screw over the system in enough other ways anyway so it's
kind of pointless", versus "let's try to shut up the static checker so
we can find real bugs".

And there I'd agree with Willy; I run xfstests with lockdep enabled,
and given that the code coverage of xfstests is pretty good, I'm
confident that any ABBA deadlocks that are *likely* to happen in real
life tend to be found quickly, and fixed.

If someone wanted to rewrite the emergency_thaw codepath to fix the
locking order, in my opinion it's *technically* a bug fix.  But it's
the sort of thing which gets categorized as a P2 bug, and after a
year, gets dropped down to P3, and a year after that, dropped down to
P4 and ignored, since for most engineering organizations, resources
are finite, and while this is a real bug, for most companies it's not
worth fixing.

Cheers,

					- Ted

