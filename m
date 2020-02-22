Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97110168B7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 02:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBVBNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 20:13:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBVBNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:13:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so3965950wrx.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 17:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3OKaYIHAkscSICnojjLFVcfWriWY1zhvs1Wig+8n2u0=;
        b=YuZBob4gmx9BoVF20MxUMC4n/O2CRqr7f4PfEbgIjSUOmHRoUON6ioN3lQAp+XaXsc
         YnYlGLs9XUL5tqmnh9TRTJpQR9PkRpU7GY0fmQqqqDpcTwhwfmm1AeAHh63DYxj94wDt
         /6xbAUPlaRkR7P/ddUn1r3McPYwTMEWRdXBmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3OKaYIHAkscSICnojjLFVcfWriWY1zhvs1Wig+8n2u0=;
        b=rRPYdJSIYBYql41r+TOd0Z8Ly+aOmywXEd50kyg+PMoJX+9FC6Do1hVhJnz23/VnS4
         COO+hjoh3671xOUOPHX23LPDJH9l63jcCkRiSMGr3ifXUfIODKIvRA8z2FjufZua2HEb
         Q7tFDh9UJh4MuaYjPvL/6weA6iSLEGvZS63t52+iFks8UXrk6POEodqxbE+fgJgpw4mg
         EQk+2L8g/AyvOw65I1CC2WZDtaLmEINs57erKG7yk/mrdtWHbBdF1Cgkc8rrq1tPVIrB
         Z1QBuPqNldLXvrzzUMJS0VvEM/WO1oHrk1JUMM6TR/DzU/aqO7TJs0l025PV8WZG1yuW
         J/Tg==
X-Gm-Message-State: APjAAAVUVwu1cxgyOGK+ayCnNPWC2zf1Gq+yeoUv6fLlvSogsCSBnADK
        BTyT3h6Yd7lZjTyuMNpBXKWvlQ==
X-Google-Smtp-Source: APXvYqz8IRZ8DqHhpRydE7w0DX5vQbJ06y2qjkNLAGTp9MyxwoZhTc6cNxB8geMHSuyuUmtCGGdTAQ==
X-Received: by 2002:adf:e683:: with SMTP id r3mr54339138wrm.38.1582333995403;
        Fri, 21 Feb 2020 17:13:15 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d4sm6275870wra.14.2020.02.21.17.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 17:13:14 -0800 (PST)
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
From:   Scott Branden <scott.branden@broadcom.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
 <20200220084255.GW7838@kadam>
 <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Message-ID: <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
Date:   Fri, 21 Feb 2020 17:13:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reponses inline.

Luis - please have a look as well.

On 2020-02-21 10:30 a.m., Scott Branden wrote:
> Hi Dan,
>
> Thanks for your review and valuable comments.
> Will have to investigate fully and correct anything wrong.
>
> On 2020-02-20 12:42 a.m., Dan Carpenter wrote:
>> On Wed, Feb 19, 2020 at 04:48:21PM -0800, Scott Branden wrote:
>>> +static int test_dev_config_update_size_t(const char *buf,
>>> +                     size_t size,
>>> +                     size_t *cfg)
>>> +{
>>> +    int ret;
>>> +    long new;
>>> +
>>> +    ret = kstrtol(buf, 10, &new);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (new > SIZE_MAX)
>> This "new" variable is long and SIZE_MAX is ULONG_MAX so the condition
>> can't be true.
Removed the check.
>>
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&test_fw_mutex);
>>> +    *(size_t *)cfg = new;
>>> +    mutex_unlock(&test_fw_mutex);
>>> +
>>> +    /* Always return full write size even if we didn't consume all */
>>> +    return size;
>>> +}
>>> +
>>> +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
>>> +{
>>> +    size_t val;
>>> +
>>> +    mutex_lock(&test_fw_mutex);
>>> +    val = cfg;
>>> +    mutex_unlock(&test_fw_mutex);
>> Both val and cfg are stack variables so there is no need for locking.
>> Probably you meant to pass a pointer to cfg?
I am following the existing code as was done for
test_dev_config_show_bool(),
test_dev_config_show_int(),
test_dev_config_show_u8()

Mutex probably not needed but I don't think I need to deviate from the 
rest of the test code.

Luis, could you please explain what the rest of your code is doing?
>>
>>> +
>>> +    return snprintf(buf, PAGE_SIZE, "%zu\n", val);
>>> +}
>>> +
>>>   static ssize_t test_dev_config_show_int(char *buf, int cfg)
>>>   {
>>>       int val;
>> regards,
>> dan carpenter
>>
>>
>

