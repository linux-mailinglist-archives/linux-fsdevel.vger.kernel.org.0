Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290C71F1D21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgFHQUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:20:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4EC08C5C2;
        Mon,  8 Jun 2020 09:20:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s23so7434045pfh.7;
        Mon, 08 Jun 2020 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/NDI/ZUtltozdgt+VOJE7nUU/VTdvGl6xwv3n0DF9lA=;
        b=T2Vhsg0fl2OahE2dkh/ezXVLuIN91L9WIqFxxzxHcuMLA5vKGXOmrJDIVBlCgSLY2j
         h6UBkKXzh7D464n6yBwiGNMWFEO06QiqLPSM605z9H23afs8UYlQNyCRFQzdZg75ptP5
         kPNfBg/KHcVuI/UVfVhkY15vEptXQWyUXfcsJQOQSRdkRY2cialTvhozElcGCqVcckjq
         ChiHewep6+WJVVRWoiOR4LjaX7BCJqWO0foYYtfRaBveOeihuSdcHbvD3tvUZBtf2Wvz
         b2nILJ/6Gp5yrr7jLzQqqwMNFg+KvOcRdodbi0BmXQktZBsOZC+m5T/HdTy77/m3cy7g
         vZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/NDI/ZUtltozdgt+VOJE7nUU/VTdvGl6xwv3n0DF9lA=;
        b=OuRutS0GosOZ6mn9N/bpC0FFITnvqVmAdVB5V+JxYK8Jo2WfMqNLI03WYxevRcCfi/
         dd252AudcQ/zjabfDcIAWYvTzawMKlZUa372Ehi+gJ31b80Js0Qq8zUUXgUY1yAad83Y
         UvOS+ofbjtf7aYK1aV5bgcpURoUW6R8/CRr4EKH18lMlBGtNUoGGkvzqtwM5ajD5Qo4c
         vPNLkTfvpkR9ck5XF+IzR27cjguhVe8aAT60ssnT7mSXlF9TjNVaA0mCuP3sv98DmmCC
         BpQwLIVZT+tJgWazlFpaKqu58bUs0Vh9ftzFmxp1MDooCjd3AKI2ll8apID9cQe3jdLj
         4jEA==
X-Gm-Message-State: AOAM531ixxxvZXH9CQorOrApMb1NA3PKg5iBluZW55CdKDpxkEGAWMVQ
        cULcAllALjTotFsU9c0kRws=
X-Google-Smtp-Source: ABdhPJxkhAFBaKaQdG026r6BnTBUV5jCbBOp7uYZAq09/0aR1h1G9KUHzyIMadVQzowYOiQ4TYuyvA==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr20417464pgn.378.1591633231761;
        Mon, 08 Jun 2020 09:20:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id s1sm43020pjp.14.2020.06.08.09.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:20:30 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:20:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 07:19:56PM -0700, Linus Torvalds wrote:
> On Sat, Jun 6, 2020 at 6:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >>
> > I'm not aware of execve issues. I don't remember being cc-ed on them.
> > To me this 'lets remove everything' patch comes out of nowhere with
> > a link to three month old patch as a justification.
> 
> Well, it's out of nowhere as far as bpf is concerned, but we've had a
> fair amount of discussions about execve cleanups (and a fair amount of
> work too, not just discussion) lately
> 
> So it comes out of "execve is rather grotty", and trying to make it
> simpler have fewer special cases.
> 
> > So far we had two attempts at converting netfilter rules to bpf. Both ended up
> > with user space implementation and short cuts.
> 
> So I have a question: are we convinced that doing this "netfilter
> conversion" in user space is required at all?
> 
> I realize that yes, running clang is not something we'd want to do in
> kernel space, that's not what I'm asking.
> 
> But how much might be doable at kernel compile time (run clang to
> generate bpf statically when building the kernel) together with some
> simplistic run-time parameterized JITting for the table details that
> the kernel could do on its own without a real compiler?

Right. There is no room for large user space application like clang
in vmlinux. The idea for umh was to stay small and self contained.
Its advantage vs kernel module is to execute with user privs
and use normal syscalls to drive kernel instead of export_symbol apis.

There are two things in this discussion. bpfilter that intercepting
netfilter sockopt and elf file embedded into vmlinux that executes
as user process.
The pro/con of bpfilter approach is hard to argue now because
bpfilter itself didn't materialize yet. I'm fine with removal of that part
from the kernel, but I'm still arguing that 'embed elf into vmlinux'
is necessary, useful and there is no alternative.
There are builtin kernel modules. 'elf in vmlinux' is similar to that.
The primary use case is bpf driven features like bpf_lsm.
bpf_lsm needs to load many different bpf programs, create bpf maps, populate
them, attach to lsm hooks to make the whole thing ready. That initialization of
bpf_lsm is currently done after everything booted, but folks want it to be
active much early. Like other LSMs.
Take android for example. It can certify vmlinux, but not boot fs image.
vmlinux needs to apply security policy via bpf_lsm during the boot.
In such case 'embedded elf in vmlinux' would start early, do its thing
via bpf syscall and exit. Unlike bpfilter approach it won't stay running.
Its job is to setup all bpf things and quit.
Theoretically we can do it as proper kernel module, but then it would mean huge
refactoring of all bpf syscall commands to be accessible from the kernel module.
It's simpler to embed elf into vmlinux and run it as user process doing normal
syscalls. I can imagine that in other cases this elf executable would keep
running after setup.
It doesn't have to be bpf related. Folks thought they can do usb drivers
running in user space and ready at boot. 'elf in vmlinux' would work as well.
