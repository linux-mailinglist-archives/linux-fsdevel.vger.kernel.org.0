Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0739456C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhE1Pzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbhE1Pzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 11:55:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4BC061763
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 08:54:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e24so5293554eds.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgRoFUGRATJe+d8KSXVyiLV5UyX1useCAnQIlrvAaWU=;
        b=TSht/y42/eGQLtb/KSdYcn4N3XmFXll94R1oB2MfApoaXw3sgup1BUAL8bFPptnNp1
         506mPb4KCAqcczfb4gyAYgHNbaFiTowloszPrFxC10pukgPD9TsBVa1ogMg/pt0GcUMT
         WS0rwDK/OKjyGJUeQmgD11ufp+b/bI1/z0GcQU13gWh9uzyNsvXCG+qHGb2bZeatOIPE
         ESqeyBp+Xs1/VOuIpz971XND8D3kjYaNUE8SN/xBOZEhe3+tztdp74dPdfm6fqekcduV
         fAtRYr9pMMX5CugO/b50XxX14rF5UEoo4Q8vcER/Ejhlf+EakgTyk3tbIJ2vJk0fS3cN
         DSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgRoFUGRATJe+d8KSXVyiLV5UyX1useCAnQIlrvAaWU=;
        b=CYJwMQrbk8UCvgrrNacMpSkm0nwmz+d11kDEIG/wacRg1m9YrMoEpWI3nDL8G7t9NG
         OQ9w+0gOCB/9fwDKmKwWLRydqoRuu9dYW+xK92gIUUCq8NZ6RpifjkxQ5bfHcsEgghCq
         juxKXT6cpe5pf+K/RlVVIMGJ5OqPvLjJ44zAMAzYFt1CmABTRv26dX4HJyJDxo0OwruN
         AXL6zJ7rzvhTvOAQ+HWuKoz3Lk304IkHGRzjwKUuW4ut4PHi53cKGAlxezU9yrTVW8mM
         eL6Ifm0oSaAjSzp+iVqAvzONXzKfd8XpFZeWETaGmfAm0IuUvz052NmRd1QRdAMLipOC
         KJBQ==
X-Gm-Message-State: AOAM532bkeQNwjCehM28/ZPY8UjreRiukoPwUbqDLWyoVLZn3KvEZLnV
        TPFlGmRw41NVY+pPkl12lKnfmn+qWFFA/9eHo8ur
X-Google-Smtp-Source: ABdhPJx9lDU4bz4ZRNuGWCmsj3KypbE5i42MpDU5uXKqoLBw/jwmLUnQhhD+lDAtTdyo/XHVCMcM3JWSpnl4Jqa5QKg=
X-Received: by 2002:a05:6402:35d4:: with SMTP id z20mr10534196edc.164.1622217256341;
 Fri, 28 May 2021 08:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <4fee8c12-194f-3f85-e28b-f7f24ab03c91@iogearbox.net>
 <CAFqZXNsKf5wSGmspEVEDrm4Ywar-F4kJWbBPBE+_hd1CGQ3jhg@mail.gmail.com> <17eaebd3-6389-8c80-38ed-dada9d087266@iogearbox.net>
In-Reply-To: <17eaebd3-6389-8c80-38ed-dada9d087266@iogearbox.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 May 2021 11:54:05 -0400
Message-ID: <CAHC9VhTuurjpkgq=cS5ZNwpxuuOq4E3eE2RuD+JaCQz6X0fk6g@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiri Olsa <jolsa@redhat.com>, andrii.nakryiko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 10:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 5/28/21 3:42 PM, Ondrej Mosnacek wrote:
> > (I'm off work today and plan to reply also to Paul's comments next
> > week, but for now let me at least share a couple quick thoughts on
> > Daniel's patch.)

Oooh, I sense some disagreement brewing :)

> > On Fri, May 28, 2021 at 11:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 5/28/21 9:09 AM, Daniel Borkmann wrote:
> >>> On 5/28/21 3:37 AM, Paul Moore wrote:
> >>>> On Mon, May 17, 2021 at 5:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> >> Ondrej / Paul / Jiri: at least for the BPF tracing case specifically (I haven't looked
> >> at the rest but it's also kind of independent), the attached fix should address both
> >> reported issues, please take a look & test.
> >
> > Thanks, I like this solution, although there are a few gotchas:
> >
> > 1. This patch creates a slight "regression" in that if someone flips
> > the Lockdown LSM into lockdown mode on runtime, existing (already
> > loaded) BPF programs will still be able to call the
> > confidentiality-breaching helpers, while before the lockdown would
> > apply also to them. Personally, I don't think it's a big deal (and I
> > bet there are other existing cases where some handle kept from before
> > lockdown could leak data), but I wanted to mention it in case someone
> > thinks the opposite.
>
> Yes, right, though this is nothing new either in the sense that there are
> plenty of other cases with security_locked_down() that operate this way
> e.g. take the open_kcore() for /proc/kcore access or the module_sig_check()
> for mod signatures just to pick some random ones, same approach where the
> enforcement is happen at open/load time.

Another, yes, this is not really a good thing to do.  Also, just
because there are other places that don't really do The Right Thing
doesn't mean that it is okay to also not do The Right Thing here.
It's basically the two-wrongs-don't-make-a-right issue applied to
kernel code.

-- 
paul moore
www.paul-moore.com
