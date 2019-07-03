Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0255EC42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCTIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 15:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCTIu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:08:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34097218A0;
        Wed,  3 Jul 2019 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562180928;
        bh=HoXkaVqeIwrvWqdQqRzUqS/2kqEcLJsak8sUVTa70Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCGRdqfrO1yKOvMzmAzI4FSJ11JFFdrT8uAKg+aygBP5h5IfEI6mCyBes+A3df9OC
         Ie4OwB9l5sIwKRko882CHgAkuHxlAwo7FQ0azM7j+nkURsbAu2Rj2Ldo80uVacZ9Ll
         swNUriKPHqt6e9DGUl5mf0/CKOg3sWOFNDJaxhoM=
Date:   Wed, 3 Jul 2019 21:08:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] Add a general, global device notification watch list
 [ver #5]
Message-ID: <20190703190846.GA15663@kroah.com>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156173697086.15137.9549379251509621554.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:30PM +0100, David Howells wrote:
> Create a general, global watch list that can be used for the posting of
> device notification events, for such things as device attachment,
> detachment and errors on sources such as block devices and USB devices.
> This can be enabled with:
> 
> 	CONFIG_DEVICE_NOTIFICATIONS
> 
> To add a watch on this list, an event queue must be created and configured:
> 
>         fd = open("/dev/event_queue", O_RDWR);
>         ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);
> 
> and then a watch can be placed upon it using a system call:
> 
>         watch_devices(fd, 12, 0);
> 
> Unless the application wants to receive all events, it should employ
> appropriate filters.

Ok, as discussed off-list, this is needed by the other patches
afterward, i.e. the USB and block ones, which makes more sense.

Some tiny nits:

> diff --git a/drivers/base/watch.c b/drivers/base/watch.c
> new file mode 100644
> index 000000000000..00336607dc73
> --- /dev/null
> +++ b/drivers/base/watch.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Event notifications.
> + *
> + * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/watch_queue.h>
> +#include <linux/syscalls.h>
> +#include <linux/init_task.h>
> +#include <linux/security.h>

You forgot to include device.h which has the prototype for your global
function :)

> +
> +/*
> + * Global queue for watching for device layer events.
> + */
> +static struct watch_list device_watchers = {
> +	.watchers	= HLIST_HEAD_INIT,
> +	.lock		= __SPIN_LOCK_UNLOCKED(&device_watchers.lock),
> +};
> +
> +static DEFINE_SPINLOCK(device_watchers_lock);
> +
> +/**
> + * post_device_notification - Post notification of a device event
> + * @n - The notification to post
> + * @id - The device ID
> + *
> + * Note that there's only a global queue to which all events are posted.  Might
> + * want to provide per-dev queues also.
> + */
> +void post_device_notification(struct watch_notification *n, u64 id)
> +{
> +	post_watch_notification(&device_watchers, n, &init_cred, id);
> +}

Don't you need to export this symbol?

> +
> +/**
> + * sys_watch_devices - Watch for device events.
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + * @flags: Flags (reserved for future)
> + */
> +SYSCALL_DEFINE3(watch_devices, int, watch_fd, int, watch_id, unsigned int, flags)

Finally, the driver core gets a syscall!  :)

Don't we need a manpage and a kselftest for it?

> +{
> +	struct watch_queue *wqueue;
> +	struct watch_list *wlist = &device_watchers;

No real need for wlist, right?  You just set it to this value and then
it never changes?

> +	struct watch *watch;
> +	long ret = -ENOMEM;
> +	u64 id = 0; /* Might want to allow dev# here. */

I don't understand the comment here, what does "dev#" refer to?

> +
> +	if (watch_id < -1 || watch_id > 0xff || flags)
> +		return -EINVAL;
> +
> +	wqueue = get_watch_queue(watch_fd);
> +	if (IS_ERR(wqueue)) {
> +		ret = PTR_ERR(wqueue);
> +		goto err;
> +	}
> +
> +	if (watch_id >= 0) {
> +		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +		if (!watch)
> +			goto err_wqueue;
> +
> +		init_watch(watch, wqueue);
> +		watch->id	= id;
> +		watch->info_id	= (u32)watch_id << WATCH_INFO_ID__SHIFT;
> +
> +		ret = security_watch_devices(watch);
> +		if (ret < 0)
> +			goto err_watch;
> +
> +		spin_lock(&device_watchers_lock);
> +		ret = add_watch_to_object(watch, wlist);
> +		spin_unlock(&device_watchers_lock);
> +		if (ret == 0)
> +			watch = NULL;
> +	} else {
> +		spin_lock(&device_watchers_lock);
> +		ret = remove_watch_from_object(wlist, wqueue, id, false);
> +		spin_unlock(&device_watchers_lock);
> +	}
> +
> +err_watch:
> +	kfree(watch);
> +err_wqueue:
> +	put_watch_queue(wqueue);
> +err:
> +	return ret;
> +}
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e85264fb6616..c947c078b1be 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -26,6 +26,7 @@
>  #include <linux/uidgid.h>
>  #include <linux/gfp.h>
>  #include <linux/overflow.h>
> +#include <linux/watch_queue.h>

No need for this, just do:

struct watch_notification;

so that things build.

thanks,

greg k-h
