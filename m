Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1172CBF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE1Q2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1Q17 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:27:59 -0400
Received: from localhost (unknown [8.46.75.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDE72166E;
        Tue, 28 May 2019 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559060877;
        bh=6B2pq+78kXu0WXQynMCezCt7AZSWLg+JakQA6Cpehlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qmkiq6DdRvM7qLor8h/Ld22TsJ9EScRxDowMi/GvB6IcFgxnr7bUvdpYRmOft4RC3
         a7EHCfPmgwbiPnYVmXyvopGZFXFzpWU/L1ifUF8rj6XlIDetMGg1PsRhbtUTpchvUJ
         hJ/cHCrbywdyC/Ga2w3litaHfmAChitJ48EmF/o8=
Date:   Tue, 28 May 2019 18:26:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190528162603.GA24097@kroah.com>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 05:01:55PM +0100, David Howells wrote:
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.

"general" but just for filesystems, right?  :(

> Each entry has a 1-slot header that describes it:
> 
> 	struct watch_notification {
> 		__u32	type:24;
> 		__u32	subtype:8;
> 		__u32	info;
> 	};

This doesn't match the structure definition in the documentation, so
something is out of sync.

> The type indicates the source (eg. mount tree changes, superblock events,
> keyring changes, block layer events) and the subtype indicates the event
> type (eg. mount, unmount; EIO, EDQUOT; link, unlink).  The info field
> indicates a number of things, including the entry length, an ID assigned to
> a watchpoint contributing to this buffer, type-specific flags and meta
> flags, such as an overrun indicator.
> 
> Supplementary data, such as the key ID that generated an event, are
> attached in additional slots.

I'm all for a "generic" event system for the kernel (heck, Solaris has
had one for decades), but it keeps getting shot down every time it comes
up.  What is different about this one?

> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -4,6 +4,19 @@
>  
>  menu "Misc devices"
>  
> +config WATCH_QUEUE
> +	bool "Mappable notification queue"
> +	default n

Nit, not needed.

> +	depends on MMU
> +	help
> +	  This is a general notification queue for the kernel to pass events to
> +	  userspace through a mmap()'able ring buffer.  It can be used in
> +	  conjunction with watches for mount topology change notifications,
> +	  superblock change notifications and key/keyring change notifications.
> +
> +	  Note that in theory this should work fine with NOMMU, but I'm not
> +	  sure how to make that work.
> +
>  config SENSORS_LIS3LV02D
>  	tristate
>  	depends on INPUT
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index b9affcdaa3d6..bf16acd9f8cc 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for misc devices that really don't fit anywhere else.
>  #
>  
> +obj-$(CONFIG_WATCH_QUEUE)	+= watch_queue.o
>  obj-$(CONFIG_IBM_ASM)		+= ibmasm/
>  obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
>  obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
> diff --git a/drivers/misc/watch_queue.c b/drivers/misc/watch_queue.c
> new file mode 100644
> index 000000000000..39a09ea15d97
> --- /dev/null
> +++ b/drivers/misc/watch_queue.c
> @@ -0,0 +1,877 @@
> +/* User-mappable watch queue
> + *
> + * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.

You didn't touch the code this year?

> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.

Please drop the boiler plate text and use a SPDX tag, checkpatch should
have caught this.  I don't want to have to go and change it again.

> + *
> + * See Documentation/watch_queue.rst
> + */
> +
> +#define pr_fmt(fmt) "watchq: " fmt
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/printk.h>
> +#include <linux/miscdevice.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/poll.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +#include <linux/file.h>
> +#include <linux/security.h>
> +#include <linux/cred.h>
> +#include <linux/watch_queue.h>
> +
> +#define DEBUG_WITH_WRITE /* Allow use of write() to record notifications */

debugging code left in?

> +
> +MODULE_DESCRIPTION("Watch queue");
> +MODULE_AUTHOR("Red Hat, Inc.");
> +MODULE_LICENSE("GPL");
> +
> +struct watch_type_filter {
> +	enum watch_notification_type type;
> +	__u32		subtype_filter[1];	/* Bitmask of subtypes to filter on */
> +	__u32		info_filter;		/* Filter on watch_notification::info */
> +	__u32		info_mask;		/* Mask of relevant bits in info_filter */
> +};
> +
> +struct watch_filter {
> +	union {
> +		struct rcu_head	rcu;
> +		unsigned long	type_filter[2];	/* Bitmask of accepted types */
> +	};
> +	u32		nr_filters;		/* Number of filters */
> +	struct watch_type_filter filters[];
> +};
> +
> +struct watch_queue {
> +	struct rcu_head		rcu;
> +	struct address_space	mapping;
> +	const struct cred	*cred;		/* Creds of the owner of the queue */
> +	struct watch_filter __rcu *filter;
> +	wait_queue_head_t	waiters;
> +	struct hlist_head	watches;	/* Contributory watches */
> +	refcount_t		usage;

Usage of what, this structure?  Or something else?

> +	spinlock_t		lock;
> +	bool			defunct;	/* T when queues closed */
> +	u8			nr_pages;	/* Size of pages[] */
> +	u8			flag_next;	/* Flag to apply to next item */
> +#ifdef DEBUG_WITH_WRITE
> +	u8			debug;
> +#endif
> +	u32			size;
> +	struct watch_queue_buffer *buffer;	/* Pointer to first record */
> +
> +	/* The mappable pages.  The zeroth page holds the ring pointers. */
> +	struct page		**pages;
> +};


> +EXPORT_SYMBOL(__post_watch_notification);

_GPL for new apis?  (I have to ask...)

> +static long watch_queue_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct watch_queue *wqueue = file->private_data;
> +	struct inode *inode = file_inode(file);
> +	long ret;
> +
> +	switch (cmd) {
> +	case IOC_WATCH_QUEUE_SET_SIZE:
> +		if (wqueue->buffer)
> +			return -EBUSY;
> +		inode_lock(inode);
> +		ret = watch_queue_set_size(wqueue, arg);
> +		inode_unlock(inode);
> +		return ret;
> +
> +	case IOC_WATCH_QUEUE_SET_FILTER:
> +		inode_lock(inode);
> +		ret = watch_queue_set_filter(
> +			inode, wqueue,
> +			(struct watch_notification_filter __user *)arg);
> +		inode_unlock(inode);
> +		return ret;
> +
> +	default:
> +		return -EOPNOTSUPP;

-ENOTTY is the correct "not a valid ioctl" error value, right?

> +	}
> +}

> +/**
> + * put_watch_queue - Dispose of a ref on a watchqueue.
> + * @wqueue: The watch queue to unref.
> + */
> +void put_watch_queue(struct watch_queue *wqueue)
> +{
> +	if (refcount_dec_and_test(&wqueue->usage))
> +		kfree_rcu(wqueue, rcu);

Why not just use a kref?

> +}
> +EXPORT_SYMBOL(put_watch_queue);


> +int add_watch_to_object(struct watch *watch, struct watch_list *wlist)
> +{
> +	struct watch_queue *wqueue = rcu_access_pointer(watch->queue);
> +	struct watch *w;
> +
> +	hlist_for_each_entry(w, &wlist->watchers, list_node) {
> +		if (watch->id == w->id)
> +			return -EBUSY;
> +	}
> +
> +	rcu_assign_pointer(watch->watch_list, wlist);
> +
> +	spin_lock_bh(&wqueue->lock);
> +	refcount_inc(&wqueue->usage);
> +	hlist_add_head(&watch->queue_node, &wqueue->watches);
> +	spin_unlock_bh(&wqueue->lock);
> +
> +	hlist_add_head(&watch->list_node, &wlist->watchers);
> +	return 0;
> +}
> +EXPORT_SYMBOL(add_watch_to_object);

Naming nit, shouldn't the "prefix" all be the same for these new
functions?

watch_queue_add_object()?  watch_queue_put()?  And so on?

> +static int __init watch_queue_init(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&watch_queue_dev);
> +	if (ret < 0)
> +		pr_err("Failed to register %d\n", ret);
> +	return ret;
> +}
> +fs_initcall(watch_queue_init);
> +
> +static void __exit watch_queue_exit(void)
> +{
> +	misc_deregister(&watch_queue_dev);
> +}
> +module_exit(watch_queue_exit);

