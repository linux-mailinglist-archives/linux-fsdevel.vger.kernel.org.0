Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553CA146842
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 13:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAWMnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 07:43:09 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51628 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgAWMnJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:43:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483MPk32vtz9vB4D;
        Thu, 23 Jan 2020 13:43:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=M+c4fJVZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MKcSH7ytUAbU; Thu, 23 Jan 2020 13:43:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483MPk1fHkz9vB4C;
        Thu, 23 Jan 2020 13:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579783386; bh=5u98EOtP2WKcTg/wP4g+30sC+JrkYBCOJLlRu95fhRc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M+c4fJVZVBnhS3LrJqZpaNaPKS4omcdwek4cx3zgeBhOVTUQxWipdFpZ3dDE3jsb7
         0vzFt2dnk9ceZD4rJtPz5HH55nBprFw7Z9bgGytv+K2FL9rBFrU7xN6VvBJEmk9AqC
         23kWu25GIwSDC3iQWt5qcsPySMvP0N41mgpbhqEk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5537F8B82B;
        Thu, 23 Jan 2020 13:43:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IWp1L7UGbtAy; Thu, 23 Jan 2020 13:43:07 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 871D98B826;
        Thu, 23 Jan 2020 13:43:06 +0100 (CET)
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <87muaeidyc.fsf@mpe.ellerman.id.au> <87k15iidrq.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f7b34529-0548-dc0d-c263-549acbb26ddc@c-s.fr>
Date:   Thu, 23 Jan 2020 13:43:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87k15iidrq.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 23/01/2020 à 13:00, Michael Ellerman a écrit :
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Hi Christophe,
>>
>> This patch is independent of the rest of the series AFAICS
> 
> And of course having hit send I immediately realise that's not true.

Without this, book3s/32 fails booting. (And without patch 2, it even 
hangs, looping forever in do_page_fault()).


> 
>> So I'll take patches 2-6 via powerpc and assume this patch will go via
>> Linus or Al or elsewhere.
> 
> So I guess I'll wait and see what happens with patch 1.

We could eventually opt out user_access_begin() for 
CONFIG_PPC_BOOK3S_32, then you could take patches 3 and 6. That's enough 
to have user_access_begin() and stuff for 8xx and RADIX.

Patch 2 should be taken as well as a fix, and can be kept independant of 
the series (once we have patch 1, we normally don't hit the problem 
fixed by patch 2).

Won't don't need patch 4 until we want user_access_begin() supported by 
book3s/32


However, I'm about to send out a v3 with a different approach. It 
modifies the core part where user_access_begin() is returning an opaque 
value used by user_access_end(). And it also tells user_access_begin() 
whether it's a read or a write, so that we can limit unlocking to write 
acccesses on book3s/32, and fine grain rights on book3s/64.

Maybe you would prefer this change on top of first step, in which case 
I'll be able to make a v4 rebasing all this on top of patch 3 and 6 of 
v3 series. Tell me what you prefer.

Christophe
