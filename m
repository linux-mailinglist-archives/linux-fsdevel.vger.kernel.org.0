Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE02D243
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfE1XMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 19:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1XMT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 19:12:19 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41D120989;
        Tue, 28 May 2019 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559085138;
        bh=pjNLO6HMwgocH5xSjKQLwUlCjFQJob9BKQ9cLgKRqF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9wru9EeqNqxQ55HDbDaFy1X8r1iIQV6cCTiFnwqXnq1MYgDZWuLbJ8T8bH8wnEDf
         hnqb8niEU+eO64TFOy0wj0d9mqg86UsLOf0rL1Jb8SruzFJ0x5BkMQpM6iPgEyASpZ
         figR5E9sjI8OVijQ/jGmWm//lV6T8I+y2m39lP7w=
Date:   Tue, 28 May 2019 16:12:18 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able
 ring buffer
Message-ID: <20190528231218.GA28384@kroah.com>
References: <20190528162603.GA24097@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4031.1559064620@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 06:30:20PM +0100, David Howells wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > Implement a misc device that implements a general notification queue as a
> > > ring buffer that can be mmap()'d from userspace.
> > 
> > "general" but just for filesystems, right?  :(
> 
> Whatever gave you that idea?  You can watch keyrings events, for example -
> they're not exactly filesystems.  I've added the ability to watch for mount
> topology changes and superblock events because those are something I've been
> asked to do.  I've added something for block events because I've recently had
> a problem with trying to recover data from a dodgy disk in that every time the
> disk goes offline, the ddrecover goes "wheeeee!" as it just sees a lot of
> EIO/ENODATA at a great rate of knots because it doesn't know the driver is now
> ignoring the disk.
> 
> I don't know what else people might want to watch, but I've tried to make it
> as generic as possible so as not to exclude it if possible.

Ok, let me try to dig up some older proposals to see if this fits into
the same model to work with them as well.

> > > +	refcount_t		usage;
> > 
> > Usage of what, this structure?  Or something else?
> 
> This is the number of usages of this struct (references to if you prefer).  I
> can add a comment to this effect.

I think you answer this later on with the kref comment :)

> > > +		return -EOPNOTSUPP;
> > 
> > -ENOTTY is the correct "not a valid ioctl" error value, right?
> 
> fs/ioctl.c does both, but I can switch it if it makes you happier.

It does.

> > > +void put_watch_queue(struct watch_queue *wqueue)
> > > +{
> > > +	if (refcount_dec_and_test(&wqueue->usage))
> > > +		kfree_rcu(wqueue, rcu);
> > 
> > Why not just use a kref?
> 
> Why use a kref?  It seems like an effort to be a C++ base class, but without
> the C++ inheritance bit.  Using kref doesn't seem to gain anything.  It's just
> a wrapper around refcount_t - so why not just use a refcount_t?
> 
> kref_put() could potentially add an unnecessary extra stack frame and would
> seem to be best avoided, though an optimising compiler ought to be able to
> inline if it can.

If kref_put() is on your fast path, you have worse problems (kfree isn't
fast, right?)

Anyway, it's an inline function, how can it add an extra stack frame?
Don't try to optimize something that isn't needed yet.

> Are you now on the convert all refcounts to krefs path?

"now"?  Remember, I wrote kref all those years ago, everyone should use
it.  It saves us having to audit the same pattern over and over again.
And, even nicer, it uses a refcount now, and as you are trying to
reference count an object, it is exactly what this was written for.

So yes, I do think it should be used here, unless it is deemed to not
fit the pattern/usage model.

> > > +EXPORT_SYMBOL(add_watch_to_object);
> > 
> > Naming nit, shouldn't the "prefix" all be the same for these new
> > functions?
> > 
> > watch_queue_add_object()?  watch_queue_put()?  And so on?
> 
> Naming is fun.  watch_queue_add_object - that suggests something different to
> what the function actually does.  I'll think about adjusting the names.

Ok, just had to say something.  It's your call, and yes, naming is hard.

> > > +module_exit(watch_queue_exit);
> > 
> > module_misc_device()?
> 
> 	warthog>git grep module_misc_device -- Documentation/
> 	warthog1>

Do I have to document all helper macros?  Anyway, it saves you
boilerplate code, but if built in, it's at the module init level, not
the fs init level, like you are asking for here.  So that might not
work, it's your call.

> > > +		struct {
> > > +			struct watch_notification watch; /* WATCH_TYPE_SKIP */
> > > +			volatile __u32	head;		/* Ring head index */
> > > +			volatile __u32	tail;		/* Ring tail index */
> > 
> > A uapi structure that has volatile in it?  Are you _SURE_ this is
> > correct?
> > 
> > That feels wrong to me...  This is not a backing-hardware register, it's
> > "just memory" and slapping volatile on it shouldn't be the correct
> > solution for telling the compiler to not to optimize away reads/flushes,
> > right?  You need a proper memory access type primitive for that to work
> > correctly everywhere I thought.
> > 
> > We only have 2 users of volatile in include/uapi, one for WMI structures
> > that are backed by firmware (seems correct), and one for DRM which I
> > have no idea how it works as it claims to be a lock.  Why is this new
> > addition the correct way to do this that no other ring-buffer that was
> > mmapped has needed to?
> 
> Yeah, I understand your concern with this.
> 
> The reason I put the volatiles in is that the kernel may be modifying the head
> pointer on one CPU simultaneously with userspace modifying the tail pointer on
> another CPU.
> 
> Note that userspace does not need to enter the kernel to find out if there's
> anything in the buffer or to read stuff out of the buffer.  Userspace only
> needs to enter the kernel, using poll() or similar, to wait for something to
> appear in the buffer.

And how does the tracing and perf ring buffers do this without needing
volatile?  Why not use the same type of interface they provide, as it's
always good to share code that has already had all of the nasty corner
cases worked out.

Anyway, I don't want you to think I don't like this code/idea overall, I
do.  I just want to see it be something that everyone can use, and use
easily, as it has been something lots of people have been asking for for
a long time.

thanks,

greg k-h
