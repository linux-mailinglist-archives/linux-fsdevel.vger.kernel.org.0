Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748C33FF3EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347245AbhIBTOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 15:14:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhIBTOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:14:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630610004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mol3Nulm2MslnoL3rZw7KR5Sk7yIbBs38Z0NkhRj0cM=;
        b=4xvAkIUloKpCD068KtfLLIaDhtuQGjgaNE5WXiqh0lLsrVRyJz3Kne6keyd6H8TriVKHDh
        B0D3FMuUNO+9zbJlassAGu05fmLkm74uqoXObuDeVoYglvbokl3zIThoBWSkWF1qVTCfKJ
        F6g2JjpOw0tRmzYZUenkdeObYUeryIaUZI6FYUM8PSujGEgfSEQWJ4O/HKp5HJByYg13Re
        RzmO0rhjViVmMPRKZ1CEsOts8PLVTf1+kfNjA4OvaLrXJy9qTKnDNCGEvm8yV2iZ9lZg1V
        xw7BOS00jyPkfQ1U8X1f1hcpzIsmnPWhFbkB5ErBM15s/8CDHadX9tlxeIzBAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630610004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mol3Nulm2MslnoL3rZw7KR5Sk7yIbBs38Z0NkhRj0cM=;
        b=cQ/vMiC1Ytsbn2pZye0Y1kAUgcWIijtybi6IoNS+yHv1VW1sOJi3j/RA/tYvU3zZ+61k4T
        PZh+9qZmZK8NgnDA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
In-Reply-To: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Date:   Thu, 02 Sep 2021 21:13:24 +0200
Message-ID: <87wnnybxkb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02 2021 at 08:47, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> As for new features: we now batch inode inactivations in percpu
>> background threads, which sharply decreases frontend thread wait time
>> when performing file deletions and should improve overall directory tree
>> deletion times.
>
> So no complaints on this one, but I do have a reaction: we have a lot
> of these random CPU hotplug events, and XFS now added another one.
>
> I don't see that as a problem, but just the _randomness_ of these
> callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
> exactly a thing of beauty, and just makes me think there's something
> nasty going on.

It's not beautiful, but it's at least well defined in terms of ordering.

Though if the entity which needs the callback does not care about
ordering against other callbacks and just cares about the CPU state, in
this case DEAD, then the explicit entry can be avoided and a dynamic
entry can be requested:

     state = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "xfs:foo", NULL, xfs_dead);

We have also a dynamic range for the online part (CPUHP_AP_ONLINE_DYN)
which runs on the incoming or outgoing CPU. That spares the explicit
entries in the enum.

I assume most of the prepare/dead states have no ordering requirement at
all, so those could be converted to the dynamic range. But for the
online one which run on the plugged CPU we have quite some ordering
constraints and that's where the explicit states matter.

That surely could be consolidated a bit if we pack the mutually
exclusive ones (timers, interrupt controllers, perf), but the question
is whether such packing (ifdeffery or arch/platform specific includes)
would make it more beautiful. The only thing we'd spare would be some
bytes in the actual state table in the core code. Whether that's worth
it, I don't know.

> For the new xfs usage, I really get the feeling that it's not that XFS
> actually cares about the CPU states, but that this is literally tied
> to just having percpu state allocated and active, and that maybe it
> would be sensible to have something more specific to that kind of use.
>
> We have other things that are very similar in nature - like the page
> allocator percpu caches etc, which for very similar reasons want cpu
> dead/online notification.
>
> I'm only throwing this out as a reaction to this - I'm not sure
> another interface would be good or worthwhile, but that "enum
> cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
> hotplug, and the percpu memory allocation people for comments.

It's not only about memory. 

> IOW, just _maybe_ we would want to have some kind of callback model
> for "percpu_alloc()" and it being explicitly about allocations
> becoming available or going away, rather than about CPU state.

The per cpu storage in XFS does not go away. It contains a llist head
and the queued work items need to be moved from the dead CPU to an alive
CPU and exposed to a work queue for processing. Similar to what we do
with timers, hrtimers and other stuff.

If there are callbacks which are doing pretty much the same thing, then
I'm all for a generic infrastructure for these.

Thanks,

        tglx


