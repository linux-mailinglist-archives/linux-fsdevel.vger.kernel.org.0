Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4A1F0383
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgFEXbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgFEXbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:31:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69DBC08C5C6
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 16:31:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so5915564pgm.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QT3TOfTZM7n8upLOBb9CoT35uLEYwP8QmqKQlYpotu8=;
        b=aRVd9mVasyOpi3qj6L+9LPZYEZeqaeUcati7cYFOWdqTeHQHVCYu1Mg3TZAEJ+Cemq
         dfXKAo+Q6UNAFsH/2ZXA/hLBkWgSa0nz4wSjsYb/wFS0rixfFi3JJfcl8n4oR6+Ps1Qy
         U+/FztKv09P0+eWToCYdTvhCeWQASBbcJYwWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QT3TOfTZM7n8upLOBb9CoT35uLEYwP8QmqKQlYpotu8=;
        b=uL8Kbt0gqzvo8oS658wtG65Gcp4ZEDM2AwwLjQ65iDiRLH+2watWKVda/J7BFo5VaW
         V6+Ur4mibfW2PJkDDVwSVSy+1PIT3o2PnStfmHpUafOoXD6e+RSVH0+r32P1xlcsfnq5
         ecTYBvI8vB4bfMJN/l/WtmX84v/G2OYFYQWXvJuyWyrdyS1epDUPcvnDsrKxnYZmtYH1
         b66RP4KyM/Bjm3Q7XhOWJStYosEvHzCjgKr8NYIcJdJC/Gaparf6ZcJWgCPZQ+JXi6cB
         C96ZRa1ONm6qnH3lh7SiU1wqNJ7jp2yKyvXlqkPzGUZiDevJJJv47NZzR1c+jWwT+Xd2
         k7Sw==
X-Gm-Message-State: AOAM532dcQJ/vAnWBtptKCvhcbT4i+9fp9hRc1KfjscL8HkZSQQVldUP
        1X3FaH5O0Rw3f8IQNzmDT8qoLw==
X-Google-Smtp-Source: ABdhPJyjNvTuZNiXBWA+wu5gD204795YG4uT5HA5nAd7pQQKXRGvD9NKYFP7JEix9AMrHm3M2js3SQ==
X-Received: by 2002:a65:6715:: with SMTP id u21mr12073266pgf.365.1591399879036;
        Fri, 05 Jun 2020 16:31:19 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 125sm588134pff.130.2020.06.05.16.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 16:31:17 -0700 (PDT)
Subject: Re: [PATCH v6 8/8] ima: add FIRMWARE_PARTIAL_READ support
To:     Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200605225959.12424-1-scott.branden@broadcom.com>
 <20200605225959.12424-9-scott.branden@broadcom.com>
 <1591399166.4615.37.camel@linux.ibm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com>
Date:   Fri, 5 Jun 2020 16:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591399166.4615.37.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mimi,

On 2020-06-05 4:19 p.m., Mimi Zohar wrote:
> Hi Scott,
>
> On Fri, 2020-06-05 at 15:59 -0700, Scott Branden wrote:
>> @@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>>   	enum ima_hooks func;
>>   	u32 secid;
>>   
>> +	if (!file && read_id == READING_FIRMWARE_PARTIAL_READ)
>> +		return 0;
> The file should be measured on the pre security hook, not here on the
> post security hook.  Here, whether "file" is defined or not, is
> irrelevant.  The test should just check "read_id".
OK, will remove the !file from here.
>
> Have you tested measuring the firmware by booting a system with
> "ima_policy=tcb" specified on the boot command line and compared the
> measurement entry in the IMA measurement list with the file hash (eg.
> sha1sum, sha256sum)?
Yes, I enabled IMA in my kernel and added ima_policy=tsb to the boot 
command line,

Here are the entries from 
/sys/kernel/security/ima/ascii_runtime_measurements of the files I am 
accessing.
Please let me know if I am doing anything incorrectly.

10 4612bce355b2dbc45ecd95e17001636be8832c7f ima-ng 
sha1:fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
10 4c0eb0fc30eb7ac3a30a27f05c1d2a8d28d6a9ec ima-ng 
sha1:b16d343dd63352d10309690c71b110762a9444c3 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsn

The sha1 sum matches:
root@genericx86-64:/sys/kernel/security/ima# sha1sum 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
fddd9a28c2b15acf3b0fc9ec0cf187cb2153d7f2 
/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin

root@genericx86-64:/sys/kernel/security/ima# sha1sum 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin
b16d343dd63352d10309690c71b110762a9444c3 
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin


>
> Mimi
>
>> +
>>   	if (!file && read_id == READING_FIRMWARE) {
>>   		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>>   		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {

