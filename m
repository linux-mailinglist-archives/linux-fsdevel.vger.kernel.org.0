Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E13D2AC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhGVQWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 12:22:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50914 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhGVQWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:22:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31A20203E2;
        Thu, 22 Jul 2021 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626973403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGctC4EQ9hNVc3gaN3R5S7yichC5UDxNPtD6UtEHN7U=;
        b=bX2bnjsCjXUeIvvsHtlTyjhnHEM7HjYuey/J7dpEg6wgAwdXJ2o1dDz/+pSStZB/yLwVMJ
        mNXkGGo+IXqr3rwwIimY2un/36++0Qo4osXDXvb3dmP4kEqnTJ7UEzEfFUnol1AlRgR5h8
        SMwNnZYGt7FTIhCYJBD/dCifs4lT/x4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D70BA139A1;
        Thu, 22 Jul 2021 17:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rd0VMtqk+WDNLwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 22 Jul 2021 17:03:22 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
 <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
 <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
 <eef30b51-c69f-0e70-11a8-c35f90aeca67@gmail.com>
 <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c8262efc-e97a-4672-0cc1-90c778eecd94@suse.com>
Date:   Thu, 22 Jul 2021 20:03:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whTNJyEMmCpNh5FeT+bJzSE2CYDPWyDO12G4q39d1jn1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 22.07.21 г. 19:40, Linus Torvalds wrote:
> On Thu, Jul 22, 2021 at 4:28 AM Nikolay Borisov
> <n.borisov.lkml@gmail.com> wrote:
>>
>> This one also works, tested only on x86-64. Looking at the perf diff:
>>
>>     30.44%    -28.66%  [kernel.vmlinux]         [k] memcmp
> 
> Ok.
> 
> So the one that doesn't even bother to align is
> 
>     30.44%    -29.38%  [kernel.vmlinux]         [k] memcmp
> 
> and the one that aligns the first one is
> 
>     30.44%    -28.66%  [kernel.vmlinux]         [k] memcmp
> 
> and the difference between the two is basically in the noise:
> 
>      1.05%     +0.72%  [kernel.vmlinux]     [k] memcmp
> 
> but the first one does seem to be slightly better.
> 
>> Now on a more practical note, IIUC your 2nd version makes sense if the
>> cost of doing a one unaligned access in the loop body is offset by the
>> fact we are doing a native word-sized comparison, right?
> 
> So honestly, the reason the first one seems to beat the second one is
> that the cost of unaligned accesses on modern x86 is basically
> epsilon.
> 
> For all normal unaligned accesses there simply is no cost at all.
> There is a _tiny_ cost when the unaligned access crosses a cacheline
> access boundary (which on older CPU's is every 32 bytes, on modern
> ones it's 64 bytes). And then there is another slightly bigger cost
> when the unaligned access actually crosses a page boundary.
> 
> But even those non-zero cost cases are basically in the noise, because
> under most circumstances they will be hidden by any out-of-order
> engine, and completely dwarfed by the _real_ costs which are branch
> mispredicts and cache misses.
> 
> So on the whole, unaligned accesses are basically no cost at all. You
> almost have to have unusual code sequences for them to be even
> measurable.
> 
> So that second patch that aligns one of the sources is basically only
> extra overhead for no real advantage. The cost of it is probably one
> more branch mispredict, and possibly a cycle or two for the extra
> instructions.
> 
> Which is why the first one wins: it's simpler, and the extra work the
> second one does is basically not worth it on x86. Plus I suspect your
> test-case was all aligned anyway to begin with, so the extra work is
> _doubly_ pointless.
> 
> I suspect the second patch would be worthwhile if
> 
>  (a) there really were a lot of strings that weren't aligned (likelihood: low)
> 
>  (b) other microarchitectures that do worse on unaligned accesses -
> some microarchitectures spend extra cycles on _any_ unaligned accesses
> even if they don't cross cache access boundaries etc.
> 
> and I can see (b) happening quite easily. You just won't see it on a
> modern x86-64 setup.
> 
> I suspect we should start with the first version. It's not only better
> on x86, but it's simpler, and it's guarded by that
> 
>     #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> so it's fundamentally "safer" on architectures that are just horrible
> about unaligned accesses.
> 
> Now, admittedly I don't personally even care about such architectures,
> and because we use "get_unaligned()", the compiler should always
> generate code that doesn't absolutely suck for bad architectures, but
> considering how long we've gone with the completely brainlessly simple
> "byte at a time" version without anybody even noticing, I think a
> minimal change is a better change.
> 
> That said, I'm not convinced I want to apply even that minimal first
> patch outside of the merge window.
> 
> So would you mind reminding me about this patch the next merge window?
> Unless there was some big extrernal reason why the performance of
> memcmp() mattered to you so much (ie some user that actually noticed
> and complained) and we really want to prioritize this..

I will do my best and hope I don't forget. OTOH there isn't anything
pressing it's something I found while looking at fidedupe's performance
and not even the major contributor but still, it looks sensible to fix
it now, that I have a workload at hand which clearly demonstrates
positive impact and can easily measure any changes.
> 
>               Linus
> 
