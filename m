Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249371658C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 08:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBTHut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 02:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgBTHut (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:50:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CDA208C4;
        Thu, 20 Feb 2020 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582185048;
        bh=v4lODHdZcWtKOq6QBrb3F9koDQfFnRGgdQb407AOT3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftUM9+xRUbFzf2UyGuR0/dLsTHYKcURtDGz787L0nfDOAaDHXb98zOde5kRu0f/bX
         u0TUcYfqcNDlhGo+zynEISCFOynB9qIfWwm4XHEUuhR47QUt7sOHnzyZppmV7abzXu
         yPaz6fN6orZthXEgwkza7hrppfFQBjU0EqvEObuA=
Date:   Thu, 20 Feb 2020 08:50:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
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
Subject: Re: [PATCH v2 5/7] bcm-vk: add bcm_vk UAPI
Message-ID: <20200220075045.GB3261162@kroah.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-6-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-6-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:48:23PM -0800, Scott Branden wrote:
> Add user space api for bcm-vk driver.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  include/uapi/linux/misc/bcm_vk.h | 117 +++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 include/uapi/linux/misc/bcm_vk.h
> 
> diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> new file mode 100644
> index 000000000000..56a2178e06f5
> --- /dev/null
> +++ b/include/uapi/linux/misc/bcm_vk.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> +/*
> + * Copyright 2018-2020 Broadcom.
> + */
> +
> +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> +#define __UAPI_LINUX_MISC_BCM_VK_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct vk_image {
> +	__u32 type;     /* Type of image */
> +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> +	char filename[64]; /* Filename of image */

__u8?

> +};
> +
> +/* default firmware images names */
> +#define VK_BOOT1_DEF_VALKYRIE_FILENAME	"vk-boot1.bin"
> +#define VK_BOOT2_DEF_VALKYRIE_FILENAME	"vk-boot2.bin"
> +
> +#define VK_BOOT1_DEF_VIPER_FILENAME	"vp-boot1.bin"
> +#define VK_BOOT2_DEF_VIPER_FILENAME	"vp-boot2.bin"

Why do these need to be in a uapi .h file?  Shouldn't they just be part
of the normal MODULE_FIRMWARE() macro in the driver itself?

> +
> +struct vk_access {
> +	__u8 barno;     /* BAR number to use */
> +	__u8 type;      /* Type of access */
> +#define VK_ACCESS_READ 0
> +#define VK_ACCESS_WRITE 1
> +	__u32 len;      /* length of data */

Horrible padding issues, are you sure this all works properly?

> +	__u64 offset;   /* offset in BAR */
> +	__u32 *data;    /* where to read/write data to */

Are you _SURE_ you want a pointer here?  How do you handle the compat
issues with 32/64 user/kernel space?

> +};

And isn't this just a normal PCI write thing?  Can't you do it from
userspace using the existing userspace PCI accesses?  Why do you need a
special ioctl for it?

> +
> +struct vk_reset {
> +	__u32 arg1;
> +	__u32 arg2;
> +};
> +
> +#define VK_MAGIC              0x5E
> +
> +/* Load image to Valkyrie */
> +#define VK_IOCTL_LOAD_IMAGE   _IOW(VK_MAGIC, 0x2, struct vk_image)
> +
> +/* Read data from Valkyrie */
> +#define VK_IOCTL_ACCESS_BAR   _IOWR(VK_MAGIC, 0x3, struct vk_access)
> +
> +/* Send Reset to Valkyrie */
> +#define VK_IOCTL_RESET        _IOW(VK_MAGIC, 0x4, struct vk_reset)
> +
> +/*
> + * message block - basic unit in the message where a message's size is always
> + *		   N x sizeof(basic_block)
> + */
> +struct vk_msg_blk {
> +	__u8 function_id;
> +#define VK_FID_TRANS_BUF 5
> +#define VK_FID_SHUTDOWN  8
> +	__u8 size;
> +	__u16 queue_id:4;
> +	__u16 msg_id:12;

Do not use bitfields in ioctls, they will not work properly on all
systems.  Use masks and shifts instead.

> +	__u32 context_id;
> +	__u32 args[2];
> +#define VK_CMD_PLANES_MASK 0x000F /* number of planes to up/download */
> +#define VK_CMD_UPLOAD      0x0400 /* memory transfer to vk */
> +#define VK_CMD_DOWNLOAD    0x0500 /* memory transfer from vk */
> +#define VK_CMD_MASK        0x0F00 /* command mask */
> +};
> +
> +#define VK_BAR_FWSTS			0x41C
> +/* VK_FWSTS definitions */
> +#define VK_FWSTS_RELOCATION_ENTRY	BIT(0)
> +#define VK_FWSTS_RELOCATION_EXIT	BIT(1)
> +#define VK_FWSTS_INIT_START		BIT(2)
> +#define VK_FWSTS_ARCH_INIT_DONE		BIT(3)
> +#define VK_FWSTS_PRE_KNL1_INIT_DONE	BIT(4)
> +#define VK_FWSTS_PRE_KNL2_INIT_DONE	BIT(5)
> +#define VK_FWSTS_POST_KNL_INIT_DONE	BIT(6)
> +#define VK_FWSTS_INIT_DONE		BIT(7)
> +#define VK_FWSTS_APP_INIT_START		BIT(8)
> +#define VK_FWSTS_APP_INIT_DONE		BIT(9)

I do not think that BIT() is exported to userspace properly, is it
really ok here?

> +#define VK_FWSTS_MASK			0xFFFFFFFF
> +#define VK_FWSTS_READY			(VK_FWSTS_INIT_START | \
> +					 VK_FWSTS_ARCH_INIT_DONE | \
> +					 VK_FWSTS_PRE_KNL1_INIT_DONE | \
> +					 VK_FWSTS_PRE_KNL2_INIT_DONE | \
> +					 VK_FWSTS_POST_KNL_INIT_DONE | \
> +					 VK_FWSTS_INIT_DONE | \
> +					 VK_FWSTS_APP_INIT_START | \
> +					 VK_FWSTS_APP_INIT_DONE)
> +/* Deinit */
> +#define VK_FWSTS_APP_DEINIT_START	BIT(23)
> +#define VK_FWSTS_APP_DEINIT_DONE	BIT(24)
> +#define VK_FWSTS_DRV_DEINIT_START	BIT(25)
> +#define VK_FWSTS_DRV_DEINIT_DONE	BIT(26)
> +#define VK_FWSTS_RESET_DONE		BIT(27)
> +#define VK_FWSTS_DEINIT_TRIGGERED	(VK_FWSTS_APP_DEINIT_START | \
> +					 VK_FWSTS_APP_DEINIT_DONE  | \
> +					 VK_FWSTS_DRV_DEINIT_START | \
> +					 VK_FWSTS_DRV_DEINIT_DONE)
> +/* Last nibble for reboot reason */
> +#define VK_FWSTS_RESET_REASON_SHIFT	28
> +#define VK_FWSTS_RESET_REASON_MASK	(0xF << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_SYS_PWRUP	(0x0 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_MBOX_DB		(0x1 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_M7_WDOG		(0x2 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_TEMP		(0x3 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_PCI_FLR		(0x4 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_PCI_HOT		(0x5 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_PCI_WARM		(0x6 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_PCI_COLD		(0x7 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_L1		(0x8 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_L0		(0x9 << VK_FWSTS_RESET_REASON_SHIFT)
> +#define VK_FWSTS_RESET_UNKNOWN		(0xF << VK_FWSTS_RESET_REASON_SHIFT)

What are all of these #defines doing in an uapi file?  How is userspace
going to use them?

thanks,

greg k-h
