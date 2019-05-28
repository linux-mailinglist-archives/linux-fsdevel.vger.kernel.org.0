Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8552CD9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfE1RaZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 13:30:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9937 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE1RaY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 13:30:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFB9D99CFE;
        Tue, 28 May 2019 17:30:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01BBC60BDF;
        Tue, 28 May 2019 17:30:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190528162603.GA24097@kroah.com>
References: <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4030.1559064620.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 28 May 2019 18:30:20 +0100
Message-ID: <4031.1559064620@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 28 May 2019 17:30:24 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> wrote:

> > Implement a misc device that implements a general notification queue as a
> > ring buffer that can be mmap()'d from userspace.
> 
> "general" but just for filesystems, right?  :(

Whatever gave you that idea?  You can watch keyrings events, for example -
they're not exactly filesystems.  I've added the ability to watch for mount
topology changes and superblock events because those are something I've been
asked to do.  I've added something for block events because I've recently had
a problem with trying to recover data from a dodgy disk in that every time the
disk goes offline, the ddrecover goes "wheeeee!" as it just sees a lot of
EIO/ENODATA at a great rate of knots because it doesn't know the driver is now
ignoring the disk.

I don't know what else people might want to watch, but I've tried to make it
as generic as possible so as not to exclude it if possible.

> This doesn't match the structure definition in the documentation, so
> something is out of sync.

Ah, yes - I need to update that doc, thanks.

> I'm all for a "generic" event system for the kernel (heck, Solaris has
> had one for decades), but it keeps getting shot down every time it comes
> up.  What is different about this one?

Without studying all the other ones, I can't say - however, I need to add
something for keyrings and I would prefer to make something generic.

> > +#define DEBUG_WITH_WRITE /* Allow use of write() to record notifications */
> 
> debugging code left in?

I'll switch it to #undef.  I want to leave the code in there for testing
purposes.  Possibly I should make it a Kconfig option.

> > +	refcount_t		usage;
> 
> Usage of what, this structure?  Or something else?

This is the number of usages of this struct (references to if you prefer).  I
can add a comment to this effect.

> > +EXPORT_SYMBOL(__post_watch_notification);
> 
> _GPL for new apis?  (I have to ask...)

No.

> > +		return -EOPNOTSUPP;
> 
> -ENOTTY is the correct "not a valid ioctl" error value, right?

fs/ioctl.c does both, but I can switch it if it makes you happier.

> > +void put_watch_queue(struct watch_queue *wqueue)
> > +{
> > +	if (refcount_dec_and_test(&wqueue->usage))
> > +		kfree_rcu(wqueue, rcu);
> 
> Why not just use a kref?

Why use a kref?  It seems like an effort to be a C++ base class, but without
the C++ inheritance bit.  Using kref doesn't seem to gain anything.  It's just
a wrapper around refcount_t - so why not just use a refcount_t?

kref_put() could potentially add an unnecessary extra stack frame and would
seem to be best avoided, though an optimising compiler ought to be able to
inline if it can.

Are you now on the convert all refcounts to krefs path?

> > +EXPORT_SYMBOL(add_watch_to_object);
> 
> Naming nit, shouldn't the "prefix" all be the same for these new
> functions?
> 
> watch_queue_add_object()?  watch_queue_put()?  And so on?

Naming is fun.  watch_queue_add_object - that suggests something different to
what the function actually does.  I'll think about adjusting the names.

> > +module_exit(watch_queue_exit);
> 
> module_misc_device()?

	warthog>git grep module_misc_device -- Documentation/
	warthog1>

> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> Yeah!!!

Blech.

> > +		struct {
> > +			struct watch_notification watch; /* WATCH_TYPE_SKIP */
> > +			volatile __u32	head;		/* Ring head index */
> > +			volatile __u32	tail;		/* Ring tail index */
> 
> A uapi structure that has volatile in it?  Are you _SURE_ this is
> correct?
> 
> That feels wrong to me...  This is not a backing-hardware register, it's
> "just memory" and slapping volatile on it shouldn't be the correct
> solution for telling the compiler to not to optimize away reads/flushes,
> right?  You need a proper memory access type primitive for that to work
> correctly everywhere I thought.
> 
> We only have 2 users of volatile in include/uapi, one for WMI structures
> that are backed by firmware (seems correct), and one for DRM which I
> have no idea how it works as it claims to be a lock.  Why is this new
> addition the correct way to do this that no other ring-buffer that was
> mmapped has needed to?

Yeah, I understand your concern with this.

The reason I put the volatiles in is that the kernel may be modifying the head
pointer on one CPU simultaneously with userspace modifying the tail pointer on
another CPU.

Note that userspace does not need to enter the kernel to find out if there's
anything in the buffer or to read stuff out of the buffer.  Userspace only
needs to enter the kernel, using poll() or similar, to wait for something to
appear in the buffer.

David
