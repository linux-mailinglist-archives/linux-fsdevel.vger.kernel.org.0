Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350150D51D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiDXUjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiDXUjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:39:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A2156E29;
        Sun, 24 Apr 2022 13:36:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id s4so9591956qkh.0;
        Sun, 24 Apr 2022 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QCYP2PyCE9BcQOAw0YSM140VN5YcTk8T2hRAd0h/gwA=;
        b=hDJ60wfmW6DQcblL5tEb+/lWxTp7lIUJJeE4f5KWQOaDaetmvHFl4Pk1lxVc31khwW
         Xkx4OijXuHNf2ljDwRsnpqGU5vkpdQcsnoYkRTVsYgJgGSs6lzBOwZvtmFtH+UEVNt1a
         i8gSmKA0G+5UaRoVthPeO5jBCIoA4kwEEcHNq+DOzobHRcpuxzU8VAhSKqCrdkTNio5O
         Tr47Pj+pDRmlcWOKahWMHXm5xJlinuGvVerWeeKBzrh/w1MnvZqRXi0tuxEWaWmZ1tmj
         RK94lxhd0pNQsJ/CFhMKxFxeGsu79Rjg/Iy0kp4HSePkUP+VIoLhlUOX7ODsoLGYSnIA
         gcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCYP2PyCE9BcQOAw0YSM140VN5YcTk8T2hRAd0h/gwA=;
        b=01CP0C1J8/mf+ykdcG4SivQFZjwnxR+AV4y759lS6x4sDtqte6TumOB7bV+2Rx/tAw
         nmmdDjM5BPayZCcJ9DZ2gRzntO4xHHalY6hFrmi1RVdtQAm7eDxKjdyrV1af4209KUPJ
         FSavjvdVkWeHMruQweB/JUElSUKeAPRyFeF0NaXmHfD4tQfMwN5rCzURPSHHU0IOZEeb
         Q/XOY9KLZx0+YDy8qCNADKda1LdK9mNbRt6Pc2CxuzIspYqdjkdOyk4YIb8ZPY11D4Zj
         87Sad5cEd440Wt7hXgQFRJbiVFUS3opzW/MaRB4oB9adm1oK0ndWZemgjS2tUijAQnze
         MXoA==
X-Gm-Message-State: AOAM532qzNoXXuyWBhTdCcXEiYqQ9vz7rsRx3Ms5CQACEt60cLjflXEn
        OhTtm9tCMxeSuy4QomjuSWwrDv0UZOij
X-Google-Smtp-Source: ABdhPJxXULIBfLZUSZrR8mF/+Gv8NBFSUmQ8mjXjzx1WN/nIKlMN8CQAlbcYgrX0lpy7K9r8tDuq8w==
X-Received: by 2002:a37:63c7:0:b0:69e:5d71:e45c with SMTP id x190-20020a3763c7000000b0069e5d71e45cmr8503598qkb.620.1650832588888;
        Sun, 24 Apr 2022 13:36:28 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 23-20020a370817000000b0069e71175d86sm3967008qki.109.2022.04.24.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:36:28 -0700 (PDT)
Date:   Sun, 24 Apr 2022 16:36:26 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: Rust and Kernel Vendoring [Was Re: [PATCH v2 1/8] lib/printbuf:
 New data structure for heap-allocated strings]
Message-ID: <20220424203626.sdppoyvyrn4yeglp@moria.home.lan>
References: <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422113736.460058cc@gandalf.local.home>
 <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
 <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
 <20220422211350.qn2brzkfwsulwbiq@moria.home.lan>
 <afdda017cbd0dc0f41d673fe53d2a9c48fba9a6c.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdda017cbd0dc0f41d673fe53d2a9c48fba9a6c.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 23, 2022 at 10:16:37AM -0400, James Bottomley wrote:
> You stripped the nuance of that.  I said many no_std crates could be
> used in the kernel.  I also said that the async crate couldn't because
> the rust compiler itself would have to support the kernel threading
> model.

I just scanned through that thread and that's not what you said. What you said
was:

