Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5D5EA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGCRL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 13:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCRL7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:11:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5575A2187F;
        Wed,  3 Jul 2019 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562173917;
        bh=436WDhYAGRaHC7DhWZalpPfSr0ODNk1419c0VWx8viE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LW8bdLtCYoDfg6i3v8/Zb0LcmNqE8rpNUBgIps/4onsP5WYZ8jFkGmxdI9HoGhFV/
         0d/AgJ6q/XRAimimUZT/3XK7cS2LB9i7IFiLCpLtrxyTMU6j5c6r0990l9bYQUWtk5
         gCSth1cwabsT5F31+PUYCFKvhk3LouU7MR1EZeZw=
Date:   Wed, 3 Jul 2019 19:11:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        raven@themaw.net, Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] General notification queue with user mmap()'able
 ring buffer [ver #5]
Message-ID: <20190703171155.GC24672@kroah.com>
References: <156173690158.15137.3985163001079120218.stgit@warthog.procyon.org.uk>
 <156173695061.15137.17196611619288074120.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156173695061.15137.17196611619288074120.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:10PM +0100, David Howells wrote:
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.
> 
> The way this is done is:
> 
>  (1) An application opens the device and indicates the size of the ring
>      buffer that it wants to reserve in pages (this can only be set once):
> 
> 	fd = open("/dev/watch_queue", O_RDWR);
> 	ioctl(fd, IOC_WATCH_QUEUE_NR_PAGES, nr_of_pages);
> 
>  (2) The application should then map the pages that the device has
>      reserved.  Each instance of the device created by open() allocates
>      separate pages so that maps of different fds don't interfere with one
>      another.  Multiple mmap() calls on the same fd, however, will all work
>      together.
> 
> 	page_size = sysconf(_SC_PAGESIZE);
> 	mapping_size = nr_of_pages * page_size;
> 	char *buf = mmap(NULL, mapping_size, PROT_READ|PROT_WRITE,
> 			 MAP_SHARED, fd, 0);
> 
> The ring is divided into 8-byte slots.  Entries written into the ring are
> variable size and can use between 1 and 63 slots.  A special entry is
> maintained in the first two slots of the ring that contains the head and
> tail pointers.  This is skipped when the ring wraps round.  Note that
> multislot entries, therefore, aren't allowed to be broken over the end of
> the ring, but instead "skip" entries are inserted to pad out the buffer.
> 
> Each entry has a 1-slot header that describes it:
> 
> 	struct watch_notification {
> 		__u32	type:24;
> 		__u32	subtype:8;
> 		__u32	info;
> 	};
> 
> The type indicates the source (eg. mount tree changes, superblock events,
> keyring changes, block layer events) and the subtype indicates the event
> type (eg. mount, unmount; EIO, EDQUOT; link, unlink).  The info field
> indicates a number of things, including the entry length, an ID assigned to
> a watchpoint contributing to this buffer, type-specific flags and meta
> flags, such as an overrun indicator.
> 
> Supplementary data, such as the key ID that generated an event, are
> attached in additional slots.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I don't know if I mentioned this before, but your naming seems a bit
"backwards" from other subsystems. Should "watch_queue" always be the
prefix, instead of a mix of prefix/suffix usage?

Anyway, your call, it's your code :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
