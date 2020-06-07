Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1A1F0D2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFGQhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:37:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54698C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2020 09:37:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so15853269ljm.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2020 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXd1D478P4SNq4RE8o4BF66Z33QidHeZFXik7VjM730=;
        b=W+WavM/Q4g1r7QpDGscIj1K4HsPcCtXjCr239DLBu5DURS8jE72otmlkWcQN9NjSj1
         SWpy1ih6gLF5LjUNCSFUMQuTEtCbzh/l+4WFpz+vgjC3Bk5zMrnKyVg2tX8TRQLWUy51
         4PhiIER9DTFk5NgUQjepDvbJFOnGkOYYAQCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXd1D478P4SNq4RE8o4BF66Z33QidHeZFXik7VjM730=;
        b=XrDr7QaRfmZr/wbF3II8h90fOV68ZqBhF49Fiv/5drqURfO8gwvylcfqwX9JElT1t4
         KJBxyy/IAAAuWTJlnLVWbNl4nUxOtt/z/3SKatk7rLXRqs3icVq2hXAn61Cv9agD98/j
         qA2FUIqcjqEEbnVhEAAbbohzUnPHjzcpH95NEYX1Wob6MiIl2GhvRCn4cA1PXUWWCNiB
         sUBqvizQkUin6UxsT7P2csPloOdPz7qy9jIGXP2yf4nin6p9ir+el3kB7ASmDqsuiBON
         JvafepyYcipJPldmC0v+n/J5r6/au4xkiIe4SMuDu5XNxZPYHJGjKMIbxYoSyiUypFMv
         m1Ag==
X-Gm-Message-State: AOAM5318FmS8SyB2dhR2vh+BiiiO02oQ+QYnP+s3O/JzAO6zXlfxqyEp
        r419fnGSrAoxN9JteUsq//Og2x0qTFk=
X-Google-Smtp-Source: ABdhPJxBYCroyoXKPmcikJCDigiWFTco1Y1DuOtrsszFwSypSeMISdvoDvRlfG0K+iWBfQyk5+wAQQ==
X-Received: by 2002:a2e:8747:: with SMTP id q7mr8487889ljj.459.1591547858353;
        Sun, 07 Jun 2020 09:37:38 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s20sm3485317ljs.36.2020.06.07.09.37.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x27so8724581lfg.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr10598957lfn.10.1591547857000;
 Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com> <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
In-Reply-To: <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jun 2020 09:37:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
Message-ID: <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 7, 2020 at 6:22 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Yes, I did think about that, but I thought this was the more obviously
> correct approach, and that in practice one only sees the 0X44 and 0X55
> cases.

I'm not sure about that - it probably depends on your umask.

Because I see a lot of -rw-rw-r--. in my home directory, and it looks
like I have a umask of 0002.

That's just the Fedora default, I think. Looking at /etc/bashrc, it does

    if [ $UID -gt 199 ] && [ "`/usr/bin/id -gn`" = "`/usr/bin/id -un`" ]; then
       umask 002
    else
       umask 022
    fi

iow, if you have the same user-name and group name, then umask is 002
by default for regular users.

Honestly, I'm not sure why Fedora has that "each user has its own
group" thing, but it's at least one common setup.

So I think that the system you are looking at just happens to have
umask 0022, which is traditional when you have just a 'user' group.

> That will kinda work, except you do that mask &= MAY_RWX before
> check_acl(), which cares about MAY_NOT_BLOCK and who knows what other bits.

Good catch.

> Perhaps this? As a whole function, I think that's a bit easier for
> brain-storming. It's your patch, just with that rwx thing used instead
> of mask, except for the call to check_acl().

Looks fine to me. Once we have to have rwx/mask separate, I'm not sure
it's worth having that early masking at all (didn't check what the
register pressure is over that "check_acl()" call, but at least it is
fairly easy to follow along.

Send me a patch with commit message etc, and I'll apply it.

               Linus
