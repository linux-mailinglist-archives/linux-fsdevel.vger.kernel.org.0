Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710AA1AF922
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSJy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 05:54:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22141 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgDSJy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:54:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 494lYR3Xc3z9tyDn;
        Sun, 19 Apr 2020 11:54:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=GMo5yCAo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nAxBIwYGtWFH; Sun, 19 Apr 2020 11:54:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 494lYR2Jrbz9tyDm;
        Sun, 19 Apr 2020 11:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587290091; bh=SLDSEP4XrdF5pJ0VblHWXGRy2Y2Yp8jccdJto8CbGTc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GMo5yCAoAVsWdEb2nyZuGs/NcpmrR+c2viuYh+CDDCjDG1lIiDMq2G0pmSZt72ixe
         Nk4oU7rpwicZO+eB/vvr2dnukKPFj//Ec4hCZumhU5k0eGF6SaCEn/t//2hPYX1I9R
         8JM1OIFgJImOH1tnT7v7AWgzpBxrn7PMltFf9/5U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94BBE8B76F;
        Sun, 19 Apr 2020 11:54:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IH0yUOqJJstY; Sun, 19 Apr 2020 11:54:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EADAD8B752;
        Sun, 19 Apr 2020 11:54:53 +0200 (CEST)
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org>
 <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
 <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
 <87v9lx3t4j.fsf@x220.int.ebiederm.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f35ddc94-e046-a807-9f58-04887aefe374@c-s.fr>
Date:   Sun, 19 Apr 2020 11:54:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v9lx3t4j.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 18/04/2020 à 13:55, Eric W. Biederman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Le 17/04/2020 à 23:09, Eric W. Biederman a écrit :
>>>
>>> To remove the use of set_fs in the coredump code there needs to be a
>>> way to convert a kernel siginfo to a userspace compat siginfo.
>>>
>>> Call that function copy_siginfo_to_compat and factor it out of
>>> copy_siginfo_to_user32.
>>
>> I find it a pitty to do that.
>>
>> The existing function could have been easily converted to using
>> user_access_begin() + user_access_end() and use unsafe_put_user() to copy to
>> userspace to avoid copying through a temporary structure on the stack.
>>
>> With your change, it becomes impossible to do that.
> 
> I don't follow.  You don't like temporary structures in the coredump
> code or temporary structures in copy_siginfo_to_user32?

In copy_siginfo_to_user32()

> 
> A temporary structure in copy_siginfo_to_user is pretty much required
> so that it can be zeroed to guarantee we don't pass a structure with
> holes to userspace.

Why ? We can zeroize the user structure directly, either with 
clear_user() or with some not yet existing unsafe_clear_user() or 
equivalent.

> 
> The implementation of copy_siginfo_to_user32 used to use the equivalent
> of user_access_begin() and user_access_end() and the code was a mess
> that was very difficult to reason about.  I recall their being holes
> in the structure that were being copied to userspace.
> 
> Meanwhile if you are going to set all of the bytes a cache hot temporary
> structure is quite cheap.

But how can we be sure it is cache hot ? As we are using memset() to 
zeroize it, it won't be loaded from memory as it will use dcbz 
instruction, but at some point in time it will get flushed back to 
memory, that's consuming anyway. Unless we invalidate it after the copy, 
but that becomes complex.

Christophe
