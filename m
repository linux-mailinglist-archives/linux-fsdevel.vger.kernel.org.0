Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31E41A3E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhI0Xr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 19:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237972AbhI0Xr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632786348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsnSPMX2S/Qat0JZTZ1IQ/fql2yzNENw+yYwIO5gmA8=;
        b=EleK6qrBrs4A+zqxEH65X56uM85OJ10FVUvpe6FndAGAPwJxf3fP+kq3HySM7YDv9uu6zI
        k0D/TJp8bSoh8IH2djagrCVkdNX88f1GYp5cK9aCUPrBsazb/NlcQTU99ADJVioX3XOMjE
        ejeQFmWvLL7H7zn65KqNe6YOAgn1tkw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-06LLtUR7OlGF3NpucwUSGw-1; Mon, 27 Sep 2021 19:45:47 -0400
X-MC-Unique: 06LLtUR7OlGF3NpucwUSGw-1
Received: by mail-oi1-f200.google.com with SMTP id j200-20020acaebd1000000b0027357b3466aso16948161oih.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 16:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsnSPMX2S/Qat0JZTZ1IQ/fql2yzNENw+yYwIO5gmA8=;
        b=mfjXkltqZ1kkwQNnfI1fEt5km9Pe1Vn8bj0tr8o2cY0qXtjfjtC1MCPir+4R/t8V+t
         Z7YYRfwf0WeaI/EEvs6HGNpa+XvhI7gNR+ahMnIZgEo2FCBcAAXi8Xng68cjFL/TjN3Z
         F81TdVGgs0Fe53bhvqOaRc0Sk1XZgOEecAsiK1kQHhK0jINkDYJi61WUBUIXHVo0EsL7
         j/hBP8M8XtPbYcAqaxM2xhlcBVBpGm7VY3RY2z/M9M0EKrHa4oN36D4JzTH/HUEk/d9i
         BsQbQMIhkq5PtKyyi3FmQGsfXmkP9ixIVOQHcOp0HIg/0nASD8Q4QwL2uUT9u5+IewOc
         pOKA==
X-Gm-Message-State: AOAM5338hTrOJ0OXjD3uFK8HMzZyYGgZXHzgb9ku5pI4b/4MCBbQr8Mo
        +S9QKoXOyEUbcyB4ErRL0ZS9Q+QRLGuXQa7vwwEBO4E19OQD9+txS8rmjCjkGwiIUrIH/V5LhMJ
        S8BpSH0vOdtzzVnHiMZZxjXD2FQ==
X-Received: by 2002:a05:6830:246f:: with SMTP id x47mr2385797otr.287.1632786346784;
        Mon, 27 Sep 2021 16:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEwgyyipAso5Lnpv6vJwXUFrYJKO6zGLcI7AhX5ImXTFSCGu/useHx1lO4JT1d7wgEAIOV2g==
X-Received: by 2002:a05:6830:246f:: with SMTP id x47mr2385776otr.287.1632786346571;
        Mon, 27 Sep 2021 16:45:46 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o62sm434028ota.14.2021.09.27.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:45:46 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:45:43 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in
 kvm_fastop_exception
Message-ID: <20210927234543.6waods7rraxseind@treble>
References: <000000000000d6b66705cb2fffd4@google.com>
 <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
 <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
 <YUpr8Vu8xqCDwkE8@google.com>
 <CACT4Y+YuX3sVQ5eHYzDJOtenHhYQqRsQZWJ9nR0sgq3s64R=DA@mail.gmail.com>
 <YVHsV+o7Ez/+arUp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVHsV+o7Ez/+arUp@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:07:51PM +0000, Sean Christopherson wrote:
> I was asking about the exact location to confirm that the explosion is indeed
> from exception fixup, which is the "unwinder scenario get confused" I was thinking
> of.  Based on the disassembly from syzbot, that does indeed appear to be the case
> here, i.e. this
> 
>   2a:   4c 8b 21                mov    (%rcx),%r12
> 
> is from exception fixup from somewhere in __d_lookup (can't tell exactly what
> it's from, maybe KASAN?).
> 
> > Is there more info on this "the unwinder gets confused"? Bug filed
> > somewhere or an email thread? Is it on anybody's radar?
> 
> I don't know if there's a bug report or if this is on anyone's radar.  The issue
> I've encountered in the past, and what I'm pretty sure is being hit here, is that
> the ORC unwinder doesn't play nice with out-of-line fixup code, presumably because
> there are no tables for the fixup.  I believe kvm_fastop_exception() gets blamed
> because it's the first label that's found when searching back through the tables.

The ORC unwinder actually knows about .fixup, and unwinding through the
.fixup code worked here, as evidenced by the entire stacktrace getting
printed.  Otherwise there would have been a bunch of question marks in
the stack trace.

The problem reported here -- falsely printing kvm_fastop_exception -- is
actually in the arch-independent printing of symbol names, done by
__sprint_symbol().  Most .fixup code fragments are anonymous, in the
sense that they don't have symbols associated with them.  For x86, here
are the only defined symbols in .fixup:

  ffffffff81e02408 T kvm_fastop_exception
  ffffffff81e02728 t .E_read_words
  ffffffff81e0272b t .E_leading_bytes
  ffffffff81e0272d t .E_trailing_bytes
  ffffffff81e02734 t .E_write_words
  ffffffff81e02740 t .E_copy

There's a lot of anonymous .fixup code which happens to be placed in the
gap between "kvm_fastop_exception" and ".E_read_words".  The kernel
symbol printing code will go backwards from the given address and will
print the first symbol it finds.  So any anonymous code in that gap will
falsely be reported as kvm_fastop_exception().

I'm thinking the ideal way to fix this would be getting rid of the
.fixup section altogether, and instead place a function's corresponding
fixup code in a cold part of the original function, with the help of
asm_goto and cold label attributes.

That way, the original faulting function would be printed instead of an
obscure reference to an anonymous .fixup code fragment.  It would have
other benefits as well.  For example, not breaking livepatch...

I'll try to play around with it.

-- 
Josh

