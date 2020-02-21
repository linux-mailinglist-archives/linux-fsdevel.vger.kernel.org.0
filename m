Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09270167944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 10:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBUJWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 04:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgBUJWW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:22:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DDD20722;
        Fri, 21 Feb 2020 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582276940;
        bh=pjHNbG2oq138uQYds5DJIbJkvhz2l6NkNog/+t1q8Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxDT8BRhztP2WTX3bgEvllGQp8+PDLoASLjfZ8HWWU07IYw0PXLTO0xQz0QbEbHNn
         gUUoX8hmkk9yqi41YBvLcS3cD4XH7wCLjhrzYRIescdRlq6C5KJdluJrjiZjDX8hxG
         0qjFvw7nx1jGT9Wlj74NJcrGyy0msCUCjjlnunGo=
Date:   Fri, 21 Feb 2020 10:22:17 +0100
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
Message-ID: <20200221092217.GA60193@kroah.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-6-scott.branden@broadcom.com>
 <20200220075045.GB3261162@kroah.com>
 <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <030219dc-539a-a2db-5ab2-1de7336a811c@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 05:15:58PM -0800, Scott Branden wrote:
> Hi Greg,
> 
> Thanks for the review.  Comments inline.
> 
> On 2020-02-19 11:50 p.m., Greg Kroah-Hartman wrote:
> > On Wed, Feb 19, 2020 at 04:48:23PM -0800, Scott Branden wrote:
> > > Add user space api for bcm-vk driver.
> > > 
> > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > ---
> > >   include/uapi/linux/misc/bcm_vk.h | 117 +++++++++++++++++++++++++++++++
> > >   1 file changed, 117 insertions(+)
> > >   create mode 100644 include/uapi/linux/misc/bcm_vk.h
> > > 
> > > diff --git a/include/uapi/linux/misc/bcm_vk.h b/include/uapi/linux/misc/bcm_vk.h
> > > new file mode 100644
> > > index 000000000000..56a2178e06f5
> > > --- /dev/null
> > > +++ b/include/uapi/linux/misc/bcm_vk.h
> > > @@ -0,0 +1,117 @@
> > > +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> > > +/*
> > > + * Copyright 2018-2020 Broadcom.
> > > + */
> > > +
> > > +#ifndef __UAPI_LINUX_MISC_BCM_VK_H
> > > +#define __UAPI_LINUX_MISC_BCM_VK_H
> > > +
> > > +#include <linux/ioctl.h>
> > > +#include <linux/types.h>
> > > +
> > > +struct vk_image {
> > > +	__u32 type;     /* Type of image */
> > > +#define VK_IMAGE_TYPE_BOOT1 1 /* 1st stage (load to SRAM) */
> > > +#define VK_IMAGE_TYPE_BOOT2 2 /* 2nd stage (load to DDR) */
> > > +	char filename[64]; /* Filename of image */
> > __u8?
> I don't understand why char is not appropriate for a filename.
> Would like to understand why __u8 is correct to use here vs. char.

Why is __u8 not correct?  It's the data type we use for ioctls.

> > > +};
> > > +
> > > +/* default firmware images names */
> > > +#define VK_BOOT1_DEF_VALKYRIE_FILENAME	"vk-boot1.bin"
> > > +#define VK_BOOT2_DEF_VALKYRIE_FILENAME	"vk-boot2.bin"
> > > +
> > > +#define VK_BOOT1_DEF_VIPER_FILENAME	"vp-boot1.bin"
> > > +#define VK_BOOT2_DEF_VIPER_FILENAME	"vp-boot2.bin"
> > Why do these need to be in a uapi .h file?  Shouldn't they just be part
> > of the normal MODULE_FIRMWARE() macro in the driver itself?
> ioctl VK_IOCTL_LOAD_IMAGE passes in type of image to load and filename.
> These are the default names used if the images are autoloaded by the driver.

Then put them in the driver, not in the user api file.

> But if userspace app wishes to load (or reload) the default images then it
> needs to know the name of the file to pass in ioctl.

That's up to userspace.

> I guess I could change the API at this point to lookup the default filename
> if NULL filename passed into ioctl.

Yes please.

> > > +struct vk_access {
> > > +	__u8 barno;     /* BAR number to use */
> > > +	__u8 type;      /* Type of access */
> > > +#define VK_ACCESS_READ 0
> > > +#define VK_ACCESS_WRITE 1
> > > +	__u32 len;      /* length of data */
> > Horrible padding issues, are you sure this all works properly?
> Haven't had any issues.

Use pahole to see the holes you have in here and please fix that up.

> > > +	__u64 offset;   /* offset in BAR */
> > > +	__u32 *data;    /* where to read/write data to */
> > Are you _SURE_ you want a pointer here?  How do you handle the compat
> > issues with 32/64 user/kernel space?
> Don't care about 32-bit user space for this driver.

We all do, see the link that Arnd sent you.

> I don't think there isn't even enough memory in such systems for the number
> of streams of video buffers needed for transcoding.

32bit systems have lots of memory.

> This driver is only used in high end 64-bit x86 servers.

For today, what about in 2 years?

> But, VK_IOCTL_ACCESS_BAR can go away entirely if standard user space
> approach already exists as you imply.

Yes, please use that interface, as you should never duplicate existing
functionality.

> > > +};
> > And isn't this just a normal PCI write thing?  Can't you do it from
> > userspace using the existing userspace PCI accesses?  Why do you need a
> > special ioctl for it?
> This follows how pci_endpoint_test reads and writes BARS via ioctl.
> It also abstracts the accesses all into the device node being opened.
> 
> I am not familiar with userspace PCI accesses.  Would this be through some
> sys entries?

Yes, it can read PCI config space that way, and if you use the uio
interface, you can read PCI memory.

thanks,

greg k-h
