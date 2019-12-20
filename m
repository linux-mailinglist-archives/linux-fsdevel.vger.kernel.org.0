Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1065C127BDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 14:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTNlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 08:41:24 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41347 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLTNlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:41:24 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so7966183ils.8;
        Fri, 20 Dec 2019 05:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qh5cYXxFRGpFv8otu5KV+5LFZdLrjawHvU8eQ0w0XsM=;
        b=euA88fm7+cHYyiofPQMwySeksKkPzRpogHq+sbGc1tSKghKdKnEXYQoGcUtKpdz5hc
         JqL0m89lCv7Xb3/AMdZjR1u3H74BVZ0FwQyhgWBf/OiwMxO2Ki/hWBnuGp3cPECLzAFf
         kD+DzxaLeefKXfqhs9lOv4YLk/31Jq+Y2tmhhIhAEw81hZWFEyc18RUBoO7u0jwekKXr
         AjgfMkSRgKNNl8CCtbsScAO9GIVCqxY1a7tPKvjFchGNIqb7YalhwEj0BBuHXFKypVpV
         XfEpbg258cqjsuo295WOvTebha7d+XuMal5d0wU874cs0JizHc2Wg65nUzAu11NJIBWX
         bENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qh5cYXxFRGpFv8otu5KV+5LFZdLrjawHvU8eQ0w0XsM=;
        b=tmavAOXpjZDoZuEu+l0ZEi8zquxJ3tUC3c6LzBZAZbDszMFUPokOUayV6qbJnt8PqL
         Mqi7jYF+u8dts/vc6RWST0XrFdITqo0TTIIgyMKb5dqgvsHnPVAfQcfSPnIPM2474LTD
         M95v1Trbs9Gz5/CsNkW7thzR8wgo6dDIOhm9rsjVlYChS59WEHSxo53xWnk5UzFLSlXG
         gghN66NBOPRrAUtne1/H+jK9i5XazVdK+WsLNuvVeuTT3MAb5c3nq3oYUL7EAHSzUWm9
         M3/9shDWZRkkd7tenz2w45R1nK3JGXDc3NjgYovmMKX4raiA/VJNBJGlPfHX3FUfXncz
         RH9g==
X-Gm-Message-State: APjAAAWUqwDxXoZKNv5O0xQdq2fu3kF8aa/mlwy9QQ7YbWvvdTRbjt8C
        HggLKpzv0xKyL+zH09W+95SP+4KRVRAhBqxKDvA=
X-Google-Smtp-Source: APXvYqxUSjpz8VJ0iWntbdakDVY1jIgjfzY/ClEZs2zcQGpbuNlikURui/0eMQO6GKwOFUaz/zDypgPuX/3NhHXhR8E=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr13170403ilg.137.1576849283201;
 Fri, 20 Dec 2019 05:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20191220024936.GA380394@chrisdown.name> <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
In-Reply-To: <20191220121615.GB388018@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Dec 2019 15:41:11 +0200
Message-ID: <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 2:16 PM Chris Down <chris@chrisdown.name> wrote:
>
> Hi Amir,
>
> Thanks for getting back, I appreciate it.
>
> Amir Goldstein writes:
> >How about something like this:
> >
> >/* just to explain - use an existing macro */
> >shmem_ino_shift = ilog2(sizeof(void *));
> >inode->i_ino = (__u64)inode >> shmem_ino_shift;
> >
> >This should solve the reported problem with little complexity,
> >but it exposes internal kernel address to userspace.
>
> One problem I can see with that approach is that get_next_ino doesn't
> discriminate based on the context (for example, when it is called for a
> particular tmpfs mount) which means that eventually wraparound risk is still
> pushed to the limit on such machines for other users of get_next_ino (like
> named pipes, sockets, procfs, etc). Granted then the space for collisions
> between them is less likely due to their general magnitude of inodes at one
> time compared to some tmpfs workloads, but still.

If you ask me, trying to solve all the problems that may or may not exist
is not the best way to solve "your" problem. I am not saying you shouldn't
look around to see if you can improve something for more cases, but every
case is different, so not sure there is one solution that fits all.

If you came forward with a suggestion to improve get_next_ino() because
it solves a microbenchmark, I suspect that you wouldn't have gotten far.
Instead, you came forward with a report of a real life problem:
"In Facebook production we are seeing heavy inode number wraparounds
on tmpfs..." and Hugh confessed that Google are facing the same problem
and carry a private patch (per-sb ino counter).

