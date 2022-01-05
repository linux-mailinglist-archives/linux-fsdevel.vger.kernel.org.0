Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5F4858E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbiAETHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 14:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiAETHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:07:33 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7AC061245
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 11:07:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so309786edd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyMNvvq0PEPzslt4MSGCkpasRaRMjefk5SUq0r41MJo=;
        b=HCszAIvsRbzHlCtHIRPeDuKPDcR1lrL6BkCRu+HjowLsRZyE6WlMB5UCoxalh9VvvT
         kNldojtQrvE7JFw+ZnKXRQn72R/lUyGgBVxRVVw5o7OJlhyAP9cJ50FBeLDiJcWfJb0N
         YXqwklj0PcrrhPDeOOqJIDM2iPvpqRymF2iBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyMNvvq0PEPzslt4MSGCkpasRaRMjefk5SUq0r41MJo=;
        b=MwaSCzaGjLCyZq1nrZGz+0kuNi1e9cUGALQynTkcikUC4gXJYEywdVEBheThWwJbl4
         Qp264LVwnU6Rxr0pTdY+B24gZ0iwXvwIZNlzPr3tCfqBo/Qs/sQUqX25KhHwOLaG4294
         JWOEI7AXPpZ5g2c+1Au1RAuTrLzBwXC8eP7RSnSaVD+jpm1PI02EZPvFpraSyg0xPLOo
         7lfxrWjO4B7Eo175vWnB9Ilax32BnHqNBfIu67zr3MIZFXkuFtWMiCpK37I9kenhLmmE
         XWkZjqWrfkfzI55XdMGQLJ01etH0r3QE+igrQssQuouLzWtkH+bEWD0djFBVRqOqNw4S
         OPLw==
X-Gm-Message-State: AOAM5310CzjW8maKjHQ4Ethc4aOcGM8f7IxcZ9q8y2+kahGADcIV3sjJ
        sEeGCxDI3WiCJMsIjQxX+uqB4rfwkZbfVa9vkoA=
X-Google-Smtp-Source: ABdhPJxEv5MW6Hmr0OVRp0Zjx/DPWJ75ndu7rzn+SWp6Js8mKvdcIqikb6btsulIeTx2uUxSvN+HOA==
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr45284473ejc.575.1641409651554;
        Wed, 05 Jan 2022 11:07:31 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id qt5sm12350029ejb.214.2022.01.05.11.07.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:07:30 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id l10so184439wrh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 11:07:29 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr47391843wrx.193.1641409649356;
 Wed, 05 Jan 2022 11:07:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain> <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
In-Reply-To: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 11:07:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
Message-ID: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 10:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That would require that 'psi_trigger_replace()' serialize with the
> waitqueue lock (easy)

I take the "easy" back. The other side of that serialization would
require that the poll() side also re-lookup the trigger pointer under
that same lock.

And you can't do that with the waitqueue lock, because 'poll_wait()'
does the add_wait_queue() internally, and that will take the waitqueue
lock. So you can't take and hold the waitqueue lock in the caller in
poll, it would just deadlock.

And not holding the lock over the call would mean that you'd have a
small race between adding a new poll waiter, and checking that the
trigger is still the same one.

We could use another lock - the code in kernel/sched/psi.c already does

        mutex_lock(&seq->lock);
        psi_trigger_replace(&seq->private, new);
        mutex_unlock(&seq->lock);

and could use that same lock around the poll sequence too.

But the cgroup_pressure_write() code doesn't even do that, and
concurrent writes aren't serialized at all (much less concurrent
poll() calls).

Side note: it looks like concurrent writes in the
cgroup_pressure_write() is literally broken. Because
psi_trigger_replace() is *not* handling concurrency, and does that

        struct psi_trigger *old = *trigger_ptr;
        ....
        if (old)
                kref_put(&old->refcount, psi_trigger_destroy);

assuming that the caller holds some lock that makes '*trigger_ptr' a
stable thing.

Again, kernel/sched/psi.c itself does that already, but the cgroup
code doesn't seem to.

So the bugs in this area go deeper than "just" poll(). The whole
psi_trigger_replace() thing is literally broken even ignoring the
poll() interactions.

Whoever came up with that stupid "replace existing trigger with a
write()" model should feel bad. It's garbage, and it's actively buggy
in multiple ways.

                  Linus
