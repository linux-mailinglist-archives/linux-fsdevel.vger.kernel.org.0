Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D63A6BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhFNQeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 12:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhFNQeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623688326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DISslyfLGhpMa3WyA2T18Pg0TsQiGkTpC7aVUBeR5IM=;
        b=dKdMLoGjSmR0Adm2DSdyJzQunyIysRnhLtepuL5cTxScG8+oLBSRGTLyT+BETCy4AyPz2A
        e28RS67c0CX9WwHr4a/YTTpzHqBhVOhtIZ4+scF05Ori91iXsxWDLQ7oT8TaL7VpyvC5Eq
        E7B7FSy2fprVtDv+u6x4G5CwdaIe8tE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-CZv2yj-fMyubBhfkHaFsPQ-1; Mon, 14 Jun 2021 12:32:05 -0400
X-MC-Unique: CZv2yj-fMyubBhfkHaFsPQ-1
Received: by mail-qk1-f198.google.com with SMTP id b125-20020a3799830000b02903ad1e638ccaso3387542qke.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 09:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DISslyfLGhpMa3WyA2T18Pg0TsQiGkTpC7aVUBeR5IM=;
        b=ZM+K7crM5o+Rwe8MAAGiHZoBxp6IQPCjbwK367u3wfFa1qgX6EyE04HBg1KqLZBC82
         JXgSI9N7++k4H9kZPFdFUJcbr5bdlGS8kZZLI082VRDZCPjyRZJKspttSrDSFJtJQiAg
         fdXSeFbZrt1zZToiaPOits8r9VG+JxJyXv5p2o2uiqQ8s/mfgMuz7jWVwH3deywfiugD
         YZGPrm5sZr3VylzROQN68j5JI9fMw++uzbvdm491aSrp0fF1OdWpygRUu+bSZhL85ZaT
         nJg49uvAi3wmrVtnGvphNEHH8d619AK0dHzWWi7iRdBx4JDO6dadM+Lzebc/iQPNOpqJ
         lbsA==
X-Gm-Message-State: AOAM5323N8VNA49h7xnmyq3WKp4SA3glLAodf5dBJdCE4uXxh6QgxAxN
        jca3uMZiKpm77dY2PAaSC8EsaSmAzdrucVtJ9UTagB+2o0dITR8hvzWMbGSHPCEOWmh1xwIzPNT
        SGKGi9TGHcGnM25aJSxtkv9bRvQgeKjxOMSjU2nl9optY20KUui1KiARdCmEMowvmIbyOv0iKyA
        ==
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr17106010qke.326.1623688324382;
        Mon, 14 Jun 2021 09:32:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCvxn+ltzjQlfYVUxjQ+5bHloF+7JsMElf+UL5szMp3AVyCsKA+9NhZBjoT78OZ0Xt7flNDw==
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr17105966qke.326.1623688324062;
        Mon, 14 Jun 2021 09:32:04 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j14sm8455892qtq.56.2021.06.14.09.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:32:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 4/4] driver core: Allow showing cpu as offline if not
 valid in cpuset context
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210614152306.25668-1-longman@redhat.com>
 <20210614152306.25668-5-longman@redhat.com> <YMd7PEU0KPulsgMz@kroah.com>
Message-ID: <ad33a662-7ebe-fb92-4459-5dd85a013501@redhat.com>
Date:   Mon, 14 Jun 2021 12:32:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMd7PEU0KPulsgMz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/21 11:52 AM, Greg KH wrote:
> On Mon, Jun 14, 2021 at 11:23:06AM -0400, Waiman Long wrote:
>> Make /sys/devices/system/cpu/cpu<n>/online file to show a cpu as
>> offline if it is not a valid cpu in a proper cpuset context when the
>> cpuset_bound_cpuinfo sysctl parameter is turned on.
> This says _what_ you are doing, but I do not understand _why_ you want
> to do this.
>
> What is going to use this information?  And now you are showing more
> files than you previously did, so what userspace tool is now going to
> break?

One reason that is provided by the customer asking for this 
functionality is because some applications use the number of cpu cores 
for licensing purpose. Even though the applications are running in a 
container with a smaller set of cpus, they may still charge as if all 
the cpus are available. They ended up using a bind mount to mount over 
the cpuX/online file.

I should have included this information in the patchset.


>
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/base/core.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 54ba506e5a89..176b927fade2 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/sched/mm.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/dma-map-ops.h> /* for dma_default_coherent */
>> +#include <linux/cpuset.h>
>>   
>>   #include "base.h"
>>   #include "power/power.h"
>> @@ -2378,11 +2379,24 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RW(uevent);
>>   
>> +static bool is_device_cpu(struct device *dev)
>> +{
>> +	return dev->bus && dev->bus->dev_name
>> +			&& !strcmp(dev->bus->dev_name, "cpu");
>> +}
> No, this is not ok, there is a reason we did not put RTTI in struct
> devices, so don't try to fake one here please.
>
>> +
>>   static ssize_t online_show(struct device *dev, struct device_attribute *attr,
>>   			   char *buf)
>>   {
>>   	bool val;
>>   
>> +	/*
>> +	 * Show a cpu as offline if the cpu number is not valid in a
>> +	 * proper cpuset bounding cpuinfo context.
>> +	 */
>> +	if (is_device_cpu(dev) && !cpuset_current_cpu_valid(dev->id))
>> +		return sysfs_emit(buf, "0\n");
> Why are you changing the driver core for a single random, tiny set of
> devices?  The device code for those devices can handle this just fine,
> do NOT modify the driver core for each individual driver type, that way
> lies madness.
>
> This change is not ok, sorry.

OK, thanks for the comments. I will see if there is alternative way of 
doing it.

Cheers,
Longman

