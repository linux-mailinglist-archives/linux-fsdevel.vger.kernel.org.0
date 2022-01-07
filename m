Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B2E486E61
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 01:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiAGAOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiAGAOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8858C061201;
        Thu,  6 Jan 2022 16:14:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9408361E58;
        Fri,  7 Jan 2022 00:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95676C36AE0;
        Fri,  7 Jan 2022 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641514441;
        bh=3FrIFZaXJ02RwBEVOOXJcx4x1yw60ylJkU2mZqQjAMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNTeTWT/rpj0nfHUCszPJ4rTQzWujIzb6kDqSzNbIAMrPaSuJQ5TCWYUlXg7J58t3
         rUhZpTY2Dt8G93NuLuL74WJ1QABK1FSthhFBfPKFHGdT9Mkm0U1QhbwBIdWLlQq23o
         aTWLXrwJJgmi9G6oqhxp4/fk750HCaa9fI+8zx6GGyAPbw7MeI31PBlzI2YUJMyzTw
         TqP/FDqyxNP3FgB+z89NywaUrQnMh5agO5V/FLUozA+Yc2jsuL/FnYtBt02d2ECpwt
         ekcd6/JtC5rC5ngXACrcqoZrBxJkR0I9jXkYbVlQWSeMIkCu9HiNrKATagE2yjkgu8
         6r6/KQgCj4/Qg==
Date:   Thu, 6 Jan 2022 16:13:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: psi_trigger_poll() is completely broken
Message-ID: <YdeFx9i/LaAC346s@sol.localdomain>
References: <000000000000e8f8f505d0e479a5@google.com>
 <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain>
 <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
 <YddnuSh15BAGdjAD@slm.duckdns.org>
 <CAHk-=whhcoeTOZB_de-Nh28Fy4iNTu2DXzKXEPOubzL36+ME=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhcoeTOZB_de-Nh28Fy4iNTu2DXzKXEPOubzL36+ME=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 06, 2022 at 02:59:36PM -0800, Linus Torvalds wrote:
> 
> So here's a COMPLETELY UNTESTED patch to try to fix the lifetime and locking.
> 
> The locking was completely broken, in that psi_trigger_replace()
> expected that the caller would hold some exclusive lock so that it
> would release the correct previous trigger. The cgroup code doesn't
> seem to have any such exclusion.
> 
> This (UNTESTED!) patch fixes that breakage by just using a cmpxchg loop.
> 
> And the lifetime was completely broken (and that's Eric's email)
> because psi_trigger_replace() would drop the refcount to the old
> trigger - assuming it got the right one - even though the old trigger
> could still have active waiters on the waitqueue due to poll() or
> select().
> 
> This (UNTESTED!) patch fixes _that_ breakage by making
> psi_trigger_replace() instead just put the previous trigger on the
> "stale_trigger" linked list, and never release it at all.
> 
> It now gets released by "psi_trigger_release()" instead, which walks
> the list at file release time. Doing "psi_trigger_replace(.., NULL)"
> is not valid any more.
> 
> And because the reference cannot go away, we now can throw away all
> the incorrect temporary kref_get/put games from psi_trigger_poll(),
> which didn't actually fix the race at all, only limited it to the poll
> waitqueue.
> 
> That also means we can remove the "synchronize_rcu()" from
> psi_trigger_destroy(), since that was trying to hide all the problems
> with the "take rcu lock and then do kref_get()" thing not having
> locking. The locking still doesn't exist, but since we don't release
> the old one when replacing it, the issue is moot.
> 
> NOTE NOTE NOTE! Not only is this patch entirely untested, there are
> optimizations you could do if there was some sane synchronization
> between psi_trigger_poll() and psi_trigger_replace(). I put comments
> about it in the code, but right now the code just assumes that
> replacing a trigger is fairly rare (and since it requires write
> permissions, it's not something random users can do).
> 
> I'm not proud of this patch, but I think it might fix the fundamental
> bugs in the code for now.
> 
> It's not lovely, it has room for improvement, and I wish we didn't
> need this kind of thing, but it looks superficially sane as a fix to
> me.
> 
> Comments?
> 
> And once again: this is UNTESTED. I've compiled-tested it, it looks
> kind of sane to me, but honestly, I don't know the code very well.
> 
> Also, I'm not super-happy with how that 'psi_disabled' static branch
> works.  If somebody switches it off after it has been on, that will
> also disable the freeing code, so now you'll be leaking memory.
> 
> I couldn't find it in myself to care.

I had to make the following changes to Linus's patch:

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 10430f75f21a..7d5afa89db44 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1255,7 +1255,7 @@ void psi_trigger_replace(void **trigger_ptr, struct psi_trigger *new)
 		struct psi_trigger *old = *trigger_ptr;
 
 		new->stale_trigger = old;
-		if (try_cmpxchg(trigger_ptr, old, new))
+		if (try_cmpxchg(trigger_ptr, &old, new))
 			break;
 	}
 
@@ -1270,7 +1270,7 @@ void psi_trigger_replace(void **trigger_ptr, struct psi_trigger *new)
 /* No locking needed for final release */
 void psi_trigger_release(void **trigger_ptr)
 {
-	struct psi_trigger *trigger;
+	struct psi_trigger *trigger = *trigger_ptr;
 
 	if (static_branch_likely(&psi_disabled))
 		return;


After that, the two reproducers I gave in
https://lore.kernel.org/r/YbQUSlq76Iv5L4cC@sol.localdomain (the ones at the end
of my mail, not the syzbot-generated ones which I didn't try) no longer crash
the kernel.

This is one way to fix the use-after-free, but the fact that it allows anyone
who can write to a /proc/pressure/* file to cause the kernel to allocate an
unbounded number of 'struct psi_trigger' structs is still really broken.

I think we really need an answer to Linus' question:

> What are the users? Can we make the rule for -EBUSY simply be that you
> can _install_ a trigger, but you can't replace an existing one (except
> with NULL, when you close it).

... since that would be a much better fix.  The example in
Documentation/accounting/psi.rst only does a single write; that case wouldn't be
broken if we made multiple writes not work.

- Eric
