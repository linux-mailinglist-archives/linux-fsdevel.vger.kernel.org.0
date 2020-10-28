Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0549A29D7B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgJ1W0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbgJ1W0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB0C0613CF;
        Wed, 28 Oct 2020 15:26:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id y186so1247048oia.3;
        Wed, 28 Oct 2020 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s9cgYbyfQqq5UrYB+51r7q1mjBjejxSSOe4Pf+0dXSc=;
        b=rXNAYzp0HeMoYo9Rs2j7a7wVExN8Iyb5gKJa3ilnzOfGHJwcd+RFugTbbv4YUD3Mnj
         2VUO9dlRzbWeNmhZQWRmIldeVTDDuir4KELQdTV8pKPdUaKgxaJ0IfJxBnM0G7vRBCYg
         wiT8wBbr85sNx5oNi5w1j5zdrDvcm3y/EvCc8kg4eRMh6e4OhiTUEBlFVB0b+ClJRPsJ
         TUQPC9Lpnd7T4yc2WOtO43nneYC6WKlAT53mGvvaNge6Yx9M/aeXZ+pqCJrHxuwPUVlT
         Z3sxPuGh8uWER8Un/fum42c093n9HO5gFE6T+nYBivL+DRtjuefzSY2LaKQepJTmgDcw
         UYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s9cgYbyfQqq5UrYB+51r7q1mjBjejxSSOe4Pf+0dXSc=;
        b=uN/mP0tUlWurG3Gdw3cZBQcgxc7YWvs/03LTDg72jKxT8k/J8lpYBgfjHSKMnkWjXT
         a4T18xEnehlAK+qWWdXj0aUS1JkX5OMeT440pzo0trxU5FWp9KVRJemW063Ow+MVFtOU
         vcKzYIzv8x9RRNl/JdDkPyy5vTKgvQA8TDHovaj+FnmwK6e9msAOQaBVwVwM4ihNxJqb
         po3xrCLmCc1m5zAbJz0v8nFTIkb4ajsA+Pd6rfZH+ga9H25cv3yxGOqqpTdPJr9Efys1
         lPbOquO330J2BhN3V5EtdIuwnOsSSLdqqvAy6ANNgkZJHnV9jM5z/xVldqnmdT/PlB4O
         KPFw==
X-Gm-Message-State: AOAM531sgsd7dD0lVgqQfpGEoAnzlmkHgAAkX6eiSl3x95UbwolhUzBS
        kg4IzazG4GX9xIPTKdkUBK3XtyklJZvNRg==
X-Google-Smtp-Source: ABdhPJxTVCFgGb7WglQERoAc+UBIhCpYSdy5fzH3i6p6S1gDc3JwHMqoX8TTAJWZ5WiJDakcD5Jdcg==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr209008pjb.138.1603908889414;
        Wed, 28 Oct 2020 11:14:49 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:70b5:cf21:2a3a:f170? ([2001:df0:0:200c:70b5:cf21:2a3a:f170])
        by smtp.gmail.com with ESMTPSA id i21sm60510pgh.2.2020.10.28.11.14.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 11:14:48 -0700 (PDT)
Subject: Re: [PATCH 11/13] m68k/mm: make node data and node setup depend on
 CONFIG_DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        arcml <linux-snps-arc@lists.infradead.org>
References: <20201027112955.14157-1-rppt@kernel.org>
 <20201027112955.14157-12-rppt@kernel.org>
 <CAMuHMdU4r4CJ1kBu7gx1jkputjDn2S8Lqkj7RPfa3XUnM1QOFg@mail.gmail.com>
 <20201028111631.GF1428094@kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fd55643a-a17b-5a23-4c77-9e832c1e5128@gmail.com>
Date:   Thu, 29 Oct 2020 07:14:38 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201028111631.GF1428094@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

On 29/10/20 12:16 AM, Mike Rapoport wrote:
> Hi Geert,
>
> On Wed, Oct 28, 2020 at 10:25:49AM +0100, Geert Uytterhoeven wrote:
>> Hi Mike,
>>
>> On Tue, Oct 27, 2020 at 12:31 PM Mike Rapoport <rppt@kernel.org> wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> The pg_data_t node structures and their initialization currently depends on
>>> !CONFIG_SINGLE_MEMORY_CHUNK. Since they are required only for DISCONTIGMEM
>>> make this dependency explicit and replace usage of
>>> CONFIG_SINGLE_MEMORY_CHUNK with CONFIG_DISCONTIGMEM where appropriate.
>>>
>>> The CONFIG_SINGLE_MEMORY_CHUNK was implicitly disabled on the ColdFire MMU
>>> variant, although it always presumed a single memory bank. As there is no
>>> actual need for DISCONTIGMEM in this case, make sure that ColdFire MMU
>>> systems set CONFIG_SINGLE_MEMORY_CHUNK to 'y'.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> Thanks for your patch!
>>
>>> ---
>>>   arch/m68k/Kconfig.cpu           | 6 +++---
>>>   arch/m68k/include/asm/page_mm.h | 2 +-
>>>   arch/m68k/mm/init.c             | 4 ++--
>>>   3 files changed, 6 insertions(+), 6 deletions(-)
>> Is there any specific reason you didn't convert the checks for
>> CONFIG_SINGLE_MEMORY_CHUNK in arch/m68k/kernel/setup_mm.c
> In arch/m68k/kernel/setup_mm.c the CONFIG_SINGLE_MEMORY_CHUNK is needed
> for the case when a system has two banks, the kernel is loaded into the
> second bank and so the first bank cannot be used as normal memory. It
> does not matter what memory model will be used in this case.


That case used to be detected just fine at run time (by dint of the 
second memory chunk having an address below the first; the chunk the 
kernel resides in is always listed first), even without using 
CONFIG_SINGLE_MEMORY_CHUNK.

Unless you changed that behaviour (and I see nothing in your patch that 
would indicate that), this is still true.

Converting the check as Geert suggested, without also adding a test for 
out-of-order memory bank addresses, would implicitly treat DISCONTIGMEM 
as  SINGLE_MEMORY_CHUNK, regardless of bank ordering. I don't think that 
is what we really want?

Cheers,

     Michael


>
>> and arch/m68k/include/asm/virtconvert.h?
>   
> I remember I had build errors and troubles with include file
> dependencies if I changed it there, but I might be mistaken. I'll
> recheck again.
>
>> Gr{oetje,eeting}s,
>>
>>                          Geert
>>
>> -- 
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                  -- Linus Torvalds
