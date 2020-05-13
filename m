Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68E1D2258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 00:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgEMWsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbgEMWsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 18:48:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DA8C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 15:48:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so11612707pjd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=H+AfxUaMnhwNQoaeoLBhnhy670cA4ggBoeJoS1eRurw=;
        b=JGD7HQd4cFtwAgY6blAgbXdG6kcGmAAG1VWu80Jyf2foqmg/CPidgYdJYYyspMDrP4
         /EVgNm2nMhqtWEvVGt5m0mjK4HAef18Jhth28pHYJDCID+v52/KeMHGrvvt4kUngLxIi
         v69i+/VoYcfURFZw1kflWQB7jS9mJAyZnR3NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=H+AfxUaMnhwNQoaeoLBhnhy670cA4ggBoeJoS1eRurw=;
        b=i3fdcpmc7eM+nuRFLOsZX/cYL4dWBII5YvCYfQ5DU6XqZIPnBKjB7jyWwOBnBchxCU
         nFTmsneXycnwctt5msUBuN/SqgowjpAna43y8zPSmaKO0l6LD8ugb9AkLZRVZyqi0RJU
         2gpO0v+aZAAooorMpkgEb+rJdEPWTZX8xZbcIAoiZwYAsTQZ27/5tlkd062F3jBfOEb4
         V9Ck1QiozGFNI0oz7XOMZ2GVYaofvAtfuMRRGrjtFIitP79kFsavPafl04EsJrUu1kTQ
         xq4fOP3r8i5UloD15iXZ+ZB3yeuM1Mf3TLjswtv7Ye1omP/Npeocua8PzqYWzAcQdLOT
         pVOA==
X-Gm-Message-State: AOAM532aSr5qTIocmCZZMEtPmXw3voCyEagHTTwmnOJd/V//ZAuEmmp8
        iImF7iewenQ3QDeG8DYy7B8jLw==
X-Google-Smtp-Source: ABdhPJybl/6AytHcx4YvEW8rJAb5cTYd9TKvgTzZxRiFPIg0ucMe2oMrD9kjvJc/qEKo/373gAT/Yg==
X-Received: by 2002:a17:902:465:: with SMTP id 92mr1264035ple.227.1589410093370;
        Wed, 13 May 2020 15:48:13 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f64sm16806846pjd.5.2020.05.13.15.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 15:48:12 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
To:     Mimi Zohar <zohar@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <1589395153.5098.158.camel@kernel.org>
 <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
 <1589396593.5098.166.camel@kernel.org>
 <e1b92047-7003-0615-3d58-1388ec27c78a@broadcom.com>
 <1589398747.5098.178.camel@kernel.org>
 <a228ae0f-d551-e0e8-446e-5ae63462c520@broadcom.com>
 <1589404814.5098.185.camel@kernel.org>
 <20200513212847.GT11244@42.do-not-panic.com>
 <1589407924.5098.208.camel@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f8de785c-60df-3fec-c2c6-b1dd2c77db17@broadcom.com>
Date:   Wed, 13 May 2020 15:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589407924.5098.208.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-05-13 3:12 p.m., Mimi Zohar wrote:
> On Wed, 2020-05-13 at 21:28 +0000, Luis Chamberlain wrote:
>> On Wed, May 13, 2020 at 05:20:14PM -0400, Mimi Zohar wrote:
>>> On Wed, 2020-05-13 at 12:41 -0700, Scott Branden wrote:
>>>> On 2020-05-13 12:39 p.m., Mimi Zohar wrote:
>>>>> On Wed, 2020-05-13 at 12:18 -0700, Scott Branden wrote:
>>>>>> On 2020-05-13 12:03 p.m., Mimi Zohar wrote:
>>>>>>> On Wed, 2020-05-13 at 11:53 -0700, Scott Branden wrote:
>>>>>> Even if the kernel successfully verified the firmware file signature it
>>>>>> would just be wasting its time.  The kernel in these use cases is not always
>>>>>> trusted.  The device needs to authenticate the firmware image itself.
>>>>> There are also environments where the kernel is trusted and limits the
>>>>> firmware being provided to the device to one which they signed.
>>>>>
>>>>>>> The device firmware is being downloaded piecemeal from somewhere and
>>>>>>> won't be measured?
>>>>>> It doesn't need to be measured for current driver needs.
>>>>> Sure the device doesn't need the kernel measuring the firmware, but
>>>>> hardened environments do measure firmware.
>>>>>
>>>>>> If someone has such need the infrastructure could be added to the kernel
>>>>>> at a later date.  Existing functionality is not broken in any way by
>>>>>> this patch series.
>>>>> Wow!  You're saying that your patch set takes precedence over the
>>>>> existing expectations and can break them.
>>>> Huh? I said existing functionality is NOT broken by this patch series.
>>> Assuming a system is configured to measure and appraise firmware
>>> (rules below), with this change the firmware file will not be properly
>>> measured and will fail signature verification.
So no existing functionality has been broken.
>>>
>>> Sample IMA policy rules:
>>> measure func=FIRMWARE_CHECK
>>> appraise func=FIRMWARE_CHECK appraise_type=imasig
>> Would a pre and post lsm hook for pread do it?
> IMA currently measures and verifies the firmware file signature on the
> post hook.  The file is read once into a buffer.  With this change,
> IMA would need to be on the pre hook, to read the entire file,
> calculating the file hash and verifying the file signature.  Basically
> the firmware would be read once for IMA and again for the device.
The entire file may not fit into available memory to measure and 
verify.  Hence the reason for a partial read.

Is there some way we could add a flag when calling the 
request_firmware_into_buf to indicate it is ok that the data requested 
does not need to be measured?
> Mimi

