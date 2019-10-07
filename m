Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF059CE163
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJGMQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 08:16:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfJGMQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:16:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so5314162plo.2;
        Mon, 07 Oct 2019 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5on/5THDGr0FTVE93D1DksMY2m/icc8L62Rjb72VT6M=;
        b=ZHHtrWMrMw1ZM3ClD+XwTg1ixkQcdoOd24VVzmMIjMZ0iwW7DrW2BTBj8ZlfuFgNDI
         65KhfgT00GZWTvwZQmZVZEWePaBc2VGvNh65GNvN0gk/jAEewqx2AQVspN3WZUwRIPtF
         GQFPBFlSCxfGodFzEaRjgBwWz2ZiP+WkwzREZbqZhS1iyqW/XhwNJ1EM9s5VzB2/EwfE
         SQAYjaOqWWm95m0kTsRdK8mcEq+6APz2TPBGgQ7ESqo2I6qZNTSdVXkvYoXlPqh8hGeG
         sLOSoovB5+Y/glJ0nyVxyNWwdK4H6ChhuwjBSgB/vA/cllGDVTYbnKiqgUPNau/YJdK7
         BjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5on/5THDGr0FTVE93D1DksMY2m/icc8L62Rjb72VT6M=;
        b=SqExMujSd+mZeYlfpdgmJUTZ6DnPiSo2IU+x5lc1o14t4yAZEsQzyw/wC6/DkakdMW
         Dvc1ib4lNM9BcqmVmh7Pud4UlA107xGG0xi09gRN6E8/Jae8kly4goKuPgc6LAanoawn
         ym2F6PF1SSwM21LTvZLj32HX+HidwfkfO3PxffOC4HW0QqTeJbeA4f2AXVagwBImdRhg
         9gYJ8/0P26CYYRY5AWf7LfnVK6kbnvnyC+GSoJLIoxWOueYileBMrCRc3QAH7HfYhb5l
         6Ajc8mRt3baOjBj8AbSeoUHbO1m2AQjBWHeVC+YK+gm1okPgHdVt8P0I3KkgHGb2THXB
         WHmQ==
X-Gm-Message-State: APjAAAUwRGdRcNwaeAnTcgn9lbL8Zocg9sIzDVuzsBnJGKx052lHVwqB
        MiXtfhl9a8+mdcxo2czoAsXWhfTu
X-Google-Smtp-Source: APXvYqzbRj0lokpGHCLI0hUfbbSCF50ahzf0bAwozYzufUwgWGJzpn8g17fJMtAMIiQ6oFcSF4sRdw==
X-Received: by 2002:a17:902:b94b:: with SMTP id h11mr27691653pls.164.1570450618400;
        Mon, 07 Oct 2019 05:16:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm15774756pfg.164.2019.10.07.05.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:16:57 -0700 (PDT)
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20191006222046.GA18027@roeck-us.net>
 <CAMo8BfJHcLQ_TuacCwdhQYB-nhpdBrCq5EuB=E7SafP15=kd3A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d6726d0f-3412-b5e9-fbd1-2dae302f0ef3@roeck-us.net>
Date:   Mon, 7 Oct 2019 05:16:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJHcLQ_TuacCwdhQYB-nhpdBrCq5EuB=E7SafP15=kd3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Max,

On 10/6/19 9:04 PM, Max Filippov wrote:
> On Sun, Oct 6, 2019 at 3:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> this patch causes all my sparc64 emulations to stall during boot. It causes
>> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
>> disk, and one of the xtensa emulations to crash with [2].
> 
> [...]
> 
>> [2]
>>
>> Unable to handle kernel paging request at virtual address 0000000000000004
>> reboot(50): Oops -1
>> pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Tainted: G      D
>> pc is at 0x4
>> ra is at filldir64+0x64/0x320
>> v0 = 0000000000000000  t0 = 0000000067736d6b  t1 = 000000012011445b
>> t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000007ef8
>> t5 = 0000000120114448  t6 = 0000000000000000  t7 = fffffc0007eec000
>> s0 = fffffc000792b5c3  s1 = 0000000000000004  s2 = 0000000000000018
>> s3 = fffffc0007eefec8  s4 = 0000000000000008  s5 = 00000000f00000a3
>> s6 = 000000000000000b
>> a0 = fffffc000792b5c3  a1 = 2f2f2f2f2f2f2f2f  a2 = 0000000000000004
>> a3 = 000000000000000b  a4 = 00000000f00000a3  a5 = 0000000000000008
>> t8 = 0000000000000018  t9 = 0000000000000000  t10= 0000000022e1d02a
>> t11= 000000011fd6f3b8  pv = fffffc0000b9a810  at = 0000000022e1ccf8
>> gp = fffffc0000f03930  sp = (____ptrval____)
>> Trace:
>> [<fffffc00004ccba0>] proc_readdir_de+0x170/0x300
>> [<fffffc0000451280>] filldir64+0x0/0x320
>> [<fffffc00004c565c>] proc_root_readdir+0x3c/0x80
>> [<fffffc0000450c68>] iterate_dir+0x198/0x240
>> [<fffffc00004518b8>] ksys_getdents64+0xa8/0x160
>> [<fffffc0000451990>] sys_getdents64+0x20/0x40
>> [<fffffc0000451280>] filldir64+0x0/0x320
>> [<fffffc0000311634>] entSys+0xa4/0xc0
> 
> This doesn't look like a dump from xtensa core.
> v5.4-rc2 kernel doesn't crash for me on xtensa, but the userspace
> doesn't work well, because all directories appear to be empty.
> 
> __put_user/__get_user don't do unaligned access on xtensa,
> they check address alignment and return -EFAULT if it's bad.
> 
You are right, sorry; I must have mixed that up. xtensa doesn't crash.
The boot stalls, similar to sparc64. This is only seen with my nommu
test (de212:kc705-nommu:nommu_kc705_defconfig). xtensa mmu tests are fine,
at least for me, but then I only run tests with initrd (which for some
reason doesn't crash on alpha either).

Guenter
