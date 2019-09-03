Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1281AA657D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 11:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfICJhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 05:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfICJhY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:37:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A07C2173E;
        Tue,  3 Sep 2019 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567503443;
        bh=1pvNoYETXZHOaryWxGlz7vAjmxKlkKa4yKwwHuSZMVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIdtFNVUgfs39r6OrFh5h/UU5nqUa+osiFIglZDVzLqzeVKvAKQOY4uo4MrQ3wTOR
         iktWgzpMbsenQo1lKN/dw/zbemJ6jAUs1Oh5lHJg1SB++AKnnmuLbc8joRxdOquJR+
         +77Rc4gc37ehaPRXnNk0T6OmffvNqIU6xQdYT1so=
Date:   Tue, 3 Sep 2019 11:37:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     David Howells <dhowells@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "raven@themaw.net" <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
Message-ID: <20190903093720.GD12325@kroah.com>
References: <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717350329.2204.7056537095039252263.stgit@warthog.procyon.org.uk>
 <TYAPR01MB4544829484474FC61E850F32D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB4544829484474FC61E850F32D8B90@TYAPR01MB4544.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:53:31AM +0000, Yoshihiro Shimoda wrote:
> Hi,
> 
> > From: David Howells, Sent: Friday, August 30, 2019 10:58 PM
> <snip>
> > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > index 9063ede411ae..b8572e4d6a1b 100644
> > --- a/drivers/usb/core/devio.c
> > +++ b/drivers/usb/core/devio.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <asm/byteorder.h>
> >  #include <linux/moduleparam.h>
> > +#include <linux/watch_queue.h>
> > 
> >  #include "usb.h"
> > 
> > @@ -2660,13 +2661,68 @@ static void usbdev_remove(struct usb_device *udev)
> >  	}
> >  }
> > 
> > +#ifdef CONFIG_USB_NOTIFICATIONS
> > +static noinline void post_usb_notification(const char *devname,
> > +					   enum usb_notification_type subtype,
> > +					   u32 error)
> > +{
> > +	unsigned int gran = WATCH_LENGTH_GRANULARITY;
> > +	unsigned int name_len, n_len;
> > +	u64 id = 0; /* Might want to put a dev# here. */
> > +
> > +	struct {
> > +		struct usb_notification n;
> > +		char more_name[USB_NOTIFICATION_MAX_NAME_LEN -
> > +			       (sizeof(struct usb_notification) -
> > +				offsetof(struct usb_notification, name))];
> > +	} n;
> > +
> > +	name_len = strlen(devname);
> > +	name_len = min_t(size_t, name_len, USB_NOTIFICATION_MAX_NAME_LEN);
> > +	n_len = round_up(offsetof(struct usb_notification, name) + name_len,
> > +			 gran) / gran;
> > +
> > +	memset(&n, 0, sizeof(n));
> > +	memcpy(n.n.name, devname, n_len);
> > +
> > +	n.n.watch.type		= WATCH_TYPE_USB_NOTIFY;
> > +	n.n.watch.subtype	= subtype;
> > +	n.n.watch.info		= n_len;
> > +	n.n.error		= error;
> > +	n.n.name_len		= name_len;
> > +
> > +	post_device_notification(&n.n.watch, id);
> > +}
> > +
> > +void post_usb_device_notification(const struct usb_device *udev,
> > +				  enum usb_notification_type subtype, u32 error)
> > +{
> > +	post_usb_notification(dev_name(&udev->dev), subtype, error);
> > +}
> > +
> > +void post_usb_bus_notification(const struct usb_bus *ubus,
> 
> This function's argument is struct usb_bus *, but ...
> 
> > +			       enum usb_notification_type subtype, u32 error)
> > +{
> > +	post_usb_notification(ubus->bus_name, subtype, error);
> > +}
> > +#endif
> > +
> >  static int usbdev_notify(struct notifier_block *self,
> >  			       unsigned long action, void *dev)
> >  {
> >  	switch (action) {
> >  	case USB_DEVICE_ADD:
> > +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_ADD, 0);
> >  		break;
> >  	case USB_DEVICE_REMOVE:
> > +		post_usb_device_notification(dev, NOTIFY_USB_DEVICE_REMOVE, 0);
> > +		usbdev_remove(dev);
> > +		break;
> > +	case USB_BUS_ADD:
> > +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_ADD, 0);
> > +		break;
> > +	case USB_BUS_REMOVE:
> > +		post_usb_bus_notification(dev, NOTIFY_USB_BUS_REMOVE, 0);
> >  		usbdev_remove(dev);
> 
> this function calls usbdev_remove() with incorrect argument if the action
> is USB_BUS_REMOVE. So, this seems to cause the following issue [1] on
> my environment (R-Car H3 / r8a7795 on next-20190902) [2]. However, I have
> no idea how to fix the issue, so I report this issue at the first step.

As a few of us just discussed this on IRC, these bus notifiers should
probably be dropped as these are the incorrect structure type as you
found out.  Thanks for the report.

greg k-h
