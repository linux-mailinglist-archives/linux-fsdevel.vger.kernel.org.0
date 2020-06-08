Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8431F1D90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgFHQkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgFHQkt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:40:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793152053B;
        Mon,  8 Jun 2020 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591634447;
        bh=bdHQSYuFCQC9U8rBWpgGyCgRgsDbTZv8KmlSKZVp9M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+sVVnQudLA+5zW4IXXj+kVIZ1M97tk/BQIyt/Ris+5A2cXcXgb9IxJSj5GjzTUPJ
         8EGhbVtTb+DtGhaxZThtxgeAx6JbOX4JMtU+1WJgV5szji0WxYEsYJW/UMj5Yf+yEf
         R2rK7vJLY6hjF96mta7pLZe3iL9IsxYe2RTROw6w=
Date:   Mon, 8 Jun 2020 18:40:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200608164045.GC425601@kroah.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
 <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:20:27AM -0700, Alexei Starovoitov wrote:
> On Sat, Jun 06, 2020 at 07:19:56PM -0700, Linus Torvalds wrote:
> > On Sat, Jun 6, 2020 at 6:49 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >>
> > > I'm not aware of execve issues. I don't remember being cc-ed on them.
> > > To me this 'lets remove everything' patch comes out of nowhere with
> > > a link to three month old patch as a justification.
> > 
> > Well, it's out of nowhere as far as bpf is concerned, but we've had a
> > fair amount of discussions about execve cleanups (and a fair amount of
> > work too, not just discussion) lately
> > 
> > So it comes out of "execve is rather grotty", and trying to make it
> > simpler have fewer special cases.
> > 
> > > So far we had two attempts at converting netfilter rules to bpf. Both ended up
> > > with user space implementation and short cuts.
> > 
> > So I have a question: are we convinced that doing this "netfilter
> > conversion" in user space is required at all?
> > 
> > I realize that yes, running clang is not something we'd want to do in
> > kernel space, that's not what I'm asking.
> > 
> > But how much might be doable at kernel compile time (run clang to
> > generate bpf statically when building the kernel) together with some
> > simplistic run-time parameterized JITting for the table details that
> > the kernel could do on its own without a real compiler?
> 
> Right. There is no room for large user space application like clang
> in vmlinux. The idea for umh was to stay small and self contained.
> Its advantage vs kernel module is to execute with user privs
> and use normal syscalls to drive kernel instead of export_symbol apis.
> 
> There are two things in this discussion. bpfilter that intercepting
> netfilter sockopt and elf file embedded into vmlinux that executes
> as user process.
> The pro/con of bpfilter approach is hard to argue now because
> bpfilter itself didn't materialize yet. I'm fine with removal of that part
> from the kernel, but I'm still arguing that 'embed elf into vmlinux'
> is necessary, useful and there is no alternative.
> There are builtin kernel modules. 'elf in vmlinux' is similar to that.
> The primary use case is bpf driven features like bpf_lsm.
> bpf_lsm needs to load many different bpf programs, create bpf maps, populate
> them, attach to lsm hooks to make the whole thing ready. That initialization of
> bpf_lsm is currently done after everything booted, but folks want it to be
> active much early. Like other LSMs.
> Take android for example. It can certify vmlinux, but not boot fs image.

Huh?  dm-verity does this for the whole "boot fs partition" already,
right?  Or one of the "dm-" modules...

> vmlinux needs to apply security policy via bpf_lsm during the boot.
> In such case 'embedded elf in vmlinux' would start early, do its thing
> via bpf syscall and exit. Unlike bpfilter approach it won't stay running.
> Its job is to setup all bpf things and quit.
> Theoretically we can do it as proper kernel module, but then it would mean huge
> refactoring of all bpf syscall commands to be accessible from the kernel module.
> It's simpler to embed elf into vmlinux and run it as user process doing normal
> syscalls. I can imagine that in other cases this elf executable would keep
> running after setup.
> It doesn't have to be bpf related. Folks thought they can do usb drivers
> running in user space and ready at boot. 'elf in vmlinux' would work as well.

I still want to work on the "usb drivers in userspace" like this, it's
on my TODO for this year.  But don't let that "sometime in the future
wish" keep this code around if no one is currently using it.

thanks,

greg k-h