There is no doubt that tmpfs is growing to bigger scales than it used to
be accustomed to in the past. I do doubt that other filesystems that use
get_next_ino() like pseudo filesystems really have a wraparound problem.
If there is such a real world problem, let someone come forward with the
report for the use case.

IMO, tmpfs should be taken out of the list of get_next_ino() (ab)users and
then the rest of the cases should be fine. When I say "tmpfs" I mean
every filesystem with similar use pattern as tmpfs, which is using inode
cache pool and has potential to recycle a very large number of inodes.

>
> >Can we do anything to mitigate this risk?
> >
> >For example, instead of trying to maintain a unique map of
> >ino_t to struct shmem_inode_info * in the system
> >it would be enough (and less expensive) to maintain a unique map of
> >shmem_ino_range_t to slab.
> >The ino_range id can then be mixes with the relative object index in
> >slab to compose i_ino.
> >
> >The big win here is not having to allocate an id every bunch of inodes
> >instead of every inode, but the fact that recycled (i.e. delete/create)
> >shmem_inode_info objects get the same i_ino without having to
> >allocate any id.
> >
> >This mimics a standard behavior of blockdev filesystem like ext4/xfs
> >where inode number is determined by logical offset on disk and is
> >quite often recycled on delete/create.
> >
> >I realize that the method I described with slab it crossing module layers
> >and would probably be NACKED.
>
> Yeah, that's more or less my concern with that approach as well, hence why I
> went for something that seemed less intrusive and keeps with the current inode
> allocation strategy :-)
>
> >Similar result could be achieved by shmem keeping a small stash of
> >recycled inode objects, which are not returned to slab right away and
> >retain their allocated i_ino. This at least should significantly reduce the
> >rate of burning get_next_ino allocation.
>
> While this issue happens to present itself currently on tmpfs, I'm worried that
> future users of get_next_ino based on historic precedent might end up hitting
> this as well. That's the main reason why I'm inclined to try and improve
> get_next_ino's strategy itself.
>

I am not going to stop you from trying to improve get_next_ino()
I just think there is a MUCH simpler solution to your problem (see below).

> >Anyway, to add another consideration to the mix, overlayfs uses
> >the high ino bits to multiplex several layers into a single ino domain
> >(mount option xino=on).
> >
> >tmpfs is a very commonly used filesystem as overlayfs upper layer,
> >so many users are going to benefit from keeping the higher most bits
> >of tmpfs ino inodes unused.
> >
> >For this reason, I dislike the current "grow forever" approach of
> >get_next_ino() and prefer that we use a smarter scheme when
> >switching over to 64bit values.
>
> By "a smarter scheme when switching over to 64bit values", you mean keeping
> i_ino as low magnitude as possible while still avoiding simultaneous reuse,
> right?

Yes.

>
> To that extent, if we can reliably and expediently recycle inode numbers, I'm
> not against sticking to the existing typing scheme in get_next_ino. It's just a
> matter of agreeing by what method and at what level of the stack that should
> take place :-)
>

Suggestion:
1. Extend the kmem_cache API to let the ctor() know if it is
initializing an object
    for the first time (new page) or recycling an object.
2. Let shmem_init_inode retain the value of i_ino of recycled shmem_inode_info
    objects
3. i_ino is initialized with get_next_ino() only in case it it zero

Alternatively to 1., if simpler to implement and acceptable by slab developers:
1.b. remove the assertion from cache_grow_begin()/new_slab_objects():
       WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
       and pass __GFP_ZERO in shmem_alloc_inode()

You see, when you look at the big picture, all the smarts of an id allocator
that you could possibly need is already there in the slab allocator for shmem
inode objects. You just need a way to access that "'id" information for recycled
objects without having to write any performance sensitive code.

> I'd appreciate your thoughts on approaches forward. One potential option is to
> reimplement get_next_ino using an IDA, as mentioned in my patch message. Other
> than the potential to upset microbenchmarks, do you have concerns with that as
> a patch?
>

Only that it will be subject to performance regression reports from hardware and
workloads that you do not have access to - It's going to be hard for
you to prove
that you did not hurt any workload, so it's not an easy way forward.

Thanks,
Amir.
