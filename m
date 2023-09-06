Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEE79424A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbjIFRxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbjIFRxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:53:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C0BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:53:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso7235e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694022815; x=1694627615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GItvzZBrWu32ylbui0Mu9MqN0Zvfi9d46znV9XBqxIM=;
        b=v1CuGagZm/Ulpz9n/dpOtd2MCgdS8tUByoZoawhcJ6IytEgChJ862f01Wqvvibk6FG
         hr+NCCnd0wVo2YOaxvgtrtqq9u25CVFS+MJ0tstS5TGo3YLDcXIC0si66aWr3QIUjtoL
         zONvvvOYZ63kMslWlDmy9xjnpCr2vi0nz8NMC8C/a2uFpLXVHoAXp2HgGNKt/FTul1du
         k4GqL2ycz2UqL6Ysws8V3jxhwNtSwXNfnHw4CZK8w7FPuSUeXWByXvCJffv069V76t7r
         mW7stbZm3S/srNhrtLfZtbeB0ptq9+pbl7HvzVHUp1LxgBjzvcfgrcVxhW2cqDk6O3H2
         2A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022815; x=1694627615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GItvzZBrWu32ylbui0Mu9MqN0Zvfi9d46znV9XBqxIM=;
        b=dDTPKK0DTr64jvAPyHOb+AQnBMJw9laPdtxhWFFIy0kWmvdzDX3KcL8XtrotrSHvpy
         H4v1Ubp+eGAIgv50tHIK65kKGof6uZoeegz/TmVH3hUmcN3fz1tfIwzzp6ohXa4mK6wx
         266UeazSRV9RoK3FIJepSmGzQq4fqIZHI8Is6jWOMMhgy4hchM76uOYmJmfrZxhMBAWx
         n65ryvokYOwMXiZ/oFq4zyd3MOHu3Wg/aBeIs65i1rdVXL+u6or9Oj7b7uGLz6uXu1T5
         dZ91lGV8DfMO5VPyDNMS43OO9uO9jTW2rvkbsLaLcZU+HO/BCHdE9A2Km/Gl/XZJUpnA
         jFyw==
X-Gm-Message-State: AOJu0YzQXGPYKfPQnq+JeRco53Lg49EOHph8Zrr5VTdBxH10PRWIT97i
        p6TnMhfLfhq+waSFX72JLFaieAC3LWLM1mVn5eT6JA==
X-Google-Smtp-Source: AGHT+IGE+KRbKMdMCSUHfOxchGSX//3upfBW6z8FnI8Xd0ueFP0OnH3XRDlho/9C9hBrnYDsizqh/iPaU7AFTTHjiD0=
X-Received: by 2002:a05:600c:1d98:b0:3f4:fb7:48d4 with SMTP id
 p24-20020a05600c1d9800b003f40fb748d4mr5069wms.3.1694022814737; Wed, 06 Sep
 2023 10:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e6432a06046c96a5@google.com> <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f> <20230903180126.GL3390869@ZenIV>
 <CAGudoHHjnRct1jEAjNSHmmPt9u_y+tYhrb56uRKXez8DKydNaQ@mail.gmail.com>
 <20230903195155.GM3390869@ZenIV> <CAGudoHGJsKqDWtp-7SmM9FRni+xBY98odAROxOifFR-4PpmJWQ@mail.gmail.com>
In-Reply-To: <CAGudoHGJsKqDWtp-7SmM9FRni+xBY98odAROxOifFR-4PpmJWQ@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 6 Sep 2023 19:53:22 +0200
Message-ID: <CANp29Y7CVJveEgQQj8qq2eyvtkdYqvuJuqePVAR7oky14N2i2g@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 3, 2023 at 10:04=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On 9/3/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Sun, Sep 03, 2023 at 08:57:23PM +0200, Mateusz Guzik wrote:
> >
> >> This does not dump backtraces, just a list of tasks + some stats.
> >>
> >> The closest to useful here I found are 'w' ("Dumps tasks that are in
> >> uninterruptable (blocked) state.") and 'l' ("Shows a stack backtrace
> >> for all active CPUs."), both of which can miss the task which matters
> >> (e.g., stuck in a very much *interruptible* state with f_pos_lock
> >> held).
> >>
> >> Unless someone can point at a way to get all these stacks, I'm going
> >> to hack something up in the upcoming week, if only for immediate
> >> syzbot usage.
> >
> > Huh?  Sample of output here:
> > 2023-09-03T15:34:36.271833-04:00 duke kernel: [87367.574459] task:ssh-a=
gent
> >      state:S stack:0     pid:3949  ppid:3947   flags:0x
< .. >
> > 2023-09-03T15:34:36.457355-04:00 duke kernel: [87367.759981]  </TASK>
> >
> > Looks like a stack trace to me; seeing one of the callers of fdget_pos(=
)
> > in that would tell you who's currently holding *some* ->f_pos_lock.
> >
> > That - on 6.1.42, with fairly bland .config (minimal debugging;
> > I need that box for fast builds, among other things).  Enable
> > lockdep and you'll get who's holding which logs in addition
> > to those stack traces...
> >
>
> That's my bad, the only content which survived for me in terminal
> buffer was a spew for the scheduler and a ps-like task list.
> Stacktraces are indeed there. Sorry for the noise on this one. I
> verified stack dumps are not gated by any defines either btw, so it's
> all good on this front.
>
> All this brainos aside, I added Aleksandr Nogikh to To: in my previous
> e-mail. From short poking around I found he was responsive to some
> queries concerning Linux vs syzbot and I figured would a good person
> to ask.
>
> So, Aleksandr, tl;dr would it be a problem to add the 't' sysrq to
> syzbot in order to dump backtraces from all threads? Either break t
> over a serial port or t written to /proc/sysrq-trigger. Lack of this
> info blocks progress on the issue reported here
> (https://syzkaller.appspot.com/bug?extid=3De245f0516ee625aaa412)

That's a good suggestion, thanks!
I think it should be doable and would indeed simplify debugging of our
reports (even if not for this particular one, judging by the
conversation below :) ).

I've filed https://github.com/google/syzkaller/issues/4200

--=20
Aleksandr

>
> --
> Mateusz Guzik <mjguzik gmail.com>
>
