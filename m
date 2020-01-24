Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B45148425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392043AbgAXLkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 06:40:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10076 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403843AbgAXLk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:40:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483xyt3Jbyz9tyMg;
        Fri, 24 Jan 2020 12:40:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iiu4nggJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id A3I6opIEV_tl; Fri, 24 Jan 2020 12:40:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483xyt27bmz9tyMf;
        Fri, 24 Jan 2020 12:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579866022; bh=FHdRJ1lym9x5LZH3JKxzccvEq6M9sGBs3OTmqNRLhTU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iiu4nggJtlejyS9CxTCWd166SJF9J7eVXuwRZ7M2gotO68hUK81m+MR2Tstk3ho8B
         Rj9fXdhonGjq/7IdTo1GHGLsriWmDEEd0f4c2HcS4bPl+9p+eVKJ1QKA/pX/XYHPtq
         QQIRjBIznCVLXgOan515E+eWZeriwxtYhT7tVKTQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 885948B858;
        Fri, 24 Jan 2020 12:40:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rd4xOECJWD9L; Fri, 24 Jan 2020 12:40:23 +0100 (CET)
Received: from [172.25.230.111] (po15451.idsi0.si.c-s.fr [172.25.230.111])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 514BB8B84A;
        Fri, 24 Jan 2020 12:40:23 +0100 (CET)
Subject: Re: [PATCH v2 6/6] powerpc: Implement user_access_begin and friends
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <2a20d19776faba4d85dbe51ae00a5f6ac5ac0969.1579715466.git.christophe.leroy@c-s.fr>
 <87iml2idi9.fsf@mpe.ellerman.id.au> <87ftg6icc8.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0c2855c2-a6d6-6b35-7f69-f55add58dfb8@c-s.fr>
Date:   Fri, 24 Jan 2020 12:40:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87ftg6icc8.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 23/01/2020 à 13:31, Michael Ellerman a écrit :
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Today, when a function like strncpy_from_user() is called,
>>> the userspace access protection is de-activated and re-activated
>>> for every word read.
>>>
>>> By implementing user_access_begin and friends, the protection
>>> is de-activated at the beginning of the copy and re-activated at the
>>> end.
>>>
>>> Implement user_access_begin(), user_access_end() and
>>> unsafe_get_user(), unsafe_put_user() and unsafe_copy_to_user()
>>>
>>> For the time being, we keep user_access_save() and
>>> user_access_restore() as nops.
>>
>> That means we will run with user access enabled in a few more places, but
>> it's only used sparingly AFAICS:
>>
>>    kernel/trace/trace_branch.c:    unsigned long flags = user_access_save();
>>    lib/ubsan.c:    unsigned long flags = user_access_save();
>>    lib/ubsan.c:    unsigned long ua_flags = user_access_save();
>>    mm/kasan/common.c:      unsigned long flags = user_access_save();
>>
>> And we don't have objtool checking that user access enablement isn't
>> leaking in the first place, so I guess it's OK for us not to implement
>> these to begin with?
> 
> It looks like we can implement them on on all three KUAP
> implementations.
> 
> For radix and 8xx we just return/set the relevant SPR.
> 
> For book3s/32/kup.h I think we'd just need to add a KUAP_CURRENT case to
> allow_user_access()?

Can't do that, we don't want to keep the info in current->thread.kuap 
after user_access_save(), otherwise we might unexpectedly re-open access 
through an interrupt.

And if we use KUAP_CURRENT case of prevent_user_access(), it means we'll 
read current->thread.kuap twice.

So, just regenerate addr and end from the flags, and use 
allow_user_access() and prevent_user_access() as usual.

I'll have it in v4

Christophe
