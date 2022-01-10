Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8453489A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiAJNqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 08:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiAJNp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:45:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8EC061751
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 05:45:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u25so53827843edf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jan 2022 05:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHeTRojrHT97CzcJwwp8ETZD3FH9KBheVLaCf3e+Bz0=;
        b=mam0LsLi8LoWTGNIdMOetg75e2XJQGJ0mNUoJa9FG0TO6dRWdqOWRNLdf+K1w2HCvn
         ekYd1httCsa1T8n7aCJEd2iRaN9JPVswWNi4V4+8QXBahGH9CmKwtF2fOYG5qCCzLeE+
         MG5PXOzkIGYFwWUVzNWAB2+Dl6nQHonD2kk2/xKDWsDE20PchZ8sFeNsreLfHgz8BtcZ
         oVS/WCHrk7F2C/U0h5gntBVEI6yQZUI/Uwj0PVyMu/QaOlmYwR1GJZff4he0ywtp6D32
         cJ1i3G7EOdxnqUy88mBICgzyC4FU6+rmZ1T3ihyWYr0gp2JMb52qWRbKIZujTXgqTuPK
         +ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHeTRojrHT97CzcJwwp8ETZD3FH9KBheVLaCf3e+Bz0=;
        b=uxpr4qcOjX6I1azjPMvxOi+Z5ex3UpGPL25ggi6txwqvvUC7ZsAFeNK4WJqUkI2wYE
         Ykt6+Y3ybnhyn2iPQupfLMATkT04HtMz4HNBJvqFzS7x2Jak+YjYR6vBj9qCBUojjb/Z
         5aRSK/qekqTGAkFh+RI18Y+I9pf7H57vpVwmBfj/4r5SNBH209nBK/irv8mHqfbNOnT9
         QXblqpCkN+eq55ED1yrZB0EADJIhYktNKck6bO50FHJIJNsriW06L/Q2bUv1f1WWcrBB
         p4Ok6YzEomE8P0LIOK5a5a2E4CEipMcqXfWF8zUMIXzrf/DsqHXO+z2rPft5BCt1rzWT
         5z/g==
X-Gm-Message-State: AOAM530YvDgHVaCg7E+xcTwpP+2sKrE/zSumkZBZFYRUKFCqUhBI6LAn
        FSF14utfHpR+OmLBJ4YH3BfjYg==
X-Google-Smtp-Source: ABdhPJxeRE0a4BzWgsaDYzwOeQO6iPCeZjoODWDm48/LJAdqsxT5P++dvckwm+iL3KZk5c4Bb65k1Q==
X-Received: by 2002:a17:907:960d:: with SMTP id gb13mr3041620ejc.572.1641822350222;
        Mon, 10 Jan 2022 05:45:50 -0800 (PST)
Received: from localhost ([57.190.1.3])
        by smtp.gmail.com with ESMTPSA id l18sm2464463ejf.7.2022.01.10.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 05:45:49 -0800 (PST)
Date:   Mon, 10 Jan 2022 14:45:41 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: psi_trigger_poll() is completely broken
Message-ID: <Ydw4hWCRjAhGfCAv@cmpxchg.org>
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

Apologies for the delay, I'm traveling right now.

The primary user of the poll interface is still Android userspace OOM
killing. I'm CCing Suren who is the most familiar with this usecase.

Suren, the way the refcounting is written right now assumes that
poll_wait() is the actual blocking wait. That's not true, it just
queues the waiter and saves &t->event_wait, and the *caller* of
psi_trigger_poll() continues to interact with it afterwards.

If at all possible, I would also prefer the simplicity of one trigger
setup per fd; if you need a new trigger, close the fd and open again.

Can you please take a look if that is workable from the Android side?

(I'm going to follow up on the static branch issue Linus pointed out,
later this week when I'm back home. I also think we should add Suren
as additional psi maintainer since the polling code is a good chunk of
the codebase and he shouldn't miss threads like these.)

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
> 
>                Linus
