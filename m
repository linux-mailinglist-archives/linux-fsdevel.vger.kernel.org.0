Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACF1AF470
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDRTyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:54:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56261 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728115AbgDRTyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:54:13 -0400
Received: (qmail 9694 invoked by uid 500); 18 Apr 2020 15:54:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2020 15:54:12 -0400
Date:   Sat, 18 Apr 2020 15:54:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Matthew Wilcox <willy@infradead.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
In-Reply-To: <20200418184409.GP5820@bombadil.infradead.org>
Message-ID: <Pine.LNX.4.44L0.2004181549020.8036-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 18 Apr 2020, Matthew Wilcox wrote:

> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
> > +++ linux-next-20200327/drivers/usb/core/sysfs.c
> > @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
> >  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
> >  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
> >  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
> > -		;	/* We don't actually care if the function fails. */
> > +		do_empty(); /* We don't actually care if the function fails. */
> >  	intf->sysfs_files_created = 1;
> >  }
> 
> Why not just?
> 
> +	if (alt->string)
> +		device_create_file(&intf->dev, &dev_attr_interface);

This is another __must_check function call.

The reason we don't care if the call fails is because the file
being created holds the USB interface string descriptor, something
which is purely informational and hardly ever gets set (and no doubt
gets used even less often).

Is this another situation where the comment should be expanded and the 
code modified to include a useless test and cast-to-void?

Or should device_create_file() not be __must_check after all?

Greg?

Alan Stern

