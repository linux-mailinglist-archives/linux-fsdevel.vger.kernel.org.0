Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00230949B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHSQT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 12:19:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39608 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSQTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:19:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so1195883pln.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IKQPktxfBXL0jaMh5fXrtktV3oFNbQQrLd0UoqhuRhc=;
        b=DMMQAXvJwkyqlEk1Z2h6vxJfOKFQi1ug7u+ZCzbyrKi+g/PxG2u7ifgSTSxzvSFtTP
         NJJMZIEShk0FdmE/MIxJo6xftNZtiYT8lUOEb6UB5ZW8t/hX6r7XTUGfwL2XWBBCgW5C
         KhxIeYon6r88GtPZSxPpSVLKZ5sjyT76+UC2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IKQPktxfBXL0jaMh5fXrtktV3oFNbQQrLd0UoqhuRhc=;
        b=sHOe9qSOWLG2tirmN9gMngtNB271rj6cOciIbrDQTkf/sodDVU8ABh07TgjNyNbUeY
         1fWMCrR7YFrz1aw80ZF8d4kEw+nxEYT7IXtZtMRzZ62tp8oCzmmUeytLbtPVpS8rbocV
         3vTQF0RUibvcYod0SHHNrCj6gjCF6GwlubeSm860F+KFZI7SAhKTNQhsdy2T2rFEnquZ
         FiydWxBmMo9p7PlzWkPxC9BfNuGG7x+113yhPH2fieZ1OldCpx4iR+gSR2q4RxljVctm
         9Ootajc/nbQrt6/4eAG/0fNr1aRQP3wXWGITUax1pXb5tCuq/kyWtzOy2kWl5G4GLw8F
         lwAw==
X-Gm-Message-State: APjAAAVvbkqoOQyne3qMztLiDO0yem7mXYKZkYeooG9MqjmmRUXo9WXN
        sBA3Vg1ARrM+z/L3BuZsSD2Wnw==
X-Google-Smtp-Source: APXvYqwggUe1ybtvS8MZcOslAorQNN7iDpcavR1/jeVJFyWXp1Q8jgD3DpZL12K988TGev7L7T6nYg==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr23927025pls.189.1566231594942;
        Mon, 19 Aug 2019 09:19:54 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c22sm8016983pfi.82.2019.08.19.09.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:19:54 -0700 (PDT)
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
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
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
Date:   Mon, 19 Aug 2019 09:19:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819053937.GR16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

Thanks for the review.

I did not think this patch would be the final solution either

as indicated in the original cover letter and code comment.

Some comments inline.

On 2019-08-18 10:39 p.m., Luis Chamberlain wrote:

> On Thu, Aug 15, 2019 at 05:09:45PM -0700, Scott Branden wrote:
>> A race condition exists between _request_firmware_prepare checking
>> if firmware is assigned and firmware_fallback_sysfs creating a sysfs
>> entry (kernel trace below).  To avoid such condition add a mutex
>> fw_lock_fallback to protect against such condition.
> I am not buying this fix, and it seems sloppy. More below.
>
>> misc test_firmware: Falling back to sysfs fallback for: nope-test-firmware.bin
> So the fallback kicks in with the file that is not there.
>
>> sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'
> And we have a duplicate entry, for the *device* created to allow us to
> create a file entry to allow us to copy the file. Your tests had a loop,
> so there is actually a race between two entries being created while
> one one failed.
>
>> CPU: 4 PID: 2059 Comm: test_firmware-3 Not tainted 5.3.0-rc4 #1
>> Hardware name: Dell Inc. OptiPlex 7010/0KRC95, BIOS A13 03/25/2013
>> Call Trace:
>>   dump_stack+0x67/0x90
>>   sysfs_warn_dup.cold+0x17/0x24
>>   sysfs_create_dir_ns+0xb3/0xd0
>>   kobject_add_internal+0xa6/0x2a0
>>   kobject_add+0x7e/0xb0
> Note: kobject_add().
>
>>   ? _cond_resched+0x15/0x30
>>   device_add+0x121/0x670
>>   firmware_fallback_sysfs+0x15c/0x3c9
>>   _request_firmware+0x432/0x5a0
>>   ? devres_find+0x63/0xc0
>>   request_firmware_into_buf+0x63/0x80
>>   test_fw_run_batch_request+0x96/0xe0
>>   kthread+0xfb/0x130
>>   ? reset_store+0x30/0x30
>>   ? kthread_park+0x80/0x80
>>   ret_from_fork+0x3a/0x50
>> kobject_add_internal failed for nope-test-firmware.bin with -EEXIST, don't try to register things with the same name in the same directory.
> So above it makes it even clearer, two kobjets with the same name.
>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/base/firmware_loader/main.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>> index bf44c79beae9..ce9896e3b782 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -88,6 +88,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
>>   /* fw_lock could be moved to 'struct fw_sysfs' but since it is just
>>    * guarding for corner cases a global lock should be OK */
>>   DEFINE_MUTEX(fw_lock);
>> +DEFINE_MUTEX(fw_lock_fallback);
> The reason I don't like this fix is that this mutex is named after ther
> fallback interface... but...
>
>>   
>>   static struct firmware_cache fw_cache;
>>   
>> @@ -758,6 +759,17 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>>   	if (!firmware_p)
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * There is a race condition between _request_firmware_prepare checking
>> +	 * if firmware is assigned and firmware_fallback_sysfs creating sysfs
>> +	 * entries with duplicate names.
>> +	 * Yet, with this lock the firmware_test locks up with cache enabled
>> +	 * and no event used during firmware test.
>> +	 * This points to some very racy code I don't know how to entirely fix.
>> +	 */
>> +	if (opt_flags & FW_OPT_NOCACHE)
>> +		mutex_lock(&fw_lock_fallback);
> Whoa.. What does no-cache have anything to do with the fallback interface
> other than the fact we enable this feature for the fallback interface?
> We don't need to penalize non-fallback users who *also* may want to
> enable the no-cache feature.
>
> So, the fix should be within the boundaries of the creation / deletion
> of the kobject, not this nocache feature. Can you please re-evaluate
> this code and look for a more compartamentalized solution to the
> fallback code only?

To be honest, I find the entire firmware code sloppy.  I don't think the 
cache/no-cache feature is

implemented or tested properly nor fallback to begin with.  I'm not 
claiming this patch is the final

solution and indicated such in the cover letter and the comment above.

I hope there is someone more familiar with this code to comment further 
and come up with a proper solution.


I have found numerous issues and race conditions with the firmware code 
(I simply added a test).

1) Try loading the same valid firmware using no-cache once it has 
already been loaded with cache.

It won't work, which is why I had to use a different filename in the 
test for request_firmware_into_buf.

2) Try removing the "if (opt_flags & FW_OPT_NOCACHE)" in my patch and 
always call the mutex.

The firmware test will lock up during a "no uevent" test.  I am not 
familiar with the code to

know why such is true and what issue this exposes in the code.

3) I have a driver that uses request_firmware_into_buf and have multiple 
instances of the driver

loading the same firmware in parallel.  Some of the data is not read 
correctly in each instance.

I haven't yet to reproduce this issue with the firmware test but 
currently have a mutex around the entire

call to request_firmware_into_buf in our driver.


Perhaps it is better at this point to add a mutex in 
request_firmware_into_buf to make is entirely safe?

(Perhaps even with every request_firmware functions as none seems to be 
tested properly.)

Or, add a new function called safe_request_firmware_into_buf with such 
mutex to protect the function.

The current racey request_firmware functions could then be left alone 
and those who want reliable

firmware loading can use the safe calls?

>
>    Luis
