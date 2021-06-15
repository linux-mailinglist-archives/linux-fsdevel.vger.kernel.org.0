Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE33A8BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFOWhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 18:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFOWhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:37:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239BAC061574;
        Tue, 15 Jun 2021 15:35:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g22so317658pgk.1;
        Tue, 15 Jun 2021 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vchL1M+HPGlNWBtVdvON9ynumPv6rYV8n+FcAt7BSyA=;
        b=Y36LJfDYZimfsaEIJSAnjzvd5PzCSteXiNeZu4xHAe9dVcaNbCDWM6h8tpkDEGwAMJ
         e2OrXqX/s8sNA4rA8OLWCHJ3AvxB07ac6DiQFHolLCjEymo+sz93ZPfJPBjTyYfDXdMz
         RfWYuas3W0hJ4W/k73As6CeZPty0EFXUJOTV2dM1hkuYZN2sjNHHsGGEMxfu578G4aPK
         o/Kb8w4tpRiJhMKxFptv/ZYgpdVq5Sj5+NltRiY853RrE30h8UyqF6x4feMDDL9wxV0U
         liiFLHkuGty5X80IestebJ1knyj3aiV2p9RkJHbMWonefNAHEDpa2ATCaczEKhudOe5i
         Oo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vchL1M+HPGlNWBtVdvON9ynumPv6rYV8n+FcAt7BSyA=;
        b=mX4tttdcPTsx6quahJU5/Sn9+kSqNqKQ3qs9zFj2+0cJMKU3a+amsG14XOHaMK13MR
         aCQ+co3Or/JRd9WBiUidpO5E1yIJ7fuZubkZBw4r8aG+WuU1b+uHBRPgjxCjOeImumUy
         q0hQcS3k3n1NfvSDqQHCmunwWxj2VVcWQWC9388+XFK0Ss4iJCfb93yrAR4H7Oj7KH0h
         PSN4Gv+XrMTARbnq84RMHrlI5Xe5DcoXweSHztNJd+qaVkaYAB96Q601yccJjXJabrvR
         7mGBYyl+LA3kgFZzl91KHg0/0VrFJwKA6q/ZRBeSlVHSZc2vKY0qObJhbcbk7yhq/5Ar
         N7kQ==
X-Gm-Message-State: AOAM530K85uS3B4LWcJgQd8D7kX3Q/L+IKgIZvnbQH4ONX2vB+yvnOz7
        5Hx8L9CKxmje14zptGrSM1RhhDp3JmXubq/Ndrk=
X-Google-Smtp-Source: ABdhPJzSI6OWPxJl2kB/pEnDW5w6zJpXHaOqPtWJu7uNObfM5CXccVmIq4Jy4DzYxBgOP8+pDY4NzBrkUY5MBSNxfQE=
X-Received: by 2002:a63:e245:: with SMTP id y5mr1735817pgj.171.1623796525390;
 Tue, 15 Jun 2021 15:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210615162346.16032-1-avagin@gmail.com> <877diuq5xb.fsf@disp2133>
In-Reply-To: <877diuq5xb.fsf@disp2133>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 15 Jun 2021 15:35:14 -0700
Message-ID: <CANaxB-zVMxxvt8c1XNKfy6-hAUoodxp=ChJpP_Rn5cTD=26p9w@mail.gmail.com>
Subject: Re: [PATCH] exec/binfmt_script: trip zero bytes from the buffer
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:33 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Andrei Vagin <avagin@gmail.com> writes:
>
> > Without this fix, if we try to run a script that contains only the
> > interpreter line, the interpreter is executed with one extra empty
> > argument.
> >
> > The code is written so that i_end has to be set to the end of valuable
> > data in the buffer.
>
> Out of curiosity how did you spot this change in behavior?

gVisor tests started failing with this change:
https://github.com/google/gvisor/blob/5e05950c1c520724e2e03963850868befb95efeb/test/syscalls/linux/exec.cc#L307

We run these tests on Ubuntu 20.04 and this is the reason why we
caught this issue just a few days ago.

>
> > Fixes: ccbb18b67323 ("exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC")
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  fs/binfmt_script.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> > index 1b6625e95958..e242680f96e1 100644
> > --- a/fs/binfmt_script.c
> > +++ b/fs/binfmt_script.c
> > @@ -68,6 +68,9 @@ static int load_script(struct linux_binprm *bprm)
> >               if (!next_terminator(i_end, buf_end))
> >                       return -ENOEXEC;
> >               i_end = buf_end;
> > +             /* Trim zero bytes from i_end */
> > +             while (i_end[-1] == 0)
> > +                     i_end--;
> >       }
> >       /* Trim any trailing spaces/tabs from i_end */
> >       while (spacetab(i_end[-1]))
