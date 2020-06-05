Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088D1EFFBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFESP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgFESP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:15:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE9C08C5C4
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 11:15:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o6so5591939pgh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=esmpnZfFmK3cVOEF7B5Xrx0JRzL/dAN0UyhbSUY5XOU=;
        b=cOcYA+tCbSiD62uF7VZPNASE+6dozCHWTwtyvAv86J4CHtUt/BKZxe9Hl8emWeJu32
         NmToqo3tnfYNAFrtfZAe9DVKolOa1e6H2hwmafgv8/uG4iS4t+bJfKetLXM5cH7dUqwK
         3Wi+k5Txc+6B/rmQRnq5aNqkpcI8toqLOgkyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=esmpnZfFmK3cVOEF7B5Xrx0JRzL/dAN0UyhbSUY5XOU=;
        b=jtI4Ed2M3fsa+Dcuzwlqt55o9ikNrIFxo38axC64HrVAKOzReu7zpQ/HqI6kBS7P/Y
         Z7xbeOvO7+cgrC6F+cM4PWmP3GhEZfBGrvW9c9pW8C4Ej8Glsrx/bW6ekRAss/OBamLA
         FHyFQKrOr12Y6N02BRjYvBj73/RjoLEx1G1QKLe67ob8j/cPNx6V5uUATPP9B+QgTne5
         zaCRf3S9PbgjwUMARXcpjHqs4PlpQND+qTspUZQpBEh3f0Yuaca5fjIDNz0XxPRQPi2O
         LR1dg2QEE1HKvpEZHxx48UcsGpmZ5H9eHaF9sce8G+4+R/YuGdtYSbO7d209Uh9WuDGs
         OjbQ==
X-Gm-Message-State: AOAM531zpHia26bpCEEMlOHBoKLXyO2LtsyXaZD97oc1qftaLqdDbs4N
        0Z0kggorXBkLn+Oj95u80w3obA==
X-Google-Smtp-Source: ABdhPJx44Y+GjhW2vgNui0lp10q3hv9zSss9PMmRFy4YprMV+idGKYTS6mCLEIhZlMSH2tpAFlibiw==
X-Received: by 2002:a63:9d0a:: with SMTP id i10mr10476176pgd.209.1591380926608;
        Fri, 05 Jun 2020 11:15:26 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w24sm286555pfn.11.2020.06.05.11.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 11:15:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
To:     Mimi Zohar <zohar@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
 <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
 <1590288736.5111.431.camel@linux.ibm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1c68c0c7-1b0a-dfec-0e50-1b65eedc3dc7@broadcom.com>
Date:   Fri, 5 Jun 2020 11:15:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590288736.5111.431.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mimi,

