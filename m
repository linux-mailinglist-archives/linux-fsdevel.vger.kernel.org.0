Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB84849EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiADVdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 16:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiADVda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:33:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCCC061792
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 13:33:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp20so84615886lfb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=drummond.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNEHR3Z7xVYize0mN8B03PgruOrGHLeNm9z/WBZRA5s=;
        b=LSyr4sBMVZkpPhkZtPK2JisrQnhbBz7QjSfd4KNOcFM4AU0qKdk0UJpGZb+0jCOp3+
         0be2y+YCjX3RXXSmjxSyg/dpUkwk8g9tR8tFlfpCoOl6gkjkt+fMq0PjjxyyJNTFYt8c
         FZ11XeMeClhzKwY1EEXw6Drw6bXTNBrvYYXipPSLk1+G8bt34GEm94U8/3NBUpQmgo+I
         6vFq6ItJdEYDUqsby/7d+eoSK1bjO+/oetaZ8Iew/taVDbU7iIgFSoXhe3hb0Ldw03MT
         R+bmOKg8bmymIWyhHMZmRW+3LFsecnJ0FzU9ADVVLGkhSvwBro4JKi84WWqvGtFZApC4
         FWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNEHR3Z7xVYize0mN8B03PgruOrGHLeNm9z/WBZRA5s=;
        b=SAnqCMH2jHjHXMS6ZAiT6/jlc30pEYujgvzt4PtV8udm4xy1XguYnds+a7B/TBMJFC
         dlNxARqCDsqDy40ksvWNMqNOumXDHN6PlJHjTGm55KL1uurF4o8Y4QO8HNXMUn6jjBcA
         3ZujUysHcwJiVxFhpR6Qf5R3DDjEMQZxlmtxQzr4n9YB1SGnI75k4pgM2L5QJzZJwfqS
         MiAJkQWtBiS7bRjIX2od0F/X2itFtrVm3vgKUXOWSgN+NNpXk2uYWCKGYJ1lH670R/Rc
         HWZ855pUa29umMzESiArIaATXTOMxxEF6t75UiJGBM7mNFf806moGlapD7fb5v6yq0Lq
         c8Vg==
X-Gm-Message-State: AOAM532gO7Grkk6N9zsg5LgIavCdlkS5R4gA8BDm1j11TM0mJ8R+npvs
        yM+m72ARSaobtG4FYtk+8w7XeLbPxQREkUZZUisREQ==
X-Google-Smtp-Source: ABdhPJyRA2K3TMJ6jSnxBuWi5MuQ4iKJxLMI138ugfOpXQ7kPFHXRpFMZUcCtjTEsQxbN1KSwsm/r+TWYRcUIccdplg=
X-Received: by 2002:a05:6512:2083:: with SMTP id t3mr44658689lfr.595.1641332007792;
 Tue, 04 Jan 2022 13:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20220103181956.983342-1-walt@drummond.us> <87iluzidod.fsf@email.froward.int.ebiederm.org>
 <YdSzjPbVDVGKT4km@mit.edu>
In-Reply-To: <YdSzjPbVDVGKT4km@mit.edu>
From:   Walt Drummond <walt@drummond.us>
Date:   Tue, 4 Jan 2022 13:33:16 -0800
Message-ID: <CADCN6nz0ih2k7-LB9D3qJjQ9Dv5QAkn7KC9Ci-qcbMHTG7_F+A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fair enough.  I'll abandon the signals part of this and just send out
the VSTATUS/Control-T part, after I address some comments from Greg.

Thanks.

