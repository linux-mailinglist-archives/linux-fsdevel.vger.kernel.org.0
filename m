Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAA434CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJTN6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTN6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:58:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040EC06161C;
        Wed, 20 Oct 2021 06:56:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i20so26060100edj.10;
        Wed, 20 Oct 2021 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCdZv2e62ABN56MTTs5oGH5NMRs9ClTsnNTNWpGbnRI=;
        b=EWbY5Dviy2DZHiyOZzbGQdERHZ5KvL4s7Ss6sUG1m1LFp1YBswM4l3xWhZJ9KBIXSa
         ZbE/ZcVpj+Bu+ITXVL5JPqRYFCmU9nCrxOYYoWxLI32qSHR71pakJpYF6ecm6HpJ8S70
         spltE1Vt266lFklnDyfGnTEj8Qc9UxcyrXaPDzp6R+9fYcHPoSYV3HxebnPniplf2W+F
         HJLBY27lOXxAM/Z129If7+XZHN0TkB5WppNubldHfisAQ2zeMTshWl8NUaqMHWlfbBF5
         cPdCCdFHumG1gwhRrNh0fg6vxxpiNwxd6ZVCjff13eVd8dfT0ZYG8iuysKU1jAa5h1TZ
         eyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCdZv2e62ABN56MTTs5oGH5NMRs9ClTsnNTNWpGbnRI=;
        b=Wn9hQhnQtX4uCqcrwgaYsKSMF49hUwyfUcF4i2ynf840jd2z3pgb8WQmP1+u00OYYT
         slo/eWA1v/44lm4uur+Li9k06s+sf0WlTLNpR8JuqMLBx3WiTgPCZj0cN2YHsXfbXFcu
         eo0HATmUDAUhpnyL/55Ey89+qU/Pzlj0vpOxKR7QcccbI5GKhvDnkAkropLY/hsVYjrj
         lyc4b5cGoM2RCPbTnDc1wNebdNl2x8tTbQqBiFXTHlTiqT0G0RHOZFhZI2CzLAlzsu3M
         o5uCEAmGIPZznQoebPds/sS5nmybdrODEJ5LvlWWy43M/APuQl1DIazISbZy98jcsTOk
         UqHQ==
X-Gm-Message-State: AOAM532kX86A2UFc18caMCManMtdHyXm9ObrvAT2w0Xa6Q+ocGRFZRjV
        Jho3SuZlSGmfV5DCoF6x/Q9xRE8fogEsFPf2j10EVdyE9u9yeA==
X-Google-Smtp-Source: ABdhPJyFR5arm+ejse92keU//979Z9636AyxL7WCQcldmVzN3fnBF5ek60aXn5jd8eDKIfCmlUL+lgszFqWqOr01MYM=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr218009edc.106.1634738074303;
 Wed, 20 Oct 2021 06:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211018114712.9802-1-mhocko@kernel.org> <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan> <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan> <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
In-Reply-To: <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 20 Oct 2021 15:54:23 +0200
Message-ID: <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > >
> > I think adding kind of schedule() will not make things worse and in corner
> > cases could prevent a power drain by CPU. It is important for mobile devices.
>
> I suspect you mean schedule_timeout here? Or cond_resched? I went with a
> later for now, I do not have a good idea for how to long to sleep here.
> I am more than happy to change to to a sleep though.
>
cond_resched() reschedules only if TIF_NEED_RESCHED is raised what is not good
here. Because in our case we know that we definitely would like to
take a breath. Therefore
invoking the schedule() is more suitable here. It will give a CPU time
to another waiting
process(if exists) in any case putting the "current" one to the tail.

As for adding a delay. I am not sure about for how long to delay or i
would say i do not
see a good explanation why for example we delay for 10 milliseconds or so.

> > As for vmap space, it can be that a user specifies a short range that does
> > not contain any free area. In that case we might never return back to a caller.
>
> This is to be expected. The caller cannot fail and if it would be
> looping around vmalloc it wouldn't return anyway.
>
> > Maybe add a good comment something like: think what you do when deal with the
> > __vmalloc_node_range() and __GFP_NOFAIL?
>
> We have a generic documentation for gfp flags and __GFP_NOFAIL is
> docuemented to "The allocation could block indefinitely but will never
> return with failure." We are discussing improvements for the generic
> documentation in another thread [1] and we will likely extend it so I
> suspect we do not have to repeat drawbacks here again.
>
> [1] http://lkml.kernel.org/r/163184741778.29351.16920832234899124642.stgit@noble.brown
>
> Anyway the gfp mask description and constrains for vmalloc are not
> documented. I will add a new patch to fill that gap and send it as a
> reply to this one
>
This is really good. People should be prepared for a case when it
never returns back
to a caller :)

-- 
Uladzislau Rezki
