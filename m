Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8DA8972
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfIDPRw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 4 Sep 2019 11:17:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfIDPRw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:17:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67C7710F23EC;
        Wed,  4 Sep 2019 15:17:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC6560C44;
        Wed,  4 Sep 2019 15:17:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.1909031316130.1859-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1909031316130.1859-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     dhowells@redhat.com, Guenter Roeck <linux@roeck-us.net>,
        viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] usb: Add USB subsystem notifications [ver #7]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1500.1567610266.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 04 Sep 2019 16:17:46 +0100
Message-ID: <1501.1567610266@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Wed, 04 Sep 2019 15:17:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:

> > > Unfortunately, I don't know how to fix it and don't have much time to
> > > investigate it right now - and it's something that can be added back later.
> > 
> > The cause of your problem is quite simple:
> > 
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
> >  		break;
> >  	}
> > 
> > The original code had usbdev_remove(dev) under the USB_DEVICE_REMOVE
> > case.  The patch mistakenly moves it, putting it under the
> ------------------------------^^^^^
> 
> Sorry, I should have said "duplicates" it.

Ah, thanks.  I'd already removed the USB bus notifications, so I'll leave them
out for now.

David
