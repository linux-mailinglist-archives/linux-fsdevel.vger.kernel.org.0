Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418501F4A38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 01:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFIX4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 19:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgFIX4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:56:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72867C08C5C3;
        Tue,  9 Jun 2020 16:56:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so86459pju.3;
        Tue, 09 Jun 2020 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iiMYy2UHmaKTFs09QEQeECPwuhESuKPQ15dcebo1ZRs=;
        b=SNQSAWBNT5u3pPydw/W6Uj796+vQGG8OkNPK8dVeGKwOdBVWGPOySAajjBXzziBzRp
         LhPMcbyTCj9N80dq5/MUsuX1n5Cfb/0Q9C4lre9OUZ7e4EFZ0eaangZ2rRbSsRlRcQrb
         xvYdoEC1nRvdLcNHVvQ6qB6oiaMNPvcJ1GqtxByoiPgQeEqwylOGqyxlCCiLwQKZezwN
         LMJdAEqYg6rMRqvFT6LSvTOf0cGjK3b0DP2ti1Wex7TMELer2tMJQXE1IIMGCfKvznqV
         +UVJ2FBc0LXbir0oet5X3qB4EwO9Go7BC9GwNC3dGdA1sBzDUXmcejb6r8z7BIfpfwTq
         4Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iiMYy2UHmaKTFs09QEQeECPwuhESuKPQ15dcebo1ZRs=;
        b=a130W42m+Frio4waLEj5KoKSkUinCV9qRm80twlpXmtWQ31cRtQbsorQX8lHwYuIzD
         9azrf/n47c3MOkdtoC5YrSQ/gFrMFFnYqIJp43fexNidjL5L7SjyZ+IEwhxC+L+J9O3F
         KM4yRrtWVhjgC/s/MvTh7GUTg5rvIAO4YvTA/f0moklUl+xDg6GxFRzApP9jTreADqMU
         ggYI1Nqt85aS00M9HsYONj/QE2Q30BRLhl3MHrewGicWrDfhWcEc6GxAMKEpXFlTXknX
         lbe4T9aX145DEOVftnPaTXqvEp2TGmhcdf6c/CPluFbV7uKFWUQUExa+l7k/v98OmgbT
         CuAA==
X-Gm-Message-State: AOAM533y+y00xVJKiOS/Pb3AZ9q1yLmkkZfMhcdAywdiNkP5AvVfwV/i
        ykB8QZ3ahSbdWsTP/ICDJwg=
X-Google-Smtp-Source: ABdhPJzRQ3IwWefT2BmnWd6RljaZgyR+lj1yulZqeL/AZOPbpuIRmHeCC+Wz1CF6XcylfViXiCezyw==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr702459plq.111.1591746994845;
        Tue, 09 Jun 2020 16:56:34 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id h17sm10719500pfo.168.2020.06.09.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 16:56:33 -0700 (PDT)
Date:   Tue, 9 Jun 2020 16:56:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1uo2ejt.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:02:30PM -0500, Eric W. Biederman wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > bpf_lsm is that thing that needs to load and start acting early.
> > It's somewhat chicken and egg. fork_usermode_blob() will start a process
> > that will load and apply security policy to all further forks and
> > execs.
> 
> What is the timeframe for bpf_lsm patches wanting to use
> fork_usermode_blob()?
> 
> Are we possibly looking at something that will be ready for the next
> merge window?

In bpf space there are these that want to use usermode_blobs:
1. bpfilter itself.
First of all I think we made a mistake delaying landing the main patches:
https://lore.kernel.org/patchwork/patch/902785/
https://lore.kernel.org/patchwork/patch/902783/
without them bpfilter is indeed dead. That probably was the reason
no one was brave enough to continue working on it.
So I think the landed skeleton of bpfilter can be removed.
I think no user space code will notice that include/uapi/linux/bpfilter.h
is gone. So it won't be considered as user space breakage.
Similarly CONFIG_BPFILTER can be nuked too.
bpftool is checking for it (see tools/bpf/bpftool/feature.c)
but it's fine to remove it.
I still think that the approach taken was a correct one, but
lifting that project off the ground was too much for three of us.
So when it's staffed appropriately we can re-add that code.

2. bpf_lsm.
It's very active at the moment. I'm working on it as well
(sleepable progs is targeting that), but I'm not sure when folks
would have to have it during the boot. So far it sounds that
they're addressing more critical needs first. "bpf_lsm ready at boot"
came up several times during "bpf office hours" conference calls,
so it's certainly on the radar. If I to guess I don't think
bpf_lsm will use usermode_blobs in the next 6 weeks.
More likely 2-4 month.

3. bpf iterator.
It's already capable extension of several things in /proc.
See https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
Cat-ing bpf program as "cat /sys/fs/bpf/my_ipv6_route"
will produce the same human output as "cat /proc/net/ipv6_route".
The key difference is that bpf is all tracing based and it's unstable.
struct fib6_info can change and prog will stop loading.
There are few FIXME in there. That is being addressed right now.
After that the next step is to make cat-able progs available
right after boot via usermode_blobs.
Unlike cases 1 and 2 here we don't care that they appear before pid 1.
They can certainly be chef installed and started as services.
But they are kernel dependent, so deploying them to production
is much more complicated when they're done as separate rpm.
Testing is harder and so on. Operational issues pile up when something
that almost like kernel module is done as a separate package.
Hence usermode_blob fits the best.
Of course we were not planning to add a bunch of them to kernel tree.
The idea was to add only _one_ such cat-able bpf prog and have it as
a selftest for usermode_blob + bpf_iter. What we want our users to
see in 'cat my_ipv6_route' is probably different from other companies.
These patches will likely be using usermode_blob() in the next month.

But we don't need to wait. We can make the progress right now.
How about we remove bpfilter uapi and rename net/bpfilter/bpfilter_kern.c
into net/umb/umb_test.c only to exercise Makefile to build elf file
from simple main.c including .S with incbin trick
and kernel side that does fork_usermode_blob().
And that's it.
net/ipv4/bpfilter/sockopt.c and kconfig can be removed.
That would be enough base to do use cases 2 and 3 above.
Having such selftest will be enough to adjust the layering
for fork_usermode_blob(), right?
If I understood you correctly you want to replace pid_t
in 'struct umh_info' with proper 'struct pid' pointer that
is refcounted, so user process's exit is clean? What else?
