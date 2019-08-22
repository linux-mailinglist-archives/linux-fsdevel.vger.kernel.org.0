Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722CA9A0CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfHVUHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 16:07:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbfHVUHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:07:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so4098589plr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T7WELdrj1lpZKb10glO64Ci1A/cHC9qRquQl0ZBFVYE=;
        b=C3g11sbiJLWJXhTVKSRs7RsmwmyNDMWE2NR02ihZhTaX8aV3FEKZ5YdkwOxo6qCVWq
         m8jJkKYj85QU0HpYZJ1Drc4qi0TJV0r3IGjyGWOOP0/s3ieUNAmBO2MVB0IRxNYezn93
         Ta1X+nvAuArVldordiVEZgCtlKT/kaqGj7nFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T7WELdrj1lpZKb10glO64Ci1A/cHC9qRquQl0ZBFVYE=;
        b=W2peexsTFpHFf0Q0iaLNh7YWtp7QFRe6vvOrIzDM27S3FfYO9floXa5zzMhd/FwtFX
         b0l3068jQQmC5s3b8kPkMq04+V2FAS3ONmtMd647ysg+yj/7mYt9dn8s8JNdWYyvd0hx
         nEVuJ3UxZUGe3Hcp0bHfLXO+Fx5OVZs+iIEpbml7n2Hvck533KGem1VFJsrcbwQft811
         IPiIdrB3Hh+iAKsF6iTHVWtUFs1Z4evlCh2SU5NB5G8Xr6s4dNob5aYJoSQdhshAK4iy
         YU2wqnc6QZyVm7X88MlTiHOLmdgYzzscNBeOTm75iX0VFsMCIHQ1Pak4TSABOsBIPYWX
         hxgQ==
X-Gm-Message-State: APjAAAV+LegP0quuL1UNb5tiwVYOtC3yo8vH88Lt2ZIyohpK/hSzv6Nq
        bPTKcNO20fkCt2tFzBop/byn1Q==
X-Google-Smtp-Source: APXvYqwPgliCGszErOKKFpnP9RfEOJ+aybpl80q46iwpUnIp/wgrGOyV1u3N0905b4Kuaoc0P8jo7w==
X-Received: by 2002:a17:902:1027:: with SMTP id b36mr585958pla.203.1566504465286;
        Thu, 22 Aug 2019 13:07:45 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k5sm229441pfg.167.2019.08.22.13.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:07:44 -0700 (PDT)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <20190822194712.GG16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <7ee02971-e177-af05-28e0-90575ebe12e0@broadcom.com>
Date:   Thu, 22 Aug 2019 13:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822194712.GG16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

On 2019-08-22 12:47 p.m., Luis Chamberlain wrote:
> On Thu, Aug 22, 2019 at 12:24:46PM -0700, Scott Branden wrote:
>> @@ -923,16 +936,22 @@ EXPORT_SYMBOL_GPL(firmware_request_cache);
>>    */
>>   int
>>   request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
>> -			  struct device *device, void *buf, size_t size)
>> +			  struct device *device, void *buf, size_t size,
>> +			  size_t offset, unsigned int pread_flags)
> This implies you having to change the other callers, and while currently
> our list of drivers is small,

Yes, the list is small, very small.

There is a single driver making a call to the existing API.

And, the existing API was never tested until I submitted a test case.

And, the maintainer of that driver wanted

to start utilizing my enhanced API instead of the current API.

As such I think it is very reasonable to update the API right now.

> following the history of the firmware API
> and the long history of debate of *how* we should evolve its API, its
> preferred we add yet another new caller for this functionality. So
> please add a new caller, and use EXPORT_SYMBOL_GPL().
>
> And while at it, pleaase use firmware_request_*() as the prefix, as we
> have want to use that as the instilled prefix. We have yet to complete
> the rename of the others older callers but its just a matter of time.
>
> So something like: firmware_request_into_buf_offset()

I would prefer to rename the API at this time given there is only a 
single user.

Otherwise I would need to duplicate quite a bit in the test code to 
support testing

the single user of the old api and then enhanced API.

Or, I can leave existing API in place and change the test case to

just test the enhanced API to keep things simpler in the test code?

>
> And thanks for adding a test case!
>
>    Luis

Regards,

  Scott

