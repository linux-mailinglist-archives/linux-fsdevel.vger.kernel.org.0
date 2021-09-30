Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E902441E23B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhI3T22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 15:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238316AbhI3T21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 15:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633030004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84aioMVzye4mu3+jKsp5Lz9dVTyI5BIn8daf8EFsh/I=;
        b=ddyllbr1pUbZHeKTnRJZeLTwseu0IWbW1CBRmFz7zf4SnF+bPa1PBH5yRyUdgZtjyOLVkT
        Kf56SJEBhEtZcZHiU3BanMIV8M459gc3UE/ejgXI3nA+9GXQIhpkZFWWTLrsJBC5J3dr0n
        5eFnhbA3qBe1vJ6B6xtvzITbnTQ/ZsU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-4ZyzhGmTPQO_8pzd2lQCsg-1; Thu, 30 Sep 2021 15:26:42 -0400
X-MC-Unique: 4ZyzhGmTPQO_8pzd2lQCsg-1
Received: by mail-ot1-f72.google.com with SMTP id p26-20020a9d4e1a000000b0054d847be7aaso4994063otf.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 12:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84aioMVzye4mu3+jKsp5Lz9dVTyI5BIn8daf8EFsh/I=;
        b=nDw3IRT/qUoVyndx58FWW2uMaSE8Byk5FnicY4ZoGIZMGSnInh4MPHoNMURMmuyq45
         vbMbdw8Cmdg09ozsqNhkYPtdGDw4cLR3v2N8TkLT7P46R+WonWpXT1kV1Aaf5WALeNmM
         MUaRR9Kikmh/d2Jm3grMwBR+2XW11mlVCTKurhwA3g3Z1GARKruxy8qjRFgFpVvXrDnq
         FOH1Y0nMvM+BvSalrJC/CvgL4A1vdRscyQfjHzos2293VClXggwAyhamJFQafJVmWcbX
         0p9SL3H0L3nFdxmhrmV+lXS9kD+u5qhxeGIam2ZRSulo/GJqmaU6PZIlJVN56/z2gYlW
         vHvg==
X-Gm-Message-State: AOAM530z/RJpgVYeXgVgMEf9RHdJkAWP6C1L3VUec4oc3EBiHQxcSV0e
        8NoIr7Zjb02nlkPh6l5HKmE6ERCThYLCSD25+6DQWnp2gGj4qLy96vn4NRF3L6g1TCPZud6aFOs
        p5cUHsvhN3mxcfQTZBbpB3JLt0w==
X-Received: by 2002:a4a:b282:: with SMTP id k2mr6154862ooo.11.1633030001820;
        Thu, 30 Sep 2021 12:26:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzul+KG+HIrMR3r/kdHh8q4z01ZL0Yv343OQE1gnyfoE9GjNSC5C76UwoXDsn37+QmYhDN5kQ==
X-Received: by 2002:a4a:b282:: with SMTP id k2mr6154840ooo.11.1633030001550;
        Thu, 30 Sep 2021 12:26:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id x4sm748421otq.25.2021.09.30.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 12:26:41 -0700 (PDT)
Date:   Thu, 30 Sep 2021 12:26:38 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org, live-patching@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210930192638.xwemcsohivoynwx3@treble>
References: <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
 <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
 <20210929085035.GA33284@C02TD0UTHF1T.local>
 <YVQ5F9aT7oSEKenh@hirez.programming.kicks-ass.net>
 <20210929103730.GC33284@C02TD0UTHF1T.local>
 <YVRRWzXqhMIpwelm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVRRWzXqhMIpwelm@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 01:43:23PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 29, 2021 at 11:37:30AM +0100, Mark Rutland wrote:
> 
> > > This is because _ASM_EXTABLE only generates data for another section.
> > > There doesn't need to be code continuity between these two asm
> > > statements.
> > 
> > I think you've missed my point. It doesn't matter that the
> > asm_volatile_goto() doesn't contain code, and this is solely about the
> > *state* expected at entry/exit from each asm block being different.
> 
> Urgh.. indeed :/

So much for that idea :-/

To fix the issue of the wrong .fixup code symbol names getting printed,
we could (as Mark suggested) add a '__fixup_text_start' symbol at the
start of the .fixup section.  And then remove all other symbols in the
.fixup section.

For x86, that means removing the kvm_fastop_exception symbol and a few
others.  That way it's all anonymous code, displayed by the kernel as
"__fixup_text_start+0x1234".  Which isn't all that useful, but still
better than printing the wrong symbol.

But there's still a bigger problem: the function with the faulting
instruction doesn't get reported in the stack trace.

For example, in the up-thread bug report, __d_lookup() bug report
doesn't get printed, even though its anonymous .fixup code is running in
the context of the function and will be branching back to it shortly.

Even worse, this means livepatch is broken, because if for example
__d_lookup()'s .fixup code gets preempted, __d_lookup() can get skipped
by a reliable stack trace.

So we may need to get rid of .fixup altogether.  Especially for arches
which support livepatch.

We can replace some of the custom .fixup handlers with generic handlers
like x86 does, which do the fixup work in exception context.  This
generally works better for more generic work like putting an error code
in a certain register and resuming execution at the subsequent
instruction.

However a lot of the .fixup code is rather custom and doesn't
necessarily work well with that model.

In such cases we could just move the .fixup code into the function
(inline for older compilers; out-of-line for compilers that support
CC_HAS_ASM_GOTO_OUTPUT).

Alternatively we could convert each .fixup code fragment into a proper
function which returns to a specified resume point in the function, and
then have the exception handler emulate a call to it like we do with
int3_emulate_call().

-- 
Josh

