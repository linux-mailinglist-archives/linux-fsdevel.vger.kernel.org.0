Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5EC1F1D6A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgFHQdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFHQdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:33:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C1C08C5C2;
        Mon,  8 Jun 2020 09:33:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so8604961pfe.4;
        Mon, 08 Jun 2020 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJcZ00wnITW0LqN97nIwwvtJcq7wRf84lNoz3DlusEQ=;
        b=o8EqlF3H4gqS5yXqaBtYk8O3DrlSSHNuMWxJ7wTCu1BKKGcktqX8fhxUn5oxtREY/M
         ftikyALgrXIGDxfhv8RHlNXxiTdos98MTLFEsjSrp/fFoA6OhLPMLnwY1ieiqINNzv7j
         ehiW6Lo2HwpUu+3jNOthPzfqTMyr3LTI0G1SbSj/ozNhemsA2moJ1qDrPAJJ4A4AmAAB
         4Skpp4RuBcQt7ILS7qBtbh9yohWt7y6kAGKHQTUHgWwK/PXMlx5FrPxu6xeH6dA/B1l8
         3Y67fZeV5OW1zllgIEa4DyAoDztZi8dYnSGdxX9r7cTW9Us279lnRhFKYSB/j2XD6CbW
         YHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJcZ00wnITW0LqN97nIwwvtJcq7wRf84lNoz3DlusEQ=;
        b=oj2rTNif/SGhjyNu96Q6dy/6/Qu26nHHSwyqgW+qqXJIWrmqaSSY8hqpG+Fo65JBFx
         2Cybi8VfjqUA6iuk7Nh0FxQwN9nywnRl0jQ9gzjSGekJ5zNpPd+2W886ngq7miEHPeW2
         RjzWRrCu6JRU21Pjzo+lDvSb4uWifKAqCmmXl177ijVZxEw0qLtmtJbtg20VprNiegl0
         RRQmMi5v5ha2niTvlM1jHASgf6YDi+yoOsUeIjSE7EOXwd3CTqfbDe5649aAXa98UO7F
         GyceU/34PQTdaSkaBy/UzLhaRhUWLDP94i2pyERlg3TLAK5hdg0fwP7aTMce2+8B1woQ
         dsNA==
X-Gm-Message-State: AOAM531dVhZBRTLJg1ktL1/x9VDFdDjJ+URiHa1H1oaSWjS8PgTlDrX5
        W/jd5QiPFywPWh6ZtCIJpTA=
X-Google-Smtp-Source: ABdhPJyOhiZlrc0coLPKFOLTt0F1l8PT3HNaJO2lkvGHg5TRGR2lTzvIbw0NwZueBZGRatNo4V0TvQ==
X-Received: by 2002:a65:678c:: with SMTP id e12mr20403137pgr.375.1591634026633;
        Mon, 08 Jun 2020 09:33:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id e21sm6346773pga.71.2020.06.08.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:33:45 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:33:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200608163343.nvmdhbgkhoscwpau@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <87mu5f8ljf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu5f8ljf.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 12:58:12AM -0500, Eric W. Biederman wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Sat, Jun 06, 2020 at 03:33:14PM -0700, Linus Torvalds wrote:
