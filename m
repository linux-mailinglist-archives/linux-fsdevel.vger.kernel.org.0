Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8432DD53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfE2MkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 08:40:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43126 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2MkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 08:40:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn7so1008631plb.10;
        Wed, 29 May 2019 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P4/IUlrr1evi37yoa1wMPw3lbTyHMqQSbn2mIGZdBv0=;
        b=oMtyHtBB6St248zv/nIh+eoYH0Npn5mikvEOv/23yRg4eu5mo8B7V17JXyqlmIg+OA
         efL5010uCcLw/WUd3vGWRxxT/KRk48hM5gHDKt9DMjzxlZsTI07gJ06Iofa/sPC7P+ig
         AUpg3S0nmjUPnudA2vVEXqE6CKXpg/UZ1wsbLBplMvIqHZ0An4522dvy6vrus7y6d9ke
         wHCbM1+FJ5bM1AoRq7hhT9Bjl76W9OTYmj69UDXE9arNOuNe5US43CkJjhOGVfg1NBoF
         qP5KCX5hkHy4S7ks9x36EXPbRHTr2ODY6kvPXny1S8nYUNgOMGCq3OhMErJQyVbgoLW6
         yszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P4/IUlrr1evi37yoa1wMPw3lbTyHMqQSbn2mIGZdBv0=;
        b=lqtQAR7n21FAVAsyzzNlNIrJfFEpxtcxPtf/K8ia++Wg5MIUIQ5XfUaRTOXpYFXL0i
         GT/bCsYCR66/O1512KTvAAZYK5upffQYHhxlSUfYyO3kmws96UP+JqKlGYVbjEFMAkpy
         OuqGUhCOeLRIcDAlrY5RH+3lgVNO8KreVJT6NGnTfwplNQObGb0h/TxAf6j85dG2+GMy
         BAYJz5LXnOsL+CN+hHPLXOH0qqt1PYAhmD7LfguBzMtfxNGS4abgh748futtnQrxpSfY
         +b/GClqxVDXZn9lZ6bUshaWUEPkK3Ar7J39DnXRbJYBobXp5box669VWIEqQwkJiYblF
         wV1A==
X-Gm-Message-State: APjAAAWdKmJUJuAZIEMJY0s/CONJCVQT+nDnsqfoDqQuTU2fFaFCws6f
        xe1Z80SdNGW7EtjfASzwBuA=
X-Google-Smtp-Source: APXvYqxVUuOzE4bbxCoVGQ2RIzcnimP9AyU9zP/BbHERJRgmIpigahXeeg+v8KhBpZpLPyRNv6JPyg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr7508574plp.65.1559133613833;
        Wed, 29 May 2019 05:40:13 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id j14sm21177611pfe.10.2019.05.29.05.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:40:13 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20190524201817.16509-1-jannh@google.com>
 <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
 <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
 <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
Message-ID: <246af630-5957-0cdc-491d-5e59c520ebf6@linux-m68k.org>
Date:   Wed, 29 May 2019 22:40:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 29/5/19 10:32 pm, John Paul Adrian Glaubitz wrote:
> On 5/28/19 12:56 PM, Greg Ungerer wrote:
>>> Maybe... but I didn't want to rip it out without having one of the
>>> maintainers confirm that this really isn't likely to be used anymore.
>>
>> I have not used shared libraries on m68k non-mmu setups for
>> a very long time. At least 10 years I would think.
> We use shared libraries in Debian on m68k and Andreas Schwab uses them
> on openSUSE/m68k.

When used on no-mmu platforms?

Regards
Greg


> So, they should keep working.
> 
> Thanks,
> Adrian
> 
