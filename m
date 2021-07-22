Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDC3D1DCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhGVFNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 01:13:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36414 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhGVFNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:13:40 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 434F91FEEF;
        Thu, 22 Jul 2021 05:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626933255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEQOsUBhG7WuceEdafdVcMY/cqYyTJYTe4BOBvgIZgM=;
        b=FzsAUuKT9FbQwXQ3KEtoHkP8PVj0LRaZb5nqfoPxY3v5XjScaLtY3LhudrgyZU2GbiAwgf
        CocoqrB672lsxB8PS2NDLR7blctdZlwgyuie4K+bWvT2nxPYmoQb5wEta7gn1mgsyLs0Ze
        1thGT4zbJ4gVye4yLA8Kw5OaR7/VCsQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DFDFA13299;
        Thu, 22 Jul 2021 05:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pPCSMwYI+WB6aQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 22 Jul 2021 05:54:14 +0000
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
References: <20210721135926.602840-1-nborisov@suse.com>
 <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <20210721201029.GQ19710@twin.jikos.cz>
 <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <792949a2-d987-f6a0-a153-8c5fe1e3a073@suse.com>
Date:   Thu, 22 Jul 2021 08:54:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whCygw44p30Pmf+Bt8=LVtmij3_XOxweEA3OQNruhMg+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21.07.21 г. 23:27, Linus Torvalds wrote:
> On Wed, Jul 21, 2021 at 1:13 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> adding a memcmp_large that compares by native words or u64 could be
>> the best option.
> 
> Yeah, we could just special-case that one place.

This who thread started because I first implemented a special case just
for dedupe and Dave Chinner suggested instead of playing whack-a-mole to
get something decent for the generic memcmp so that we get an
improvement across the whole of the kernel.

> 
> But see the patches I sent out - I think we can get the best of both worlds.
> 
> A small and simple memcmp() that is good enough and not the
> _completely_ stupid thing we have now.
> 
> The second patch I sent out even gets the mutually aligned case right.
> 
> Of course, the glibc code also ended up unrolling things a bit, but
> honestly, the way it did it was too disgusting for words.
> 
> And if it really turns out that the unrolling makes a big difference -
> although I doubt it's meaningful with any modern core - I can add a
> couple of lines to that simple patch I sent out to do that too.
> Without getting the monster that is that glibc code.
> 
> Of course, my patch depends on the fact that "get_unaligned()" is
> cheap on all CPU's that really matter, and that caches aren't
> direct-mapped any more. The glibc code seems to be written for a world
> where registers are cheap, unaligned accesses are prohibitively
> expensive, and unrolling helps because L1 caches are direct-mapped and
> you really want to do chunking to not get silly way conflicts.
> 
> If old-style Sparc or MIPS was our primary target, that would be one
> thing. But it really isn't.
> 
>               Linus
> 