> >> On Sat, Jun 6, 2020 at 1:20 PM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> >
> >> > Please mention specific bugs and let's fix them.
> >> 
> >> Well, Eric did mention one explicit bug, and several "looks dodgy" bugs.
> >> 
> >> And the fact is, this isn't used.
> >> 
> >> It's clever, and I like the concept, but it was probably a mistake to
> >> do this as a user-mode-helper thing.
> >> 
> >> If people really convert netfilter rules to bpf, they'll likely do so
> >> in user space. This bpfilter thing hasn't gone anywhere, and it _has_
> >> caused problems.
> >> 
> >> So Alexei, I think the burden of proof is not on Eric, but on you.
> >> 
> >> Eric's claim is that
> >> 
> >>  (a) it has bugs (and yes, he pointed to at lelast one)
> >
> > the patch from March 12 ?
> > I thought it landed long ago. Is there an issue with it?
> > 'handling is questionable' is not very constructive.
> 
> It was half a fix.  Tetsuo still doesn't know how to fix tomoyo to work
> with fork_usermode_blob.
> 
> He was asking for your feedback and you did not give it.
> 
> The truth is Tetsuo's fix was only a fix for the symptoms.  It was not a
> good fix to the code.
> 
> >>  (b) it's not doing anything useful
> >
> > true.
> >
> >>  (b) it's a maintenance issue for execve, which is what Eric maintains.
> >
> > I'm not aware of execve issues. I don't remember being cc-ed on them.
> > To me this 'lets remove everything' patch comes out of nowhere with
> > a link to three month old patch as a justification.
> 
> I needed to know how dead the code is and your reply has confirmed
> that the code is dead.
> 
> Deleting the code is much easier than the detailed careful work it would
> take to make code that is in use work correctly.
> 
> >> So you can't just dismiss this, ignore the reported bug, and say
> >> "we'll fix them".
> >> 
> >> That only answers (a) (well, it _would_ have answered (a)., except you
> >> actually didn't even read Eric's report of existing bugs).
> >> 
> >> What is your answer to (b)-(c)?
> >
> > So far we had two attempts at converting netfilter rules to bpf. Both ended up
> > with user space implementation and short cuts. bpf side didn't have loops and
> > couldn't support 10k+ rules. That is what stalled the effort. imo it's a
> > pointless corner case, but to be a true replacement people kept bringing it up
> > as something valid. Now we have bpf iterator concept and soon bpf will be able
> > to handle millions of rules. Also folks are also realizing that this effort has
> > to be project managed appropriately. Will it materialize in patches tomorrow?
> > Unlikely. Probably another 6 month at least. Also outside of netfilter
> > conversion we've started /proc extension effort that will use the same umh
> > facility. It won't be ready tomorrow as well, but both need umh.
> 
> Given that I am one of the folks who looks after proc I haven't seen
> that either.  The direction I have seen in the last 20 years is people
> figuring out how to reduce proc not really how to extend it so I can't
> imagine what a /proc extension effort is.

We already made it extensible without changing /proc.
Folks can mount bpffs into /newproc, pin bpf prog in there and it
will be cat-able.
It's not quite /proc, of course. It's a flexible alternative
with unstable cat-able files that are kernel specific.

> 
> > initrd is not
> > an option due to operational constraints. We need a way to ship kernel tarball
> > where bpf things are ready at boot. I suspect /proc extensions patches will
> > land sooner. Couple month ago people used umh to do ovs->xdp translatation. It
> > didn't land. People argued that the same thing can be achieved in user space
> > and they were correct. So you're right that for most folks user space is the
> > answer. But there are cases where kernel has to have these things before
> > systemd starts.
> 
> You may have a valid case for doing things in the kernel before systemd
> starts.  The current mechanism is fundamentally in conflict with the
> LSMs which is an unresolved problem.

It's the other way around. fork_usermode_blob is a mechanism to launch bpf_lsm.

> I don't see why you can't have a userspace process that does:
> 
> 	pid = fork();
>         if (pid == 0) {
>         	/* Do bpf stuff */
>         }
>         else if (pid > 0) {
>         	execve("/sbin/init", ...);
>         }
> 
> You can build an initramfs with that code right into the kernel, so
> I can't imagine the existing mechanisms being insufficient.

that doesn't work for android.
It also doesn't work for us. We ship the kernel package.
It has vmlinux and kernel modules. That's it.

> That said the fork_usermode_blob code needs to be taken out and
> rewritten so as not to impose a burden on the rest of the code.  There
> is no reason why code that is called only one time can not allocate a
> filename and pass it to __do_execve_file.

Sure. Let's alloc filename.

> There is no reason to allow modules access to any of that functionality
> if you need something before an initramfs can be processed.
> 
> exit_umh() is completely unnecessary all that is needed is a reference
> to a struct pid.

So there are no bugs, but there are few layering concerns, right?
Let's switch to pid from task_struct.

> There are all of these layers and abstractions but with only the single
> user in net/bpfilter/bpfilter_kern.c they all appear to have been
> jumbled together without good layering inbetween then.

I'm totally fine tweaking the layering if it makes exec code easier
to maintain.
Sounds like alloc filename and pid vs task_struct are the only things
that needs to be tweaked.
