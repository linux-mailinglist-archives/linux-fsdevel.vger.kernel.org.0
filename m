Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE5ED343
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfKCMCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 07:02:12 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:57400 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfKCMCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:02:12 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 54FA82E12F1;
        Sun,  3 Nov 2019 15:02:07 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id E9iTHkqXmn-25RCivqh;
        Sun, 03 Nov 2019 15:02:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572782527; bh=22EDXIE7sdCqMg9/8WHEbWESicgc5h63XsjO5uxv1rM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=dSxNOPO6KBTPwQVUMQsuoRYP2Rm4g+elu12lWUeOlbU6shBt2vVjk+8a9T+Ws1Crl
         7M9I/RtuybtEgw/2CYq/3gOZp2rM6HlcFjEq+tAopJfR6tmmd46WeI5DCF7/o5oKNY
         gSw+yqWfMiXCpvTo7HcNlk9jNn8xHug4DNIN8o/8=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7101::1:7])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1UOEXN5iqJ-25VW2Fdc;
        Sun, 03 Nov 2019 15:02:05 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
 <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
 <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
 <CALCETrWZjW88OY2mh7v8cUU_6XTSJTkQhAfNbSC17AdhEWwVAA@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c8001e7c-8039-3efb-948b-482b88005660@yandex-team.ru>
Date:   Sun, 3 Nov 2019 15:02:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWZjW88OY2mh7v8cUU_6XTSJTkQhAfNbSC17AdhEWwVAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/11/2019 02.14, Andy Lutomirski wrote:
> On Sat, Nov 2, 2019 at 4:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> But I don't think anybody actually _did_ any of that. But that's
>>> basically the argument for the three splice operations:
>>> write/vmsplice/splice(). Which one you use depends on the lifetime and
>>> the source of your data. write() is obviously for the copy case (the
>>> source data might not be stable), while splice() is for the "data from
>>> another source", and vmsplace() is "data is from stable data in my
>>> vm".
>>
>> Btw, it's really worth noting that "splice()" and friends are from a
>> more happy-go-lucky time when we were experimenting with new
>> interfaces, and in a day and age when people thought that interfaces
>> like "sendpage()" and zero-copy and playing games with the VM was a
>> great thing to do.
> 
> I suppose a nicer interface might be:
> 
> 
> madvise(buf, len, MADV_STABILIZE);
> 
> (MADV_STABILIZE is an imaginary operation that write protects the
> memory a la fork() but without the copying part.)
> 
> vmsplice_safer(fd, ...);
> 
> Where vmsplice_safer() is like vmsplice, except that it only works on
> write-protected pages.  If you vmsplice_safer() some memory and then
> write to the memory, the pipe keeps the old copy.
> 
> But this can all be done with memfd and splice, too, I think.

Looks monstrous. This will kill all fun and profit. =)

I think vmsplice should at least deprecate and ignore SPLICE_F_GIFT.

It almost never works - if page still mapped then page_count in
generic_pipe_buf_steal() will be at least 2 (pte and pipe gup).
But if user munmap vma between splicing and consuming (and page not
stuck in lazy tlb and per-cpu vectors) then page from anon lru
could be spliced into file. Ouch.

And looks like fuse device still accepts SPLICE_F_MOVE.

> 
> 
>>
>> It turns out that VM games are almost always more expensive than just
>> copying the data in the first place, but hey, people didn't know that,
>> and zero-copy was seen a big deal.
>>
>> The reality is that almost nobody uses splice and vmsplice at all, and
>> they have been a much bigger headache than they are worth. If I could
>> go back in time and not do them, I would. But there have been a few
>> very special uses that seem to actually like the interfaces.
>>
>> But it's entirely possible that we should kill vmsplice() (likely by
>> just implementing the semantics as "write()") because it's not common
>> enough to have the complexity.
> 
> I think this is the right choice.
> 
> FWIW, the openssl vmsplice() call looks dubious, but I suspect it's
> okay because it's vmsplicing to a netlink socket, and the kernel code
> on the other end won't read the data after it returns a response.
> 
> --Andy
> 