On Tue, Jan 4, 2022 at 12:52 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jan 04, 2022 at 12:00:34PM -0600, Eric W. Biederman wrote:
> > I dug through the previous conversations and there is a little debate
> > about what makes sense for SIGPWR to do by default.  Alan Cox remembered
> > SIGPWR was sent when the power was restored, so ignoring SIGPWR by
> > default made sense.  Ted Tso pointed out a different scenario where it
> > was reasonable for SIGPWR to be a terminating signal.
> >
> > So far no one has actually found any applications that will regress if
> > SIGPWR becomes ignored by default.  Furthermore on linux SIGPWR is only
> > defined to be sent to init, and init ignores all signals by default so
> > in practice SIGPWR is ignored by the only process that receives it
> > currently.
>
> As it turns out, systemd does *not* ignore SIGPWR.  Instead, it will
> initiate the sigpwr target.  From the systemd.special man page:
>
>        sigpwr.target
>            A special target that is started when systemd receives the
>            SIGPWR process signal, which is normally sent by the kernel
>            or UPS daemons when power fails.
>
> And child processes of systemd are not ignoring SIGPWR.  Instead, they
> are getting terminated.
>
> <tytso@cwcc>
> 41% /bin/sleep 50 &
> [1] 180671
> <tytso@cwcc>
> 42% kill -PWR 180671
> [1]+  Power failure           /bin/sleep 50
>
> > Where I saw the last conversation falter was in making a persuasive
> > case of why SIGINFO was interesting to add.  Given a world of ssh
> > connections I expect a persuasive case can be made.  Especially if there
> > are a handful of utilities where it is already implemented that just
> > need to be built with SIGINFO defined.
>
> One thing that's perhaps worth disentangling is the value of
> supporting VSTATUS --- which is a control character much like VINTR
> (^C) or VQUIT (control backslash) which is set via the c_cc[] array in
> termios structure.  Quoting from the termios man page:
>
>        VSTATUS
>               (not in POSIX; not supported under Linux; status
>               request: 024, DC4, Ctrl-T).  Status character (STATUS).
>               Display status information at terminal, including state
>               of foreground process and amount of CPU time it has
>               consumed.  Also sends a SIGINFO signal (not supported on
>               Linux) to the foreground process group.
>
> The basic idea is that when you type C-t, you can find out information
> about the currently running process.  This is a feature that
> originally comes from TOPS-10's TENEX operating system, and it is
> supported today on FreeBSD and Mac OS.  For example, it might display
> something like this:
>
> load: 2.39  cmd: ping 5374 running 0.00u 0.00s
>
> The reason why SIGINFO is sent to the foreground process group is that
> it gives the process an opportunity print application specific
> information about currently running process.  For example, maybe the C
> compiler could print something like "parsing 2042 of 5000 header
> files", or some such.  :-)
>
> There are people who wish that Linux supported Control-T / VSTATUS,
> for example, just last week, on TUHS, the Unix greybeards list, there
> were two such heartfelt wishes for Control-T support from two such
> greybeards:
>
>     "It's my biggest annoyance with Linux that it doesn't [support
>     control-t]
>     - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024849.html
>
>     "I personally can't stand using Linux, even casually for a very
>      short sys-admin task, because of this missing feature"
>     - https://minnie.tuhs.org/pipermail/tuhs/2021-December/024898.html
>
> I claim, though, that we could implement VSTATUS without implenting
> the SIGINFO part of the feature.  Previous few applications *ever*
> implemented SIGINFO signal handlers so they could give status
> information, it's the hard one, since we don't have any spare signals
> left.  If we were to repurpose some lesser used signal, whether it be
> SIGPWR, SIGLOST, or SIGSTKFLT, the danger is that there might be some
> userspace program (such as a UPS monitoring program which wants to
> trigger power fail handling, or a userspace NFSv4 process that wants
> to signal that it was unable to recover a file's file lock after a
> server reboot), and if we try to take over the signal assignment, it's
> possible that we might get surprised.  Furthermore, all of the
> possibly unused signals that we might try to reclaim terminate the
> process by default, and SIGINFO *has* to have a default signal
> handling action of Ignore, since otherwise typing Control-T will end
> up killing the current foreground application.
>
> Personally, I don't care all that much about VSTATUS support --- I
> used it when I was in university, but honestly, I've never missed it.
> But if there is someone who wants to try to implement VSTATUS, and
> make some Unix greybeards happy, and maybe even switch from FreeBSD to
> Linux as a result, go wild.  I'm not convinced, though, that adding
> the SIGINFO part of the support is worth the effort.
>
> Not only do almost no programs implement SIGINFO support, a lot of CPU
> bound programs where this might be actually useful, end up running a
> large number of processes in parallel.  Take the "parsing 2042 of 5000
> header files" example I gave above.  Consider what would happen if gcc
> implemented support for SIGINFO, but the user was running a "make -j
> 16" and typed Control-T.   The result would be chaos!
>
> So if you really miss Control-T, and it's the only thing holding back
> a few FreeBSD users from Linux, I don't see the problem with
> implementing that part of the feature.  Why not just do the easy part
> of the feature which is perhaps 5% of the work, and might provide 99%
> of the benefit (at least for those people who care).
>
> > Without seeing the persuasive case for more signals I have to say that
> > adding more signals to the kernel sounds like a bad idea.
>
> Concur, 100%.
>
>                                                 - Ted
