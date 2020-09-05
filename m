Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3025E5F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIEHQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 03:16:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51449 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEHQS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:16:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bk5SF0YcXz9v21X;
        Sat,  5 Sep 2020 09:16:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I2kWpVRgLGRj; Sat,  5 Sep 2020 09:16:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bk5SD6rtHz9v21V;
        Sat,  5 Sep 2020 09:16:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F36098B76E;
        Sat,  5 Sep 2020 09:16:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LbgFIZMjw9IA; Sat,  5 Sep 2020 09:16:13 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9E268B75B;
        Sat,  5 Sep 2020 09:16:12 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     David Laight <David.Laight@ACULAB.COM>,
        'Alexey Dobriyan' <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
 <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
 <63f3c9342a784a0890b3b641a71a8aa1@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4500d8d9-7318-4505-6086-2d2dc41f3866@csgroup.eu>
Date:   Sat, 5 Sep 2020 09:16:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <63f3c9342a784a0890b3b641a71a8aa1@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 04/09/2020 à 23:01, David Laight a écrit :
> From: Alexey Dobriyan
>> Sent: 04 September 2020 18:58
>>
>> On Fri, Sep 04, 2020 at 08:00:24AM +0200, Ingo Molnar wrote:
>>> * Christoph Hellwig <hch@lst.de> wrote:
>>>> this series removes the last set_fs() used to force a kernel address
>>>> space for the uaccess code in the kernel read/write/splice code, and then
>>>> stops implementing the address space overrides entirely for x86 and
>>>> powerpc.
>>>
>>> Cool! For the x86 bits:
>>>
>>>    Acked-by: Ingo Molnar <mingo@kernel.org>
>>
>> set_fs() is older than some kernel hackers!
>>
>> 	$ cd linux-0.11/
>> 	$ find . -type f -name '*.h' | xargs grep -e set_fs -w -n -A3
>> 	./include/asm/segment.h:61:extern inline void set_fs(unsigned long val)
>> 	./include/asm/segment.h-62-{
>> 	./include/asm/segment.h-63-     __asm__("mov %0,%%fs"::"a" ((unsigned short) val));
>> 	./include/asm/segment.h-64-}
> 
> What is this strange %fs register you are talking about.
> Figure 2-4 only has CS, DS, SS and ES.
> 

Intel added registers FS and GS in the i386

Christophe
