Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387481D1E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbgEMS5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390513AbgEMS5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:57:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4878C05BD09
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 11:57:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u15so196791plm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=olYgNFifDF5Ql8cvhPsDTbAfAKaoIaJE4DaDog+mNS4=;
        b=Mxga3zG+/llCfFVNMb4pfupbzjfgaM9EEesFiwESfHj8FFQxGRavYEICkCcOqf1FNC
         WEltsqblrtZzlLWK+i4JwtOaroJ1sJY3Et7c7VKZ2VMKq2LBYLjkFaGsc+g3KmoJbwpe
         9gJXssiGnu0P62bGFSfvvpRogr+D+sPmJasFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=olYgNFifDF5Ql8cvhPsDTbAfAKaoIaJE4DaDog+mNS4=;
        b=SZE4WgEhvkFV5G/a7+0HoOR9/9sei6wGD4ORsvhDyb8MFLA/+If0uug4Di5tHZOzOa
         r9kHacG/ikMfA8dsWuZi+QmV/3mBGqJ/PwUowUi/pcgvyxHw23wPX22d2WDeHwT0nJFZ
         A08sSQh3U+CyakS0f70K7YmzEpyNQ4dYQ++yECLag/E8+mecxKQHdzlkhXreHaSm/wKi
         88G3xfk6DoT8jEekanmjxLuO6ZxAlMUhl8nwRnm15qoiSKIp7j8htj/2g4QF4vyODd5B
         PD2U9HnQBvO3yMKJ+vfgpWO37dodhczFlg8bz571z14EQ7gGrC7PK7t2EuqExGmtWyql
         ECuw==
X-Gm-Message-State: AOAM531Gryt8t0XHfwr6bbDRpX4aWIaPSTA6pr2TSiPalkkItF5RhpvO
        smlKNSJ9HcE9SpZd/UU4WLRp0w==
X-Google-Smtp-Source: ABdhPJyNy9Rl7h8JlfCsAM2l3oYqsGcSQPFVLty424N5CPNqdloYyrOidsbzuToZPmVBZWv6P8ZZzw==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr518815plb.325.1589396234214;
        Wed, 13 May 2020 11:57:14 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm360743pgm.73.2020.05.13.11.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 11:57:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
From:   Scott Branden <scott.branden@broadcom.com>
To:     Mimi Zohar <zohar@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <104a1eea-6b55-d857-04b9-d13aed9a36fd@broadcom.com>
Date:   Wed, 13 May 2020 11:57:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0e6b5f65-8c61-b02e-7d35-b4ae52aebcf3@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-05-13 11:53 a.m., Scott Branden wrote:
> Hi Mimi,
>
> On 2020-05-13 11:39 a.m., Mimi Zohar wrote:
>> [Cc'ing linux-security-module, linux-integrity]
>>
>> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
>>> Add kernel_pread_file* support to kernel to allow for partial read
>>> of files with an offset into the file.  Existing kernel_read_file
>>> functions call new kernel_pread_file functions with offset=0 and
>>> flags=KERNEL_PREAD_FLAG_WHOLE.
>>>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>> <snip>
>>
>>> @@ -941,14 +955,16 @@ int kernel_read_file(struct file *file, void 
>>> **buf, loff_t *size,
> The checkpatch shows this as kernel_read_file when it is actually the 
> new function kernel_pread_file.
typo: "checkpatch" should be "patch diff"
> Please see the call to kernel_pread_file from kernel_read_file in the 
> complete patch rather this snippet.
>>>             if (bytes == 0)
>>>               break;
>>> +
>>> +        buf_pos += bytes;
>>>       }
>>>   -    if (pos != i_size) {
>>> +    if (pos != read_end) {
>>>           ret = -EIO;
>>>           goto out_free;
>>>       }
>>>   -    ret = security_kernel_post_read_file(file, *buf, i_size, id);
>>> +    ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>>>       if (!ret)
>>>           *size = pos;
>> Prior to the patch set that introduced this security hook, firmware
>> would be read twice, once for measuring/appraising the firmware and
>> again reading the file contents into memory.  Partial reads will break
>> both IMA's measuring the file and appraising the file signatures.
> The partial file read support is needed for request_firmware_into_buf 
> from drivers.  The EXPORT_SYMBOL_GPL is being removed so that
> there can be no abuse of the partial file read support.  Such file 
> integrity checks are not needed for this use case.  The partial file 
> (firmware image) is actually downloaded in portions and verified on 
> the device it is loaded to.
>
> Regards,
>  Scott

