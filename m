Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6741835B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCLQCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 12:02:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727693AbgCLQCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584028942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Levu9e5gKEGuGjfYAxBNO+RhloIEDELGqMCTmJZ5K4=;
        b=JzharAGDPX4P7WPKaFioUm3ihGmXwUFMmrNXDhT8J2CEXxC8svLesFMRA02ZTXh2xw6q4x
        T4+T2Iv+qisTJ0GP5XR4zic8nAztVb3I8e/cnpyqUSsIS/gZNKbOD6mGPz0YHUJ5gxHzC9
        9WqrdiXVd6esIulVG1iijx7EyT4cYdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-NMmabGOgMtyJm4gfGA7NGw-1; Thu, 12 Mar 2020 12:02:18 -0400
X-MC-Unique: NMmabGOgMtyJm4gfGA7NGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D3D86A070;
        Thu, 12 Mar 2020 16:02:16 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D379C8F35C;
        Thu, 12 Mar 2020 16:02:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7025022021D; Thu, 12 Mar 2020 12:02:08 -0400 (EDT)
Date:   Thu, 12 Mar 2020 12:02:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200312160208.GB114720@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-14-vgoyal@redhat.com>
 <CAJfpegtpgE+vnN0hvEVMDyNkYZ0h3_kNgxWCQUb2iuBdy8kEsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtpgE+vnN0hvEVMDyNkYZ0h3_kNgxWCQUb2iuBdy8kEsw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:43:10AM +0100, Miklos Szeredi wrote:
> On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This patch implements basic DAX support. mmap() is not implemented
> > yet and will come in later patches. This patch looks into implemeting
> > read/write.
> >
> > We make use of interval tree to keep track of per inode dax mappings.
> >
> > Do not use dax for file extending writes, instead just send WRITE message
> > to daemon (like we do for direct I/O path). This will keep write and
> > i_size change atomic w.r.t crash.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > ---
> >  fs/fuse/file.c            | 597 +++++++++++++++++++++++++++++++++++++-
> >  fs/fuse/fuse_i.h          |  23 ++
> >  fs/fuse/inode.c           |   6 +
> >  include/uapi/linux/fuse.h |   1 +
> >  4 files changed, 621 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 9d67b830fb7a..9effdd3dc6d6 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -18,6 +18,12 @@
> >  #include <linux/swap.h>
> >  #include <linux/falloc.h>
> >  #include <linux/uio.h>
> > +#include <linux/dax.h>
> > +#include <linux/iomap.h>
> > +#include <linux/interval_tree_generic.h>
> > +
> > +INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
> > +                     START, LAST, static inline, fuse_dax_interval_tree);
> 
> Are you using this because of byte ranges (u64)?   Does it not make
> more sense to use page offsets, which are unsigned long and so fit
> nicely into the generic interval tree?

I think I should be able to use generic interval tree. I will switch
to that.

