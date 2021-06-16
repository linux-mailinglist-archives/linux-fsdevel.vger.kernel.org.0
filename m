Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1623D3A8F40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFPDRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 23:17:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7444 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDRd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:17:33 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4Vby745szZhkv;
        Wed, 16 Jun 2021 11:12:30 +0800 (CST)
Received: from [10.174.177.253] (10.174.177.253) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:15:25 +0800
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, Tom Rix <trix@redhat.com>,
        <linux-afs@lists.infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
 <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
Date:   Wed, 16 Jun 2021 11:15:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme751-chm.china.huawei.com (10.3.19.97)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops, Sorry for the late reply and missing the compilation details.

> On 6/15/21 5:32 PM, Linus Torvalds wrote:
>> On Tue, Jun 15, 2021 at 4:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> Some implementations of BUG() are macros, not functions,
>> Not "some", I think. Most.
>>
>>> so "unreachable" is not applicable AFAIK.
>> Sure it is. One common pattern is the x86 one:
>>
>>    #define BUG()                                                   \
>>    do {                                                            \
>>            instrumentation_begin();                                \
>>            _BUG_FLAGS(ASM_UD2, 0);                                 \
>>            unreachable();                                          \
>>    } while (0)
> duh.
>
>> and that "unreachable()" is exactly what I'm talking about.
>>
>> So I repeat: what completely broken compiler / config / architecture
>> is it that needs that "return 0" after a BUG() statement?
> I have seen it on ia64 -- most likely GCC 9.3.0, but I'll have to
> double check that.

Actually we build the kernel with the following compiler, config and 
architecture :

powerpc64-linux-gnu-gcc --version
powerpc64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_DEBUG_CURSOR=y

make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- -j64

...

fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
fs/afs/dir.c:51:1: error: no return statement in function returning 
non-void [-Werror=return-type]
    51 | }
       | ^
cc1: some warnings being treated as errors

>> Because that environment is broken, and the warning is bogus and wrong.
>>
>> It might not be the compiler. It might be some architecture that does
>> this wrong. It might be some very particular configuration that does
>> something bad and makes the "unreachable()" not work (or not exist).
>>
>> But *that* is the bug that should be fixed. Not adding a pointless and
>> incorrect line that makes no sense, just to hide the real bug.
> .
>
