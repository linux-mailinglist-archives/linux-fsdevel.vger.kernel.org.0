Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF837405C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjF0VnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF0VnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:43:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F426AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:43:19 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39ed35dfa91so3765945b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687902198; x=1690494198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSllMEfZxRxH/Ncdk3MCdEqFObJmS1OPb8q9+W1DegI=;
        b=2+sKZNQhP9V45I8qJWmARf2B8RZm3gD3w1G+fLrVbz3etG8Oy46GcaOZIS6i7K3h/K
         SnY+Z8y93mRayVYzD/bBmI80k6bOpZEltc522mgvrW4dvBA20utkIhJVmxipLS63eotD
         OyLxRMnsUYN/ZiQUZzCEJJzijs2bOmz42QDP0WZjEI6cTrxikwWePyRBiuQ5A9UsY3dC
         HKRakkm9SFetS+kNfa6Lt+7YxydPGWd5AFikKCGvrj1w+1hBmz0IlQzke2XDQmZMWaJi
         uq+Mg+T2/IijmOF+rcVsmhWxm+1bEl6ldl8lqzk8I27SotQNuNZbyDyOsVEeygiRqyqr
         bXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902198; x=1690494198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSllMEfZxRxH/Ncdk3MCdEqFObJmS1OPb8q9+W1DegI=;
        b=FrhEnmJPly+0MvZbfAsHhZR+8/amkbx82xJuPITakRrXyndfk+heAZK+WacUW8fKfp
         QXvOipURgbfrKph9XVsDxTUmQ2xHfZ63rKMSyrFdSTb9Otw1evmzEgRQVevde8p9Igkn
         U5+tDmovDVHuOwhEpngZCJhdA+6HU7+l+jrRvw8awhz8pbc2N4NPPL9dj6GPuGKqKk2b
         VjNxvb6K7cH2NA0ZZFMW1ntc3laEVoNmg+O8Xyxcub06USNboPlYDJ5kcvhsFWrRwClm
         z7uA+qbwFb29QG1e/sCZ2lQ2qnr+uziAkWUp+G+EAOkDPY/k6QZk/HJosY3dE3SEzWJh
         CHUQ==
X-Gm-Message-State: AC+VfDw8ye/mjPe66BfqqoYUxYuQJczn1/6oVoJmjJPfycLNbt1T8Cbm
        +sHPGJmxMkxb41jd8a1H5qyi0/ozTQgurTDkbjB26g==
X-Google-Smtp-Source: ACHHUZ5NN7n+x2d9nfA/dWjNvQsLrsGjE2IAN6NXyzlKoA60nHqa/WX6aQ+BhuHdTgfam03zZqGyClh2IrEsyhW5Whg=
X-Received: by 2002:a05:6808:21a2:b0:3a2:de7b:775f with SMTP id
 be34-20020a05680821a200b003a2de7b775fmr2907663oib.22.1687902198145; Tue, 27
 Jun 2023 14:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230626201713.1204982-1-surenb@google.com> <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner> <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner> <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
In-Reply-To: <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 14:43:06 -0700
Message-ID: <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 1:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jun 27, 2023 at 11:42=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello, Christian.
> >
> > On Tue, Jun 27, 2023 at 07:30:26PM +0200, Christian Brauner wrote:
> > ...
> > > ->release() was added in
> > >
> > >     commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
> > >     kernfs: add kernfs_ops->open/release() callbacks
> > >
> > >     Add ->open/release() methods to kernfs_ops.  ->open() is called w=
hen
> > >     the file is opened and ->release() when the file is either releas=
ed or
> > >     severed.  These callbacks can be used, for example, to manage
> > >     persistent caching objects over multiple seq_file iterations.
> > >
> > >     Signed-off-by: Tejun Heo <tj@kernel.org>
> > >     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >     Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>
> > >
> > > which mentions "either releases or severed" which imho already points=
 to
> > > separate methods.
> >
> > This is because kernfs has revoking operation which doesn't exist for o=
ther
> > filesystems. Other filesystem implemenations can't just say "I'm done. =
Bye!"
> > and go away. Even if the underlying filesystem has completely failed, t=
he
> > code still has to remain attached and keep aborting operations.
> >
> > However, kernfs serves as the midlayer to a lot of device drivers and o=
ther
> > internal subsystems and it'd be really inconvenient for each of them to=
 have
> > to implement "I want to go away but I gotta wait out this user who's ho=
lding
> > onto my tuning knob file". So, kernfs exposes a revoke or severing sema=
ntics
> > something that's exposing interface through kernfs wants to stop doing =
so.
> >
> > If you look at it from file operation implementation POV, this seems ex=
actly
> > like ->release. All open files are shutdown and there won't be any futu=
re
> > operations. After all, revoke is forced closing of all fd's. So, for mo=
st
> > users, treating severing just like ->release is the right thing to do.
> >
> > The PSI file which caused this is a special case because it attaches
> > something to its kernfs file which outlives the severing operation bypa=
ssing
> > kernfs infra. A more complete way to fix this would be supporting the
> > required behavior from kernfs side, so that the PSI file operates on ke=
rnfs
> > interface which knows the severing event and detaches properly. That sa=
id,
> > currently, this is very much an one-off.
> >
> > Suren, if you're interested, it might make sense to pipe poll through k=
ernfs
> > properly so that it has its kernfs operation and kernfs can sever it. T=
hat
> > said, as this is a fix for something which is currently causing crashes=
,
> > it'd be better to merge this simpler fix first no matter what.
>
> I'm happy to implement the right fix if you go into more details.
> AFAIKT kernfs_ops already has poll() operation, we are hooking
> cgroup_file_poll() to it and using kernfs_generic_poll(). I thought
> this is the right way to pipe poll through kernfs but if that's
> incorrect, please let me know. I'm happy to fix that.

Ah, sorry, for PSI we are not using kernfs_generic_poll(), so my claim
misrepresents the situation. Let me look into how
kernfs_generic_poll() is implemented and maybe I can find a better
solution for PSI.
Thanks,
Suren.

> Thanks,
> Suren.
>
> >
> > Thanks.
>
> >
> > --
> > tejun
