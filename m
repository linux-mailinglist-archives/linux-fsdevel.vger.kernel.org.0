Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0BDB021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437889AbfJQOd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 10:33:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34977 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfJQOd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:33:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so3918533qtq.2;
        Thu, 17 Oct 2019 07:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxqpxXBkdXm8+PD0xJUGu+5NPhpp64cZpau/yKP1PZY=;
        b=fTM5hjnOYN0BD62J4BVMJ5Bx14uPDXFzyayGQpcdL9pzHwLz2Mc/QrGm92hSRKXQEd
         NLtFbUe0ZfIyIfyKuqT3ff3UxTPoY41KEOnD3H+tI8qL5ms1/9aNk9jVIhuR0nClc2jn
         kdjZk4TIqG4Cqt8PZyACl1cY1HucjqEVIxDBghzWFLF7hdS6IabG90cILbH+YOEOJQtW
         GGeZWrCSJIhl59JNYxe+zkCX93/ORN6Mk0en4w79UrK0CSrecuun7jltqFZXMceJI2a2
         w6jjcuygfoJBbHtdXR/rUVLoZTWwZ3XoXmvjBz0M2VWGp6skb21S1bQvuW6DMv0itdNs
         59kQ==
X-Gm-Message-State: APjAAAVNYqCmHx8gdAeH4kZdadvGXNEG8j/4kE2GYvjp9ChbKwCHh22t
        9yfRn/M1bWEv0hYnzVyK8J2MZB1CtJHk0GWV1QE=
X-Google-Smtp-Source: APXvYqzvTygfLmPgy5cG7H73eugUrdFK6qsnTv2IvbiQ3RJPDn04cLz8yPwWU8xHjvUQ/3XK3Pv4SUukJRbVUi3ELPg=
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr4100968qvt.197.1571322806412;
 Thu, 17 Oct 2019 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-10-arnd@arndb.de>
 <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
In-Reply-To: <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 16:33:09 +0200
Message-ID: <CAK8P3a0BYkPTSnQUmde2k+HVcg7XNihzWTEzrCD4d8G8ecO9-w@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 3:42 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Wed, 2019-10-09 at 21:10 +0200, Arnd Bergmann wrote:
> > We no longer need the rtc compat handling to be in common code, now that
> > all drivers are either moved to the rtc-class framework, or (rarely)
> > exist in drivers/char for architectures without compat mode (m68k,
> > alpha and ia64, respectively).
> >
> > I checked the list of ioctl commands in drivers, and the ones that are
> > not already handled are all compatible, again with the one exception of
> > m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
> > compat mode.
> >
> > Since the ioctl commands are either compatible or differ in both structure
> > and command code between 32-bit and 64-bit, we can merge the compat
> > handler into the native one and just implement the two common compat
> > commands (RTC_IRQP_READ, RTC_IRQP_SET) there.
> [...]
>
> I don't think this can work properly on s390, because some of them take
> integers and some take pointers.

Thanks a lot for taking a look at the patch and pointing this out!

I don't remember how I got to this, either I missed the problem or I
decided that it was ok, since it will still do the right thing:
On s390 only the highest bit is cleared in a pointer value, and we
ensure that the RTC_IRQP_SET argument is between 1 and 8192.

Passing a value of (0x80000000 + n) where n is in the valid range
would lead to the call succeeding unexpectedly on compat s390
(if it had an RTC, which it does not) which is clearly not good but
mostly harmless. I certainly had not considered this case.

However, looking at this again after your comment I found a rather
more serious bug in my new RTC_IRQP_SET handling: Any 64-bit
machine can now bypass the permission check for RTC_IRQP_SET by
calling RTC_IRQP_SET32 instead.

I'll fix it both issues by adding a rtc_compat_dev_ioctl() to handle
RTC_IRQP_SET32/RTC_IRQP_READ32:

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 1dc5063f78c9..9e4fd5088ead 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -358,16 +358,6 @@ static long rtc_dev_ioctl(struct file *file,
                mutex_unlock(&rtc->ops_lock);
                return rtc_update_irq_enable(rtc, 0);

-#ifdef CONFIG_64BIT
-#define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
-#define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
-       case RTC_IRQP_SET32:
-               err = rtc_irq_set_freq(rtc, arg);
-               break;
-       case RTC_IRQP_READ32:
-               err = put_user(rtc->irq_freq, (unsigned int __user *)uarg);
-               break;
-#endif
        case RTC_IRQP_SET:
                err = rtc_irq_set_freq(rtc, arg);
                break;
@@ -409,6 +399,29 @@ static long rtc_dev_ioctl(struct file *file,
        return err;
 }

+#ifdef CONFIG_COMPAT
+#define RTC_IRQP_SET32         _IOW('p', 0x0c, __u32)
+#define RTC_IRQP_READ32                _IOR('p', 0x0b, __u32)
+
+static long rtc_dev_compat_ioctl(struct file *file,
+                                unsigned int cmd, unsigned long arg)
+{
+       struct rtc_device *rtc = file->private_data;
+       void __user *uarg = compat_ptr(arg);
+
+       switch (cmd) {
+       case RTC_IRQP_READ32:
+               return put_user(rtc->irq_freq, (__u32 __user *)uarg);
+
+       case RTC_IRQP_SET32:
+               /* arg is a plain integer, not pointer */
+               return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
+       }
+
+       return rtc_dev_ioctl(file, cmd, (unsigned long)uarg);
+}
+#endif
+
 static int rtc_dev_fasync(int fd, struct file *file, int on)
 {
        struct rtc_device *rtc = file->private_data;
@@ -444,7 +457,7 @@ static const struct file_operations rtc_dev_fops = {
        .read           = rtc_dev_read,
        .poll           = rtc_dev_poll,
        .unlocked_ioctl = rtc_dev_ioctl,
-       .compat_ioctl   = compat_ptr_ioctl,
+       .compat_ioctl   = rtc_dev_compat_ioctl,
        .open           = rtc_dev_open,
        .release        = rtc_dev_release,
        .fasync         = rtc_dev_fasync,

If you and Alexandre are both happy with this version, I'll fold it into
my original patch.

      Arnd
