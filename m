Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7242D196
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfE1W2i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 18:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfE1W2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 18:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54E98307D925;
        Tue, 28 May 2019 22:28:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FCBD100203C;
        Tue, 28 May 2019 22:28:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAG48ez3L5KzKyKMxUTaaB=r1E1ZXh=m6e9+CwYcXfRnUSjDvWA@mail.gmail.com>
References: <CAG48ez3L5KzKyKMxUTaaB=r1E1ZXh=m6e9+CwYcXfRnUSjDvWA@mail.gmail.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk> <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11465.1559082515.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 28 May 2019 23:28:35 +0100
Message-ID: <11466.1559082515@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 28 May 2019 22:28:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> wrote:

> I don't see you setting any special properties on the VMA that would
> prevent userspace from extending its size via mremap() - no
> VM_DONTEXPAND or VM_PFNMAP. So I think you might get an out-of-bounds
> access here?

Should I just set VM_DONTEXPAND in watch_queue_mmap()?  Like so:

	vma->vm_flags |= VM_DONTEXPAND;

> > +static void watch_queue_map_pages(struct vm_fault *vmf,
> > +                                 pgoff_t start_pgoff, pgoff_t end_pgoff)
> ...
> 
> Same as above.

Same solution as above?  Or do I need ot check start/end_pgoff too?

> > +static int watch_queue_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +       struct watch_queue *wqueue = file->private_data;
> > +
> > +       if (vma->vm_pgoff != 0 ||
> > +           vma->vm_end - vma->vm_start > wqueue->nr_pages * PAGE_SIZE ||
> > +           !(pgprot_val(vma->vm_page_prot) & pgprot_val(PAGE_SHARED)))
> > +               return -EINVAL;
> 
> This thing should probably have locking against concurrent
> watch_queue_set_size()?

Yeah.

	static int watch_queue_mmap(struct file *file,
				    struct vm_area_struct *vma)
	{
		struct watch_queue *wqueue = file->private_data;
		struct inode *inode = file_inode(file);
		u8 nr_pages;

		inode_lock(inode);
		nr_pages = wqueue->nr_pages;
		inode_unlock(inode);

		if (nr_pages == 0 ||
		...
			return -EINVAL;

> > +       smp_store_release(&buf->meta.head, len);
> 
> Why is this an smp_store_release()? The entire buffer should not be visible to
> userspace before this setup is complete, right?

Yes - if I put the above locking in the mmap handler.  OTOH, it's a one-off
barrier...

> > +               if (wqueue->buffer)
> > +                       return -EBUSY;
> 
> The preceding check occurs without any locks held and therefore has no
> reliable effect. It should probably be moved below the
> inode_lock(...).

Yeah, it can race.  I'll move it into watch_queue_set_size().

> > +static void free_watch(struct rcu_head *rcu)
> > +{
> > +       struct watch *watch = container_of(rcu, struct watch, rcu);
> > +
> > +       put_watch_queue(rcu_access_pointer(watch->queue));
> 
> This should be rcu_dereference_protected(..., 1).

That shouldn't be necessary.  rcu_access_pointer()'s description says:

 * It is also permissible to use rcu_access_pointer() when read-side
 * access to the pointer was removed at least one grace period ago, as
 * is the case in the context of the RCU callback that is freeing up
 * the data, ...

It's in an rcu callback function, so accessing the __rcu pointers in the RCU'd
struct should be fine with rcu_access_pointer().

> > +       /* We don't need the watch list lock for the next bit as RCU is
> > +        * protecting everything from being deallocated.
> 
> Does "everything" mean "the wqueue" or more than that?

Actually, just 'wqueue' and its buffer.  'watch' is held by us once we've
dequeued it as we now own the ref 'wlist' had on it.  'wlist' and 'wq' must be
pinned by the caller.

> > +                       if (release) {
> > +                               if (wlist->release_watch) {
> > +                                       rcu_read_unlock();
> > +                                       /* This might need to call dput(), so
> > +                                        * we have to drop all the locks.
> > +                                        */
> > +                                       wlist->release_watch(wlist, watch);
> 
> How are you holding a reference to `wlist` here? You got the reference through
> rcu_dereference(), you've dropped the RCU read lock, and I don't see anything
> that stabilizes the reference.

The watch record must hold a ref on the watched object if the watch_list has a
->release_watch() method.  In the code snippet above, the watch record now
belongs to us because we unlinked it under the wlist->lock some lines prior.

However, you raise a good point, and I think the thing to do is to cache
->release_watch from it and not pass wlist into (*release_watch)().  We don't
need to concern ourselves with cleaning up *wlist as it will be cleaned up
when the target object is removed.

Keyrings don't have a ->release_watch method and neither does the block-layer
notification stuff.

> > +       if (wqueue->pages && wqueue->pages[0])
> > +               WARN_ON(page_ref_count(wqueue->pages[0]) != 1);
> 
> Is there a reason why there couldn't still be references to the pages
> from get_user_pages()/get_user_pages_fast()?

I'm not sure.  I'm not sure what to do if there are.  What do you suggest?

> > +       n->info &= (WATCH_INFO_LENGTH | WATCH_INFO_TYPE_FLAGS | WATCH_INFO_ID);
> 
> Should the non-atomic modification of n->info

n's an unpublished copy of some userspace data that's local to the function
instance.  There shouldn't be any way to race with it at this point.

> (and perhaps also the
> following uses of ->debug) be protected by some lock?
> 
> > +       if (post_one_notification(wqueue, n, file->f_cred))
> > +               wqueue->debug = 0;
> > +       else
> > +               wqueue->debug++;
> > +       ret = len;
> > +       if (wqueue->debug > 20)
> > +               ret = -EIO;

It's for debugging purposes, so the non-atomiticity doesn't matter.  I'll
#undef the symbol to disable the code.

> > +#define IOC_WATCH_QUEUE_SET_SIZE       _IO('s', 0x01)  /* Set the size in pages */
> > +#define IOC_WATCH_QUEUE_SET_FILTER     _IO('s', 0x02)  /* Set the filter */
> 
> Should these ioctl numbers be registered in
> Documentation/ioctl/ioctl-number.txt?

Quite possibly.  I'm not sure where's best to actually allocate it.  I picked
's' out of the air.

David