On 2020-05-23 7:52 p.m., Mimi Zohar wrote:
> On Fri, 2020-05-22 at 16:25 -0700, Scott Branden wrote:
>> Hi Kees,
>>
>> On 2020-05-22 4:04 p.m., Kees Cook wrote:
>>> On Fri, May 22, 2020 at 03:24:32PM -0700, Scott Branden wrote:
>>>> On 2020-05-18 5:37 a.m., Mimi Zohar wrote:
>>>>> On Sun, 2020-05-17 at 23:22 -0700, Christoph Hellwig wrote:
>>>>>> On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
>>>>>>> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
>>>>>>>> Can you also move kernel_read_* out of fs.h?  That header gets pulled
>>>>>>>> in just about everywhere and doesn't really need function not related
>>>>>>>> to the general fs interface.
>>>>>>> Sure, where should I dump these?
>>>>>> Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
>>>>>> of the file comment explaining the point of the interface, which I
>>>>>> still don't get :)
>>>>> Instead of rolling your own method of having the kernel read a file,
>>>>> which requires call specific security hooks, this interface provides a
>>>>> single generic set of pre and post security hooks.  The
>>>>> kernel_read_file_id enumeration permits the security hook to
>>>>> differentiate between callers.
>>>>>
>>>>> To comply with secure and trusted boot concepts, a file cannot be
>>>>> accessible to the caller until after it has been measured and/or the
>>>>> integrity (hash/signature) appraised.
>>>>>
>>>>> In some cases, the file was previously read twice, first to measure
>>>>> and/or appraise the file and then read again into a buffer for
>>>>> use.  This interface reads the file into a buffer once, calls the
>>>>> generic post security hook, before providing the buffer to the caller.
>>>>>     (Note using firmware pre-allocated memory might be an issue.)
>>>>>
>>>>> Partial reading firmware will result in needing to pre-read the entire
>>>>> file, most likely on the security pre hook.
>>>> The entire file may be very large and not fit into a buffer.
>>>> Hence one of the reasons for a partial read of the file.
>>>> For security purposes, you need to change your code to limit the amount
>>>> of data it reads into a buffer at one time to not consume or run out of much
>>>> memory.
>>> Hm? That's not how whole-file hashing works. :)
>>> These hooks need to finish their hashing and policy checking before they
>>> can allow the rest of the code to move forward. (That's why it's a
>>> security hook.) If kernel memory utilization is the primary concern,
>>> then sure, things could be rearranged to do partial read and update the
>>> hash incrementally, but the entire file still needs to be locked,
>>> entirely hashed by hook, then read by the caller, then unlocked and
>>> released.
> Exactly.
>
>>> So, if you want to have partial file reads work, you'll need to
>>> rearchitect the way this works to avoid regressing the security coverage
>>> of these operations.
>> I am not familiar with how the security handling code works at all.
>> Is the same security check run on files opened from user space?
>> A file could be huge.
>>
>> If it assumes there is there is enough memory available to read the
>> entire file into kernel space then the improvement below can be left as
>> a memory optimization to be done in an independent (or future) patch series.
> There are two security hooks - security_kernel_read_file(),
> security_kernel_post_read_file - in kernel_read_file().  The first
> hook is called before the file is read into a buffer, while the second
> hook is called afterwards.
>
> For partial reads, measuring the firmware and verifying the firmware's
> signature will need to be done on the security_kernel_read_file()
> hook.
>
>>> So, probably, the code will look something like:
>>>
>>>
>>> file = kernel_open_file_for_reading(...)
>>> 	file = open...
>>> 	disallow_writes(file);
>>> 	while (processed < size-of-file) {
>>> 		buf = read(file, size...)
>>> 		security_file_read_partial(buf)
>>> 	}
>>> 	ret = security_file_read_finished(file);
>>> 	if (ret < 0) {
>>> 		allow_writes(file);
>>> 		return PTR_ERR(ret);
>>> 	}
>>> 	return file;
>>>
>>> while (processed < size-of-file) {
>>> 	buf = read(file, size...)
>>> 	firmware_send_partial(buf);
>>> }
>>>
>>> kernel_close_file_for_reading(file)
>>> 	allow_writes(file);
> Right, the ima_file_mmap(), ima_bprm_check(), and ima_file_check()
> hooks call process_measurement() to do this.  ima_post_read_file()
> passes a buffer to process_measurement() instead.
>
> Scott, the change should be straight forward.  The additional patch
> needs to:
> - define a new kernel_read_file_id enumeration, like
> FIRMWARE_PARTIAL_READ.
> - Currently ima_read_file() has a comment about pre-allocated firmware
> buffers.  Update ima_read_file() to call process_measurement() for the
> new enumeration FIRMWARE_PARTIAL_READ and update ima_post_read_file()
> to return immediately.
Should this be what is in ima_read_file?
{
     enum ima_hooks func;
     u32 secid;

     if (read_id != READING_FIRMWARE_PARTIAL_READ)
         return 0;

     if (!file) { /* should never happen */
         if (ima_appraise & IMA_APPRAISE_ENFORCE)
             return -EACCES;
         return 0;
     }

     security_task_getsecid(current, &secid);
     return process_measurement(file, current_cred(), secid, NULL,
                    0, MAY_READ, FILE_CHECK);
}
>
> The built-in IMA measurement policy contains a rule to measure
> firmware.  The policy can be specified on the boot command line by
> specifying "ima_policy=tcb".  After reading the firmware, the firmware
> measurement should be in <securityfs>/ima/ascii_runtime_measurements.
>
> thanks,
>
> Mimi

