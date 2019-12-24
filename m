Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1194E12A17E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLXM7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 07:59:41 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:23316 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfLXM7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:59:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577192377; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=U6TeHDAV6sflwWxMP6nOFCQrWn/KVLM1xdJTM2HvT2I=; b=uVm1tWgiBADHoPxNfzz5fafHpSfJa+9f8Xh8Fp3F8LXrnsZspk4P7EZBUc63fuRhMndqnEht
 fKHVKMKy3HUTnmyNS8Aa+dgq6K4zjoeyzoc6mDH+GO7hPhV0MdfKxalBA0DvRNn9KBW5KVIE
 zkKrWVRalLDIsInTxbD4JNzug/c=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e020bb6.7f6fbe349ed8-smtp-out-n02;
 Tue, 24 Dec 2019 12:59:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42CFAC4479C; Tue, 24 Dec 2019 12:59:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.204.79.81] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3A0EC433CB;
        Tue, 24 Dec 2019 12:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3A0EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: WARNING: refcount bug in cdev_get
To:     Will Deacon <will@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        hdanton@sina.com, akpm@linux-foundation.org
References: <000000000000bf410005909463ff@google.com>
 <20191204115055.GA24783@willie-the-truck>
 <20191204123148.GA3626092@kroah.com>
 <20191210114444.GA17673@willie-the-truck>
 <20191218170854.GC18440@willie-the-truck> <20191218182026.GB882018@kroah.com>
 <20191219115909.GA32361@willie-the-truck>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <93629f93-d20e-fa56-b021-3a90b355e6ec@codeaurora.org>
Date:   Tue, 24 Dec 2019 18:29:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219115909.GA32361@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Will,

I am facing same issue while syzkaller fault injection code is causing

failure in filp->f_op->open() from chrdev_open().

I believe we need to rely on refcount as cdev_lock() is not sufficient

in this case.

Patch mentioned in 
https://groups.google.com/forum/#!original/syzkaller-bugs/PnQNxBrWv_8/X1ygj8d8DgAJ

seems good.


Please share your opinion the same.


Regards

Prateek



On 12/19/2019 5:29 PM, Will Deacon wrote:
> On Wed, Dec 18, 2019 at 07:20:26PM +0100, Greg KH wrote:
>> On Wed, Dec 18, 2019 at 05:08:55PM +0000, Will Deacon wrote:
>>> On Tue, Dec 10, 2019 at 11:44:45AM +0000, Will Deacon wrote:
>>>> On Wed, Dec 04, 2019 at 01:31:48PM +0100, Greg KH wrote:
>>>>> This code hasn't changed in 15+ years, what suddenly changed that causes
>>>>> problems here?
>>>> I suppose one thing to consider is that the refcount code is relatively new,
>>>> so it could be that the actual use-after-free is extremely rare, but we're
>>>> now seeing that it's at least potentially an issue.
>>>>
>>>> Thoughts?
>>> FWIW, I added some mdelay()s to make this race more likely, and I can now
>>> trigger it reasonably reliably. See below.
>>>
>>> --->8
>>>
>>> [   89.512353] ------------[ cut here ]------------
>>> [   89.513350] refcount_t: addition on 0; use-after-free.
>>> [   89.513977] WARNING: CPU: 2 PID: 6385 at lib/refcount.c:25 refcount_warn_saturate+0x6d/0xf0
> [...]
>
>> No hint as to _where_ you put the mdelay()?  :)
> I threw it in the release function to maximise the period where the refcount
> is 0 but the inode 'i_cdev' pointer is non-NULL. I also hacked chrdev_open()
> so that the fops->open() call appears to fail most of the time (I guess
> syzkaller uses error injection to do something similar). Nasty hack below.
>
> I'll send a patch, given that I've managed to "reproduce" this.
>
> Will
>
> --->8
>
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index 00dfe17871ac..e2e48fcd0435 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -375,7 +375,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>   	const struct file_operations *fops;
>   	struct cdev *p;
>   	struct cdev *new = NULL;
> -	int ret = 0;
> +	int ret = 0, first = 0;
>   
>   	spin_lock(&cdev_lock);
>   	p = inode->i_cdev;
> @@ -395,6 +395,7 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>   			inode->i_cdev = p = new;
>   			list_add(&inode->i_devices, &p->list);
>   			new = NULL;
> +			first = 1;
>   		} else if (!cdev_get(p))
>   			ret = -ENXIO;
>   	} else if (!cdev_get(p))
> @@ -411,6 +412,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>   
>   	replace_fops(filp, fops);
>   	if (filp->f_op->open) {
> +		if (first && (get_cycles() & 0x3)) {
> +			ret = -EINTR;
> +			goto out_cdev_put;
> +		}
>   		ret = filp->f_op->open(inode, filp);
>   		if (ret)
>   			goto out_cdev_put;
> @@ -594,12 +599,14 @@ void cdev_del(struct cdev *p)
>   	kobject_put(&p->kobj);
>   }
>   
> +#include <linux/delay.h>
>   
>   static void cdev_default_release(struct kobject *kobj)
>   {
>   	struct cdev *p = container_of(kobj, struct cdev, kobj);
>   	struct kobject *parent = kobj->parent;
>   
> +	mdelay(50);
>   	cdev_purge(p);
>   	kobject_put(parent);
>   }

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
