Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1C2EE815
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 23:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbhAGWEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 17:04:45 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:64184 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAGWEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:04:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610057063; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=og7Iog2EeRDPDZsuuFHbYx6v2VbDmhb2mwPl51ar7Dg=; b=xkDSp8/rzh5BF7fcshau1q7Ly/hsPzfGIO2LMbx9lfRxQLKX4TGnTv7hEHFz3bKjixLA1+vD
 oG1A7dvfACcPSfAu/utCBV2wvNc9JLHY/Tt4n3KizDPD7p9hKZU2CpLlXAsTLLD6g7F08Hso
 pSzTf5fQpaw6MzGZfPFAMuc4Qzw=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ff78546c732bc96210df30e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Jan 2021 22:03:50
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0CB16C43462; Thu,  7 Jan 2021 22:03:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFD49C433CA;
        Thu,  7 Jan 2021 22:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFD49C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <X/QJCgoLPhfECEmP@kroah.com>
 <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
 <X/WSA7nmsUSrpsfr@kroah.com>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <62583aaa-d557-8c9a-5959-52c9efad1fe3@codeaurora.org>
Date:   Thu, 7 Jan 2021 14:03:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/WSA7nmsUSrpsfr@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/6/2021 2:33 AM, Greg KH wrote:
> On Tue, Jan 05, 2021 at 05:00:58PM -0800, Siddharth Gupta wrote:
>> On 1/4/2021 10:36 PM, Greg KH wrote:
>>> On Mon, Jan 04, 2021 at 02:43:45PM -0800, Siddharth Gupta wrote:
>>>> Hi all,
>>>>
>>>> With the introduction of the filesystem change "fs: don't allow splice
>>>> read/write without explicit ops"[1] the fallback mechanism of the firmware
>>>> loader[2] no longer works when using sendfile[3] from the userspace.
>>> What userspace program are you using to load firmware?
>> The userspace program is in the android userspace which listens to a uevent
>> from the firmware loader and then loads the firmware using sendfile[1].
>>>    Are you not using the in-kernel firmware loader for some reason?
>> We have certain non-standard firmware paths that should not be added to the
>> linux kernel, and the firmware_class.path only supports a single path.
> That option is just for a single override, which should be all that you
> need if the other paths that are built into the kernel do not work.
> Surely one of the 5 different paths here are acceptable?
Unfortunately they are not, and we understand that such changes 
shouldn't make it to upstream hence it was not a part of the request. If 
the firmware loader fallback mechanism was being deprecated then we 
would have to look into our options. As of now the series of changes 
breaking the sysfs bin attributes is the only bug that affects us.
>
> If not, how many more do you need?
We need 2 paths.
>
> And last I looked, Android wants you to use the built-in kernel firmware
> loader, and NOT an external firmware binary anymore.  So this shouldn't
> be an issue for your newer systems anyway :)
In our discussion with the Android team that is not the case currently. 
In the future yes, but not now :)

Regardless this bug is in the kernel and not Android. If the firmware 
loader fallback mechanism is used on the current kernel we would see the 
issue with sendfile in the userspace whether Android is running or not.
>
>>>> Since the binary attributes don't support splice_{read,write} functions the
>>>> calls to splice_{read,write} used the default kernel_{read,write} functions.
>>>> With the above change this results in an -EINVAL return from
>>>> do_splice_from[4].
>>>>
>>>> This essentially means that sendfile will not work for any binary attribute
>>>> in the sysfs.
>>> Have you tried fixing this with a patch much like what we did for the
>>> proc files that needed this?  If not, can you?
>> I am not aware of this fix, could you provide me a link for reference? I
>> will try it out.
> Look at the series of commits starting at fe33850ff798 ("proc: wire up
> generic_file_splice_read for iter ops") for how this was fixed in procfs
> as an example of what also needs to be done for binary sysfs files.
I tried to follow these fixes, but I am unfamiliar with fs code. I don't 
see the generic_file_splice_write function anymore on newer kernels, 
also AFAICT kernfs_ops does not define {read,write}_iter operations. If 
the solution is simple and someone could provide the patches I would be 
happy to test them out. If not, some more information about how to 
proceed would be nice.

Thanks,
Sid
>
> thanks,
>
> greg k-h
