Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C403E17F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404230AbfJWK3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 06:29:42 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33417 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391014AbfJWK3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:29:42 -0400
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2864240012;
        Wed, 23 Oct 2019 10:29:39 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:29:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into
 rtc-dev.c
Message-ID: <20191023102937.GK3125@piout.net>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
 <20191022043051.GA20354@ZenIV.linux.org.uk>
 <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3yutJU83AfxKXTFuCVQwsX50KYsDgbGbHeJJ0JoLbejg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/2019 14:14:21+0200, Arnd Bergmann wrote:
> On Tue, Oct 22, 2019 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Oct 17, 2019 at 04:33:09PM +0200, Arnd Bergmann wrote:
> >
> > > However, looking at this again after your comment I found a rather
> > > more serious bug in my new RTC_IRQP_SET handling: Any 64-bit
> > > machine can now bypass the permission check for RTC_IRQP_SET by
> > > calling RTC_IRQP_SET32 instead.
> >
> > You've lost the check on RTC_EPOCH_SET as well.
> 
> Right, originally my plan was to keep the epoch handling local to
> rtc-vr41xx.c as explained in the patch description. The driver is
> specific to a particular very obsolete MIPS machine that was
> apparently only ever used with 32-bit kernels.
> 
> I guess it can't hurt to treat it the same as RTC_IRQP_SET32
> if you prefer. Folding in this change now and adapting the
> changelog text:
> 
> --- a/drivers/rtc/dev.c
> +++ b/drivers/rtc/dev.c
> @@ -402,6 +402,7 @@ static long rtc_dev_ioctl(struct file *file,
>  #ifdef CONFIG_COMPAT
>  #define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
>  #define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
> +#define RTC_EPOCH_SET32                _IOW('p', 0x0e, __u32)
> 
>  static long rtc_dev_compat_ioctl(struct file *file,
>                                  unsigned int cmd, unsigned long arg)
> @@ -416,6 +417,10 @@ static long rtc_dev_compat_ioctl(struct file *file,
>         case RTC_IRQP_SET32:
>                 /* arg is a plain integer, not pointer */
>                 return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
> +
> +       case RTC_EPOCH_SET32:
> +               /* arg is a plain integer, not pointer */
> +               return rtc_dev_ioctl(file, RTC_EPOCH_SET, arg);
>         }
> 
>         return rtc_dev_ioctl(file, cmd, (unsigned long)uarg);
> diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
> index 79f27de545af..c3671043ace7 100644
> --- a/drivers/rtc/rtc-vr41xx.c
> +++ b/drivers/rtc/rtc-vr41xx.c
> @@ -69,7 +69,6 @@ static void __iomem *rtc2_base;
> 
>  /* 32-bit compat for ioctls that nobody else uses */
>  #define RTC_EPOCH_READ32       _IOR('p', 0x0d, __u32)
> -#define RTC_EPOCH_SET32                _IOW('p', 0x0e, __u32)
> 
>  static unsigned long epoch = 1970;     /* Jan 1 1970 00:00:00 */
> 
> @@ -187,7 +186,6 @@ static int vr41xx_rtc_ioctl(struct device *dev,
> unsigned int cmd, unsigned long
>  #ifdef CONFIG_64BIT
>         case RTC_EPOCH_READ32:
>                 return put_user(epoch, (unsigned int __user *)arg);
> -       case RTC_EPOCH_SET32:
>  #endif
>         case RTC_EPOCH_SET:
>                 /* Doesn't support before 1900 */
> 
> > Another potential issue is drivers/input/misc/hp_sdc_rtc.c,
> > provided that the hardware in question might possibly exist
> > on hppa64 boxen - CONFIG_GSC defaults to y and it's not
> > 32bit-only, so that thing is at least selectable on 64bit
> > kernels.
> 
> I decided long ago not to care: that code has never compiled after
> it was originally merged into the kernel in 2005:
> 
> static int hp_sdc_rtc_ioctl(struct inode *inode, struct file *file,
>                            unsigned int cmd, unsigned long arg)
> {
> #if 1
>        return -EINVAL;
> #else
>       ...
>     RTC_IRQP_SET, RTC_EPOCH_SET, ...
>       ...
> #endif
> }
> 
> I don't see any chance that this code is revived. If anyone wanted to
> make it work, the right approach would be to use the rtc framework
> and rewrite the code first.
> 
> I could send a patch to remove the dead code though if that helps.
> 

Please do.

IIUC, this doesn't affect arch/alpha/kernel/rtc.c because alpha has
always been 64bit.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
