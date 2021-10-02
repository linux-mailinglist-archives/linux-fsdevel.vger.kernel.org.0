Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06F141F9E8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 07:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJBFMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 01:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhJBFMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 01:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633151430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2llZTC7o2LsdAZtu4bkMyBA1hnJDlag5HFNAp4HjTvs=;
        b=NXeGpibP2mxrX4Cwn4MN18abygu8o34y5gTwj5WPbzqlIFCK3jD7EogC9IA3gIFdP80JwB
        ZTOAx04VTgmWhJnyHsYqrArRboy6kZwvYJR3pTbJduZikGKay4K8F4HVp6OTpoPeAfgYvI
        2l9baG0p0KW0pTj9FOJSNWuCqArsAl4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-k9wOjSiPOz2ZMvhJlPUJqw-1; Sat, 02 Oct 2021 01:10:29 -0400
X-MC-Unique: k9wOjSiPOz2ZMvhJlPUJqw-1
Received: by mail-oi1-f197.google.com with SMTP id i6-20020a056808030600b00276175dd3b9so7642836oie.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 22:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2llZTC7o2LsdAZtu4bkMyBA1hnJDlag5HFNAp4HjTvs=;
        b=x5isaM/gxIeGDmwD94MEl6kJo4XKWBITVSA7romFDQCNE6TFMxqHLoaQk8kcoBXKUa
         My9gSldlsHx3suBWItAHgKXDDMbfh6cfsPRzEBzekmo69y1eGtgrTP9Q6moMTdvK44Q8
         WK11WAixKVaWtCIvCCO9kpJ5XtVsEtYrSzTbSrPsEDpfO2AVEbI2HZO9p9HNbdaZZKcM
         S5X6ItARuNYH0QH6VoWBvCOoRflRbPXjO6NmfchnmqQzR1lWJmab9OExuD5rLViTidTu
         5sbDGCZdM6t2/YvKKxfGaJCHNAoiHvsTW5hbsZwQLFOJcHDCgGR3WDzhOuX30pYEnxKm
         G8GQ==
X-Gm-Message-State: AOAM530uTo14GtTaY7khEalUyHpeit3932Sl9V+qnDRAU6g2vnjs7GKl
        jFO5iagkEbgTm+3gJvmlKcKho6iQ+W56LTjAXkGdM6JuuF7p0HtTBwwRd4B2AppCmK0vmJUEMq+
        3Mj42+BsHItwMIoKtAjXfeeJaMw==
X-Received: by 2002:a05:6820:548:: with SMTP id n8mr1494790ooj.2.1633151428318;
        Fri, 01 Oct 2021 22:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMZBKsU0l2A3zI3qrE5E96ZbV26roVRCXpLzW4En0hQYpxaJDCLcDEsPcOAys9BDWAL5EOCA==
X-Received: by 2002:a05:6820:548:: with SMTP id n8mr1494777ooj.2.1633151427993;
        Fri, 01 Oct 2021 22:10:27 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id q2sm1579594ooe.12.2021.10.01.22.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 22:10:27 -0700 (PDT)
Date:   Fri, 1 Oct 2021 22:10:24 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org, live-patching@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20211002051024.bddvcr44eb4zuoxk@treble>
References: <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
 <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
 <20210929103730.GC33284@C02TD0UTHF1T.local>
 <YVRRWzXqhMIpwelm@hirez.programming.kicks-ass.net>
 <20210930192638.xwemcsohivoynwx3@treble>
 <20211001122706.GA66786@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211001122706.GA66786@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 01:27:06PM +0100, Mark Rutland wrote:
> > So we may need to get rid of .fixup altogether.  Especially for arches
> > which support livepatch.
> > 
> > We can replace some of the custom .fixup handlers with generic handlers
> > like x86 does, which do the fixup work in exception context.  This
> > generally works better for more generic work like putting an error code
> > in a certain register and resuming execution at the subsequent
> > instruction.
> 
> I reckon even ignoring the unwind problems this'd be a good thing since
> it'd save on redundant copies of the fixup logic that happen to be
> identical, and the common cases like uaccess all fall into this shape.
> 
> As for how to do that, in the past Peter and I had come up with some
> assembler trickery to get the name of the error code register encoded
> into the extable info:
> 
>   https://lore.kernel.org/lkml/20170207111011.GB28790@leverpostej/
>   https://lore.kernel.org/lkml/20170207160300.GB26173@leverpostej/
>   https://lore.kernel.org/lkml/20170208091250.GT6515@twins.programming.kicks-ass.net/
>
> ... but maybe that's already solved on x86 in a different way?

That's really cool :-) But it might be overkill for x86's needs.  For
the exceptions which rely on handlers rather than anonymous .fixup code,
the register assumptions are hard-coded in the assembler constraints.  I
think that works well enough.

> > However a lot of the .fixup code is rather custom and doesn't
> > necessarily work well with that model.
> 
> Looking at arm64, even where we'd need custom handlers it does appear we
> could mostly do that out-of-line in the exception handler. The more
> exotic cases are largely in out-of-line asm functions, where we can move
> the fixups within the function, after the usual return.
> 
> I reckon we can handle the fixups for load_unaligned_zeropad() in the
> exception handler.
> 
> Is there anything specific that you think is painful in the exception
> handler?

Actually, after looking at all the x86 .fixup usage, I think we can make
this two-pronged approach work.  Either move the .fixup code to an
exception handler (with a hard-coded assembler constraint register) or
put it in the function (out-of-line where possible).  I'll try to work
up some patches (x86 only of course).

-- 
Josh

