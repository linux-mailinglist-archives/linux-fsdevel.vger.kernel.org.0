Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA593FFA5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhICG2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 02:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48570 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhICG2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:28:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630650419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oj03gZFgBKlneXTLuFlpjosq+qsCnLlz6Tsf57RrU6U=;
        b=UxCO301dAkvC1O6CEFSs9BDF/EHWaGq74xuu22aOSKeDxyiG15pXQ8UdzD+GMCWD7qI2fy
        1okhBIFuVJXPh18K9KmQXoAZmndIa7mAif+MJIC0m77cZqFlZPWn0jCziqOparFdWWg8Ln
        OTKZ0Nv0FbxBGulDLACNIMI0f4i6IYRnxCcFGnsSLdcYXxlfncPuartw/17m5N75tPNhQ3
        vWxLcBKMUq8fVXX9LT31xa70mOlZz9Wf50c3274w7i87yNQG9bCqGZCFPeEn6k8HsBsNj5
        9y7uRrO8AIlOopb20+7C6qICj3fvhfZWyMpqG4VZYpTx4vzk3bAzpG67V9Z+ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630650419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oj03gZFgBKlneXTLuFlpjosq+qsCnLlz6Tsf57RrU6U=;
        b=w5/p55F8WBEP8YihYst5Fz3ycPHwF6J50NOGKBuCgwVsb5tcD0J8VxMchQOyY3ysNKvBlx
        dcqIrcLg4xwxFrCg==
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
In-Reply-To: <20210902223545.GA1826899@dread.disaster.area>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
 <20210902223545.GA1826899@dread.disaster.area>
Date:   Fri, 03 Sep 2021 08:26:58 +0200
Message-ID: <87a6kub2dp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

On Fri, Sep 03 2021 at 08:35, Dave Chinner wrote:
> On Thu, Sep 02, 2021 at 10:43:11AM -0700, Darrick J. Wong wrote:
> The part I dislike most about it is that we have to modify a header
> file that triggers full kernel rebuilds. Managing patch stacks and
> branches where one of them modifies such a header file means quick,
> XFS subsystem only kernel rebuilds are a rare thing...

If you don't care about ordering, you can avoid touching the global
header completely. The dynamic state ranges in PREPARE and ONLINE
provide exactly what you want. It's documented.

> That said, I'm all for a better interface to the CPU hotplug
> notifications. THe current interface is ... esoteric and to

What's so esoteric about:

       state = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "xfs:prepare", func1, func2);
       state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "xfs:online", func3, func4);

Only if you care about callback ordering vs. other subsystems, then adding
the state in the global header is required. It's neither the end of the
world, nor is it rocket science and requires expert knowledge to do so.

> understand how to use it effectively requires becoming a CPU hotplug
> expert.

  https://www.kernel.org/doc/html/latest/core-api/cpu_hotplug.html

If there is something missing in that documentation which makes you
think you need to become a CPU hotplug expert, please let me know. I'm
happy to expand that document.

> There's something to be said for the simplicity of the old
> register_cpu_notifier() interface we used to have...

There is a lot to be said about it. The simplicity of it made people do
the most hillarious things to deal with:

  - Ordering issues including build order dependencies
  - Asymetry between bringup and teardown
  - The inability to test state transitions
  - ....

Back then when we converted the notifier mess 35 of ~140 hotplug
notifiers (i.e. ~25%) contained bugs of all sorts. Quite some of them
were caused by the well understood simplicity of the hotplug notifier
mechanics. I'm surely not missing any of that.

Thanks,

        tglx
