Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA910E180A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 12:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbfJWKce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 06:32:34 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46475 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbfJWKce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:32:34 -0400
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2816C240010;
        Wed, 23 Oct 2019 10:32:29 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:32:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into
 rtc-dev.c
Message-ID: <20191023103228.GL3125@piout.net>
References: <20191009190853.245077-1-arnd@arndb.de>
 <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
 <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/10/2019 16:33:09+0200, Arnd Bergmann wrote:
> On Thu, Oct 17, 2019 at 3:42 PM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> >
> > On Wed, 2019-10-09 at 21:10 +0200, Arnd Bergmann wrote:
> > > We no longer need the rtc compat handling to be in common code, now that
> > > all drivers are either moved to the rtc-class framework, or (rarely)
> > > exist in drivers/char for architectures without compat mode (m68k,
> > > alpha and ia64, respectively).
> > >
> > > I checked the list of ioctl commands in drivers, and the ones that are
> > > not already handled are all compatible, again with the one exception of
> > > m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
> > > compat mode.
> > >
> > > Since the ioctl commands are either compatible or differ in both structure
> > > and command code between 32-bit and 64-bit, we can merge the compat
> > > handler into the native one and just implement the two common compat
> > > commands (RTC_IRQP_READ, RTC_IRQP_SET) there.
> > [...]
> >
> > I don't think this can work properly on s390, because some of them take
> > integers and some take pointers.
> 
> Thanks a lot for taking a look at the patch and pointing this out!
> 
> I don't remember how I got to this, either I missed the problem or I
> decided that it was ok, since it will still do the right thing:
> On s390 only the highest bit is cleared in a pointer value, and we
> ensure that the RTC_IRQP_SET argument is between 1 and 8192.
> 
> Passing a value of (0x80000000 + n) where n is in the valid range
> would lead to the call succeeding unexpectedly on compat s390
> (if it had an RTC, which it does not) which is clearly not good but
> mostly harmless. I certainly had not considered this case.
> 
> However, looking at this again after your comment I found a rather
> more serious bug in my new RTC_IRQP_SET handling: Any 64-bit
> machine can now bypass the permission check for RTC_IRQP_SET by
> calling RTC_IRQP_SET32 instead.
> 
> I'll fix it both issues by adding a rtc_compat_dev_ioctl() to handle
> RTC_IRQP_SET32/RTC_IRQP_READ32:
> 
> diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
> index 1dc5063f78c9..9e4fd5088ead 100644
> --- a/drivers/rtc/dev.c
> +++ b/drivers/rtc/dev.c
> @@ -358,16 +358,6 @@ static long rtc_dev_ioctl(struct file *file,
>                 mutex_unlock(&rtc->ops_lock);
>                 return rtc_update_irq_enable(rtc, 0);
> 
> -#ifdef CONFIG_64BIT
> -#define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
> -#define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
> -       case RTC_IRQP_SET32:
> -               err = rtc_irq_set_freq(rtc, arg);
> -               break;
> -       case RTC_IRQP_READ32:
> -               err = put_user(rtc->irq_freq, (unsigned int __user *)uarg);
> -               break;
> -#endif
>         case RTC_IRQP_SET:
>                 err = rtc_irq_set_freq(rtc, arg);
>                 break;
> @@ -409,6 +399,29 @@ static long rtc_dev_ioctl(struct file *file,
>         return err;
>  }
> 
> +#ifdef CONFIG_COMPAT
> +#define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
> +#define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
> +
> +static long rtc_dev_compat_ioctl(struct file *file,
> +                                unsigned int cmd, unsigned long arg)
> +{
> +       struct rtc_device *rtc = file->private_data;
> +       void __user *uarg = compat_ptr(arg);
> +
> +       switch (cmd) {
> +       case RTC_IRQP_READ32:
> +               return put_user(rtc->irq_freq, (__u32 __user *)uarg);
> +
> +       case RTC_IRQP_SET32:
> +               /* arg is a plain integer, not pointer */
> +               return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
> +       }
> +
> +       return rtc_dev_ioctl(file, cmd, (unsigned long)uarg);
> +}
> +#endif
> +
>  static int rtc_dev_fasync(int fd, struct file *file, int on)
>  {
>         struct rtc_device *rtc = file->private_data;
> @@ -444,7 +457,7 @@ static const struct file_operations rtc_dev_fops = {
>         .read           = rtc_dev_read,
>         .poll           = rtc_dev_poll,
>         .unlocked_ioctl = rtc_dev_ioctl,
> -       .compat_ioctl   = compat_ptr_ioctl,
> +       .compat_ioctl   = rtc_dev_compat_ioctl,
>         .open           = rtc_dev_open,
>         .release        = rtc_dev_release,
>         .fasync         = rtc_dev_fasync,
> 
> If you and Alexandre are both happy with this version, I'll fold it into
> my original patch.
> 

I'm OK with that version

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
