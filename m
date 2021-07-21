Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C853D160A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhGURgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 13:36:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56404 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhGURgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:36:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BD7F2258A;
        Wed, 21 Jul 2021 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626891448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zh24kwQr9x4P8HQI50R94dH2ZajAoCPcMUdpyJhEnqQ=;
        b=gldfdSjnXji3kshIswXgAlYayMJ39mkOCMUm4yiNyho/j3rXUKZhCXXpDNoaj/bRlnv8q3
        Ln8DJeWHmFxZk+lTMXjDzKHjTzW8i0JV+iIbBX07jrfdnIwHZiQjXVNKq6NysJoSSuYgRl
        ce8MwCeENaXOyF4p/4samYPMx2iaOHI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5821413C09;
        Wed, 21 Jul 2021 18:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id BUscE7hk+GCJXgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 21 Jul 2021 18:17:28 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
Date:   Wed, 21 Jul 2021 21:17:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21.07.21 г. 21:00, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 6:59 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> This is glibc's memcmp version. The upside is that for architectures
>> which don't have an optimized version the kernel can provide some
>> solace in the form of a generic, word-sized optimized memcmp. I tested
>> this with a heavy IOCTL_FIDEDUPERANGE(2) workload and here are the
>> results I got:
> 
> Hmm. I suspect the usual kernel use of memcmp() is _very_ skewed to
> very small memcmp calls, and I don't think I've ever seen that
> (horribly bad) byte-wise default memcmp in most profiles.
> 
> I suspect that FIDEDUPERANGE thing is most likely a very special case.
> 
> So I don't think you're wrong to look at this, but I think you've gone
> from our old "spend no effort at all" to "look at one special case".
> 
> And I think the glibc implementation is horrible and doesn't know
> about machines where unaligned loads are cheap - which is all
> reasonable ones.
> 
> That MERGE() macro is disgusting, and memcmp_not_common_alignment()
> should not exist on any sane architecture. It's literally doing extra
> work to make for slower accesses, when the hardware does it better
> natively.
> 
> So honestly, I'd much rather see a much saner and simpler
> implementation that works well on the architectures that matter, and
> that don't want that "align things by hand".
> 
> Aligning one of the sources by hand is fine and makes sense - so that
> _if_ the two strings end up being mutually aligned, all subsequent
> accesses are aligned.

I find it somewhat arbitrary that we choose to align the 2nd pointer and
not the first. Obviously it'll be easy to detect which one of the 2 is
unaligned and align it so that from thereon memcmp can continue doing
aligned accesses. However, this means a check like that would be done
for *every* (well, barring some threshold value) access to memcmp.

> 
>  But then trying to do shift-and-masking for the possibly remaining
> unaligned source is crazy and garbage. Don't do it.
> 
> And you never saw that, because your special FIDEDUPERANGE testcase
> will never have anything but mutually aligned cases.
> 
> Which just shows that going from "don't care at all' to "care about
> one special case" is not the way to go.
> 
> So I'd much rather see a simple default function that works well for
> the sane architectures, than go with the default code from glibc - and
> bad for the common modern architectures.

So you are saying that the current memcmp could indeed use improvement
but you don't want it to be based on the glibc's code due to the ugly
misalignment handling?

> 
> Then architectures could choose that one with some

So you are suggesting keeping the current byte comparison one aka
'naive' and having another, more optimized generic implementation that
should be selected by GENERIC_MEMCMP or have I misunderstood you ?

> 
>         select GENERIC_MEMCMP
> 
> the same way we have
> 
>         select GENERIC_STRNCPY_FROM_USER
> 
> for the (sane, for normal architectures) common optimized case for a
> special string instruction that matters a lot for the kernel.
> 
>                      Linus
> 
