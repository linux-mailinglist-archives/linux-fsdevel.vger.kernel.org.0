Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67014720C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 20:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAWTrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 14:47:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61664 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgAWTrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:47:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Xq32wGFz9twsF;
        Thu, 23 Jan 2020 20:47:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=GiT4oOAM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SdrD6o_7qs43; Thu, 23 Jan 2020 20:47:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Xq31j0Sz9twsD;
        Thu, 23 Jan 2020 20:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579808831; bh=7aISpSDwk7v2lI/VXtmtSlwWRv+BW39/h3hG4uOf4xk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GiT4oOAMsDoIJbqHVSxG301CAWwldgZmQRaIfFMSVrBDbBc/V9IXlyBKUf1FQX89s
         crLgitQifrTzbgyEVrCPJRbrcv2z6CpXbA2e1nkKThpAmm/AlGNMSMpu/ixIreuf5B
         KfqT02ezurVVK0RQGGtRw0A4me1TlQkiUzi+NGDM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C6F28B837;
        Thu, 23 Jan 2020 20:47:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LHxckWJhJw66; Thu, 23 Jan 2020 20:47:11 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 151148B836;
        Thu, 23 Jan 2020 20:47:10 +0100 (CET)
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
 <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <fc5c94a2-5a25-0715-5240-5ba3cbe0f2b2@c-s.fr>
Date:   Thu, 23 Jan 2020 20:47:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 200122-2, 22/01/2020), Outbound message
X-Antivirus-Status: Not-Tested
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 23/01/2020 à 19:02, Linus Torvalds a écrit :
> On Thu, Jan 23, 2020 at 4:59 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> On 32 bits powerPC (book3s/32), only write accesses to user are
>> protected and there is no point spending time on unlocking for reads.
> 
> Honestly, I'm starting to think that 32-bit ppc just needs to look
> more like everybody else, than make these changes.

Well, beside ppc32, I was also seen it as an opportunity for the modern 
ppc64. On it, you can unlock either read or write or both. And this is 
what is done for get_user() / put_user() and friends: unlock only reads 
for get_user() and only writes for put_user().

Could also be a compromise between performance and security: keeping 
reads allowed at all time and only protect against writes on modern 
architectures which support it like ppc64.

> 
> We used to have a read/write argument to the old "verify_area()" and
> "access_ok()" model, and it was a mistake. It was due to odd i386 user
> access issues. We got rid of it. I'm not convinced this is any better
> - it looks very similar and for odd ppc access issues.

I'm going to leave it aside, at least for the time being, and do it as a 
second step later after evaluating the real performance impact. I'll 
respin tomorrow in that way.

> 
> But if we really do want to do this, then:

Indeed I took the idea from a discussion in last Octobre (Subject: 
"book3s/32 KUAP (was Re: [PATCH] Convert filldir[64]() from __put_user() 
to unsafe_put_user())" )

https://lore.kernel.org/lkml/87h84avffi.fsf@mpe.ellerman.id.au/


> 
>> Add an argument to user_access_begin() to tell when it's for write and
>> return an opaque key that will be used by user_access_end() to know
>> what was done by user_access_begin().
> 
> You should make it more opaque than "unsigned long".
> 
> Also, it shouldn't be a "is this a write". What if it's a read _and_ a
> write? Only a write? Only a read?

Indeed that was more: does it includes a write. It's either RO or RW

Christophe
