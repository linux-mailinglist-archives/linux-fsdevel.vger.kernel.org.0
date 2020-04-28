Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0E1BB7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD1Hp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:45:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50279 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1Hp4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:45:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49BDGT61qhz9v0Yh;
        Tue, 28 Apr 2020 09:45:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UBR5gAQ5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Jm5mmlEvRnDf; Tue, 28 Apr 2020 09:45:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49BDGT4QTyz9v0Yg;
        Tue, 28 Apr 2020 09:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588059953; bh=/2fZZkU1LY2pi9G08Gg14D8HOq4abGxDwLX+kqPlt1o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UBR5gAQ53YJN7ELul96h9s1XA1XXA+4fvsvJ+j3pt0+0nKvRCMh3AZyL/IBPKVzuA
         j3Gc+fUrI76w6umT2wOmN3GTPm/U0ZjnNCv4YC/kSlVhGQRyeNlBqhuRQjCUJuX8ff
         HU7o4PADGi6vHlzTQ7FuNK5gQHJ7lzZ6KlCoAPp8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CC8B8B7EF;
        Tue, 28 Apr 2020 09:45:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rlSWOtbbJT9w; Tue, 28 Apr 2020 09:45:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE3628B7ED;
        Tue, 28 Apr 2020 09:45:53 +0200 (CEST)
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20200421154204.252921-1-hch@lst.de>
 <20200421154204.252921-3-hch@lst.de>
 <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org>
 <20200426074039.GA31501@lst.de>
 <20200427154050.e431ad7fb228610cc6b95973@linux-foundation.org>
 <20200428070935.GE18754@lst.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ddbaba35-9cc5-dfb9-3cae-51b026de5b65@c-s.fr>
Date:   Tue, 28 Apr 2020 09:45:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428070935.GE18754@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 28/04/2020 à 09:09, Christoph Hellwig a écrit :
> On Mon, Apr 27, 2020 at 03:40:50PM -0700, Andrew Morton wrote:
>>> https://www.spinics.net/lists/kernel/msg3473847.html
>>> https://www.spinics.net/lists/kernel/msg3473840.html
>>> https://www.spinics.net/lists/kernel/msg3473843.html
>>
>> OK, but that doesn't necessitate the above monstrosity?  How about
>>
>> static int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
>> 			     const struct kernel_siginfo *from, bool x32_ABI)
>> {
>> 	struct compat_siginfo new;
>> 	copy_siginfo_to_external32(&new, from);
>> 	...
>> }
>>
>> int copy_siginfo_to_user32(struct compat_siginfo __user *to,
>> 			   const struct kernel_siginfo *from)
>> {
>> #if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
>> 	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
>> #else
>> 	return __copy_siginfo_to_user32(to, from, 0);
>> #endif
>> }
>>
>> Or something like that - I didn't try very hard.  We know how to do
>> this stuff, and surely this thing isn't how!
> 
> I guess that might be a worthwhile middle ground.  Still not a fan of
> all these ifdefs..
> 

Can't we move the small X32 specific part out of 
__copy_siginfo_to_user32(), in an arch specific helper that voids for 
other architectures ?

Something like:

		if (!arch_special_something(&new, from)) {
			new.si_utime = from->si_utime;
			new.si_stime = from->si_stime;
		}

Then the arch_special_something() does what it wants in x86 and returns 
1, and for architectures not implementating it, a generic version return 
0 all the time.

Christophe
