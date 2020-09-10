Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB2263F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIJIRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:17:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46071 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgIJION (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:14:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BnBVJ36t0z9txjs;
        Thu, 10 Sep 2020 10:13:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mLdPjtz4MI3T; Thu, 10 Sep 2020 10:13:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BnBVJ24wQz9txjr;
        Thu, 10 Sep 2020 10:13:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C4A28B820;
        Thu, 10 Sep 2020 10:13:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yqpTmoCr2JC9; Thu, 10 Sep 2020 10:13:45 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71AD28B81D;
        Thu, 10 Sep 2020 10:13:43 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142803.GM1236603@ZenIV.linux.org.uk>
 <CAHk-=wgQNyeHxXfckd1WtiYnoDZP1Y_kD-tJKqWSksRoDZT=Aw@mail.gmail.com>
 <20200909184001.GB28786@gate.crashing.org>
 <CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com>
 <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <186a62fc-042c-d6ab-e7dc-e61b18945498@csgroup.eu>
Date:   Thu, 10 Sep 2020 10:13:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3beb8b019e4a4f7b81fdb1bc68bd1e2d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 10/09/2020 à 10:04, David Laight a écrit :
> From: Linus Torvalds
>> Sent: 09 September 2020 22:34
>> On Wed, Sep 9, 2020 at 11:42 AM Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>>>
>>> It will not work like this in GCC, no.  The LLVM people know about that.
>>> I do not know why they insist on pushing this, being incompatible and
>>> everything.
>>
>> Umm. Since they'd be the ones supporting this, *gcc* would be the
>> incompatible one, not clang.
> 
> I had an 'interesting' idea.
> 
> Can you use a local asm register variable as an input and output to
> an 'asm volatile goto' statement?
> 
> Well you can - but is it guaranteed to work :-)
> 

With gcc at least it should work according to 
https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html

They even explicitely tell: "The only supported use for this feature is 
to specify registers for input and output operands when calling Extended 
asm "

Christophe
