Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9C486D07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 23:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiAFWFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 17:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbiAFWFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:05:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCCC061245;
        Thu,  6 Jan 2022 14:05:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso4601895pjb.1;
        Thu, 06 Jan 2022 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g2O7xnrLPpqXXwOCapU3Xp7r0vQceHZ0G5UiRjpq8YU=;
        b=T5y8RqSbxZC8esbKQZXw4JqYsM/uqWOXxZ7+KJmj6LC1SPZCOyFwLoe7oEEQ7c6RYK
         nIJRb6O6w+g3z+0NSdHRkUiLoBlvNlN7J8gWt4t6KQNCtnKIzQfvYSnyx0jB0h4gP7eY
         tSMsnQD8PDUyExKJvp/uYW/0IW6DLVZPDYcpz/KVWAcNBzMaB4U+dd9TA5HYVLIC1+vP
         XkGC2IQnIAEg5MRd6fuhFGpWRjiT7066ciz0sX39wqVV7U6AEAD6bYwcuyTnoqRscyiI
         BfN/zDC30gUAqEDmfvtG0zh/V9axSPRv4CokOCyAfAV8a7+fQIAuD4UWdx/eUJet4bgD
         rCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g2O7xnrLPpqXXwOCapU3Xp7r0vQceHZ0G5UiRjpq8YU=;
        b=jteUuDfvdqTAn0Ml8auZ5kePIbN3FDb9+M1Nn2obTTjxpKRdbTBHy23gmQYN3ZvZYT
         z8KLQ+X2khVyyEH3UOxGqGmZCDkkAkbuZx0iHq6Da4cZyxgjoIVbqAHW5uh7tq4XnZDK
         awvJr338YE2HAIKrQ+pjrEVksbTi7QgDSIEo6yy7r4B5HjZTQMzqSEC5ckUqU4bc2t/c
         Q06WpxF/lVKZnb0k6P+iAFqcTW0BRYeX2INm8Ul/153Q8uph4cwakwoTzYc/ntqjmgxt
         3NAI/sRiWQu/Bzh/woGcV/WpK4lGZOCeW0iJr0kx44TV7owO07qmDrLrovXtjV6irbjx
         rGWA==
X-Gm-Message-State: AOAM5312ZotRBiXl+STvvFNWtjqDcqBq685y8H/MvJYA3eULAE4tanvX
        45v3XV97Re4od0182EUzwsA=
X-Google-Smtp-Source: ABdhPJzxXkAt0X3wMEjyDjnGygiMMan8y3eiebKhXSdK7HpNq+PQfq27Y1el0Y2io4yaCknV2yFQwg==
X-Received: by 2002:a17:90a:8983:: with SMTP id v3mr5723579pjn.11.1641506747772;
        Thu, 06 Jan 2022 14:05:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h7sm3598689pfc.152.2022.01.06.14.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:05:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 12:05:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
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
Message-ID: <YddnuSh15BAGdjAD@slm.duckdns.org>
References: <000000000000e8f8f505d0e479a5@google.com>
 <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain>
 <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Happy new year,

On Wed, Jan 05, 2022 at 11:13:30AM -0800, Linus Torvalds wrote:
> On Wed, Jan 5, 2022 at 11:07 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Whoever came up with that stupid "replace existing trigger with a
> > write()" model should feel bad. It's garbage, and it's actively buggy
> > in multiple ways.
> 
> What are the users? Can we make the rule for -EBUSY simply be that you
> can _install_ a trigger, but you can't replace an existing one (except
> with NULL, when you close it).

I don't have enough context here and Johannes seems offline today. Let's
wait for him to chime in.

> That would fix the poll() lifetime issue, and would make the
> psi_trigger_replace() races fairly easy to fix - just use
> 
>         if (cmpxchg(trigger_ptr, NULL, new) != NULL) {
>                 ... free 'new', return -EBUSY ..
> 
> to install the new one, instead of
> 
>         rcu_assign_pointer(*trigger_ptr, new);
> 
> or something like that. No locking necessary.
> 
> But I assume people actually end up re-writing triggers, because
> people are perverse and have taken advantage of this completely broken
> API.

IIRC, the rationale for the shared trigger at the time was around the
complexities of preventing it from devolving into O(N) trigger checks on
every pressure update. If the overriding behavior is something that can be
changed, I'd prefer going for per-opener triggers even if that involves
adding complexities (maybe a rbtree w/ prev/next links for faster sweeps?).

Thanks.

-- 
tejun
