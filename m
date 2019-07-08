Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B208A62A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404944AbfGHUVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 16:21:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33744 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHUVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:21:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hka8a-0006Uo-Ea; Mon, 08 Jul 2019 20:21:24 +0000
Date:   Mon, 8 Jul 2019 21:21:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
Message-ID: <20190708202124.GX17978@ZenIV.linux.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708180132.GU17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 07:01:32PM +0100, Al Viro wrote:
> On Mon, Jul 08, 2019 at 12:12:21PM -0500, Eric W. Biederman wrote:
> 
> > Al you do realize that the TOCTOU you are talking about comes the system
> > call API.  TOMOYO can only be faulted for not playing in their own
> > sandbox and not reaching out and fixing the vfs implementation details.

PS: the fact that mount(2) has been overloaded to hell and back (including
MS_MOVE, which goes back to v2.5.0.5) predates the introduction of ->sb_mount()
and LSM in general (2.5.27).  MS_BIND is 2.4.0-test9pre2.

In all the years since the introduction of ->sb_mount() I've seen zero
questions from LSM folks regarding a sane place for those checks.  What I have
seen was "we want it immediately upon the syscall entry, let the module
figure out what to do" in reply to several times I tried to tell them "folks,
it's called in a bad place; you want the checks applied to objects, not to
raw string arguments".

As it is, we have easily bypassable checks on mount(2) (by way of ->sb_mount();
there are other hooks also in the game for remounts and new mounts).

I see no point whatsoever trying to duplicate ->sb_mount() on the top level
of move_mount(2).  When and if sane checks are agreed upon for that thing,
they certainly should be used both for MS_MOVE case of mount(2) and for
move_mount(2).  And that'll come for free from calling those in do_move_mount().
They won't be the first thing called in mount(2) - we demultiplex first,
decide that we have a move and do pathname resolution on source.  And that's
precisely what we need to avoid the TOCTOU there.

I'm sorry, but this "run the hook at the very beginning, the modules know
better what they want, just give them as close to syscall arguments as
possible before even looking at the flags" model is wrong, plain and simple.

As for the MS_MOVE checks, the arguments are clear enough (two struct path *,
same as what we pass to do_move_mount()).  AFAICS, only tomoyo and
apparmor are trying to do anything for MS_MOVE in ->sb_mount(), and both
look like it should be easy enough to implement what said checks intend
to do (probably - assuming that aa_move_mount() doesn't depend upon
having its kern_path() inside the __begin_current_label_crit_section()/
__end_current_label_crit_section() pair; looks like it shouldn't be,
but that's for apparmor folks to decide).

That's really for LSM folks, though - I've given up on convincing
(or even getting a rationale out of) them on anything related to hook
semantics years ago.
