Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6222F25BB9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgICH1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 03:27:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50426 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgICH1a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:27:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bhsp66rdGzB09ZZ;
        Thu,  3 Sep 2020 09:27:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rH9lzYdCHhM9; Thu,  3 Sep 2020 09:27:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bhsp64yDPzB09ZW;
        Thu,  3 Sep 2020 09:27:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B05F68B7B1;
        Thu,  3 Sep 2020 09:27:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EOoz4qHnxzKL; Thu,  3 Sep 2020 09:27:27 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0575E8B790;
        Thu,  3 Sep 2020 09:27:26 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
 <20200903071144.GA19247@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e6afe576-c3b2-81af-b042-e5930a8fd4c8@csgroup.eu>
Date:   Thu, 3 Sep 2020 09:27:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903071144.GA19247@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 03/09/2020 à 09:11, Christoph Hellwig a écrit :
> On Wed, Sep 02, 2020 at 11:02:22AM -0700, Linus Torvalds wrote:
>> I don't see why this change would make any difference.
> 
> Me neither, but while looking at a different project I did spot places
> that actually do an access_ok with len 0, that's why I wanted him to
> try.
> 
> That being said: Christophe are these number stables?  Do you get
> similar numbers with multiple runs?

Yes the numbers are similar with multiple runs and multiple reboots.

> 
>> And btw, why do the 32-bit and 64-bit checks even differ? It's not
>> like the extra (single) instruction should even matter. I think the
>> main reason is that the simpler 64-bit case could stay as a macro
>> (because it only uses "addr" and "size" once), but honestly, that
>> "simplification" doesn't help when you then need to have that #ifdef
>> for the 32-bit case and an inline function anyway.
> 
> I'll have to leave that to the powerpc folks.  The intent was to not
> change the behavior (and I even fucked that up for the the size == 0
> case).
> 
>> However, I suspect a bigger reason for the actual performance
>> degradation would be the patch that makes things use "write_iter()"
>> for writing, even when a simpler "write()" exists.
> 
> Except that we do not actually have such a patch.  For normal user
> writes we only use ->write_iter if ->write is not present.  But what
> shows up in the profile is that /dev/zero only has a read_iter op and
> not a normal read.  I've added a patch below that implements a normal
> read which might help a tad with this workload, but should not be part
> of a regression.
> 
> Also Christophe:  can you bisect which patch starts this?  Is it really
> this last patch in the series?

5.9-rc2: 91.5MB/s
Patch 1: 74.9MB/s
Patch 2: 97.9MB/s
Patch 3: 97.7MB/s
Patch 4 to 9: 97.9MB/s
Patch 10: 85.3MB/s
Patch 11: 75.4MB/s

See my other mail, when removing CONFIG_STACKPROTECTOR, I get a stable 
99.8MB/s throughput.

Christophe
