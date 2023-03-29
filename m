Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B236CF17B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjC2RyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2RyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:54:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6BE102
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 10:54:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g19so8171669lfr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680112455; x=1682704455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7r474dcwAeSgzFtA0e++9lGH7M7F1P88vLQKvQsNGk=;
        b=BvTNLj+T6CPVNp/B17LSyz/YfoU50UfKpT8APVBjmijPPh3VFYJahkylhYlXnIk43Q
         6cHt3gQeVzUk7wTQWXdZeGFnVOKnYd453W3FNjOL5XfQEuLFXvXlYTMUAZ5EpIpxIBlJ
         fDaArvKVjDUgumVb53IEDTLBhZF/oeW78YWaRHFI5pwZKEa4We2ErPZ+LoZ0Vjz940T4
         kAjtBW6zReQwLO4VHR+jS19ef74AzyxOc/ftH5A2C/bKM4D032qE+SsBgljcY9ntOfTG
         pQB7E7k/+is01eN8PhehbkJfo6KvAgVDatZr6icaCIHo2jo2atZLkR6NMRTtgmyzKRGJ
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112455; x=1682704455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7r474dcwAeSgzFtA0e++9lGH7M7F1P88vLQKvQsNGk=;
        b=m/FQjcBTAP1jxn/sshz1u7MI8/ITDfN9RaM/IA2bY0hyEO8QwwUQQ2mdxl+3uoQtDA
         mdAoE1Qm1BTApJ44LD7j0kI4xPqhr/dkgJBlka31sU3KMJXpjLWc7GUkQXDR6UYrw90I
         Bs0NqzRy7cZK21XDQzOAdKqDalOBpRawJAeuGMbIxfDU87FH3qKWUxUjwhUe03S6ZpsP
         izLyR0Zn7Y4ned3NA76Quhc2WZYo3ssWzaory+9LnVeTNMJIw+kH1yMyhFNRw7+3LbEh
         4e8KHOFEkDaeIxPQJknqi3ma2BPKWE/RIJ4QACIeYtnKrO/4MD1SZThVl4KJ3rxuifH3
         W7Ww==
X-Gm-Message-State: AAQBX9c+etwR7sAsu2xz4VI2pra53YUgfCFpO3/zweL3pefiCBoZ42In
        uXOecdasFtNDnjTx1rwBgpQvIjvP3Aix7PD5fZI2rKLRNqi6Y/ZBfg0=
X-Google-Smtp-Source: AKy350ZSPh9VmsS6Q/pJBKAbtq5YPvsyHXlILYzOrNSc83L8rkC9PnnTNtcUV7vNWn5zQpAe0CB+yJLGOmLk+fmAX+o=
X-Received: by 2002:ac2:55a2:0:b0:4ea:f9d4:93a1 with SMTP id
 y2-20020ac255a2000000b004eaf9d493a1mr6037484lfg.10.1680112455212; Wed, 29 Mar
 2023 10:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n> <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n> <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
 <ZCNPFDK0vmzyGIHb@x1n> <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
 <ZCNrWRKl4nCJX3pg@x1n>
In-Reply-To: <ZCNrWRKl4nCJX3pg@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 29 Mar 2023 10:53:38 -0700
Message-ID: <CAJHvVch52KG3V6eQY47t2hbJfEczdLgxcg65VWZdzML6bVFXeg@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 3:34=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Mar 28, 2023 at 02:52:35PM -0700, Axel Rasmussen wrote:
> > I don't see being very strict here as useful. Another example might be
> > madvise() - for example trying to MADV_PAGEOUT on a kernel that
> > doesn't support it. There is no way the kernel can proceed here, since
> > it simply doesn't know how to do what you're asking for. In this case
> > an error makes sense.
>
> IMHO, PAGEOUT is not a great example.  I wished we can have a way to prob=
e
> what madvise() the system supports, and I know many people wanted that to=
o.
> I even had a feeling that we'll have it some day.
>
> So now I'm going back to look at this patch assuming I'm reviewing it, I'=
m
> still not convinced the old API needs changing.
>
> Userfaultfd allows probing with features=3D0 with/without this patch, so =
I
> see this patch as something that doesn't bring a direct functional benefi=
t,

The benefit is we combine probing for features and creating a
userfaultfd into a single step, so userspace doesn't have to open +
manipulate a userfaultfd twice. In my mind, both approaches achieve
the same thing, it's just that one requires extra steps to get there.

To me, it's still unclear why there is any harm in supporting the
simpler way? And, I also don't see any way in which the more complex
way is better?

> but some kind of api change due to subjective preferences which I cannot
> say right or wrong.  Now the patch is already merged.  If we need to chan=
ge
> either this patch or the man page to make them match again, again I'd
> prefer we simply revert it to keep everything like before and copy stable=
.

I think we need to change documentation either way. But, I think the
changes needed are actually bigger if we want to revert.

With the simpler behavior, the selftest and the example program in the
man page are ~correct as-is; otherwise we would need to modify those
to use the two-step probing method.

(By the way, I am excited about the selftest refactoring you talked
about! Thanks for doing that work. It definitely needs it, the
complexity there has gotten significantly worse as we've added more
things onto it [wp, minor faults].)

I think the man page description of how to use the API is incomplete
in either case. Right now it sort of alludes to the fact that you can
probe with features=3D=3D0, but it doesn't explicitly say "you need to
probe first, then close that userfaultfd and open the real one you
want to use, with a subset of the features reported in the first
step". If we want to keep the old behavior, it should be more explicit
about the steps needed to get a userfaultfd.

You are right that it also doesn't describe "you can just ask for what
you want, and the kernel tells you what subset it can give you; you
need to check that the reported features are acceptable" - the new
behavior. That should be updated.

>
> Thanks,
>
> --
> Peter Xu
>
