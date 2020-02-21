Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731F7166C34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 02:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgBUBQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 20:16:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgBUBQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:16:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so178689wrt.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o+pp6WjkijFi/cFymD5udOX8QbE4tnzlUQVoizd2/v8=;
        b=JCdw/jYCzwsajXk+2CRmpVEuCLHdL5I2WS7TTRwQgDkpfHH2vClT/cONJ+PaB6MenR
         +EOi/x2mr7KGl30PbOwwgQ6BfQoVCbFG4FVzXEbqGOFKRqQ65kjbM2+WnDz1OL3nN8G5
         uMwCnkiVZ89PeOTZOyg1EPOp6/t84WvjVZlnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o+pp6WjkijFi/cFymD5udOX8QbE4tnzlUQVoizd2/v8=;
        b=J+7yAnEvBS7nefwsMD9mSq103TQi+Rma1r5+iUYPN4Zjvh+qtFypqHRMORBjxVWnqd
         Ij3eQB6zvGiBYJQd6py3osGRvz44VXefwO8rYBrlKUuDCp7Vk5Xn87n74g44vWetC4nv
         YoDNerNUBPoOTUtJIDjvIPsS3f5K6AwYPpJMtXIPU9lestLcfS/CDvszeUmjlJnLzmgK
         BJG6y8v3ewq2Rh2W11HRTjFVuYAhhfcjDWaLXsC9209wM/iK0TsvdvEcHhkctYkedyTS
         dfjeNyto3psacawsOC92KT8Pw+AUvblqhJFrNbDxWYOfWV4MJ/T6qQLNyMcbwbn2PfvM
         +EFw==
X-Gm-Message-State: APjAAAW1jOMEsP6+CjouaYi8SDzuULsCqHP28zZB/3kMHUcFKY0GZyW9
        I6m8lWpHBbmK/lLznhAEXLy1lQ==
X-Google-Smtp-Source: APXvYqxxcQJGSUxxc/xkaF1XgEwdO9U0vVvBJoSNVQvkEfShM9JCtvPvpgn1NaRGE7wFd3Ii4IpK9w==
X-Received: by 2002:adf:df03:: with SMTP id y3mr45314758wrl.260.1582247765872;
        Thu, 20 Feb 2020 17:16:05 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h205sm1517742wmf.25.2020.02.20.17.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 17:16:04 -0800 (PST)
Subject: Re: [PATCH v2 5/7] bcm-vk: add bcm_vk UAPI
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-6-scott.branden@broadcom.com>
 <20200220075045.GB3261162@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
Date:   Thu, 20 Feb 2020 17:15:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220075045.GB3261162@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

Thanks for the review.  Comments inline.

On 2020-02-19 11:50 p.m., Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2020 at 04:48:23PM -0800, Scott Branden wrote:
>> Add user space api for bcm-vk driver.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   include/uapi/linux/misc/bcm_vk.h | 117 +++++++++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>   create mode 100644 include/uapi/linux/misc/bcm_vk.h
>>
>> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
>> new file mode 100644
>> index 000000000000..56a2178e06f5
>> --- /dev/null
>> +++ b/include/uapi/linux/misc/bcm_vk.h
>> @@ -0,0 +1,117 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>> +/*
>> + * Copyright 2018-2020 Broadcom.
>> + */
>> +
>> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
>> +#define __UAPI_LINUX_MISC_BCM_VK_H
>> +
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +struct vk_image {
>> +	__u32 type;     /* Type of image */
>> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
>> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
>> +	char filename[64]; /* Filename of image */
> __u8?
I don't understand why char is not appropriate for a filename.
Would like to understand why __u8 is correct to use here vs. char.
>
>> +};
>> +
>> +/* default firmware images names */
>> +#define VK_BOOT1_DEF_VALKYRIE_FILENAME	"vk-boot1.bin"
>> +#define VK_BOOT2_DEF_VALKYRIE_FILENAME	"vk-boot2.bin"
>> +
>> +#define VK_BOOT1_DEF_VIPER_FILENAME	"vp-boot1.bin"
>> +#define VK_BOOT2_DEF_VIPER_FILENAME	"vp-boot2.bin"
> Why do these need to be in a uapi .h file?  Shouldn't they just be part
> of the normal MODULE_FIRMWARE() macro in the driver itself?
ioctl VK_IOCTL_LOAD_IMAGE passes in type of image to load and filename.
These are the default names used if the images are autoloaded by the driver.
But if userspace app wishes to load (or reload) the default images then 
it needs to know the name of the file to pass in ioctl.
I guess I could change the API at this point to lookup the default 
filename if NULL filename passed into ioctl.
>> +struct vk_access {
>> +	__u8 barno;     /* BAR number to use */
>> +	__u8 type;      /* Type of access */
>> +#define VK_ACCESS_READ 0
>> +#define VK_ACCESS_WRITE 1
>> +	__u32 len;      /* length of data */
> Horrible padding issues, are you sure this all works properly?
Haven't had any issues.
>
>> +	__u64 offset;   /* offset in BAR */
>> +	__u32 *data;    /* where to read/write data to */
> Are you _SURE_ you want a pointer here?  How do you handle the compat
> issues with 32/64 user/kernel space?
Don't care about 32-bit user space for this driver.
I don't think there isn't even enough memory in such systems for the 
number of streams of video buffers needed for transcoding.
This driver is only used in high end 64-bit x86 servers.
But, VK_IOCTL_ACCESS_BAR can go away entirely if standard user space 
approach already exists as you imply.
>> +};
> And isn't this just a normal PCI write thing?  Can't you do it from
> userspace using the existing userspace PCI accesses?  Why do you need a
> special ioctl for it?
This follows how pci_endpoint_test reads and writes BARS via ioctl.
It also abstracts the accesses all into the device node being opened.

