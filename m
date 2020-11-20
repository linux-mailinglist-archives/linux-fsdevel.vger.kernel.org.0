Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CE52BB825
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 22:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgKTVN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 16:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgKTVN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:13:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 13:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YFyZ12L9XZV5/bG8xWEunlZ6fJwvZBT9afefbuSo1tQ=; b=sKDdd9J8rGaVUdeY0+FLm2VlNW
        dPmuVpZ68mxRj8S58YVKQE1uuj6JerRpyMk8/expyqsqDSlt9DLP0D4hgx/D0x3DcfVALQEjgy7eF
        WQzK1Diucumfz1d9Uo1fc0KfnN3fA3Ik8G4+uEhVTKJtICiJns4FoCMFDNLnydMyTak4SLto5uFBK
        oBrd1kUY1RkHAcs0zelSwrqB0tHDgPbDqQeSBp/O9jMqZmhr83ne6gMuSXOJ+xojrp27CJnL5Sx9x
        cIcCEGBfL74tEhfBEaH8Q9UeFlh+9gCW8FFdhuk6uhgoOxtECxzn/iAqhGk/sof1U4iUs4KlczvBY
        7TU5d5Bg==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgDie-0000X4-Hj; Fri, 20 Nov 2020 21:13:24 +0000
Subject: Re: BUG triggers running lsof
To:     "K.R. Foley" <kr@cybsft.com>, Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <de8c0e6b73c9fc8f22880f0e368ecb0b@cybsft.com>
 <4cc7a530-41ed-81f4-82cd-6a3a93661dce@infradead.org>
 <x49im9zn6wb.fsf@segfault.boston.devel.redhat.com>
 <5310969ec0c67c25ae2eff16f1e904d5@cybsft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d070f189-d8ee-73e5-5502-6618080e64bc@infradead.org>
Date:   Fri, 20 Nov 2020 13:13:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5310969ec0c67c25ae2eff16f1e904d5@cybsft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/20 12:59 PM, K.R. Foley wrote:
> 
> 
> 
> On 2020-11-20 13:51, Jeff Moyer wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> On 11/20/20 11:16 AM, K.R. Foley wrote:
>>>> I have found an issue that triggers by running lsof. The problem is
>>>> reproducible, but not consistently. I have seen this issue occur on
>>>> multiple versions of the kernel (5.0.10, 5.2.8 and now 5.4.77). It
>>>> looks like it could be a race condition or the file pointer is being
>>>> corrupted. Any pointers on how to track this down? What additional
>>>> information can I provide?
>>>
>>> Hi,
>>>
>>> 2 things in general:
>>>
>>> a) Can you test with a more recent kernel?
>>>
>>> b) Can you reproduce this without loading the proprietary & out-of-tree
>>> kernel modules?  They should never have been loaded after bootup.
>>> I.e., don't just unload them -- that could leave something bad behind.
>>
>> Heh, the EIP contains part of the name of one of the modules:
>>
>>>
>>>> [ 8057.297159] BUG: unable to handle page fault for address: 31376f63
>>                                                                 ^^^^^^^^

Thanks for noticing that, Jeff.  I should have seen it.

>>>> [ 8057.297219] Modules linked in: ITXico7100Module(O)
>>                                          ^^^^
> 
> Perhaps this is a dumb question, but how could this happen?


We don't know what is in that loadable kernel module, so we can't
give a definitive answer to your question, other than it's buggy.
Or maybe it was just written for an older kernel version.
Or a kernel with different build options/settings.

Have you contacted IT support?

It would (will) be interesting to see if you can reproduce the problem
without these modules being loaded...
I kind of doubt it, but if it does still fail, it will give us something
to look at.

-- 
~Randy

