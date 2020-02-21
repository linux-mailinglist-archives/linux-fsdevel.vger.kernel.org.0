Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64443168A76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 00:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgBUXhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 18:37:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:37:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so1776057pgm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 15:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U8GTXDQYqxVMWeiE3CeM22iOXjrDkwUgtcNqh51keqY=;
        b=BTbJ9DV5UnhS6c59epTpH7XTEnU2oooXg+g6bAhjUyVbujp1zj/9TaRU8cj0TPZwd3
         CG8U0vdI5gFnoJTHTJLwe669yrJzuJv13qa3AVL8dmiMh5v19I5goaubVFzUpLjj3wTs
         7lQz+6WG62x4T5Z+CFsJPY2Ds6kbuZLZW2JXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U8GTXDQYqxVMWeiE3CeM22iOXjrDkwUgtcNqh51keqY=;
        b=LD/vhunnraxDyp9D4donZXrt+MJ+mYaaZGmwRP6jfAAz8oWRpK3gVGtuqEtznTnv+c
         yz/JomYy2627UYNuU6jmiYv/2WhP5Xe2uUO/ShGw4pggXaRo6xMyrWdSo8CpnlC4MjWa
         Cbi+4K1CGs1UNeZ1Iw3oAJj+dJN586z3QPifx0p42qGIkj0kIK6pmTuSZEXYJiu2SOo0
         q+yLynf0b3J/aXzihcAWIMoC33hmz5MU/X8+LTWgJvN+7MwkLV1avk4jh3ZKTGYHa9dM
         /S3I41KOkGBPdIJWJJcNhQMSD76bXaDEHjGm4NaATETbBgxLKWr0SKdQCgjku0tv1SB4
         V4Qg==
X-Gm-Message-State: APjAAAU4idBuykK3wJLa3y8g6dvyE9TeZHrYjgnNQyoOTZP7NG/lfTcf
        fVmX/3n98GO10MCD6J1Zpzu5mg==
X-Google-Smtp-Source: APXvYqzSKwENjp8Zc5/+UeGf1chfHFs+nHCsMZqHL9BYW/wJmsDWoBM6WNV9QMdjdezOfrljgme5xQ==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr40832260pga.223.1582328272147;
        Fri, 21 Feb 2020 15:37:52 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u23sm3891110pfm.29.2020.02.21.15.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 15:37:51 -0800 (PST)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
 <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com>
 <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com>
 <s5hwoeyj3i5.wl-tiwai@suse.de> <20191011133120.GP16384@42.do-not-panic.com>
 <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
 <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3731a882-8784-b957-7628-49edfa9683e7@broadcom.com>
Date:   Fri, 21 Feb 2020 15:37:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Arnd,

On 2020-02-21 12:44 a.m., Arnd Bergmann wrote:
> On Fri, Feb 21, 2020 at 1:11 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
>> On 2019-10-11 6:31 a.m., Luis Chamberlain wrote:
>>> On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
>>>> On Mon, 26 Aug 2019 19:24:22 +0200,
>>>> Scott Branden wrote:
>>>>> I will admit I am not familiar with every subtlety of PCI
>>>>> accesses. Any comments to the Valkyrie driver in this patch series are
>>>>> appreciated.
>>>>> But not all drivers need to work on all architectures. I can add a
>>>>> depends on x86 64bit architectures to the driver to limit it to such.
>>>> But it's an individual board on PCIe, and should work no matter which
>>>> architecture is?  Or is this really exclusive to x86?
>>> Poke Scott.
>> Yes, this is exclusive to x86.
>> In particular, 64-bit x86 server class machines with PCIe gen3 support.
>> There is no reason for these PCIe boards to run in other lower end
>> machines or architectures.
> It doesn't really matter that much what you expect your customers to
> do with your product, or what works a particular machine today, drivers
> should generally be written in a portable manner anyway and use
> the documented APIs. memcpy() into an __iomem pointer is not
> portable and while it probably works on any x86 machine today, please
> just don't do it. If you use 'sparse' to check your code, that would normally
> result in an address space warning, unless you add __force and a
> long comment explaining why you cannot just use memcpy_to_io()
> instead. At that point, you are already better off usingn memcpy_to_io() ;-)
>
>          Arnd
I am a not performing a memcpy at all right now.
I am calling a request_firmware_into_buf call and do not need to make a 
copy.
This function eventually calls kernel_read_file, which then makes at 
indirect call in __vfs_read to perform the read to memory.
 From there I am lost as to what operation happens to achieve this.
The read function would need to detect the buf is in io space and 
perform the necessary operation.
Anyone with any knowledge on how to make this read to io space would be 
appreciated?

ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
            loff_t *pos)
{
     if (file->f_op->read)
         return file->f_op->read(file, buf, count, pos);
     else if (file->f_op->read_iter)
         return new_sync_read(file, buf, count, pos);
     else
         return -EINVAL;
}

ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
{
     mm_segment_t old_fs;
     ssize_t result;

     old_fs = get_fs();
     set_fs(KERNEL_DS);
     /* The cast to a user pointer is valid due to the set_fs() */
     result = vfs_read(file, (void __user *)buf, count, pos);
     set_fs(old_fs);
     return result;
}

