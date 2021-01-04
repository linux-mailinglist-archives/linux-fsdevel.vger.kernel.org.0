Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21C2EA01F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhADWoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 17:44:38 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:18526 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADWoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:44:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609800255; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: Cc: To: Sender;
 bh=zZUFznR+lb3g0Oh2iFAqK9DoirsGLwYKKznxswKYgIc=; b=r+bmttG9fBXAX9lg/jTFpyzMfILLCaLHnkIAKx5qSBNVYgwHdIknThdu6+wgPT2xlo14BFVH
 VtOg0o9+p8wEVYW2WNHawNkeBMuQpuvLYNGVUBJ9mQrmf8B3xvIEjpBqlDoTHe5V+5S8WZdM
 8OundXs5KAsOzYGcAlLg4ra9XNE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ff39a233d84969114531a74 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Jan 2021 22:43:47
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5BF44C433ED; Mon,  4 Jan 2021 22:43:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.10] (cpe-75-83-25-192.socal.res.rr.com [75.83.25.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4628BC433CA;
        Mon,  4 Jan 2021 22:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4628BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "psodagud@codeaurora.org" <psodagud@codeaurora.org>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Subject: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
Date:   Mon, 4 Jan 2021 14:43:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

With the introduction of the filesystem change "fs: don't allow splice 
read/write without explicit ops"[1] the fallback mechanism of the 
firmware loader[2] no longer works when using sendfile[3] from the 
userspace.

Since the binary attributes don't support splice_{read,write} functions 
the calls to splice_{read,write} used the default kernel_{read,write} 
functions. With the above change this results in an -EINVAL return from 
do_splice_from[4].

This essentially means that sendfile will not work for any binary 
attribute in the sysfs.

Thanks,
Siddharth

[1]: 
https://github.com/torvalds/linux/commit/36e2c7421f02a22f71c9283e55fdb672a9eb58e7#diff-70c49af2ed5805fc1406ed6e6532d6a029ada1abd90cca6442711b9cecd4d523
[2]: 
https://github.com/torvalds/linux/blob/master/drivers/base/firmware_loader/main.c#L831
[3]: https://github.com/torvalds/linux/blob/master/fs/read_write.c#L1257
[4]: https://github.com/torvalds/linux/blob/master/fs/splice.c#L753

