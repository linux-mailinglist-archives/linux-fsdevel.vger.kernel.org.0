Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426E9145B32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgAVRyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:54:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48676 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRyr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:54:47 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482tMm3lzRz9vBf2;
        Wed, 22 Jan 2020 18:54:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OcJlBYzu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id g55D7HPV3Pwg; Wed, 22 Jan 2020 18:54:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482tMm2SL9z9vBf1;
        Wed, 22 Jan 2020 18:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579715684; bh=nMZdRf5UsRj5KxQzwPP0NxCJ+9fa/JNI7E3shGKwtEs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OcJlBYzuayKTBlwDBdHG6QFeB0VoE/H+bzD9dU4M5bNP7OWUZKU4CVf0g6xmdG17n
         aDVEV8uPTBOJLj3L7ro5dOR/K2G0KeM7H1aC/PuOC8xLvG2mvLfW1Nobjbnwkl2FQU
         I6xJXWlceBU7CM1zDVJfem12s6jlYfllbGHsPocg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 029598B810;
        Wed, 22 Jan 2020 18:54:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fO2Q8JMqvBdc; Wed, 22 Jan 2020 18:54:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 565C88B7FE;
        Wed, 22 Jan 2020 18:54:45 +0100 (CET)
Subject: Re: [PATCH v1 1/6] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
 <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
 <20200122174129.GH23230@ZenIV.linux.org.uk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e6423f62-c29a-1a67-fb75-1330f5ef1348@c-s.fr>
Date:   Wed, 22 Jan 2020 18:54:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200122174129.GH23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 22/01/2020 à 18:41, Al Viro a écrit :
> On Wed, Jan 22, 2020 at 08:13:12AM -0800, Linus Torvalds wrote:
>> On Wed, Jan 22, 2020 at 5:00 AM Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> Modify filldir() and filldir64() to request the real area they need
>>> to get access to.
>>
>> Not like this.
>>
>> This makes the situation for architectures like x86 much worse, since
>> you now use "put_user()" for the previous dirent filling. Which does
>> that expensive user access setup/teardown twice again.
>>
>> So either you need to cover both the dirent's with one call, or you
>> just need to cover the whole (original) user buffer passed in. But not
>> this unholy mixing of both unsafe_put_user() and regular put_user().
> 
> I would suggest simply covering the range from dirent->d_off to
> buf->current_dir->d_name[namelen]; they are going to be close to
> each other and we need those addresses anyway...
> 

In v2, I'm covering from the beginning of parent dirent to the end of 
current dirent.

Christophe
