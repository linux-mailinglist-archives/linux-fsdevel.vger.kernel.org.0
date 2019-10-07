Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24224CEF92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfJGX1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 19:27:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36877 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGX1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:27:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so7366803pgi.4;
        Mon, 07 Oct 2019 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=drQ9Fuuxi5Om0DBUu3npjjuPKc/L/4rbp0fQkiAHqys=;
        b=uPpPwqvM60vSTr9/8C0E+zGlG1O+KN8Pl13BdBDAuLgLLsUjfrrEsmeBDWTRJGjINa
         toKFtGKzbQ8zeWEVIZn50hFSd1kyXgibJKbvX+Vb1QAwjE+ZQb/N6kKx+0/tdKRaoFFn
         ndFaUuJr1eH0vsh8DwKu5m5BlLfgQfU59RP7QSgUVT12Y5b/zpjyeGt+SiaKkkt0Mf5D
         5TtSXh8B3Homx22X3GOo6f7YUw2amryf6dVl+cK63HgeZC+f40MLpCb8N7JTtC/6dAkv
         zkVXsVxucGxemp069QPD+uh032vWvsnQFdUpAhl//l7r1FvH1j7ZW4jF0fVO0SenqJ1t
         rCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drQ9Fuuxi5Om0DBUu3npjjuPKc/L/4rbp0fQkiAHqys=;
        b=iovhUHkPHfHL6IZyRmd2zpZgmdcWqY1ay8Ww4hQa78tngEUoO1mXsAHcRbjpxHcgI/
         QpqowqsuQvjhcQLy82+uNXsp8nvOxDyy9+VROU74BOAgkj3/IW9mEQFRgz+sWkeFg8hM
         eT4BDdNDVAICSLnoYP6qRDvZ+/pSXjfyaMrHc3o6xAU0WRXetzuRxqN57pDX5qz1mmjP
         AIz53Nwmr26cySHob3N06kOKTT5sd75G1ON2WxKuAu6XaKB6Dr9df2wFjGx9LhmCdVv0
         E0Q+DgIIcJwKxKvOUG6/Y2C3OXLERAwyxGUPKp5kYJAgAm0TFiRWtlVL2AiR3BJYJ5YW
         anJA==
X-Gm-Message-State: APjAAAWoS/bL4rDC8jjI+g3IcH+wsPJq7jgItYF9iOm/SB71Z+2VcBdm
        RbSsdwz4fg2l1RVVFrzEdIFMK1GB
X-Google-Smtp-Source: APXvYqw7YeEWzoTom/YFQPRYESwUQpoAVrTnf72HEU9CmBiIDC11AmsFOdHgwZwU7m4RcGjSBrt5iA==
X-Received: by 2002:a65:4007:: with SMTP id f7mr5940848pgp.88.1570490823892;
        Mon, 07 Oct 2019 16:27:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r21sm16957247pgm.78.2019.10.07.16.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 16:27:03 -0700 (PDT)
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Cree <mcree@orcon.net.nz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
Date:   Mon, 7 Oct 2019 16:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/19 12:21 PM, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> this patch causes all my sparc64 emulations to stall during boot. It causes
>> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
>> disk, and one of the xtensa emulations to crash with [2].
> 
> So I think your alpha emulation environment may be broken, because
> Michael Cree reports that it works for him on real hardware, but he
> does see the kernel unaligned count being high.
> 
> But regardless, this is my current fairly minimal patch that I think
> should fix the unaligned issue, while still giving the behavior we
> want on x86. I hope Al can do something nicer, but I think this is
> "acceptable".
> 
> I'm running this now on x86, and I verified that x86-32 code
> generation looks sane too, but it woudl be good to verify that this
> makes the alignment issue go away on other architectures.
> 
>                  Linus
> 

Test results look good. Feel free to add
Tested-by: Guenter Roeck <linux@roeck-us.net>
to your patch.

Build results:
	total: 158 pass: 154 fail: 4
Failed builds:
	arm:allmodconfig
	m68k:defconfig
	mips:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 391 pass: 390 fail: 1
Failed tests:
	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd

This is with "regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF"
applied as well. The other failures are unrelated.

arm:

arch/arm/crypto/aes-ce-core.S:299: Error:
	selected processor does not support `movw ip,:lower16:.Lcts_permute_table' in ARM mode

Fix is pending in crypto tree.

m68k:

c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'

I don't know the status.

mips:

drivers/staging/octeon/ethernet-defines.h:30:38: error:
		'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared
and other similar errors. I don't know the status.

ppc64:

powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x18): undefined reference to `node_reclaim_distance'

Reported against offending patch earlier today.

sparc64:

drivers/watchdog/cpwd.c:500:19: error: 'compat_ptr_ioctl' undeclared here

Oops. I'll need to look into that. Looks like the patch to use a new
infrastructure made it into the kernel but the infrastructure itself
didn't make it after all.

Guenter
