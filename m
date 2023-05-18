Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF47086A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjERRUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjERRUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87544E52
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 10:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11AF65114
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 17:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7D3C4339B;
        Thu, 18 May 2023 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430435;
        bh=222VQjjUtIiGhUY9FBroejFXhKZCkzPC3yb+IyR8E1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRoYMEZMsWAYwxbdrql/riC7kqpmHkANCT21pDX6Sg93oUyMyygl8vEy/PsFnvEJp
         7qgP7HrC2Jvgte/ZKpi3tLN0apJ6hni6FVZwIpeOso+nT35K1tFEC81CX3VNDm/sKu
         45aGSSNkrzIU/NbuIytSS9G2Pt1KsD1Dmg21gR/Aq5keOQXUbkz5xNZ1jExdTV6kIP
         +UYm8ApLfkdRMB2oRfCFB+L/NpJT0i/guxh59pp+pTWDP92cGp5VHAIQ5s9F+6tK7R
         zOmB0Lddky90rNBTOgeE93Ozlt4EQmoVdAEo/I8YcZuDZ7Q52C7ZCgby2h4kKOQ02u
         FRzDyXfgruP+w==
Date:   Thu, 18 May 2023 19:20:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 09:25:08AM -0700, Alexei Starovoitov wrote:
> On Thu, May 18, 2023 at 10:38:46AM +0200, Christian Brauner wrote:
> > On Wed, May 17, 2023 at 09:17:36AM -0700, Alexei Starovoitov wrote:
> > > On Wed, May 17, 2023 at 5:05 AM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > > > > Adding fsdevel so we're aware of this quirk.
> > > > >
> > > > > So I'm not sure whether this was ever discussed on fsdevel when you took
> > > > > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > > > > invalid value.
> > > >
> > > > I've never heard of this before, and I think it is compltely
> > > > unacceptable. 0 ist just a normal FD, although one that happens to
> > > > have specific meaning in userspace as stdin.
> > > >
> > > > >
> > > > > If it was discussed then great but if not then I would like to make it
> > > > > very clear that if in the future you decide to introduce custom
> > > > > semantics for vfs provided infrastructure - especially when exposed to
> > > > > userspace - that you please Cc us.
> > > >
> > > > I don't think it's just the future.  We really need to undo this ASAP.
> > > 
> > > Christian is not correct in stating that treatment of fd==0 as invalid
> > > bpf object applies to vfs fd-s.
> > > The path_fd addition in this patch is really the very first one of this kind.
> > > At the same time bpf anon fd-s (progs, maps, links, btfs) with fd == 0
> > > are invalid and this is not going to change. It's been uapi for a long time.
> > > 
> > > More so fd-s 0,1,2 are not "normal FDs".
> > > Unix has made two mistakes:
> > > 1. fd==0 being valid fd
> > > 2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.
> > > 
> > > The first mistake makes it hard to pass FD without an extra flag.
> > > The 2nd mistake is just awful.
> > > We've seen plenty of severe datacenter wide issues because some
> > > library or piece of software assumes stdin/out/err.
> > > Various services have been hurt badly by this "convention".
> > > In libbpf we added ensure_good_fd() to make sure none of bpf objects
> > > (progs, maps, etc) are ever seen with fd=0,1,2.
> > > Other pieces of datacenter software enforce the same.
> > > 
> > > In other words fds=0,1,2 are taken. They must not be anything but
> > > stdin/out/err or gutted to /dev/null.
> > > Otherwise expect horrible bugs and multi day debugging.
> > > 
> > > Because of that, several years ago, we've decided to fix unix mistake #1
> > > when it comes to bpf objects and started reserving fd=0 as invalid.
> > > This patch is proposing to do the same for path_fd (normal vfs fd) when
> > 
> > It isn't as you now realized but I'm glad we cleared that up off-list.
> > 
> > > it is passed to bpf syscall. I think it's a good trade-off and fits
> > > the rest of bpf uapi.
> > > 
> > > Everyone who's hiding behind statements: but POSIX is a standard..
> > > or this is how we've been doing things... are ignoring the practical
> > > situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces them.
> > 
> > (Prefix: Imagine me calmly writing this and in a relaxed tone.)
> > 
> > Just to clarify. I do think that deciding that 0 is an invalid file

descriptor

> 
> We're still talking past each other.
> 0 is an invalid bpf object. Not file.
> There is a difference.

You cut of a word above. I can't follow your argument.
File descriptor numbers are free to refer to whatever we want.
They don't care about what type of object they refer to and they
better not.

> The kernel is breaking user space by returning non-file FDs in 0,1,2.
> Especially as fd = 1 and 2.

This has a strong aura of a strawman argument. ;)

> ensure_good_fd() in libbpf is a library workaround to make sure bpf objects
> are not the reason for user app brekage.
> I firmly believe that making kernel return socket FDs and other special FDs with fd >=3
> (under new sysctl, for example) will prevent user space breakage.
> 
> And to answer Ted's question..
> Yes. It's a security issue, but it's the other way around.
> The kernel returning non vfs file FD in [0,1,2] range is a security issue.
> I'm proposing to fix it with new sysctl or boot flag.

That's just completely weird. We can see what Linus thinks but I think
that's a somewhat outlandish proposal that I wouldn't support.