[..]
> > +/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
> > +static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
> > +                                 struct fuse_dax_mapping *dmap, bool writable,
> > +                                 bool upgrade)
> > +{
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_setupmapping_in inarg;
> > +       FUSE_ARGS(args);
> > +       ssize_t err;
> > +
> > +       WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
> > +       WARN_ON(fc->nr_free_ranges < 0);
> > +
> > +       /* Ask fuse daemon to setup mapping */
> > +       memset(&inarg, 0, sizeof(inarg));
> > +       inarg.foffset = offset;
> > +       inarg.fh = -1;
> > +       inarg.moffset = dmap->window_offset;
> > +       inarg.len = FUSE_DAX_MEM_RANGE_SZ;
> > +       inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
> > +       if (writable)
> > +               inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
> > +       args.opcode = FUSE_SETUPMAPPING;
> > +       args.nodeid = fi->nodeid;
> > +       args.in_numargs = 1;
> > +       args.in_args[0].size = sizeof(inarg);
> > +       args.in_args[0].value = &inarg;
> 
> args.force = true?

I can do that but I am not sure what exactly does args.force do and
why do we need it in this case.

First thing it does is that request is allocated with flag __GFP_NOFAIL.
Second thing it does is that caller is forced to wait for request
completion and its not an interruptible sleep. 

I am wondering what makes FUSE_SETUPMAPING/FUSE_REMOVEMAPPING requests
special that we need to set force flag.

> 
> > +       err = fuse_simple_request(fc, &args);
> > +       if (err < 0) {
> > +               printk(KERN_ERR "%s request failed at mem_offset=0x%llx %zd\n",
> > +                                __func__, dmap->window_offset, err);
> 
> Is this level of noisiness really needed?  AFAICS, the error will
> reach the caller, in which case we don't usually need to print a
> kernel error.

I will remove it. I think code in general has quite a few printk() and
pr_debug() we can get rid of. Some of them were helpful for debugging
problems while code was being developed. But now that code is working,
we should be able to drop some of them.

[..]
> > +static int
> > +fuse_send_removemapping(struct inode *inode,
> > +                       struct fuse_removemapping_in *inargp,
> > +                       struct fuse_removemapping_one *remove_one)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       FUSE_ARGS(args);
> > +
> > +       args.opcode = FUSE_REMOVEMAPPING;
> > +       args.nodeid = fi->nodeid;
> > +       args.in_numargs = 2;
> > +       args.in_args[0].size = sizeof(*inargp);
> > +       args.in_args[0].value = inargp;
> > +       args.in_args[1].size = inargp->count * sizeof(*remove_one);
> > +       args.in_args[1].value = remove_one;
> 
> args.force = true?

FUSE_REMOVEMAPPING is an optional nice to have request. Will it make
help to set force.

> 
> > +       return fuse_simple_request(fc, &args);
> > +}
> > +
> > +static int dmap_removemapping_list(struct inode *inode, unsigned num,
> > +                                  struct list_head *to_remove)
> > +{
> > +       struct fuse_removemapping_one *remove_one, *ptr;
> > +       struct fuse_removemapping_in inarg;
> > +       struct fuse_dax_mapping *dmap;
> > +       int ret, i = 0, nr_alloc;
> > +
> > +       nr_alloc = min_t(unsigned int, num, FUSE_REMOVEMAPPING_MAX_ENTRY);
> > +       remove_one = kmalloc_array(nr_alloc, sizeof(*remove_one), GFP_NOFS);
> > +       if (!remove_one)
> > +               return -ENOMEM;
> > +
> > +       ptr = remove_one;
> > +       list_for_each_entry(dmap, to_remove, list) {
> > +               ptr->moffset = dmap->window_offset;
> > +               ptr->len = dmap->length;
> > +               ptr++;
> 
> Minor nit: ptr = &remove_one[i] at the start of the section would be
> cleaner IMO.

Will do.

[..]
> > +static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
> > +                                        loff_t length, unsigned flags,
> > +                                        struct iomap *iomap)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       struct fuse_dax_mapping *dmap, *alloc_dmap = NULL;
> > +       int ret;
> > +       bool writable = flags & IOMAP_WRITE;
> > +
> > +       alloc_dmap = alloc_dax_mapping(fc);
> > +       if (!alloc_dmap)
> > +               return -EBUSY;
> > +
> > +       /*
> > +        * Take write lock so that only one caller can try to setup mapping
> > +        * and other waits.
> > +        */
> > +       down_write(&fi->i_dmap_sem);
> > +       /*
> > +        * We dropped lock. Check again if somebody else setup
> > +        * mapping already.
> > +        */
> > +       dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos,
> > +                                               pos);
> > +       if (dmap) {
> > +               fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
> > +               dmap_add_to_free_pool(fc, alloc_dmap);
> > +               up_write(&fi->i_dmap_sem);
> > +               return 0;
> > +       }
> > +
> > +       /* Setup one mapping */
> > +       ret = fuse_setup_one_mapping(inode,
> > +                                    ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> > +                                    alloc_dmap, writable, false);
> > +       if (ret < 0) {
> > +               printk("fuse_setup_one_mapping() failed. err=%d"
> > +                       " pos=0x%llx, writable=%d\n", ret, pos, writable);
> 
> More  unnecessary noise?

Will remove.

> 
> > +               dmap_add_to_free_pool(fc, alloc_dmap);
> > +               up_write(&fi->i_dmap_sem);
> > +               return ret;
> > +       }
> > +       fuse_fill_iomap(inode, pos, length, iomap, alloc_dmap, flags);
> > +       up_write(&fi->i_dmap_sem);
> > +       return 0;
> > +}
> > +
> > +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> > +                                        loff_t length, unsigned flags,
> > +                                        struct iomap *iomap)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_dax_mapping *dmap;
> > +       int ret;
> > +
> > +       /*
> > +        * Take exclusive lock so that only one caller can try to setup
> > +        * mapping and others wait.
> > +        */
> > +       down_write(&fi->i_dmap_sem);
> > +       dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
> > +
> > +       /* We are holding either inode lock or i_mmap_sem, and that should
> > +        * ensure that dmap can't reclaimed or truncated and it should still
> > +        * be there in tree despite the fact we dropped and re-acquired the
> > +        * lock.
> > +        */
> > +       ret = -EIO;
> > +       if (WARN_ON(!dmap))
> > +               goto out_err;
> > +
> > +       /* Maybe another thread already upgraded mapping while we were not
> > +        * holding lock.
> > +        */
> > +       if (dmap->writable)
> > +               goto out_fill_iomap;
> > +
> > +       ret = fuse_setup_one_mapping(inode,
> > +                                    ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> > +                                    dmap, true, true);
> > +       if (ret < 0) {
> > +               printk("fuse_setup_one_mapping() failed. err=%d pos=0x%llx\n",
> > +                      ret, pos);
> 
> Again.

Will remove. How about converting some of them to pr_debug() instead? It
can help with debugging if something is not working.

> 
> > +               goto out_err;
> > +       }
> > +
> > +out_fill_iomap:
> > +       fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
> > +out_err:
> > +       up_write(&fi->i_dmap_sem);
> > +       return ret;
> > +}
> > +
> > +/* This is just for DAX and the mapping is ephemeral, do not use it for other
> > + * purposes since there is no block device with a permanent mapping.
> > + */
> > +static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
> > +                           unsigned flags, struct iomap *iomap,
> > +                           struct iomap *srcmap)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       struct fuse_dax_mapping *dmap;
> > +       bool writable = flags & IOMAP_WRITE;
> > +
> > +       /* We don't support FIEMAP */
> > +       BUG_ON(flags & IOMAP_REPORT);
> > +
> > +       pr_debug("fuse_iomap_begin() called. pos=0x%llx length=0x%llx\n",
> > +                       pos, length);
> > +
> > +       /*
> > +        * Writes beyond end of file are not handled using dax path. Instead
> > +        * a fuse write message is sent to daemon
> > +        */
> > +       if (flags & IOMAP_WRITE && pos >= i_size_read(inode))
> > +               return -EIO;
> 
> Okay, this will work fine if the host filesystem is not modified by
> other entities.

