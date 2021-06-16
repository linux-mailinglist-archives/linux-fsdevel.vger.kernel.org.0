Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABB83A8EC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 04:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFPCVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 22:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhFPCVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:21:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7DC061574;
        Tue, 15 Jun 2021 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cAFNJ1/DwVcSuyRvAwvNKZrXlrL9rYgK3W8Ic4ttV/8=; b=h4O7+9VsNWjBMVqH4uGscTf+2E
        Y+2KszH0xsTNWqZGX0xC9MYUJvqLb2pAiLbdOjKiZVhkzE7tqHF0vX8jqfw/ZijXQeDkKetDqhIt9
        X+A8Zygmim6WYlRQYj1VwpQQ3d1q8wAb9m9eG50Ili2M+TPLOOfRVqr67mTOkXcT9yZxK8kgXU0kX
        96Pds4lzKmFayRiubPf8iBDI/Su+E0mBRUD/H5pGxMllnbrWGRrXbvdofgqYfpwuyhAA8dcHunwpr
        032dR/SFn2X90Y7pRZCexz4bxx1iYdSTIl5eV8nc4YNs1EVkHAD1+EtBZoYc1WD69pGQv8nodJsLC
        CpOYkazg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltL8y-004Rdw-GO; Wed, 16 Jun 2021 02:19:04 +0000
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Tom Rix <trix@redhat.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
 <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
Message-ID: <07d62654-15c1-29a4-c671-1669ea92510b@infradead.org>
Date:   Tue, 15 Jun 2021 19:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/21 6:38 PM, Randy Dunlap wrote:
> On 6/15/21 5:32 PM, Linus Torvalds wrote:
>> On Tue, Jun 15, 2021 at 4:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> Some implementations of BUG() are macros, not functions,
>>
>> Not "some", I think. Most.
>>
>>> so "unreachable" is not applicable AFAIK.
>>
>> Sure it is. One common pattern is the x86 one:
>>
>>   #define BUG()                                                   \
>>   do {                                                            \
>>           instrumentation_begin();                                \
>>           _BUG_FLAGS(ASM_UD2, 0);                                 \
>>           unreachable();                                          \
>>   } while (0)
> 
> duh.
> 
>> and that "unreachable()" is exactly what I'm talking about.
>>
>> So I repeat: what completely broken compiler / config / architecture
>> is it that needs that "return 0" after a BUG() statement?
> 
> I have seen it on ia64 -- most likely GCC 9.3.0, but I'll have to
> double check that.

Nope, I cannot repro that now. I'll check a few more arches...

>> Because that environment is broken, and the warning is bogus and wrong.
>>
>> It might not be the compiler. It might be some architecture that does
>> this wrong. It might be some very particular configuration that does
>> something bad and makes the "unreachable()" not work (or not exist).
>>
>> But *that* is the bug that should be fixed. Not adding a pointless and
>> incorrect line that makes no sense, just to hide the real bug.


-- 
~Randy

