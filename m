Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE072D9E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438284AbgLNRow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 12:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408708AbgLNRol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:44:41 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA957C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 09:44:00 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id y5so17694048iow.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ChLmMvE3eUsFX8hb3JIqoU+gVF4XXgcb5esNC81m7+0=;
        b=astbjUG0fsAbhf5mdaZhuOyLl/xqK6lPaqC0TPcrB2o5h5A3cegbLzo/kY7mvBwDqi
         vLbdHuh2gJhRvcnR6BbnDyTxYnZtTahZYRsK7PlvKyQMita2E5S+ET/PV0s3JpFyi2H+
         BZvOCBKnIbJLeUFTlfQamMbL0wNsJlNb4dqyYLbqAiNvs7H1lDx1RCYT5tdfr1dQZpjY
         0d6p0qeob02FhA52T3FeTkbnHHP3ZwPP26NrHNawYv71L47pNaNOgAez+aRcpaKosLIM
         IPfTMgcL16+8dwkHVbg8KZ8Y+r+Z3U1uDnZSmDsVQAZUnVnjm5Zv4lcmpbXBXmSAzxU4
         aa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ChLmMvE3eUsFX8hb3JIqoU+gVF4XXgcb5esNC81m7+0=;
        b=YLRbpenAfy1jrz5vxp/odjI0z3q/CQiPYpAjPmgrp8qzVkh+VmsvlwR9AmgzhUCllv
         cqtW3p3HhiFllLw7kMy+8lM1MSGTot5GIT2imrBb49jf2zdsRRlGQnQnBO+D76NAzj5U
         8bNkln1gZVSZiJXOj/q0BLWlvFDNBy/+QJfe48oEHJ4UXmNnfdFe8B/xBvKv3FYrsBic
         ByVm8ZPrcjuLDBSfJMafl/mJjwT1CyCrjIrFCtJQ0wWkcqxC8oKualKMEOXFfi/00k95
         6ov7Tp8+Fff3RliXXJDW3uvOR0ltiw7ZjhgXRuk1XzhYEqqKbTycwBIG5aRUt7jY0v2e
         /gSQ==
X-Gm-Message-State: AOAM530SlWg6DK/0t5Ew1HLOi1j8v7jqXjP66zGRQHnJKfDlR58YlbUx
        qg14sXrylJuL16RWXI066UNLtBGKVxK52g==
X-Google-Smtp-Source: ABdhPJzA56T2VYNGcHT+P9deCxNDvibgo0QTC1yF+cT6lC7EfBDJuQTUFSDiBH71uhQpdstM9KUhmw==
X-Received: by 2002:a05:6602:1492:: with SMTP id a18mr33629498iow.124.1607967840025;
        Mon, 14 Dec 2020 09:44:00 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a18sm294672ilt.52.2020.12.14.09.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:43:59 -0800 (PST)
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
 <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
 <20201213225022.GF3913616@dread.disaster.area>
 <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25350c3b-4954-3733-ce09-b92dc4c57721@kernel.dk>
Date:   Mon, 14 Dec 2020 10:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 5:45 PM, Linus Torvalds wrote:
> On Sun, Dec 13, 2020 at 2:50 PM Dave Chinner <david@fromorbit.com> wrote:
>>>>
>>>> Only O_CREAT | O_TRUNC should matter, since those are the ones that
>>>> cause writes as part of the *open*.
>>
>> And __O_TMPFILE, which is the same as O_CREAT.
> 
> This made me go look at the code, but we seem to be ok here -
> __O_TMPFILE should never get to the do_open() logic at all, because it
> gets caught before that and does off to do_tmpfile() and then
> vfs_tmpfile() instead.
> 
> And then it's up to the filesystem to do the inode locking if it needs
> to - it has a separate i_io->tempfile function for that.
> 
> From a LOOKUP_NONBLOCK standpoint, I think we should just disallow
> O_TMPFILE the same way Jens disallowed O_TRUNCATE.
> 
> Otherwise we'd have to teach filesystems about it.

Good point, let's avoid that for now... More below.

> Which might be an option long-term of course, but I don't think it
> makes sense for any initial patch-set: the real "we can do this with
> no locks and quickly" case is just opening an existing file entirely
> using the dcache.
> 
> Creating new files isn't exactly _uncommon_, of course, but it's
> probably still two orders of magnitude less common than just opening
> an existing file. Wild handwaving.

Obviously depends on the workload, but there are plenty of interesting
workloads that are not create intensive at all and just want a fast way
to open an existing file.

> So I suspect O_CREAT simply isn't really interesting either. Sure, the
> "it already exists" case could potentially be done without any locking
> or anything like that, but again, I don't think that case is worth
> optimizing for: O_CREAT probably just isn't common enough.
> 
> [ I don't have tons of hard data to back that handwaving argument
> based on my gut feel up, but I did do a trace of a kernel build just
> because that's my "default load" and out of 250 thousand openat()
> calls, only 560 had O_CREAT and/or O_TRUNC. But while that's _my_
> default load, it's obviously not necessarily very representative of
> anything else. The "almost three orders of magnitude more regular
> opens" doesn't _surprise_ me though ]
> 
> So I really think the right model is not to worry about trylock for
> the inode lock at all, but to simply just always fail with EAGAIN in
> that case - and not do LOOKUP_NONBLOCK for O_CREAT at all.
> 
> The normal fast-path case in open_last_lookups() is the "goto
> finish_lookup" case in this sequence:
> 
>         if (!(open_flag & O_CREAT)) {
>                 if (nd->last.name[nd->last.len])
>                         nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>                 /* we _can_ be in RCU mode here */
>                 dentry = lookup_fast(nd, &inode, &seq);
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
>                 if (likely(dentry))
>                         goto finish_lookup;
> 
> and we never get to the inode locking sequence at all.
> 
> So just adding a
> 
>         if (nd->flags & LOOKUP_NONBLOCK)
>                 return -EAGAIN;
> 
> there is probably the right thing - rather than worry about trylock on
> the inode lock.

I really like that, as it also means we can safely drop the
mnt_want_write() path and just safe that for a separate cleanup that's
not related to this at all. With that, I'd suggest folding the two
patches into one as we no longer need followup work. It also means we
can drop the concept of having two flags for this, LOOKUP_NONBLOCK
covers the entire case of the existing fast path.

Might still make sense to name it LOOKUP_CACHE instead, but I'll leave
that for you/Al to decide...

> Because if you've missed in the dcache, you've by definition lost the fast-path.
> 
> That said, numbers talk, BS walks, and maybe somebody has better loads
> with better numbers. I assume Jens has some internal FB io_uring loads
> and could do stats on what kinds of pathname opens matter there...

Definitely, was already planning on checking that. And just as
importantly, once we have this, it's pretty trivial to do the same thing
on the stat side as well, which makes me excited for that change too.
io_uring currently punts that one too, and that's arguably even more
interesting than open if we can avoid that for the fast case.

-- 
Jens Axboe

