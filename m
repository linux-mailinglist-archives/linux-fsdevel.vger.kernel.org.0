Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86546168663
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgBUSXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:23:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40062 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgBUSXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:23:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2901239wmi.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 10:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=el0ksJbOaCzUgbQQlOdxCAczDgGJZ08IsAkqI71psIE=;
        b=JJd2icL1qjAUrXOYho8MTDEJu+K4IobYWsBZeg0w/qRU4Rs1SfWnWRv0Vo09VjqD8X
         UUdtVwRy2eNM7ZZ5gGp5d4+KME3tnAciw2KQZWZ+H1lGcdWYIXyOYQR/ziz5xaGCD19L
         gwVfS8Z2Eij1tCyGwa+maXTsvzgfh9scgHCfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=el0ksJbOaCzUgbQQlOdxCAczDgGJZ08IsAkqI71psIE=;
        b=fkpwesmvEm7AgSqq0ROC41M83+SE93tUnLQy0EcbraRl1gKFR2m1F4WpxWvHEhB0Uo
         VvG7X+jqEXZsmF2A38fW+q6/au6Poy2QBpWjPLzPZ7418y8P+jpg1cb1SwyBvWcHU/lw
         4+jffh1yUtfvTUvVJ0aZjfxUS24W+r4+T1wYiR44dc1PIxkkteLqvsCEGmF+zt1oI+zi
         n711QaxMijTfYPtzM0nBzlf7K2e1lOsfanEAbLbSvnT5Rrqq/L4ylOiNKibVzq+ct5bC
         H+KM7s6W6Wxoadj5OVxyuUnIKhKoE+jNMBcb9vBn2mmJyDrmgD5l0QlsKWP+1x1FiyA9
         BCAA==
X-Gm-Message-State: APjAAAVviLigM1bOOoLJap48BQUQ5rGEf7cVoeWFD7mCWGlw9HNoDkgt
        aM/43FpJR5XjtjcAtkztE/ERlQ==
X-Google-Smtp-Source: APXvYqx4zkQNTAzHsaS1HJ4Q9vOk7i7H0fXR5nL1AHhodIvw7c+ts75n1DYhqiJupD1CUbSs1LvWGQ==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr4959041wmh.113.1582309410725;
        Fri, 21 Feb 2020 10:23:30 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f8sm4696963wru.12.2020.02.21.10.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:23:27 -0800 (PST)
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
Message-ID: <c3bf2985-78d3-ae98-a19d-a596f42a22ce@broadcom.com>
Date:   Fri, 21 Feb 2020 10:23:21 -0800
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
We don't want to allocate to intermediate memory and do another memcpy 
just to write to pcie.
I will have to look into the linux request_firmware_info_buf code and 
detect whether the buf being request to is
in kernel or io memory and perform the operation there.  Hopefully such 
is possible.
>
>          Arnd

