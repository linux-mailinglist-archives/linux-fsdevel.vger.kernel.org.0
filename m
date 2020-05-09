Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9562D1CC468
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgEIUII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgEIUII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 16:08:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95398C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 13:08:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so4183427lfd.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDsZUXjsiQvBTwD4B5aSZNNtEwOJDWf1jYmy0/zS14Y=;
        b=WPsXnPQBGyK2C++rccv5Or4C/vXPwP21oG2KRmQ8V6fcspuR8XbQ+5r89R8PKmZfOF
         OUxu8eXSqHgIWypV16sewX14zsAgL4jY7RoV06dLY1M4OWHITNrYQ0wZpSJbXKu2f1cz
         vVVczp9RsCnFy9vDPFYs0H9UUc+JYWG7BNq9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDsZUXjsiQvBTwD4B5aSZNNtEwOJDWf1jYmy0/zS14Y=;
        b=Dv4CI1arhrYWv4ym5loWNcvLbtmXkNao22w+BGdDzvjvGjeUeMOflPtn34mc/91rVo
         wSHjnrvCwpi8PHpJujF38E5gMJ/lK2Wu5+wMsUvFfjQOp11AaSxCo2SJbFw8z3y8pbQR
         6/XDxvf+rsK6bBM4ZAE93HAIxOzZ39BPnFZwERRFtwuL56gToK6NiSJv3uUsXm5uMEyF
         9B/piYuLqu8chePrnIdyz2tB2qIJsdxBXingJ2IG+60UowLgI6OQI9BdP4VJrMl7Zufk
         a6UGlOhkLRnWiBpibIz72J/nGR3EYTjA7V7oJvaSfKPb9K/gLjB0Hc0T88G1vmpcfjx/
         hU3w==
X-Gm-Message-State: AOAM533dZFlGSItsW72nev9CcEEzMUDt/73ee/z58DV5cSFVlO3K4kUM
        ZdpCeUfz1LAlr/F8sIMQoUdf1kVUpjI=
X-Google-Smtp-Source: ABdhPJxuJss2KQiik6JEF+XxeLiummkW9hLgSwPXvgRq2SSUslkLOickvE+Wp0LNkqdoK25b1fopqg==
X-Received: by 2002:a19:7418:: with SMTP id v24mr5868509lfe.15.1589054885252;
        Sat, 09 May 2020 13:08:05 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y8sm4670244ljh.83.2020.05.09.13.08.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:08:04 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x73so4173514lfa.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 13:08:04 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr5945437lfh.30.1589054883772;
 Sat, 09 May 2020 13:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Message-ID: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 9, 2020 at 12:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Now that security_bprm_set_creds is no longer responsible for calling
> cap_bprm_set_creds, security_bprm_set_creds only does something for
> the primary file that is being executed (not any interpreters it may
> have).  Therefore call security_bprm_set_creds from __do_execve_file,
> instead of from prepare_binprm so that it is only called once, and
> remove the now unnecessary called_set_creds field of struct binprm.

Ahh, good, this patch removes the 'called_set_creds' logic from the
security subsystems.

So it does half of what I asked for: please also just rename that
"security_bprm_set_creds()" to be "security_primary_bprm_set_creds()"
so that the change of semantics also shows up that way.

And so that there is no confusion about the fact that
"cap_bprm_set_creds()" has absolutely nothing to do with
"security_bprm_set_creds()" any more.

             Linus
