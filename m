Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010C417BBAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 12:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFLaK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Mar 2020 06:30:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44732 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFLaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:30:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id f198so1889167qke.11;
        Fri, 06 Mar 2020 03:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nna0nsguv2U+v9ziNQRL80k09HbQlLvP1j4KtjoAo7M=;
        b=P7EcwBcK7dx8cF79C9pN3P6os2Z3YL6AU/wh0wx1LLH1l78jY4kiL53d5woVTM5qNl
         zOzIhESzoLvN1T5kdKAfTD6rEiWYYQmj+xeoVvPw7HKmTpokbVUhNvpt/vCeC++Y0PcH
         wHOg/i20WypsCUUFgbqe6UFtxftO/ptP3eLWTbAjYWfrB/oSVIeVXeKCRK/Mq3AiPiwG
         k4Z1KVUXJK31T5j3cxAUY4fkAhBuFMhJ9kQquP2yjt/XYVvIHr687XaoKLW7wJ1X81a6
         3WHz4RRRyGYR3Cz2V8fxrqB+uhS0usmz1JcTQn6297qOtrPwKhMR0BC3oFg/fOhY8eh/
         o9wg==
X-Gm-Message-State: ANhLgQ2znZ8XFgc+mygHmuNsTYQFfSoyz/gjmjdDUHVshFUUVC/DZaxY
        LOX4AjZ68l09qOI7Cmd7s9HwHNWz9Jum35wfD7Q=
X-Google-Smtp-Source: ADFU+vsdbMUXZ/9+PsZX4vmn+uiZw3tJKm/S0yTnSyg72ZSBwF9YNhD0HM8bKgqMu40FTOyith2U60eZc5tP18laC8U=
X-Received: by 2002:a37:6646:: with SMTP id a67mr2383615qkc.457.1583494209166;
 Fri, 06 Mar 2020 03:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20200306080905.173466-1-syq@debian.org> <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
In-Reply-To: <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
From:   YunQiang Su <syq@debian.org>
Date:   Fri, 6 Mar 2020 19:29:57 +0800
Message-ID: <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Florian Weimer <fw@deneb.enyo.de>, torvalds@linux-foundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> 于2020年3月6日周五 下午7:13写道：
>
> Le 06/03/2020 à 09:37, Florian Weimer a écrit :
> > * Laurent Vivier:
> >
> >> Le 06/03/2020 à 09:13, Florian Weimer a écrit :
> >>> * YunQiang Su:
> >>>
> >>>> +  if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> >>>> +          flags |= AT_FLAGS_PRESERVE_ARGV0;
> >>>> +  NEW_AUX_ENT(AT_FLAGS, flags);
> >>>
> >>> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
> >>> separate AT_ tag dedicated to binfmt_misc.
> >>
> >> Not necessary, but it seemed simpler and cleaner to re-use a flag that
> >> is marked as unused and with a name matching the new role. It avoids to
> >> patch other packages (like glibc) to add it as it is already defined.
> >
> > You still need to define AT_FLAGS_PRESERVE_ARGV0.  At that point, you
> > might as well define AT_BINFMT and AT_BINFMT_PRESERVE_ARGV0.
> >
>
> Yes, you're right.
>
> But is there any reason to not reuse AT_FLAGS?

AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
   /* AT_* values 18 through 22 are reserved */
   27,28,29,30 are not used now.
Which should we use?

>
> Thanks,
> Laurent