module_misc_device()?


> --- /dev/null
> +++ b/include/linux/watch_queue.h
> @@ -0,0 +1,86 @@
> +/* User-mappable watch queue
> + *
> + * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.

Again, SPDX headers please.

> --- /dev/null
> +++ b/include/uapi/linux/watch_queue.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

Yeah!!!

No copyright?  :(

> +#ifndef _UAPI_LINUX_WATCH_QUEUE_H
> +#define _UAPI_LINUX_WATCH_QUEUE_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define IOC_WATCH_QUEUE_SET_SIZE	_IO('s', 0x01)	/* Set the size in pages */
> +#define IOC_WATCH_QUEUE_SET_FILTER	_IO('s', 0x02)	/* Set the filter */
> +
> +enum watch_notification_type {
> +	WATCH_TYPE_META		= 0,	/* Special record */
> +	WATCH_TYPE_MOUNT_NOTIFY	= 1,	/* Mount notification record */
> +	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
> +	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
> +	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
> +#define WATCH_TYPE___NR 5
> +};
> +
> +enum watch_meta_notification_subtype {
> +	WATCH_META_SKIP_NOTIFICATION	= 0,	/* Just skip this record */
> +	WATCH_META_REMOVAL_NOTIFICATION	= 1,	/* Watched object was removed */
> +};
> +
> +/*
> + * Notification record
> + */
> +struct watch_notification {
> +	__u32			type:24;	/* enum watch_notification_type */
> +	__u32			subtype:8;	/* Type-specific subtype (filterable) */
> +	__u32			info;
> +#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
> +#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
> +#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
> +#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */
> +#define WATCH_INFO_IN_SUBTREE	0x00000200	/* Change was not at watched root */
> +#define WATCH_INFO_TYPE_FLAGS	0x00ff0000	/* Type-specific flags */
> +#define WATCH_INFO_FLAG_0	0x00010000
> +#define WATCH_INFO_FLAG_1	0x00020000
> +#define WATCH_INFO_FLAG_2	0x00040000
> +#define WATCH_INFO_FLAG_3	0x00080000
> +#define WATCH_INFO_FLAG_4	0x00100000
> +#define WATCH_INFO_FLAG_5	0x00200000
> +#define WATCH_INFO_FLAG_6	0x00400000
> +#define WATCH_INFO_FLAG_7	0x00800000
> +#define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */
> +};
> +
> +#define WATCH_LENGTH_SHIFT	3
> +
> +struct watch_queue_buffer {
> +	union {
> +		/* The first few entries are special, containing the
> +		 * ring management variables.
> +		 */
> +		struct {
> +			struct watch_notification watch; /* WATCH_TYPE_SKIP */
> +			volatile __u32	head;		/* Ring head index */
> +			volatile __u32	tail;		/* Ring tail index */

A uapi structure that has volatile in it?  Are you _SURE_ this is
correct?

That feels wrong to me...  This is not a backing-hardware register, it's
"just memory" and slapping volatile on it shouldn't be the correct
solution for telling the compiler to not to optimize away reads/flushes,
right?  You need a proper memory access type primitive for that to work
correctly everywhere I thought.

We only have 2 users of volatile in include/uapi, one for WMI structures
that are backed by firmware (seems correct), and one for DRM which I
have no idea how it works as it claims to be a lock.  Why is this new
addition the correct way to do this that no other ring-buffer that was
mmapped has needed to?

thanks,

greg k-h
