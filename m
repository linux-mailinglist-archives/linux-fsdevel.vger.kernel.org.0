Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3938217E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgGHEvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgGHEvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:51:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0703C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 21:51:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so1505836wmj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 21:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YM0IzGADgX2tl1Mp5AFtyEMSY+GtGZFBS0TzG37PEVo=;
        b=WUXj1hnghzt3S3Xl8PkHIhKgc4y1+imaFlRTqYId1bXkQETCFWvksi9OaC5IchDWnN
         /G3tZ3QPpXYdo0LQXnUBTJmqJT9KSLHL1W0ppqEv0GzEoRLMsgv7oAFu9hXuZV3qNwUU
         EmbTjiaI3Wsm/bQlCldA6nvGa0OVis92xbh6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YM0IzGADgX2tl1Mp5AFtyEMSY+GtGZFBS0TzG37PEVo=;
        b=NHHpVq24+4v9T09Eq8JbmnFivBpRJDwy4RUAzkg20CeRKPe8HfJfCSCwq8lj/Pbb63
         dM3WbSjyolTV/vRAUqkXkEVJ6jFfMOdmG2yxh+jaG840YJBw65QrMRuKjeeU0OTC5gW2
         yQOL9bSfHI/PeIa1w0b4Vzm4SYmOUtaYWuJsetfxiDpbAx3YP71HbDXq7hxUz5vILPqQ
         LSvhB2q1l/RS98ARAhbjTkqaq81U50CZXZYhQqYFYVC5a7m7XxPLPbdfdZNvNVli89u1
         8h2Dlt3MNfvyf+MXH6uhrmz4Yanjk+epK6sLeRcm5Oluebqxw8//Bn6h4Ar8O11oqr8r
         iLqg==
X-Gm-Message-State: AOAM531OtL6KSKVjXV132Vr4aLhJtnwi+NTiCa3RjJ7Q4iF0e1zencO2
        CIIe39uiUj8rZwNs+s7LUq7CUg==
X-Google-Smtp-Source: ABdhPJxCmxanR1p+Zv9NtrwZXxJyNGR3oD42FStMXE5QtLw0GpBvXi6oEnvGhedpl11EqTWK1HD1Eg==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr7135332wmf.140.1594183908367;
        Tue, 07 Jul 2020 21:51:48 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y7sm3843597wrt.11.2020.07.07.21.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:51:47 -0700 (PDT)
Subject: Re: [PATCH v10 0/9] firmware: add request_partial_firmware_into_buf
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <c8bbabe6-0b25-a816-f95d-8af63010eaf2@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6c6126cc-6572-b341-7808-5e573d0cfad8@broadcom.com>
Date:   Tue, 7 Jul 2020 21:51:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c8bbabe6-0b25-a816-f95d-8af63010eaf2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Florian,

On 2020-07-07 9:38 p.m., Florian Fainelli wrote:
>
> On 7/6/2020 4:23 PM, Scott Branden wrote:
>> This patch series adds partial read support via a new call
>> request_partial_firmware_into_buf.
>> Such support is needed when the whole file is not needed and/or
>> only a smaller portion of the file will fit into allocated memory
>> at any one time.
>> In order to accept the enhanced API it has been requested that kernel
>> selftests and upstreamed driver utilize the API enhancement and so
>> are included in this patch series.
>>
>> Also in this patch series is the addition of a new Broadcom VK driver
>> utilizing the new request_firmware_into_buf enhanced API.
>>
>> Further comment followed to add IMA support of the partial reads
>> originating from request_firmware_into_buf calls.  And another request
>> to move existing kernel_read_file* functions to its own include file.
> Do you have any way to separate the VK drivers submission from the
> request_partial_firmware_into_buf() work that you are doing? It looks
> like it is going to require quite a few iterations of this patch set for
> the firmware/fs/IMA part to be ironed out, so if you could get your
> driver separated out, it might help you achieve partial success here.
Originally I did not submit the driver.
But Greg K-H rejected the pread support unless there was an actual user 
in the kernel.
Hence the need to submit this all in the patch series.

