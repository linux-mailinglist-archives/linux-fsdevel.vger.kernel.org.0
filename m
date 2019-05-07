Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62F1584B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 06:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfEGEP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 00:15:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGEP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 00:15:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hNrWC-00067g-Ca; Tue, 07 May 2019 04:15:52 +0000
Date:   Tue, 7 May 2019 05:15:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Subject: Re: system panic while dentry reference count overflow
Message-ID: <20190507041552.GH23075@ZenIV.linux.org.uk>
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk>
 <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 06:50:27PM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 5:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Linus, lockref is your code, IIRC; which variant would you consider
> > more feasible?
> 
> I think we should strive for the same kind of count overflow handling
> that the pageref patches did: keep the count at 32 bits, but just add
> a new "try_dget()" thing that returns "no" when the count grows too
> large.
> 
> And then use the "try_dget()" model when possible, and particularly
> for the easy cases for user mode to trigger. You don't have to catch
> them all, and in most places it isn't worth even worrying about it
> because users can't force billions of those places to be active at
> once.

Umm...  Where would you put the cutoff for try_dget()?  1G?  Because
2G-<something relatively small> is risky - have it reached, then
get the rest of the way to 2G by normal dget() and you've got trouble.

The part that worries me is that we'd get new failure exits that will
be impossible to test without fuckloads of RAM in the testbox; certainly
more than I have ;-/

> I don't see the original email (I'm not on fsdevel, and google doesn't
> find it), so I don't see if there was some particular case that was
> pointed out as being an easy attack vector.

Attack is predicated upon having 2Tb RAM; basically, a forkbomb with
plenty of access(2) on different inexistent names in the same directory
from each process.  And yes, that can be mitigated by limiting the
number of negative dentries, but I'm pretty sure that it can be
done with positive ones.  E.g. take tmpfs, create a file there,
then link(2) a lot and you've got each child contribute to parent
directory's dentry refcount.  Or you can open the root directory
a lot (again, on tmpfs), then seek in it (each open and each cursor
will contribute).  That way you need 1G opened files, and /proc/sys/fs/file-nr
set that high is not impossible if you have enough RAM.  Will any
boxen be set up that way?  No idea...

Most of attack vectors going through ->d_parent contributions are
relatively easy to deal with - d_alloc() can fail already, and having
that kind of overflow mapped at -ENOMEM is not a big deal.  Ditto
for d_alloc_cursor().  Callers of __d_move() in d_splice_alias() are
not hard to deal with.  However, d_move() itself is nasty.  We call
it in situations where it's too late to fail.  We _might_ get away
with it if we do a variant that consumes a reference to new parent
and have that code go
	try to reserve an extra reference to new parent
	sod off if failed
	do the stuff that might fail
	if failed - drop that extra reference
	otherwise do the new variant of d_move()
That's an extra lock/unlock of parent's ->d_lock, but I'd expect
it to drown in the noise on those paths...

However, that obviously doesn't do anything for references
held by opened files.  Having complete_walk() check for
refcount being too high and buggering off in that case
probably would help that one...

Ugh...