> The above is also the rust crate problem in miniature: the crates grow
> API features the kernel will never care about and importing them
> wholesale is going to take forever because of the internal kernel
> support issue.  In the end, to take rust async as an example, it will
> be much better to do for rust what we've done for zlib: take the core
> that can support the kernel threading model and reimplement that in the
> kernel crate.  The act of doing that will a) prove people care enough
> about the functionality and b) allow us to refine it nicely.
> 
> I also don't think rust would really want to import crates wholesale.
> The reason for no_std is that rust is trying to adapt to embedded
> environments, which the somewhat harsh constraints of the kernel is
> very similar to.

But maybe your position has changed somewhat? It sounds like you've been
arguing against just directly depending on foreign reposotories and for the
staus quo of just ad-hoc copying of code.

I'll help by stating my own position: I think we should be coming up with a
process for how dependencies on other git repositories are going to work,
something better than just cut and paste. Whether or not we vendorize code isn't
really that important, but I'd say that if we are vendorizing code and we're not
including entire sub-repositories (like cargo vendor does) we ought to still
make this a scripted process that takes as an input a list of files we're
pulling and a remote repository we're pulling from, and the file list and the
remote repo (and commit ID we're pulling from) should all be checked in.

I think using cargo would be _great_ because it would handle this part for us
(perhaps minus pulling of individual files? haven't checked) instead of
home-growing our own. However, I'd like something for C repositories too, and I
don't think we want to start depending on cargo for non Rust development... :)

But much more important that the technical details of how we import code is just
having good answers for people who aren't embedded in Linux kernel development
culture, so we aren't just telling them "no" by default because we haven't
thought about this stuff and having them walk away frustrated.

> > I think Linus said recently that Rust in the kernel is something that
> > could fail, and he's right - but if it fails, it won't just be the
> > failure of the Rust people to do the required work, it'll be _our_
> > failure too, a failure to work with them.
> 
> The big risk is that rust needs to adapt to the kernel environment. 
> This isn't rust specific, llvm had similar issues as an alternative C
> compiler.  I think rust in the kernel would fail if it were only the
> rust kernel people asking.  Fortunately the pressure to support rust in
> embedded leading to the rise in no_std crates is a force which can also
> get rust in the kernel over the finish line because of the focus it
> puts on getting the language and crates to adapt to non standard
> environments.

It's both! It's on all of us to make this work.

> > The kernel community has a lot of that going on here. Again, sorry to
> > pick on you James, but I wanted to make the argument that - maybe the
> > kernel _should_ be adopting a more structured way of using code from
> > outside repositories, like cargo, or git submodules (except I've
> > never had a positive experience with git submodules, so ignore that
> > suggestion, unless I've just been using them wrong, in which case
> > someone please teach me). To read you and Greg saying "nah, just
> > copy code from other repos, it's fine" - it felt like being back in
> > the old days when we were still trying to get people to use source
> > control, and having that one older colleague who _insisted_ on not
> > using source control of any kind, and that's a bit disheartening.
> 
> Even in C terms, the kernel is a nostdlib environment.  If a C project
> has too much libc dependency it's not going to work directly in the
> kernel, nor should it.  Let's look at zstd (which is pretty much a
> nostdlib project) as a great example: the facebook people didn't
> actually port the top of their tree (1.5) to the kernel, they
> backported bug fixes to the 1.4 branch and made a special release
> (1.4.10) just for us.  Why did they do this?  It was because the 1.5
> version vastly increased stack use to the extent it would run off the
> end of the limited kernel stack so couldn't be ported directly into the
> kernel.  A lot of C libraries that are nostdlib have problems like this
> as well (you can use recursion, but not in the kernel).  There's no
> easy way of shimming environmental constraints like this.

I wonder if we might have come up with a better solution if there'd been more
cross-project communication and less siloing. Small stacks aren't particular to
the kernel - it's definitely not unheard of to write userspace code where you
want to have a lot of small stacks (especially if you're doing some kind of
coroutine style threading; I've done stuff like this in the past) - and to me,
as someone who's been incrementing on and maintaining a codebase in active use
for 10 years, having multiple older versions in active use that need bugfixes
gives me cold shivers.

I wouldn't be surprised if at some point the zstd people walk back some of their
changes or make it configurable at some point :)
