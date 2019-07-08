Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBA627DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfGHSBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:01:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60332 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfGHSBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:01:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkXxE-0003h2-Pn; Mon, 08 Jul 2019 18:01:32 +0000
Date:   Mon, 8 Jul 2019 19:01:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190708180132.GU17978@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l3wo3gq.fsf@xmission.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:12:21PM -0500, Eric W. Biederman wrote:

> Al you do realize that the TOCTOU you are talking about comes the system
> call API.  TOMOYO can only be faulted for not playing in their own
> sandbox and not reaching out and fixing the vfs implementation details.
>
> Userspace has always had to very careful to only mount filesystems
> on paths that root completely controls and won't change.

That has nothing whatsoever to do with the path where you are mounting
something.  _That_ is actually looked up before ->sb_mount() gets called;
no TOCTOU there.

The thing where ->sb_mount() is fucked by design is its handling of
	* device name
	* old tree in mount --bind
	* old tree in mount --move
	* things like journal name (not that any of the instances had tried
to do anything with that)

All of those *do* have TOCTOU, and that's an inevitable result of the
idiotic hook fetishism of LSM design.  Instead of "we want something
to happen when such-and-such predicate is about to change", it's
"lemme run my code, the earlier the better, I don't care about any
damn predicates, it's all too complicated anyway, whaddya mean
racy?"

Any time you have pathname resolution done twice, it's a built-in race.
If you want *ALL* checks on mount(2) to be done before the mean, nasty
kernel code gets to decide anything (bind/move/mount/etc. all squashed
together, just let us have at the syscall arguments, mmkay?) - that's
precisely what you get.

And no, that TOCTOU is not in syscall API.  "open() of an untrusted
pathname may end up trying to open hell knows what" is one thing;
"open() of an untrusted pathname may apply MAC checks to one object
and open something entirely different" is another.  The former is
inherent to syscall API.  The latter would be a badly fucked up
implementation (we don't have that issue on open(2), thankfully).

To make it clear, TOMOYO is not at fault here; LSM "architecture" is.
Note, BTW, that TOMOYO checks there do *NOT* limit the input pathname
at all - only the destination of the first pathwalk.  Repeating it
may easily lead to an entirely different place.

Canonicalized pathname is derived from pathwalk result; having concluded
that it's perfectly fine for the operation requested is pure security
theatre - it
	* says nothing about the trustedness of the original pathname
	* may have nothing whatsoever to the object yielded by the
second pathwalk, which is what'll end up actually used.
It's not even "this thing walks through /proc, and thus not to be trusted
to be stable" - the checks won't notice where the damn thing had been.

When somebody proposes _useful_ MAC for mount --move (and that really
can't be done at the level of syscall entry - we need to have already
figured out that with given combination of flags the 1st argument of
mount(2) will be a pathname *and* already looked it up), sure - it
will be added to do_move_mount(), which is where we have all lookups
done, and apply both for mount() and move_mount().

Right now anyone relying upon DAC enforced for MS_MOVE has worse problems
than "attacker will use move_mount(2) and bypass my policy" - the same
attacker can bloody well bypass those with nothing more exotic than
clone(2) and dup2(2) (and mount(2), of course).

And it's not just MS_MOVE (or MS_BIND).  Anyone trying to prevent
mounting e.g. ext2 from untrusted device and do that on the level of
->sb_mount() *is* *bloody* *well* *fucked*.  ->sb_mount() is simply
the wrong place for that.
