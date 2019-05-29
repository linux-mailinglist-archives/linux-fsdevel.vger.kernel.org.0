Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865592DD15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfE2M3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 08:29:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33848 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfE2M3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 08:29:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so1552966pfa.1;
        Wed, 29 May 2019 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D0hd+8IlrFbrljX6rJkpYHeRy73O1oI/e5niWGIamB0=;
        b=mAcxVAnnohWG0y0fKP3zZRtJ9Mq0fbqgBgbd4Te568VAQB3iC2NRJZx8MOVbhSgVcr
         q8uc64x9OhD6j9rUpMYGLmCNyP1h1cV+BfcIG4EojhVN5o8jt392WMo/kv8XytBo80xK
         OV2w3cwm+8XzT0+SIxTZUNxaRlzRRs+o5qOu4+ZMdypBR3n0PABL/WxuFy4P9cP/yfC1
         iDYaaGIzeDN6KAeKfiT0f7VIwfPdr15Su8dUO3rpVjmSIzAZp/vZJE3qkB7R1FCCbcUJ
         khffaKH2byom1uPVcgLmy/EwaNhHiFU7slPfaxV6E4CjL4IEwznlwVjYiciKcB7hzmVG
         nYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D0hd+8IlrFbrljX6rJkpYHeRy73O1oI/e5niWGIamB0=;
        b=YifM5zGCQvPFNVWVcfNY+x9buWa1yJLbvNKD0WIGvjFuWJOH/evQvazdqSA9O6laVR
         wRgT9UBEcJXxh+VaQxkjrjtwzsTyofoQ8PvkCzsmYRqQJk4OWINsUgmTiyrWcsNRxD6Q
         fwk426hK1uWeUHKp98/5KrSTJljuEJN7SqW0Rxd4uH5k+RFGkUjhn4536KaoQ4TWDmZI
         d+rVIe6XOAFTZEpaIvdAVym1K/HwEVoXGD6w1AsVB5Tzd9Yc1JnnZ9WrPJNZskVPicwP
         nWbzLnLk6GyTElEjJbWHM1Ca4n7Y89f6XatA3nwhkc+fyR2vgis6USI5Y96Oc0ZRlQ0I
         eaNg==
X-Gm-Message-State: APjAAAWfIAxqpeSa4ZslJpp5ARLtSLSQwHrosyTsKK3zZxiU93734CCx
        kilytnSOewVf5/DJ1bU8wkM=
X-Google-Smtp-Source: APXvYqx5fy9AgEt2qQxAINvAfQ7/rstW4D1Ukhfvs2SC4vzPunCtOtYiz4IblPd8BUa9WuA1D242cg==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr138152208pgi.187.1559132978396;
        Wed, 29 May 2019 05:29:38 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id y16sm17439175pfl.140.2019.05.29.05.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:29:37 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sergei Poselenov <sposelenov@emcraft.com>
References: <20190524201817.16509-1-jannh@google.com>
 <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
 <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
 <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
Message-ID: <889fc718-b662-8235-5d60-9d330e77cf18@linux-m68k.org>
Date:   Wed, 29 May 2019 22:29:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/5/19 10:05 pm, Arnd Bergmann wrote:
> On Tue, May 28, 2019 at 12:56 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 27/5/19 11:38 pm, Jann Horn wrote:
>>> On Sat, May 25, 2019 at 11:43 PM Andrew Morton
>>> <akpm@linux-foundation.org> wrote:
>>>> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
>>>>> load_flat_shared_library() is broken: It only calls load_flat_file() if
>>>>> prepare_binprm() returns zero, but prepare_binprm() returns the number of
>>>>> bytes read - so this only happens if the file is empty.
>>>>
>>>> ouch.
>>>>
>>>>> Instead, call into load_flat_file() if the number of bytes read is
>>>>> non-negative. (Even if the number of bytes is zero - in that case,
>>>>> load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
>>>>>
>>>>> In addition, remove the code related to bprm creds and stop using
>>>>> prepare_binprm() - this code is loading a library, not a main executable,
>>>>> and it only actually uses the members "buf", "file" and "filename" of the
>>>>> linux_binprm struct. Instead, call kernel_read() directly.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
>>>>> Signed-off-by: Jann Horn <jannh@google.com>
>>>>> ---
>>>>> I only found the bug by looking at the code, I have not verified its
>>>>> existence at runtime.
>>>>> Also, this patch is compile-tested only.
>>>>> It would be nice if someone who works with nommu Linux could have a
>>>>> look at this patch.
>>>>
>>>> 287980e49ffc was three years ago!  Has it really been broken for all
>>>> that time?  If so, it seems a good source of freed disk space...
>>>
>>> Maybe... but I didn't want to rip it out without having one of the
>>> maintainers confirm that this really isn't likely to be used anymore.
>>
>> I have not used shared libraries on m68k non-mmu setups for
>> a very long time. At least 10 years I would think.
> 
> I think Emcraft have a significant customer base running ARM NOMMU
> Linux, I wonder whether they would have run into this (adding
> Sergei to Cc).
> My suspicion is that they use only binfmt-elf-fdpic, not binfmt-flat.
> 
> The only architectures I see that enable binfmt-flat are sh, xtensa
> and h8300, but only arch/sh uses CONFIG_BINFMT_SHARED_FLAT

m68k uses enables it too. It is the only binary format supported
when running no-mmu on m68k. (You can use it with MMU enabled too
if you really want too).

The shared flat format has been used on m68k in the past (it was
originally developed on m68k platforms). But I haven't used them
for a long time (probably 10 years at least) on m68k.

Regards
Greg

