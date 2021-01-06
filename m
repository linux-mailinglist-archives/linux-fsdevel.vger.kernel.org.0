Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B672EB74C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAFBCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 20:02:12 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:34812 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbhAFBCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609894913; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=W4gpPPjzOwyYpAHogznNbJBBPbiS4KCPfs+WcgOjgBg=; b=idNWZvJ3fgyWTmW06sXxcHEi2gu6TXzATM38huKuMT0omJ8lXL8WrrtsIL9KtRuUkgPyf5jP
 3C55xf5/BiYSqrTpQH86IiYHmFp63y8162/5bXBEnxuCi4zQxlhVGduizFTybW9Eukqwvqhb
 ++3fEc/Hftuiaed7n63PA2qr88g=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ff50bccf7aeb83bf1747d96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Jan 2021 01:01:00
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24474C43462; Wed,  6 Jan 2021 01:01:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F09CCC433CA;
        Wed,  6 Jan 2021 01:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F09CCC433CA
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
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
Date:   Tue, 5 Jan 2021 17:00:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/QJCgoLPhfECEmP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/4/2021 10:36 PM, Greg KH wrote:
> On Mon, Jan 04, 2021 at 02:43:45PM -0800, Siddharth Gupta wrote:
>> Hi all,
>>
>> With the introduction of the filesystem change "fs: don't allow splice
>> read/write without explicit ops"[1] the fallback mechanism of the firmware
>> loader[2] no longer works when using sendfile[3] from the userspace.
> What userspace program are you using to load firmware?
The userspace program is in the android userspace which listens to a 
uevent from the firmware loader and then loads the firmware using 
sendfile[1].
>   Are you not using the in-kernel firmware loader for some reason?
We have certain non-standard firmware paths that should not be added to 
the linux kernel, and the firmware_class.path only supports a single path.
>
>> Since the binary attributes don't support splice_{read,write} functions the
>> calls to splice_{read,write} used the default kernel_{read,write} functions.
>> With the above change this results in an -EINVAL return from
>> do_splice_from[4].
>>
>> This essentially means that sendfile will not work for any binary attribute
>> in the sysfs.
> Have you tried fixing this with a patch much like what we did for the
> proc files that needed this?  If not, can you?
I am not aware of this fix, could you provide me a link for reference? I 
will try it out.
>
>> [1]: https://github.com/torvalds/linux/commit/36e2c7421f02a22f71c9283e55fdb672a9eb58e7#diff-70c49af2ed5805fc1406ed6e6532d6a029ada1abd90cca6442711b9cecd4d523
>> [2]: https://github.com/torvalds/linux/blob/master/drivers/base/firmware_loader/main.c#L831
>> [3]: https://github.com/torvalds/linux/blob/master/fs/read_write.c#L1257
>> [4]: https://github.com/torvalds/linux/blob/master/fs/splice.c#L753
> kernel development is on git.kernel.org, not github :)
I use it because it is easier on the eyes when looking at diffs :D
But I'll be sure to use git.kernel.org from now on if that is what is 
preferred!
>
> thanks,
>
> greg k-h
Thanks,
Sid

[1]: 
https://android.googlesource.com/platform/system/core/+/refs/heads/master/init/firmware_handler.cpp#55

