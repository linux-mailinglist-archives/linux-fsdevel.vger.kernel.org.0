Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1743A256F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFJH1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 03:27:45 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45871 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhFJH1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:27:34 -0400
Received: by mail-pl1-f174.google.com with SMTP id 11so497444plk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jun 2021 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XcUEI16ALb5GgW+UVrUnX4fue34D+7ULda2k5ZCrDto=;
        b=D0HcA7G8j989gqeD2tAswToqZ3OjIVq76zLvL7qijhhQg39/8RZlnUBb73esda5GjC
         yj4dR+k3LBXcKPPbF/eD3aBkQX5l/2zOlqLu3RyGz/emk65OiYo/0aRK1SnULbDAUruy
         EPYelmmxCPOXSKngrCAyb1NuaKDucRGmkaMYfgC/ACXdRCcrQvBycDPto2g3xsrUxdwQ
         Cfj673pNZZRpN8BsC0NK4NzmZ4y2NMwOmaQVkzcp64+XSG7RrgclmJ51IkHO3p5aI8x1
         Nn/gBqJgJSz33b8vLkEigPx7GM5L+zZD3+l1iW8BjFOYaPu9x5wbXFwwPB/XQ68tfE+G
         pynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XcUEI16ALb5GgW+UVrUnX4fue34D+7ULda2k5ZCrDto=;
        b=G83Xd53Rtol/X+i5vAyEkWtJZz2Vo9ad+AUiGhhj08KtUKJZi+nJm1+9uH/kTjMIG/
         XSSxgj86HSjBTUSlZ6JjuZwSmMmkwKsbZq/GbaCfEsxUind6ts96HrPvf7EbvdwOn8IH
         bgYp4VSO7qEt+zKSSTATAzyY23IWN/mDdqz4x+l0B1yB9WXz1xIGLsF0Ls3Ov5MVnXgU
         qIvGrvVXaF6ApReAcXPs/JoQEYS8h3SA9dv8LnGILHfF3VAaXeeQLOc10i8moiyIlT1m
         ATMbmmlGk9UV/HxsUM+Bj6vCcRF36CtOD4Gzft12i3UCKUGN4IDDu0byxuMRJw7QpAoa
         Hy/Q==
X-Gm-Message-State: AOAM530q1esl16oVZ3rYEqUqNcehltcPqPxJeXd2kT0TQvRsEGRVzR5/
        bnMycGlbQJjDCnJBMCpcrIyCsQ==
X-Google-Smtp-Source: ABdhPJz+0izmsJQXZBosjTNVF6J95vSTI79mUoQ7YZWjPYsGyarATv8FQKlIhN/+px2k60pIRKoeyQ==
X-Received: by 2002:a17:90b:901:: with SMTP id bo1mr1991970pjb.0.1623309878331;
        Thu, 10 Jun 2021 00:24:38 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id g29sm1728468pgm.11.2021.06.10.00.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:24:37 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:24:25 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YMG+KQ6Cl+Vfk1rF@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com>
 <YMGyrJMwpvqU2kcr@google.com>
 <CAOQ4uxhV32Qbk=uyxNEhUkdqzqspib=5FY_J6N-0HdLizDEAXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhV32Qbk=uyxNEhUkdqzqspib=5FY_J6N-0HdLizDEAXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:11:51AM +0300, Amir Goldstein wrote:
> > > > +               ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> > > > +                                               buf, count);
> > > >                 if (ret < 0)
> > > > -                       return ret;
> > > > +                       goto out_close_fd;
> > >
> > > This looks like a bug in upstream.
> >
> > Yes, I'm glad this was picked up and I was actually wondering why it was
> > acceptable to directly return without jumping to the out_close_fd label in
> > the case of an error. I felt like it may have been a burden to raise the
> > question in the first place because I thought that this got picked up in
> > the review already and there was a good reason for having it, despite not
> > really making much sense.
> >
> > > It should have been goto out_close_fd to begin with.
> > > We did already copy metadata.fd to user, but the read() call
> > > returns an error.
> > > You should probably fix it before the refactoring patch, so it
> > > can be applied to stable kernels.
> >
> > Sure, I will send through a patch fixing this before submitting the next
> > version of this series though. How do I tag the patch so that it's picked
> > up an back ported accordingly?
> >
> 
> The best option, in case this is a regression (it probably is)
> is the Fixes: tag which is both a clear indication for stale
> candidate patch tells the bots exactly which stable kernel the
> patch should be applied to.
> 
> Otherwise, you can Cc: stable (see examples in git)
> and generally any commit title with the right keywords
> 'fix' 'regression' 'bug' should be caught but the stable AI bots.

Ah, OK, noted.

> > > >         }
> > > >
> > > >         return metadata.event_len;
> > > > @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >                 put_unused_fd(fd);
> > > >                 fput(f);
> > > >         }
> > > > +
> > > > +       if (pidfd < 0)
> > >
> > > That condition is reversed.
> > > We do not seem to have any test coverage for this error handling
> > > Not so surprising that upstream had a bug...
> >
> > Sorry Amir, I don't quite understand what you mean by "That condition is
> > reversed". Presumably you're referring to the fd != FAN_NOFD check and not
> > pidfd < 0 here.
> >
> 
> IDGI, why is the init/cleanup code not as simple as
> 
>     int pidfd = FAN_NOPIDFD;
> ...
> out_close_fd:
> ...
>        if (pidfd >= 0)
>                  put_unused_fd(fd);

You're missing nothing, it's me that's missing a few brain cells. Sorry,
the context switching on my end is real and I had overlooked what you
meant. But yes, this will most definitely work.

/M
