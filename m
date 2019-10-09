Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC9D18B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfJITZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:25:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53787 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:25:28 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 016ED40002;
        Wed,  9 Oct 2019 19:25:24 +0000 (UTC)
Date:   Wed, 9 Oct 2019 21:25:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
Message-ID: <20191009192524.GK4254@piout.net>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009191044.308087-10-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

If you ever have to resend, the file is now named rtc/dev.c so you could
adjust the subject.

On 09/10/2019 21:10:10+0200, Arnd Bergmann wrote:
> We no longer need the rtc compat handling to be in common code, now that
> all drivers are either moved to the rtc-class framework, or (rarely)
> exist in drivers/char for architectures without compat mode (m68k,
> alpha and ia64, respectively).
> 
> I checked the list of ioctl commands in drivers, and the ones that are
> not already handled are all compatible, again with the one exception of
> m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
> compat mode.
> 
> Since the ioctl commands are either compatible or differ in both structure
> and command code between 32-bit and 64-bit, we can merge the compat
> handler into the native one and just implement the two common compat
> commands (RTC_IRQP_READ, RTC_IRQP_SET) there. The result is a slight
> change in behavior, as a native 64-bit process will now also handle the
> 32-bit commands (RTC_IRQP_SET32/RTC_IRQP_SET).
> 
> The old conversion handler also deals with RTC_EPOCH_READ and
> RTC_EPOCH_SET, which are not handled in rtc-dev.c but only in a single
> device driver (rtc-vr41xx), so I'm adding the compat version in the same
> place. I don't expect other drivers to need those commands in the future.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: merge compat handler into ioctl function to avoid the
>     compat_alloc_user_space() roundtrip, based on feedback
>     from Al Viro.
> ---
>  drivers/rtc/dev.c        | 13 +++++++++-
>  drivers/rtc/rtc-vr41xx.c | 10 ++++++++
>  fs/compat_ioctl.c        | 53 ----------------------------------------
>  3 files changed, 22 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
> index 84feb2565abd..1dc5063f78c9 100644
> --- a/drivers/rtc/dev.c
> +++ b/drivers/rtc/dev.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/compat.h>
>  #include <linux/module.h>
>  #include <linux/rtc.h>
>  #include <linux/sched/signal.h>
> @@ -357,10 +358,19 @@ static long rtc_dev_ioctl(struct file *file,
>  		mutex_unlock(&rtc->ops_lock);
>  		return rtc_update_irq_enable(rtc, 0);
>  
> +#ifdef CONFIG_64BIT
> +#define RTC_IRQP_SET32		_IOW('p', 0x0c, __u32)
> +#define RTC_IRQP_READ32		_IOR('p', 0x0b, __u32)
> +	case RTC_IRQP_SET32:
> +		err = rtc_irq_set_freq(rtc, arg);
> +		break;
> +	case RTC_IRQP_READ32:
> +		err = put_user(rtc->irq_freq, (unsigned int __user *)uarg);
> +		break;
> +#endif
>  	case RTC_IRQP_SET:
>  		err = rtc_irq_set_freq(rtc, arg);
>  		break;
> -
>  	case RTC_IRQP_READ:
>  		err = put_user(rtc->irq_freq, (unsigned long __user *)uarg);
>  		break;
> @@ -434,6 +444,7 @@ static const struct file_operations rtc_dev_fops = {
>  	.read		= rtc_dev_read,
>  	.poll		= rtc_dev_poll,
>  	.unlocked_ioctl	= rtc_dev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
>  	.open		= rtc_dev_open,
>  	.release	= rtc_dev_release,
>  	.fasync		= rtc_dev_fasync,
> diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
> index c75230562c0d..79f27de545af 100644
> --- a/drivers/rtc/rtc-vr41xx.c
> +++ b/drivers/rtc/rtc-vr41xx.c
> @@ -4,6 +4,7 @@
>   *
>   *  Copyright (C) 2003-2008  Yoichi Yuasa <yuasa@linux-mips.org>
>   */
> +#include <linux/compat.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
> @@ -66,6 +67,10 @@ static void __iomem *rtc2_base;
>  #define rtc2_read(offset)		readw(rtc2_base + (offset))
>  #define rtc2_write(offset, value)	writew((value), rtc2_base + (offset))
>  
> +/* 32-bit compat for ioctls that nobody else uses */
> +#define RTC_EPOCH_READ32	_IOR('p', 0x0d, __u32)
> +#define RTC_EPOCH_SET32		_IOW('p', 0x0e, __u32)
> +
>  static unsigned long epoch = 1970;	/* Jan 1 1970 00:00:00 */
>  
>  static DEFINE_SPINLOCK(rtc_lock);
> @@ -179,6 +184,11 @@ static int vr41xx_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
>  	switch (cmd) {
>  	case RTC_EPOCH_READ:
>  		return put_user(epoch, (unsigned long __user *)arg);
> +#ifdef CONFIG_64BIT
> +	case RTC_EPOCH_READ32:
> +		return put_user(epoch, (unsigned int __user *)arg);
> +	case RTC_EPOCH_SET32:
> +#endif
>  	case RTC_EPOCH_SET:
>  		/* Doesn't support before 1900 */
>  		if (arg < 1900)
> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index cec3ec0a1727..47da220f95b1 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -32,7 +32,6 @@
>  #include <linux/vt_kern.h>
>  #include <linux/raw.h>
>  #include <linux/blkdev.h>
> -#include <linux/rtc.h>
>  #include <linux/pci.h>
>  #include <linux/serial.h>
>  #include <linux/ctype.h>
> @@ -436,37 +435,6 @@ static int mt_ioctl_trans(struct file *file,
>  #define HCIUARTSETFLAGS		_IOW('U', 203, int)
>  #define HCIUARTGETFLAGS		_IOR('U', 204, int)
>  
> -#define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
> -#define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
> -#define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)
> -#define RTC_EPOCH_SET32		_IOW('p', 0x0e, compat_ulong_t)
> -
> -static int rtc_ioctl(struct file *file,
> -		unsigned cmd, void __user *argp)
> -{
> -	unsigned long __user *valp = compat_alloc_user_space(sizeof(*valp));
> -	int ret;
> -
> -	if (valp == NULL)
> -		return -EFAULT;
> -	switch (cmd) {
> -	case RTC_IRQP_READ32:
> -	case RTC_EPOCH_READ32:
> -		ret = do_ioctl(file, (cmd == RTC_IRQP_READ32) ?
> -					RTC_IRQP_READ : RTC_EPOCH_READ,
> -					(unsigned long)valp);
> -		if (ret)
> -			return ret;
> -		return convert_in_user(valp, (unsigned int __user *)argp);
> -	case RTC_IRQP_SET32:
> -		return do_ioctl(file, RTC_IRQP_SET, (unsigned long)argp);
> -	case RTC_EPOCH_SET32:
> -		return do_ioctl(file, RTC_EPOCH_SET, (unsigned long)argp);
> -	}
> -
> -	return -ENOIOCTLCMD;
> -}
> -
>  /*
>   * simple reversible transform to make our table more evenly
>   * distributed after sorting.
> @@ -503,21 +471,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
>  /* Big V (don't complain on serial console) */
>  IGNORE_IOCTL(VT_OPENQRY)
>  IGNORE_IOCTL(VT_GETMODE)
> -/* Little p (/dev/rtc, /dev/envctrl, etc.) */
> -COMPATIBLE_IOCTL(RTC_AIE_ON)
> -COMPATIBLE_IOCTL(RTC_AIE_OFF)
> -COMPATIBLE_IOCTL(RTC_UIE_ON)
> -COMPATIBLE_IOCTL(RTC_UIE_OFF)
> -COMPATIBLE_IOCTL(RTC_PIE_ON)
> -COMPATIBLE_IOCTL(RTC_PIE_OFF)
> -COMPATIBLE_IOCTL(RTC_WIE_ON)
> -COMPATIBLE_IOCTL(RTC_WIE_OFF)
> -COMPATIBLE_IOCTL(RTC_ALM_SET)
> -COMPATIBLE_IOCTL(RTC_ALM_READ)
> -COMPATIBLE_IOCTL(RTC_RD_TIME)
> -COMPATIBLE_IOCTL(RTC_SET_TIME)
> -COMPATIBLE_IOCTL(RTC_WKALM_SET)
> -COMPATIBLE_IOCTL(RTC_WKALM_RD)
>  /*
>   * These two are only for the sbus rtc driver, but
>   * hwclock tries them on every rtc device first when
> @@ -897,12 +850,6 @@ static long do_ioctl_trans(unsigned int cmd,
>  	case MTIOCPOS32:
>  		return mt_ioctl_trans(file, cmd, argp);
>  #endif
> -	/* Not implemented in the native kernel */
> -	case RTC_IRQP_READ32:
> -	case RTC_IRQP_SET32:
> -	case RTC_EPOCH_READ32:
> -	case RTC_EPOCH_SET32:
> -		return rtc_ioctl(file, cmd, argp);
>  	}
>  
>  	/*
> -- 
> 2.20.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
