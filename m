Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97CB707C34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjERIjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjERIi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 04:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AAF19A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 01:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FDD8648D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 08:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72110C4339B;
        Thu, 18 May 2023 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684399132;
        bh=iNXLW714wvbddxkLWEGKyjPx/5AgFNSZZHZkYsZuwCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cC9YxRI4fD2DBbMySaCf01H0z33z/CIQ0wIrPF8sJAU2RrLV/QtIYzep3NJjKtksd
         Ip5hQIZyp/52/2t5b3jqc9kfTGz4PRQbIKvgrU8RNJ3UoXGzVBeFi/apXQ6xoFA3sW
         f3G3mw2YH5MkRz1SQQ9xGzUYFimNwzVd8VgoPvS5CR6caAsm1/2YMQqRzfnY37oq2n
         7/YOvDtaSvIviciQT7T10OkcAV8RmuJGt/XUON8jF0BkE/3MeXGINt87wShnTv7C4u
         aMHqbz8ZLd03Zu+c8gjc/VGSGu03rzX813DIyRWW+rYGE33jU8oerx9F5A5vKiLQMn
         N79PFLyS08NHg==
Date:   Thu, 18 May 2023 10:38:46 +0200
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
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 09:17:36AM -0700, Alexei Starovoitov wrote:
> On Wed, May 17, 2023 at 5:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > > Adding fsdevel so we're aware of this quirk.
> > >
> > > So I'm not sure whether this was ever discussed on fsdevel when you took
> > > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > > invalid value.
> >
> > I've never heard of this before, and I think it is compltely
> > unacceptable. 0 ist just a normal FD, although one that happens to
> > have specific meaning in userspace as stdin.
> >
> > >
> > > If it was discussed then great but if not then I would like to make it
> > > very clear that if in the future you decide to introduce custom
> > > semantics for vfs provided infrastructure - especially when exposed to
> > > userspace - that you please Cc us.
> >
> > I don't think it's just the future.  We really need to undo this ASAP.
> 
> Christian is not correct in stating that treatment of fd==0 as invalid
> bpf object applies to vfs fd-s.
> The path_fd addition in this patch is really the very first one of this kind.
> At the same time bpf anon fd-s (progs, maps, links, btfs) with fd == 0
> are invalid and this is not going to change. It's been uapi for a long time.
> 
> More so fd-s 0,1,2 are not "normal FDs".
> Unix has made two mistakes:
> 1. fd==0 being valid fd
> 2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.
> 
> The first mistake makes it hard to pass FD without an extra flag.
> The 2nd mistake is just awful.
> We've seen plenty of severe datacenter wide issues because some
> library or piece of software assumes stdin/out/err.
> Various services have been hurt badly by this "convention".
> In libbpf we added ensure_good_fd() to make sure none of bpf objects
> (progs, maps, etc) are ever seen with fd=0,1,2.
> Other pieces of datacenter software enforce the same.
> 
> In other words fds=0,1,2 are taken. They must not be anything but
> stdin/out/err or gutted to /dev/null.
> Otherwise expect horrible bugs and multi day debugging.
> 
> Because of that, several years ago, we've decided to fix unix mistake #1
> when it comes to bpf objects and started reserving fd=0 as invalid.
> This patch is proposing to do the same for path_fd (normal vfs fd) when

It isn't as you now realized but I'm glad we cleared that up off-list.

> it is passed to bpf syscall. I think it's a good trade-off and fits
> the rest of bpf uapi.
> 
> Everyone who's hiding behind statements: but POSIX is a standard..
> or this is how we've been doing things... are ignoring the practical
> situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces them.

(Prefix: Imagine me calmly writing this and in a relaxed tone.)

Just to clarify. I do think that deciding that 0 is an invalid file
descriptor number is weird and I wish you'd have discussed this with us
before you took that decision. You've seen the reaction that other
low-level userspace people you talked to had to these news...

I'm not sure what to make of the POSIX excursion. I think that it is a
complete sideshow to the issue here in a way. But fwiw...

We don't follow arbitrary conventions such as 0, 1, and 2 because we all
have sworn allegiance to The Secret Order of the POSIX but because the
alternative is that one subsystem finds it neat to use fd 0 to refer to
AT_FDCWD and another one to AT_MY_CUSTOM_FD0_MEANING. Which is exactly
what would've happened if this patch would have made it unnoticed.

This doesn't scale and our interfaces aren't designed around
Shakespeare's dictum "What's in a name?".

This will quickly devolve into a situation similar to letting a step on
a staircase be off by a few millimeters. See those users falling.

I'm glad we cleared this up. My main issue is indeed that fd 0 now isn't
just forbidden it would be given an entirely different meaning which is
not acceptable from the vfs perspective.
