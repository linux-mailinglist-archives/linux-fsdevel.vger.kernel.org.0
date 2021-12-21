Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640647C650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhLUSUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbhLUSUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:20:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15093C06173F
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 10:20:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so55384842edd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKR0oGhdwDiMPz4S3RLSWot9z0K8O/O76m6YKus1B8k=;
        b=M/LLHLW9L8aMGHfWKPPMyQiCPWO5vJYDCklHLamES2SVq/PsrxRMNrHW3PUoAxV97O
         OGYasdt+65MvCQMB+KP0+mt+1iTaUIpM/X0t7W/vZoiLT/IUgpjWt4BfWdq4492pwEe3
         q9u9bEN8sLwt+eywsvLHb3AEo//KdDVwrNCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKR0oGhdwDiMPz4S3RLSWot9z0K8O/O76m6YKus1B8k=;
        b=fvcz3Dqx+Lq4s7RDu8sGpexSNichwDOEA7BR4CAXrLr96flBMTyBVfgsEt1c9h1akk
         5Fsbw6efhaK0QDMpnZ0i3Gk8R6RJvREUZalL9zrnA6XvoN+mNzUe5nLwdm3LiQDJgu8f
         L0Bq8gx1nbYzQD8aQ/uoHc6uW3Yj0YSVUGwQi6SbSyuu1sijeitQlc/hUnpsHA6Zi5W9
         zrK7znA+afQ6GoKq7VPFpoYOz1VhJAuwlUkk1ObbW31BfSOQalXLj4SR7IWly3OvHiJE
         8aFMultAPqFeBKeO9lcCcV0+UWP+fiMcB/SWFBeHNutpAjn4NEtoAETj+3dF8DHngH8W
         4q9g==
X-Gm-Message-State: AOAM5304XrTdvCX/QV9dPl279VVd5WU389YpQFnAwfY21KzFlA5OOrAB
        Ph++K+axTaqf5oJHqvp34stXpTbVxF8IQWdU1WI=
X-Google-Smtp-Source: ABdhPJyQULEths73guAaNqQfqrDo7U6HLYzp5UM0ch0HAdLbdhBQLn/5lIs2OmaTlCsgDln8MHxM/g==
X-Received: by 2002:a05:6402:1650:: with SMTP id s16mr4529943edx.193.1640110803931;
        Tue, 21 Dec 2021 10:20:03 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ck14sm4318694edb.5.2021.12.21.10.20.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:20:02 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso19467wmf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 10:20:02 -0800 (PST)
X-Received: by 2002:a1c:7312:: with SMTP id d18mr3851982wmb.8.1640110802139;
 Tue, 21 Dec 2021 10:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20211221021744.864115-1-longman@redhat.com> <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com> <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
In-Reply-To: <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 10:19:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
Message-ID: <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
To:     Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:01 AM Waiman Long <longman@redhat.com> wrote:
>
> Default RLIMIT_CORE to 0 will likely mitigate this vulnerability.
> However, there are still some userspace impacts as existing behavior
> will be modified. For instance, we may need to modify su to restore a
> proper value for RLIMIT_CORE after successful authentication.

We had a "clever" idea for this that I thought people were ok with.

It's been some time since this came up, but iirc the notion was to
instead of setting the rlimit to zero (which makes it really hard to
restore afterwards, because you don't know what the restored value
would be, so you are dependent on user space doing it), we just never
reset set_dumpable() when we execve.

So any suid exec will do set_dumpable() to suid_dumpable, and exec'ing
something else does nothing at all - it stays non-dumpable (obviously
"non-dumpable" here depends on the actual value for "suid_dumpable" -
you can enable suid dump debugging manually).

And instead, we say that operations like "setsid()" that start a new
session - *those* are the ones that enable core dumping again. Or
doing things like a "ulimit(RLIMIT_CORE)" (which clearly implies "I
want core-dumps").

Those will all very naturally make "login" and friends work correctly,
while keeping core-dumps disabled for some suid situation that doesn't
explicitly set up a new context.

I think the basic problem with the traditional UNIX model of "suid
exec doesn't core dump" is that the "enter non-core-dump" is a nice
clear "your privileges changed".

But then the "exit non-core-dump" thing is an exec that *doesn't*
change privileges. That's the odd and crazy part: you just disabled
core-dumps because there was a privilege level change, and then you
enable core-dumps again because there *wasn't* a privilege change -
even if you're still at those elevated privileges.

Now, this is clearly not a Linux issue - we're just doing what others
have been doing too. But I think we should just admit that "what
others have been doing" is simply broken.

And yes, some odd situation migth be broken by this kind of change,
but I think this kind of "the old model was broken" may simply require
that. I suspect we can find a solution that fixes all the regular
cases.

Hmm?

               Linus
