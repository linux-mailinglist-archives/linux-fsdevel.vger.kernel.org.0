Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A43FA7AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 23:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhH1Vr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 17:47:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1Vr4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:47:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630187224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=636wMEgWkaGHM7Xqjl4UaJQCprbJXsUtUL3hOaFl5LE=;
        b=xo+lADGv3ssFUE3kclN6Zr/5XBSCUKKdydttui2NNRFl14bo2HZlKDXtov53ZTr/ssqfrK
        QtvNEO0pDYaq8M2LkSXl4la7tP0IshE4PiciNRAvoSDDZ2FAANGgy8KkNn5vMNkyE7D0xm
        B6TZ66ai54A0KJRuMKOeE0wk4x8kmSITEW3bjR6Q/IBMlc1Sbuq219yCTUqzPfpPrBGaBJ
        Dg8HkLSwHQhSY+FewSR5EKydC2b/Z2520zuDss3kMlbboMIDHHCWYeWK/I51/0GpkXbVZF
        w5Y2mqj3j55IcWAwBxadOqHmGHYgi/RLlhn+qgZbVvOpxauQTBsL1ExBsymNmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630187224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=636wMEgWkaGHM7Xqjl4UaJQCprbJXsUtUL3hOaFl5LE=;
        b=NAaEzdO5CAmmmO+khxg5WLkGgrwVM1AlI3iQ+B3aafBmvWpOPZ/disdLyTZ9GKLcCKkcgp
        n2w1F3whCtuQ8HDA==
To:     "Luck, Tony" <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
In-Reply-To: <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
Date:   Sat, 28 Aug 2021 23:47:03 +0200
Message-ID: <87r1edgs2w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27 2021 at 16:22, Tony Luck wrote:
> On Fri, Aug 27, 2021 at 09:57:10PM +0000, Al Viro wrote:
>> On Fri, Aug 27, 2021 at 09:48:55PM +0000, Al Viro wrote:
>> 
>> > 	[btrfs]search_ioctl()
>> > Broken with memory poisoning, for either variant of semantics.  Same for
>> > arm64 sub-page permission differences, I think.
>> 
>> 
>> > So we have 3 callers where we want all-or-nothing semantics - two in
>> > arch/x86/kernel/fpu/signal.c and one in btrfs.  HWPOISON will be a problem
>> > for all 3, AFAICS...
>> > 
>> > IOW, it looks like we have two different things mixed here - one that wants
>> > to try and fault stuff in, with callers caring only about having _something_
>> > faulted in (most of the users) and one that wants to make sure we *can* do
>> > stores or loads on each byte in the affected area.
>> > 
>> > Just accessing a byte in each page really won't suffice for the second kind.
>> > Neither will g-u-p use, unless we teach it about HWPOISON and other fun
>> > beasts...  Looks like we want that thing to be a separate primitive; for
>> > btrfs I'd probably replace fault_in_pages_writeable() with clear_user()
>> > as a quick fix for now...
>> > 
>> > Comments?
>> 
>> Wait a sec...  Wasn't HWPOISON a per-page thing?  arm64 definitely does have
>> smaller-than-page areas with different permissions, so btrfs search_ioctl()
>> has a problem there, but arch/x86/kernel/fpu/signal.c doesn't have to deal
>> with that...
>> 
>> Sigh...  I really need more coffee...
>
> On Intel poison is tracked at the cache line granularity. Linux
> inflates that to per-page (because it can only take a whole page away).
> For faults triggered in ring3 this is pretty much the same thing because
> mm/memory_failure.c unmaps the page ... so while you see a #MC on first
> access, you get #PF when you retry. The x86 fault handler sees a magic
> signature in the page table and sends a SIGBUS.
>
> But it's all different if the #MC is triggerd from ring0. The machine
> check handler can't unmap the page. It just schedules task_work to do
> the unmap when next returning to the user.
>
> But if your kernel code loops and tries again without a return to user,
> then your get another #MC.

But that's not the case for restore_fpregs_from_user() when it hits #MC.

restore_fpregs_from_user()
  ...
  ret = __restore_fpregs_from_user(buf, xrestore, fx_only)
  
  /* Try to handle #PF, but anything else is fatal. */
  if (ret != -EFAULT)
     return -EINVAL;

Now let's look at __restore_fpregs_from_user()

__restore_fpregs_from_user()
   return $FPUVARIANT_rstor_from_user_sigframe()

which all end up in user_insn(). user_insn() returns 0 or the negated
trap number, which results in -EFAULT for #PF, but for #MC the negated
trap number is -18 i.e. != -EFAULT. IOW, there is no endless loop.

This used to be a problem before commit:

  aee8c67a4faa ("x86/fpu: Return proper error codes from user access functions")

and as the changelog says the initial reason for this was #GP going into
the fault path, but I'm pretty sure that I also discussed the #MC angle with
Borislav back then. Should have added some more comments there
obviously.

Thanks,

        tglx

