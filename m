Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2479F222CFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGPUfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGPUf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:35:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46DFC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 13:35:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so11567374wmj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9KKssZ/dTd5jFWuQk++quPFGpJEaxp++vXeRWFCVTYg=;
        b=TcYH/jHU1RmQBPJCKXiG0zbJbk6t8T+p4WR/fKwsA07BAUPP4VqbUfrlpPWqF+0UiM
         aslyup07dAKKGj1vxS9qXutKQzsMcEXQbXq4CTy9RwVdw9DdCJS0Ahbtc/p7cV6ngjeI
         rh6Q8XL8U+5dtOZTRfteBdf+eio7fNkRoMQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9KKssZ/dTd5jFWuQk++quPFGpJEaxp++vXeRWFCVTYg=;
        b=PZuqWjdJfWM5CAwKIhcGLGCOBRZMW1clIOEC1jTyeeiqPaGYIDdyv9FDTAK0OuaJ35
         Zre3SnFzHFL8O68MP0UcKU9Gy42acsH2sYyGLxJnkaBfpm3iwKO4si0VpinDUgBIRGMU
         LjA5tXy5aM1mKg7Lo1pBI2Y1RcnaMeh8VMSabD9VaenOE0VuFJTxgVOPUnsSU0gXqJCj
         eYphMX9SqSp8QEEfkF5FXzRu+tGY+gsE8E65fZavCdhiHKD29mphafCX7YRv24kEzjpC
         36gH4DgdCwMpsH9GRtJaINAj2PXzJRNbD5jYndnsjcvB02r98LXZE/9NHHbHnof+HXxa
         9ysw==
X-Gm-Message-State: AOAM533HbMgDlSXjbeOe4s5tqAHFzoIxLgIqqlSsf7Zxfe8O4tb3n/yt
        xPWxpSn/AcA88d4rdCHiG8Kn+A==
X-Google-Smtp-Source: ABdhPJwP6NWxHHZE4jgbCtjpWDSnq8sR96EVizFQf4hhI6jzl9kIJSa2hoPAe1ShiSsc4DVR7x6Big==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr5761554wme.186.1594931727116;
        Thu, 16 Jul 2020 13:35:27 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 14sm10031229wmk.19.2020.07.16.13.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 13:35:26 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
 <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
 <202007101543.912633AA73@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9ba08503-e515-6761-63de-a3b611720b1b@broadcom.com>
Date:   Thu, 16 Jul 2020 13:35:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007101543.912633AA73@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees

On 2020-07-10 3:44 p.m., Kees Cook wrote:
> On Fri, Jul 10, 2020 at 03:10:25PM -0700, Scott Branden wrote:
>>
>> On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
>>> On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
>>>>> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>>>>     		goto out;
>>>>>     	}
>>>>> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
>>>>> -		*buf = vmalloc(i_size);
>>>>> +	if (!*buf)
>>>> The assumption that *buf is always NULL when id !=
>>>> READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
>>>> I get unhandled page faults due to this change on boot.
>>> Did it give you a stack backtrace?
>> Yes, but there's no requirement that *buf need to be NULL when calling this
>> function.
>> To fix my particular crash I added the following locally:
>>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
>> __user *, uargs, int, flags)
>>   {
>>       struct load_info info = { };
>>       loff_t size;
>> -    void *hdr;
>> +    void *hdr = NULL;
>>       int err;
>>
>>       err = may_init_module();
> Thanks for the diagnosis and fix! I haven't had time to cycle back
> around to this series yet. Hopefully soon. :)
>
In order to assist in your patchset I have combined it with my patch 
series here:
https://github.com/sbranden/linux/tree/kernel_read_file_for_kees

Please let me know if this matches your expectations for my patches or 
if there is something else I need to change.

Thanks,
Scott



