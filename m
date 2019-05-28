Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A722CF4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfE1TPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 15:15:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39185 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfE1TPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 15:15:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id v2so15186316oie.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdE1JOyTYhysukiuCnGUGYuuaD5ETKfTBYPUcMycJEM=;
        b=RsZvKg2Bk/aNdZqNrNoMb1SH0F+eGIIjX61s7QIrzq8sujmgLx305XGW1Uc30bnVbV
         URwNVqDVFfw4O60nWxWylhalQkIQYaCcXlH9Ht6/sNkKG8dwjW7BR5q3aarbKPEBf9T/
         2Glj8K+Fut8RAWEbVyP5Kh1JveV4PXYgZH5G/F0ZZNEamkQytWoicg+Ez0/tfiKpBBu0
         w6U5VfIjFIjOEho4K/uEktiYgYqwB8eA+XP40xh5wIgo9/MUBxRp9NQ4CZkIZDNTS+jU
         yCb56lny234SSQh388nJoyuNAMeO/EpiXLJoz4vV3A4bLW11J2ZoATycSh6gDa2a2oHa
         Ljlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdE1JOyTYhysukiuCnGUGYuuaD5ETKfTBYPUcMycJEM=;
        b=VLE44uVqnwVZu2Xkd8f69uxoi78UH6az1Pp1TqBZ5pihzCrgy3e58WaIpCLfDdmOLu
         AI5gGzecnfpEJeutD3zIB2n3eWzcxo06d7IhDcHq+DFG4YKg9am1wHGJ3OolJbwrDyRz
         3LKNjLx/arvuZJnjlgmc3sw+yWRmv1tgFNw/8b+4oYmYve0egh/S43sP+vcAx9opr857
         l7SmegY+GtPJxo3ahVLgbmvTNE91bwe8+NRNxjK4oUEOkcK+wzxKMZ6ceRdONW51WDf0
         v6J1GC+an6g4xWrA6pp386TOxwYS89oCtez7dY9eM7FaYoXp2S39gxyb9UiYb00FT5xA
         /haA==
X-Gm-Message-State: APjAAAXSPtChJ1lE5ycUo3CdXLmz5FGOGUAmu+nfpevCkbS/0AYQhQom
        utGWVwLD9PAz5SCoVAPHd7R+CLBInlfzW8wnHL5GfMPh2sQ=
X-Google-Smtp-Source: APXvYqwnQQq7IwEatqn8HvjLe9SnaXObPKJJAqI6T69lY2rEByHcuA8nGa7Pp75ILwuyWTZvAujAFBpbGEvbnIBS1EA=
X-Received: by 2002:aca:5943:: with SMTP id n64mr3803813oib.175.1559070918274;
 Tue, 28 May 2019 12:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 May 2019 21:14:51 +0200
Message-ID: <CAG48ez3L5KzKyKMxUTaaB=r1E1ZXh=m6e9+CwYcXfRnUSjDvWA@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 6:03 PM David Howells <dhowells@redhat.com> wrote:
> Implement a misc device that implements a general notification queue as a
> ring buffer that can be mmap()'d from userspace.
[...]
> +receive notifications from the kernel.  This is can be used in conjunction

typo: s/is can/can/

