Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C92480A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHRIbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 04:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRIbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:31:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FB6C061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 01:31:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x24so9759362lfe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8GP7eS1LzqVo1eId0/J96ZQfgvz1Pc6gH5ak12QY8s=;
        b=Wv+1pa2AmKmIwoKJdEL2ArgVsY1NxHFTuMHeNtykD6cHJqyOs6Ldd9+CJCFjNiNw1n
         d//IcpMHQNlTzB1i8GiRa4VxLjdUliW2WYb/GTUaK1vaDU8mAYXpoo2Jc46qsC3kP5Wm
         0pn0jblTpfNawL8JTIl/OAsSIKZMS4Sd0olHFj2Qds9nFW/nRCvT6D0zZUS+m7KgqxpJ
         O7MvpSd5P3cLMl/q2NEF24plBojGwsdc7mNKcUet6FFV5RSF4oPL4Ina3hGzvu2YYh7C
         TJKOo4Orwsi4xp3qCJiXrJvCnVL2jVGuBxHVWeLy2/eYHcNpXYbAf5wrxAilDZcXCJVk
         kfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8GP7eS1LzqVo1eId0/J96ZQfgvz1Pc6gH5ak12QY8s=;
        b=t6EdMmwsl54VljWGACt5cSOcMNPqVyEWjziXDLMtEGnXpnuAAyGivSXL54XpHKx1jA
         UShFAtZMZLSGLqqJGmmMj5DQYEIOjFb3ii7lKnm9Q/7/n55+0Qnp3to1QjWtpeu3HCVm
         0t8PgsZeZSrcjUhElLVPWL/uyaIeT2U2BrYG6I2d3KQzbRCadTyB7rOg2FNQUQ1DLDFl
         zwVB3E0+Zv79yu2SGLfP+79Ik6qqKfs7q1n7vLi6FgikhXsyx8Fp1PjNGWRhdutc/g8d
         lSmtWd1Rmw6PcK7HWpzNDBxlEhcdlyL4mFsJU83Ok9+o72ZhUaUw9xv4MlbWNMUpuoAO
         U0Iw==
X-Gm-Message-State: AOAM532/FqOeTPcAdYFSPStZfLfo2qkhq4HR1gD77y5iZXzOeNRQa+lP
        mCTf5lg48vwTa44jcbsYnTJ+Sqmq9FVzIA/PKoq3pQ==
X-Google-Smtp-Source: ABdhPJwOK2qkpFlid8UNu4o909xNlNZeU/CcgMi47GISHCDqEJo0W4B9K2Dvq8R5VeBxjw2o4Ig7Cozq0ziLwGTgteY=
X-Received: by 2002:a19:4844:: with SMTP id v65mr9475947lfa.184.1597739506937;
 Tue, 18 Aug 2020 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-5-jannh@google.com>
 <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
In-Reply-To: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Aug 2020 10:31:20 +0200
Message-ID: <CAG48ez3pMcPTHrbgjeVbCAV1n7VQW1tqJw8kNsL4wgRxV_Fr9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 17, 2020 at 11:13 PM Jann Horn <jannh@google.com> wrote:
> >
> >         /*
> >          * If this looks like the beginning of a DSO or executable mapping,
> > +        * we'll check for an ELF header. If we find one, we'll dump the first
> > +        * page to aid in determining what was mapped here.
> > +        * However, we shouldn't sleep on userspace reads while holding the
> > +        * mmap_lock, so we just return a placeholder for now that will be fixed
> > +        * up later in vma_dump_size_fixup().
>
> I still don't like this.
>
> And I still don't think it's necessary.
>
> The whole - and only - point of "check if it's an ELF header" is that
> we don't want to dump data that could just be found by looking at the
> original binary.
>
> But by the time we get to this point, we already know that
>
>  (a) it's a private mapping with file backing, and it's the first page
> of the file
>
>  (b) it has never been written to and it's mapped for reading
>
> and the choice at this point is "don't dump at all", or "dump just the
> first page".
>
> And honestly, that whole "check if it has the ELF header" signature
> was always just a heuristic. Nothing should depend on it anyway.
>
> We already skip dumping file data under a lot of other circumstances
> (and perhaps equally importantly, we already decided to dump it all
> under other circumstances).
>
> I think this DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER hackery is worse than
> just changing the heuristic.
>
> So instead, just say "ok, if the file was executable, let's dump the
> first page".
>
> The test might be as simple as jjust checking
>
>        if (file_inode(vma->vm_file)->i_mode & 0111)
>
> and you'd be done. That's likely a _better_ heuristic than the "let's
> go look at the random first word in memory".
>
> Your patches look otherwise fine, but I really really despise that
> DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER, and I don't think it's even
> necessary.

Yeah, good point, it's a pretty ugly hack. I'll make a new version
along the lines of what you suggested.