This requires little longer explanation. It took me a while to remember
what I did.

For file extending writes, we do not want to go through dax path because
we want written data and file size to be atomic operation w.r.t guest
crash. So in fuse_dax_write_iter() I detect that this is file extending
write and call fuse_dax_direct_write() instead to fall back to regular
fuse message for write and bypass dax.

But if write is partially overwriting and rest is file extending, current
logic tries to use dax for the portion of page which is being overwritten
and fall back to fuse write message for the remaining file extending
write. And that's why after the call to dax_iomap_rw() I check one more
time if there are some bytes not written and use fuse write to extend
file.

        /*
         * If part of the write was file extending, fuse dax path will not
         * take care of that. Do direct write instead.
         */
        if (iov_iter_count(from) && file_extending_write(iocb, from)) {
                count = fuse_dax_direct_write(iocb, from);
                if (count < 0)
                        goto out;
                ret += count;
        }

dax_iomap_rw() will do dax operation for the bytes which are with-in
i_size. Then it will call iomap_apply() again with the portion of
file doing file extending write and this time iomap_begin() will return
-EIO. And dax_iomap_rw() will return number of bytes written (and not
-EIO) to caller. 

        while (iov_iter_count(iter)) {
                ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
                                iter, dax_iomap_actor);
                if (ret <= 0)
                        break;
                pos += ret;
                done += ret;
        }

I am beginning to think that this is way more complicated then it needs
to be. Probably I should detect that if any part of the file is file
extending, just fall back to using fuse write path.

> What happens if there's a concurrent truncate going on on the host
> with this write?

For regular fuse write, concurrent truncate is not a problem. But for
dax read/write/mmap, concurrent truncate is a problem. If another guest
truncates the file (after this guest has mapped this page), then
any attempt to access this page hangs that process. KVM is trying to
fault in a page on host which does not exist anymore. Currently kvm
does not seem to have the logic to be able to deal with errors in
async page fault path. And we will have to modify all that so that
we can somehow propagate errors (SIGBUS) to guest and deliver it
to process.

So if process did mmap() and tried to access truncated portion of
file, then it should get SIGBUS. If we are doing read/write then
we should have the logic to deal with this error (exception table
magic) and deliver -EIO to user space.

None of that is handled right now and is a future TODO item. So
for now, this will work well only with single guest and we will
run into issues if we are sharing directories with another
guest.

> If the two are not in any way synchronized than
> either the two following behavior is allowed:
> 
>  1) Whole or partial data in write is truncated. (If there are
> complete pages from the write being truncated, then the writing
> process will receive SIGBUS.  Does KVM hande that?   I remember that
> being discussed, but don't remember the conclusion).
> 
>  2) Write re-extends file size.

Currently, for file extending writes, if other guest truncates file first
then fuse write will extend file again. If fuse write finished first,
then other guest will truncate file and reduce size.

I think we will have problem when only part of the write is extending
file. In that case part of the file which is being overwritten, we are
doing dax. And if other guest truncates file first, then kvm will hang.

But that's a problem we have with not just file extending write, but
any read/write/mmap w.r.t truncate by another guest. We will have to
fix that before we support virtiofs+dax for shared directory.

> 
> However EIO is not a good result, so we need to do something with it.

This -EIO is not seen by user. But dax_iomap_rw() does not return it
instead returns number of bytes which have been written. 

[..]
> > +static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +       struct inode *inode = file_inode(iocb->ki_filp);
> > +       ssize_t ret, count;
> > +
> > +       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +               if (!inode_trylock(inode))
> > +                       return -EAGAIN;
> > +       } else {
> > +               inode_lock(inode);
> > +       }
> > +
> > +       ret = generic_write_checks(iocb, from);
> > +       if (ret <= 0)
> > +               goto out;
> > +
> > +       ret = file_remove_privs(iocb->ki_filp);
> > +       if (ret)
> > +               goto out;
> > +       /* TODO file_update_time() but we don't want metadata I/O */
> > +
> > +       /* Do not use dax for file extending writes as its an mmap and
> > +        * trying to write beyong end of existing page will generate
> > +        * SIGBUS.
> 
> Ah, here it is.  So what happens in case of a race?  Does that
> currently crash KVM?

In case of race, yes, KVM hangs. So no shared directory operation yet
till we have designed proper error handling in kvm path.

Thanks
Vivek