[...]
> +Overview
> +========
> +
> +This facility appears as a misc device file that is opened and then mapped and
> +polled.  Each time it is opened, it creates a new buffer specific to the
> +returned file descriptor.  Then, when the opening process sets watches, it
> +indicates that particular buffer it wants notifications from that watch to be
> +written into. Note that there are no read() and write() methods (except for

s/that particular buffer/the particular buffer/

> +debugging).  The user is expected to access the ring directly and to use poll
> +to wait for new data.
[...]
> +/**
> + * __post_watch_notification - Post an event notification
> + * @wlist: The watch list to post the event to.
> + * @n: The notification record to post.
> + * @cred: The creds of the process that triggered the notification.
> + * @id: The ID to match on the watch.
> + *
> + * Post a notification of an event into a set of watch queues and let the users
> + * know.
> + *
> + * If @n is NULL then WATCH_INFO_LENGTH will be set on the next event posted.
> + *
> + * The size of the notification should be set in n->info & WATCH_INFO_LENGTH and
> + * should be in units of sizeof(*n).
> + */
> +void __post_watch_notification(struct watch_list *wlist,
> +                              struct watch_notification *n,
> +                              const struct cred *cred,
> +                              u64 id)
> +{
> +       const struct watch_filter *wf;
> +       struct watch_queue *wqueue;
> +       struct watch *watch;
> +
> +       rcu_read_lock();
> +
> +       hlist_for_each_entry_rcu(watch, &wlist->watchers, list_node) {
> +               if (watch->id != id)
> +                       continue;
> +               n->info &= ~(WATCH_INFO_ID | WATCH_INFO_OVERRUN);
> +               n->info |= watch->info_id;
> +
> +               wqueue = rcu_dereference(watch->queue);
> +               wf = rcu_dereference(wqueue->filter);
> +               if (wf && !filter_watch_notification(wf, n))
> +                       continue;
> +
> +               post_one_notification(wqueue, n, cred);
> +       }
> +
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(__post_watch_notification);
[...]
> +static vm_fault_t watch_queue_fault(struct vm_fault *vmf)
> +{
> +       struct watch_queue *wqueue = vmf->vma->vm_file->private_data;
> +       struct page *page;
> +
> +       page = wqueue->pages[vmf->pgoff];

I don't see you setting any special properties on the VMA that would
prevent userspace from extending its size via mremap() - no
VM_DONTEXPAND or VM_PFNMAP. So I think you might get an out-of-bounds
access here?

> +       get_page(page);
> +       if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> +               put_page(page);
> +               return VM_FAULT_RETRY;
> +       }
> +       vmf->page = page;
> +       return VM_FAULT_LOCKED;
> +}
> +
> +static void watch_queue_map_pages(struct vm_fault *vmf,
> +                                 pgoff_t start_pgoff, pgoff_t end_pgoff)
> +{
> +       struct watch_queue *wqueue = vmf->vma->vm_file->private_data;
> +       struct page *page;
> +
> +       rcu_read_lock();
> +
> +       do {
> +               page = wqueue->pages[start_pgoff];

Same as above.

> +               if (trylock_page(page)) {
> +                       vm_fault_t ret;
> +                       get_page(page);
> +                       ret = alloc_set_pte(vmf, NULL, page);
> +                       if (ret != 0)
> +                               put_page(page);
> +
> +                       unlock_page(page);
> +               }
> +       } while (++start_pgoff < end_pgoff);
> +
> +       rcu_read_unlock();
> +}
[...]
> +static int watch_queue_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       struct watch_queue *wqueue = file->private_data;
> +
> +       if (vma->vm_pgoff != 0 ||
> +           vma->vm_end - vma->vm_start > wqueue->nr_pages * PAGE_SIZE ||
> +           !(pgprot_val(vma->vm_page_prot) & pgprot_val(PAGE_SHARED)))
> +               return -EINVAL;

This thing should probably have locking against concurrent
watch_queue_set_size()?

