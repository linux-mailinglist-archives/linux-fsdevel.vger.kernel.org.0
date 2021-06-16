Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B423A8E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhFPBkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhFPBkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:40:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34461C061574;
        Tue, 15 Jun 2021 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=L5KFn8XBOltgmecJHtTIarpN0RynVj+N0x57keu5L1M=; b=zje2nSXHYdaUHbbrqiRWIiYNqH
        xP7CDuUauR7UMJe77t2/v+a8WckSSZMEkKwPZVZ8sY2yGGnDuJcJJifrMEE/u8nx30Ca1LdEUa8IM
        wWQLX/EWGY86FUcY61dd7P/mJcCfY8Rrx56xyCeb7/ohvnRSs3qMIlyFB2WFtoDWRsE03UAC/5HdL
        cqmNmN7dgGeCk9190jeId5iyeG8pNdltOqaeyirrlsFeWoAZYphUq0GJc+DnSKInfqI8tiOBgF/x5
        iQm7NVCRjz3TxLmvZyljGbGDx/mlvEzwtQ5aVYtCm+WG4MBTvLa6WVP0Tz3gyfpdDy8ioeM4R5G+l
        kXODQh0A==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltKVu-004NmR-OH; Wed, 16 Jun 2021 01:38:42 +0000
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
Date:   Tue, 15 Jun 2021 18:38:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/21 5:32 PM, Linus Torvalds wrote:
> On Tue, Jun 15, 2021 at 4:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Some implementations of BUG() are macros, not functions,
> 
> Not "some", I think. Most.
> 
>> so "unreachable" is not applicable AFAIK.
> 
> Sure it is. One common pattern is the x86 one:
> 
>   #define BUG()                                                   \
>   do {                                                            \
>           instrumentation_begin();                                \
>           _BUG_FLAGS(ASM_UD2, 0);                                 \
>           unreachable();                                          \
>   } while (0)

duh.

> and that "unreachable()" is exactly what I'm talking about.
> 
> So I repeat: what completely broken compiler / config / architecture
> is it that needs that "return 0" after a BUG() statement?

I have seen it on ia64 -- most likely GCC 9.3.0, but I'll have to
double check that.

> Because that environment is broken, and the warning is bogus and wrong.
> 
> It might not be the compiler. It might be some architecture that does
> this wrong. It might be some very particular configuration that does
> something bad and makes the "unreachable()" not work (or not exist).
> 
> But *that* is the bug that should be fixed. Not adding a pointless and
> incorrect line that makes no sense, just to hide the real bug.
