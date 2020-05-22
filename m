Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9EE1DF2F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 01:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgEVXZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbgEVXZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 19:25:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5EC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:25:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so5718901pgg.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xcdARewyTG4POyZ7ltQhfJJu9Qv+Bxm+E+lkKjlpIsE=;
        b=fTK4N1uv4Kn/dR2zzPbD0jHTR52W93tW49eGy+Fa0Hl+4Be6712kZ/QI6oxwFpFI/a
         ZHU1PWctlZrqE3qr5XCDpuTkl3C2l7HVsfv5S3tv6i6eNIa81bBVA7dSqbl/5Pq6FUZs
         ABEWWzVogKKhogjSPk2sGmAiiVj+evSbq4uJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xcdARewyTG4POyZ7ltQhfJJu9Qv+Bxm+E+lkKjlpIsE=;
        b=l1Rom76tHyM9LlFisZCwZniKW3I/9fo1nk/TccteWKT0wXjqj6J6VpuRZHWpjt1zwN
         du3KlRN9Xvp4Jj1LtgdaHZca51CQPhFrVfj2XNuBmdTaZ1YFz7qrbKuZP+uv0TFriDLU
         P/zdvcC7RpY+we0t4H3V7ky3W4alpoJbvhgLuBcL9M0tkoP87zNrCFXXALr1ZMixbUc2
         9EPSmC3uIc6ok9xYRnSYIdbiiG17p5OTNd7Iy2gIKBCtPm/W28PGyfvdO7ESM5cofGSj
         k+pz7pJHTKjj0+GdxxhxRXTKhLbk2eKN05Ch3V05Rrwb5bycEibxm1gRsM//BDacPVPu
         McGQ==
X-Gm-Message-State: AOAM532HwVeOEKt9YFZRm7TcyQO3c3E9BCNa2Gp6URDasExpa01numTH
        Jxmmna0u5Xsx1MD+kRq74Eni5X7CYg1IRg==
X-Google-Smtp-Source: ABdhPJxYA3M7TqBzRS04SzG465as6Jpo33/yu9zFOYOedvseWiYUZylkj5NdgSLEDNI/UVu5rIrHaw==
X-Received: by 2002:a62:2f45:: with SMTP id v66mr6455014pfv.45.1590189916382;
        Fri, 22 May 2020 16:25:16 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12sm7637602pjs.41.2020.05.22.16.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 16:25:15 -0700 (PDT)
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, nayna@linux.ibm.com,
        dan.carpenter@oracle.com, skhan@linuxfoundation.org,
        geert@linux-m68k.org, tglx@linutronix.de, bauerman@linux.ibm.com,
        dhowells@redhat.com, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
 <202005221551.5CA1372@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
Date:   Fri, 22 May 2020 16:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005221551.5CA1372@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 2020-05-22 4:04 p.m., Kees Cook wrote:
> On Fri, May 22, 2020 at 03:24:32PM -0700, Scott Branden wrote:
>> On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
>>> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
>>>> On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
>>>>> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
>>>>>> Can you also move kernel_read_* out of fs.h?  That header gets pulled
>>>>>> in just about everywhere and doesn't really need function not related
>>>>>> to the general fs interface.
>>>>> Sure, where should I dump these?
>>>> Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
>>>> of the file comment explaining the point of the interface, which I
>>>> still don't get :)
>>> Instead of rolling your own method of having the kernel read a file,
>>> which requires call specific security hooks, this interface provides a
>>> single generic set of pre and post security hooks.  The
>>> kernel_read_file_id enumeration permits the security hook to
>>> differentiate between callers.
>>>
>>> To comply with secure and trusted boot concepts, a file cannot be
>>> accessible to the caller until after it has been measured and/or the
>>> integrity (hash/signature) appraised.
>>>
>>> In some cases, the file was previously read twice, first to measure
>>> and/or appraise the file and then read again into a buffer for
>>> use.  This interface reads the file into a buffer once, calls the
>>> generic post security hook, before providing the buffer to the caller.
>>>    (Note using firmware pre-allocated memory might be an issue.)
>>>
>>> Partial reading firmware will result in needing to pre-read the entire
>>> file, most likely on the security pre hook.
>> The entire file may be very large and not fit into a buffer.
>> Hence one of the reasons for a partial read of the file.
>> For security purposes, you need to change your code to limit the amount
>> of data it reads into a buffer at one time to not consume or run out of much
>> memory.
> Hm? That's not how whole-file hashing works. :)

>
> These hooks need to finish their hashing and policy checking before they
> can allow the rest of the code to move forward. (That's why it's a
> security hook.) If kernel memory utilization is the primary concern,
> then sure, things could be rearranged to do partial read and update the
> hash incrementally, but the entire file still needs to be locked,
> entirely hashed by hook, then read by the caller, then unlocked and
> released.
>
> So, if you want to have partial file reads work, you'll need to
> rearchitect the way this works to avoid regressing the security coverage
> of these operations.
I am not familiar with how the security handling code works at all.
Is the same security check run on files opened from user space?
A file could be huge.

If it assumes there is there is enough memory available to read the 
entire file into kernel space
then the improvement below can be left as a memory optimization to be 
done in
an independent (or future) patch series.

> So, probably, the code will look something like:
>
>
> file = kernel_open_file_for_reading(...)
> 	file = open...
> 	disallow_writes(file);
> 	while (processed < size-of-file) {
> 		buf = read(file, size...)
> 		security_file_read_partial(buf)
> 	}
> 	ret = security_file_read_finished(file);
> 	if (ret < 0) {
> 		allow_writes(file);
> 		return PTR_ERR(ret);
> 	}
> 	return file;
>
> while (processed < size-of-file) {
> 	buf = read(file, size...)
> 	firmware_send_partial(buf);
> }
>
> kernel_close_file_for_reading(file)
> 	allow_writes(file);
>
>