> +       vma->vm_ops = &watch_queue_vm_ops;
> +
> +       vma_interval_tree_insert(vma, &wqueue->mapping.i_mmap);
> +       return 0;
> +}
> +
> +/*
> + * Allocate the required number of pages.
> + */
> +static long watch_queue_set_size(struct watch_queue *wqueue, unsigned long nr_pages)
> +{
> +       struct watch_queue_buffer *buf;
> +       u32 len;
> +       int i;
> +
> +       if (nr_pages == 0 ||
> +           nr_pages > 16 || /* TODO: choose a better hard limit */
> +           !is_power_of_2(nr_pages))
> +               return -EINVAL;
> +
> +       wqueue->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
> +       if (!wqueue->pages)
> +               goto err;
> +
> +       for (i = 0; i < nr_pages; i++) {
> +               wqueue->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +               if (!wqueue->pages[i])
> +                       goto err_some_pages;
> +               wqueue->pages[i]->mapping = &wqueue->mapping;
> +               SetPageUptodate(wqueue->pages[i]);
> +       }
> +
> +       buf = vmap(wqueue->pages, nr_pages, VM_MAP, PAGE_SHARED);
> +       if (!buf)
> +               goto err_some_pages;
> +
> +       wqueue->buffer = buf;
> +       wqueue->nr_pages = nr_pages;
> +       wqueue->size = ((nr_pages * PAGE_SIZE) / sizeof(struct watch_notification));
> +
> +       /* The first four slots in the buffer contain metadata about the ring,
> +        * including the head and tail indices and mask.
> +        */
> +       len = sizeof(buf->meta) / sizeof(buf->slots[0]);
> +       buf->meta.watch.info    = len << WATCH_LENGTH_SHIFT;
> +       buf->meta.watch.type    = WATCH_TYPE_META;
> +       buf->meta.watch.subtype = WATCH_META_SKIP_NOTIFICATION;
> +       buf->meta.tail          = len;
> +       buf->meta.mask          = wqueue->size - 1;
> +       smp_store_release(&buf->meta.head, len);

Why is this an smp_store_release()? The entire buffer should not be visible to
userspace before this setup is complete, right?

> +       return 0;
> +
> +err_some_pages:
> +       for (i--; i >= 0; i--) {
> +               ClearPageUptodate(wqueue->pages[i]);
> +               wqueue->pages[i]->mapping = NULL;
> +               put_page(wqueue->pages[i]);
> +       }
> +
> +       kfree(wqueue->pages);
> +       wqueue->pages = NULL;
> +err:
> +       return -ENOMEM;
> +}
[...]
> +
> +/*
> + * Set parameters.
> + */
> +static long watch_queue_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct watch_queue *wqueue = file->private_data;
> +       struct inode *inode = file_inode(file);
> +       long ret;
> +
> +       switch (cmd) {
> +       case IOC_WATCH_QUEUE_SET_SIZE:
> +               if (wqueue->buffer)
> +                       return -EBUSY;

The preceding check occurs without any locks held and therefore has no
reliable effect. It should probably be moved below the
inode_lock(...).

> +               inode_lock(inode);
> +               ret = watch_queue_set_size(wqueue, arg);
> +               inode_unlock(inode);
> +               return ret;
> +
> +       case IOC_WATCH_QUEUE_SET_FILTER:
> +               inode_lock(inode);
> +               ret = watch_queue_set_filter(
> +                       inode, wqueue,
> +                       (struct watch_notification_filter __user *)arg);
> +               inode_unlock(inode);
> +               return ret;
> +
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
[...]
> +static void free_watch(struct rcu_head *rcu)
> +{
> +       struct watch *watch = container_of(rcu, struct watch, rcu);
> +
> +       put_watch_queue(rcu_access_pointer(watch->queue));

This should be rcu_dereference_protected(..., 1).

> +/**
> + * remove_watch_from_object - Remove a watch or all watches from an object.
> + * @wlist: The watch list to remove from
> + * @wq: The watch queue of interest (ignored if @all is true)
> + * @id: The ID of the watch to remove (ignored if @all is true)
> + * @all: True to remove all objects
> + *
> + * Remove a specific watch or all watches from an object.  A notification is
> + * sent to the watcher to tell them that this happened.
> + */
> +int remove_watch_from_object(struct watch_list *wlist, struct watch_queue *wq,
> +                            u64 id, bool all)
> +{
> +       struct watch_notification n;
> +       struct watch_queue *wqueue;
> +       struct watch *watch;
> +       int ret = -EBADSLT;
> +
> +       rcu_read_lock();
> +
> +again:
> +       spin_lock(&wlist->lock);
> +       hlist_for_each_entry(watch, &wlist->watchers, list_node) {
> +               if (all ||
> +                   (watch->id == id && rcu_access_pointer(watch->queue) == wq))
> +                       goto found;
> +       }
> +       spin_unlock(&wlist->lock);
> +       goto out;
> +
> +found:
> +       ret = 0;
> +       hlist_del_init_rcu(&watch->list_node);
> +       rcu_assign_pointer(watch->watch_list, NULL);
> +       spin_unlock(&wlist->lock);
> +
> +       n.type = WATCH_TYPE_META;
> +       n.subtype = WATCH_META_REMOVAL_NOTIFICATION;
> +       n.info = watch->info_id | sizeof(n);
> +
> +       wqueue = rcu_dereference(watch->queue);
> +       post_one_notification(wqueue, &n, wq ? wq->cred : NULL);
> +
> +       /* We don't need the watch list lock for the next bit as RCU is
> +        * protecting everything from being deallocated.

Does "everything" mean "the wqueue" or more than that?

> +        */
> +       if (wqueue) {
> +               spin_lock_bh(&wqueue->lock);
> +
> +               if (!hlist_unhashed(&watch->queue_node)) {
> +                       hlist_del_init_rcu(&watch->queue_node);
> +                       put_watch(watch);
> +               }
> +
> +               spin_unlock_bh(&wqueue->lock);
> +       }
> +
> +       if (wlist->release_watch) {
> +               rcu_read_unlock();
> +               wlist->release_watch(wlist, watch);
> +               rcu_read_lock();
> +       }
> +       put_watch(watch);
> +
> +       if (all && !hlist_empty(&wlist->watchers))
> +               goto again;
> +out:
> +       rcu_read_unlock();
> +       return ret;
> +}
> +EXPORT_SYMBOL(remove_watch_from_object);
> +
> +/*
> + * Remove all the watches that are contributory to a queue.  This will
> + * potentially race with removal of the watches by the destruction of the
> + * objects being watched or the distribution of notifications.
> + */
> +static void watch_queue_clear(struct watch_queue *wqueue)
> +{
> +       struct watch_list *wlist;
> +       struct watch *watch;
> +       bool release;
> +
> +       rcu_read_lock();
> +       spin_lock_bh(&wqueue->lock);
> +
> +       /* Prevent new additions and prevent notifications from happening */
> +       wqueue->defunct = true;
> +
> +       while (!hlist_empty(&wqueue->watches)) {
> +               watch = hlist_entry(wqueue->watches.first, struct watch, queue_node);
> +               hlist_del_init_rcu(&watch->queue_node);
> +               spin_unlock_bh(&wqueue->lock);
> +
> +               /* We can't do the next bit under the queue lock as we need to
> +                * get the list lock - which would cause a deadlock if someone
> +                * was removing from the opposite direction at the same time or
> +                * posting a notification.
> +                */
> +               wlist = rcu_dereference(watch->watch_list);
> +               if (wlist) {
> +                       spin_lock(&wlist->lock);
> +
> +                       release = !hlist_unhashed(&watch->list_node);
> +                       if (release) {
> +                               hlist_del_init_rcu(&watch->list_node);
> +                               rcu_assign_pointer(watch->watch_list, NULL);
> +                       }
> +
> +                       spin_unlock(&wlist->lock);
> +
> +                       if (release) {
> +                               if (wlist->release_watch) {
> +                                       rcu_read_unlock();
> +                                       /* This might need to call dput(), so
> +                                        * we have to drop all the locks.
> +                                        */
> +                                       wlist->release_watch(wlist, watch);

How are you holding a reference to `wlist` here? You got the reference through
rcu_dereference(), you've dropped the RCU read lock, and I don't see anything
that stabilizes the reference.

> +                                       rcu_read_lock();
> +                               }
> +                               put_watch(watch);
> +                       }
> +               }
> +
> +               put_watch(watch);
> +               spin_lock_bh(&wqueue->lock);
> +       }
> +
> +       spin_unlock_bh(&wqueue->lock);
> +       rcu_read_unlock();
> +}
> +
> +/*
> + * Release the file.
> + */
> +static int watch_queue_release(struct inode *inode, struct file *file)
> +{
> +       struct watch_filter *wfilter;
> +       struct watch_queue *wqueue = file->private_data;
> +       int i, pgref;
> +
> +       watch_queue_clear(wqueue);
> +
> +       if (wqueue->pages && wqueue->pages[0])
> +               WARN_ON(page_ref_count(wqueue->pages[0]) != 1);

Is there a reason why there couldn't still be references to the pages
from get_user_pages()/get_user_pages_fast()?

> +       if (wqueue->buffer)
> +               vfree(wqueue->buffer);
> +       for (i = 0; i < wqueue->nr_pages; i++) {
> +               ClearPageUptodate(wqueue->pages[i]);
> +               wqueue->pages[i]->mapping = NULL;
> +               pgref = page_ref_count(wqueue->pages[i]);
> +               WARN(pgref != 1,
> +                    "FREE PAGE[%d] refcount %d\n", i, page_ref_count(wqueue->pages[i]));
> +               __free_page(wqueue->pages[i]);
> +       }
> +
> +       wfilter = rcu_access_pointer(wqueue->filter);

Again, rcu_dereference_protected(..., 1).

> +       if (wfilter)
> +               kfree_rcu(wfilter, rcu);
> +       kfree(wqueue->pages);
> +       put_cred(wqueue->cred);
> +       put_watch_queue(wqueue);
> +       return 0;
> +}
> +
> +#ifdef DEBUG_WITH_WRITE
> +static ssize_t watch_queue_write(struct file *file,
> +                                const char __user *_buf, size_t len, loff_t *pos)
> +{
> +       struct watch_notification *n;
> +       struct watch_queue *wqueue = file->private_data;
> +       ssize_t ret;
> +
> +       if (!wqueue->buffer)
> +               return -ENOBUFS;
> +
> +       if (len & ~WATCH_INFO_LENGTH || len == 0 || !_buf)
> +               return -EINVAL;
> +
> +       n = memdup_user(_buf, len);
> +       if (IS_ERR(n))
> +               return PTR_ERR(n);
> +
> +       ret = -EINVAL;
> +       if ((n->info & WATCH_INFO_LENGTH) != len)
> +               goto error;
> +       n->info &= (WATCH_INFO_LENGTH | WATCH_INFO_TYPE_FLAGS | WATCH_INFO_ID);

Should the non-atomic modification of n->info (and perhaps also the
following uses of ->debug) be protected by some lock?

> +       if (post_one_notification(wqueue, n, file->f_cred))
> +               wqueue->debug = 0;
> +       else
> +               wqueue->debug++;
> +       ret = len;
> +       if (wqueue->debug > 20)
> +               ret = -EIO;
> +
> +error:
> +       kfree(n);
> +       return ret;
> +}
> +#endif
[...]
> +#define IOC_WATCH_QUEUE_SET_SIZE       _IO('s', 0x01)  /* Set the size in pages */
> +#define IOC_WATCH_QUEUE_SET_FILTER     _IO('s', 0x02)  /* Set the filter */

Should these ioctl numbers be registered in
Documentation/ioctl/ioctl-number.txt?
