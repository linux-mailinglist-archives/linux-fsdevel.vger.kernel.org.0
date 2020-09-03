Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7025BB84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICHU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 03:20:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53672 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgICHU6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:20:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhsfY3bm4zB09Zf;
        Thu,  3 Sep 2020 09:20:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id z990iF4fMPYf; Thu,  3 Sep 2020 09:20:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhsfY2h7WzB09ZZ;
        Thu,  3 Sep 2020 09:20:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F8A78B7B1;
        Thu,  3 Sep 2020 09:20:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GoY3tY2xK-tx; Thu,  3 Sep 2020 09:20:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1A698B790;
        Thu,  3 Sep 2020 09:20:53 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
 <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
 <20200902123646.GA31184@lst.de>
 <d78cb4be-48a9-a7c5-d9d1-d04d2a02b4c6@csgroup.eu>
 <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6a6ea160-a661-4a15-777c-e26a487829d4@csgroup.eu>
Date:   Thu, 3 Sep 2020 09:20:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiDCcxuHgENo3UtdFi2QW9B7yXvNpG5CtF=A6bc6PTTgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 02/09/2020 à 20:02, Linus Torvalds a écrit :
> On Wed, Sep 2, 2020 at 8:17 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>> With this fix, I get
>>
>> root@vgoippro:~# time dd if=/dev/zero of=/dev/null count=1M
>> 536870912 bytes (512.0MB) copied, 6.776327 seconds, 75.6MB/s
>>
>> That's still far from the 91.7MB/s I get with 5.9-rc2, but better than
>> the 65.8MB/s I got yesterday with your series. Still some way to go thought.
> 
> I don't see why this change would make any difference.
> 

Neither do I.

Looks like nowadays, CONFIG_STACKPROTECTOR has become a default.
I rebuilt the kernel without it, I now get a throughput of 99.8MB/s both 
without and with this series.

Looking at the generated code (GCC 10.1), a small change in a function 
seems to make large changes in the generated code when 
CONFIG_STACKPROTECTOR is set.

In addition to that, trivial functions which don't use the stack at all 
get a stack frame anyway when CONFIG_STACKPROTECTOR is set, allthough 
that's only -fstack-protector-strong. And there is no canary check.

Without CONFIG_STACKPROTECTOR:

c01572a0 <no_llseek>:
c01572a0:	38 60 ff ff 	li      r3,-1
c01572a4:	38 80 ff e3 	li      r4,-29
c01572a8:	4e 80 00 20 	blr

With CONFIG_STACKPROTECTOR (regardless of CONFIG_STACKPROTECTOR_STRONG 
or not):

c0164e08 <no_llseek>:
c0164e08:	94 21 ff f0 	stwu    r1,-16(r1)
c0164e0c:	38 60 ff ff 	li      r3,-1
c0164e10:	38 80 ff e3 	li      r4,-29
c0164e14:	38 21 00 10 	addi    r1,r1,16
c0164e18:	4e 80 00 20 	blr

Wondering why CONFIG_STACKPROTECTOR has become the default. It seems to 
imply a 10% performance loss even in the best case (91.7MB/s versus 
99.8MB/s)

Note that without CONFIG_STACKPROTECTOR_STRONG, I'm at 99.3MB/s, so 
that's really the _STRONG alternative that hurts.

Christophe