I am not familiar with userspace PCI accesses.  Would this be through 
some sys entries?
>
>> +
>> +struct vk_reset {
>> +	__u32 arg1;
>> +	__u32 arg2;
>> +};
>> +
>> +#define VK_MAGIC              0x5E
>> +
>> +/* Load image to Valkyrie */
>> +#define VK_IOCTL_LOAD_IMAGE   _IOW(VK_MAGIC, 0x2, struct vk_image)
>> +
>> +/* Read data from Valkyrie */
>> +#define VK_IOCTL_ACCESS_BAR   _IOWR(VK_MAGIC, 0x3, struct vk_access)
>> +
>> +/* Send Reset to Valkyrie */
>> +#define VK_IOCTL_RESET        _IOW(VK_MAGIC, 0x4, struct vk_reset)
>> +
>> +/*
>> + * message block - basic unit in the message where a message's size is always
>> + *		   N x sizeof(basic_block)
>> + */
>> +struct vk_msg_blk {
>> +	__u8 function_id;
>> +#define VK_FID_TRANS_BUF 5
>> +#define VK_FID_SHUTDOWN  8
>> +	__u8 size;
>> +	__u16 queue_id:4;
>> +	__u16 msg_id:12;
> Do not use bitfields in ioctls, they will not work properly on all
> systems.  Use masks and shifts instead.
I don't like the bitfields either - structure inherited from firmware code.
Will work on getting these removed.
>
>> +	__u32 context_id;
>> +	__u32 args[2];
>> +#define VK_CMD_PLANES_MASK 0x000F /* number of planes to up/download */
>> +#define VK_CMD_UPLOAD      0x0400 /* memory transfer to vk */
>> +#define VK_CMD_DOWNLOAD    0x0500 /* memory transfer from vk */
>> +#define VK_CMD_MASK        0x0F00 /* command mask */
>> +};
>> +
>> +#define VK_BAR_FWSTS			0x41C
>> +/* VK_FWSTS definitions */
>> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
>> +#define VK_FWSTS_RELOCATION_EXIT	BIT(1)
>> +#define VK_FWSTS_INIT_START		BIT(2)
>> +#define VK_FWSTS_ARCH_INIT_DONE		BIT(3)
>> +#define VK_FWSTS_PRE_KNL1_INIT_DONE	BIT(4)
>> +#define VK_FWSTS_PRE_KNL2_INIT_DONE	BIT(5)
>> +#define VK_FWSTS_POST_KNL_INIT_DONE	BIT(6)
>> +#define VK_FWSTS_INIT_DONE		BIT(7)
>> +#define VK_FWSTS_APP_INIT_START		BIT(8)
>> +#define VK_FWSTS_APP_INIT_DONE		BIT(9)
> I do not think that BIT() is exported to userspace properly, is it
> really ok here?
Works fine.  Also in uapi/linux/rtc.h.
>
>> +#define VK_FWSTS_MASK			0xFFFFFFFF
>> +#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
>> +					 VK_FWSTS_ARCH_INIT_DONE | \
>> +					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
>> +					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
>> +					 VK_FWSTS_POST_KNL_INIT_DONE | \
>> +					 VK_FWSTS_INIT_DONE | \
>> +					 VK_FWSTS_APP_INIT_START | \
>> +					 VK_FWSTS_APP_INIT_DONE)
>> +/* Deinit */
>> +#define VK_FWSTS_APP_DEINIT_START	BIT(23)
>> +#define VK_FWSTS_APP_DEINIT_DONE	BIT(24)
>> +#define VK_FWSTS_DRV_DEINIT_START	BIT(25)
>> +#define VK_FWSTS_DRV_DEINIT_DONE	BIT(26)
>> +#define VK_FWSTS_RESET_DONE		BIT(27)
>> +#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
>> +					 VK_FWSTS_APP_DEINIT_DONE  | \
>> +					 VK_FWSTS_DRV_DEINIT_START | \
>> +					 VK_FWSTS_DRV_DEINIT_DONE)
>> +/* Last nibble for reboot reason */
>> +#define VK_FWSTS_RESET_REASON_SHIFT	28
>> +#define VK_FWSTS_RESET_REASON_MASK	(0xF << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
>> +#define VK_FWSTS_RESET_UNKNOWN		(0xF << VK_FWSTS_RESET_REASON_SHIFT)
> What are all of these #defines doing in an uapi file?  How is userspace
> going to use them?
There are actually 2 linux user spaces that use this header.
One is the x86 host with the bcm-vk PCI driver.
The x86 host user space could use them to check the firmware status and 
find out what state VK is in.

The other user space is a coprocessor inside the VK SOC.
The app running in user space needs to know the state of the FWSTS in 
order to proceed.
It includes this header in its user space app (even though it doesn't 
user the linux driver, it needs access to the same FWSTS register 
directly).
> thanks,
>
> greg k-h

