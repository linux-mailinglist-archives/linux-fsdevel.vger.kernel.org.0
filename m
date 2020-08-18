Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196A248DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRSX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 14:23:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60216 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSX1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:23:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWK6M41zRz9tyqY;
        Tue, 18 Aug 2020 20:23:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FoqN8CggTbOJ; Tue, 18 Aug 2020 20:23:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWK6M2Tfqz9txTF;
        Tue, 18 Aug 2020 20:23:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D4D48B7EC;
        Tue, 18 Aug 2020 20:23:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9MZ8ZSBzYxyO; Tue, 18 Aug 2020 20:23:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F18E8B7D7;
        Tue, 18 Aug 2020 20:23:22 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200817073212.830069-1-hch@lst.de>
 <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu>
 <20200818180555.GA29185@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e3781661-2e13-4f46-d892-181907a2e768@csgroup.eu>
Date:   Tue, 18 Aug 2020 20:23:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818180555.GA29185@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 18/08/2020 à 20:05, Christoph Hellwig a écrit :
> On Tue, Aug 18, 2020 at 07:46:22PM +0200, Christophe Leroy wrote:
>> I gave it a go on my powerpc mpc832x. I tested it on top of my newest
>> series that reworks the 32 bits signal handlers (see
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=196278) with
>> the microbenchmark test used is that series.
>>
>> With KUAP activated, on top of signal32 rework, performance is boosted as
>> system time for the microbenchmark goes from 1.73s down to 1.56s, that is
>> 10% quicker
>>
>> Surprisingly, with the kernel as is today without my signal's series, your
>> series degrades performance slightly (from 2.55s to 2.64s ie 3.5% slower).
>>
>>
>> I also observe, in both cases, a degradation on
>>
>> 	dd if=/dev/zero of=/dev/null count=1M
>>
>> Without your series, it runs in 5.29 seconds.
>> With your series, it runs in 5.82 seconds, that is 10% more time.
> 
> That's pretty strage, I wonder if some kernel text cache line
> effects come into play here?
> 
> The kernel access side is only used in slow path code, so it should
> not make a difference, and the uaccess code is simplified and should be
> (marginally) faster.
> 
> Btw, was this with the __{get,put}_user_allowed cockup that you noticed
> fixed?
> 

Yes it is with the __get_user_size() replaced by __get_user_size_allowed().

Christophe
