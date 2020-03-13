Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27440184861
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 14:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCMNmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 09:42:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgCMNmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584106938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WmJMCPjLeZOGPd5XvclGChfYUeyS2atWd4pQtWyZc14=;
        b=c6/vRoLJWoY1aQvLXglZeEfR2yDmlvCw49iGV+Cz4HYZdKcS0B92+wyWPpr2tggbcmKQ3p
        R3wzDQRO4QCE+wuZ5arOUXXTJ2NzqJpAEwOpwi+pZuQONxBibNqiZPXcS87K1SVle+lLHk
        kCw7W4d0w5kWeuOyn5CHZWqGFCGc+oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-dxlPnEmCMRqY71uj9jQetw-1; Fri, 13 Mar 2020 09:42:06 -0400
X-MC-Unique: dxlPnEmCMRqY71uj9jQetw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C61518A8CAF;
        Fri, 13 Mar 2020 13:42:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A89A4101D480;
        Fri, 13 Mar 2020 13:41:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3896722021D; Fri, 13 Mar 2020 09:41:55 -0400 (EDT)
Date:   Fri, 13 Mar 2020 09:41:55 -0400
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
Message-ID: <20200313134155.GA156804@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-14-vgoyal@redhat.com>
 <CAJfpegtpgE+vnN0hvEVMDyNkYZ0h3_kNgxWCQUb2iuBdy8kEsw@mail.gmail.com>
 <20200312160208.GB114720@redhat.com>
 <CAJfpegtuCCRfKfctUyQBimAOpnOTvW5zodLAy307Mr_1h0+e7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtuCCRfKfctUyQBimAOpnOTvW5zodLAy307Mr_1h0+e7g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:18:15AM +0100, Miklos Szeredi wrote:

[..]
> > > > +/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
> > > > +static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
> > > > +                                 struct fuse_dax_mapping *dmap, bool writable,
> > > > +                                 bool upgrade)
> > > > +{
> > > > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > > +       struct fuse_setupmapping_in inarg;
> > > > +       FUSE_ARGS(args);
> > > > +       ssize_t err;
> > > > +
> > > > +       WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
> > > > +       WARN_ON(fc->nr_free_ranges < 0);
> > > > +
> > > > +       /* Ask fuse daemon to setup mapping */
> > > > +       memset(&inarg, 0, sizeof(inarg));
> > > > +       inarg.foffset = offset;
> > > > +       inarg.fh = -1;
> > > > +       inarg.moffset = dmap->window_offset;
> > > > +       inarg.len = FUSE_DAX_MEM_RANGE_SZ;
> > > > +       inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
> > > > +       if (writable)
> > > > +               inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
> > > > +       args.opcode = FUSE_SETUPMAPPING;
> > > > +       args.nodeid = fi->nodeid;
> > > > +       args.in_numargs = 1;
> > > > +       args.in_args[0].size = sizeof(inarg);
> > > > +       args.in_args[0].value = &inarg;
> > >
> > > args.force = true?
> >
> > I can do that but I am not sure what exactly does args.force do and
> > why do we need it in this case.
> 
> Hm, it prevents interrupts.  Looking closely, however it will only
> prevent SIGKILL from immediately interrupting the request, otherwise
> it will send an INTERRUPT request and the filesystem can ignore that.
> Might make sense to have a args.nonint flag to prevent the sending of
> INTERRUPT...

Hi Miklos,

virtiofs does not support interrupt requests yet. Its fiq interrupt
handler just does not do anything.

static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
__releases(fiq->lock)
{
        /*
         * TODO interrupts.
         *
         * Normal fs operations on a local filesystems aren't interruptible.
         * Exceptions are blocking lock operations; for example fcntl(F_SETLKW)
         * with shared lock between host and guest.
         */
        spin_unlock(&fiq->lock);
}

So as of now setting force or not will not make any difference. We will
still end up waiting for request to finish.

Infact, I think there is no mechanism to set fc->no_interrupt in
virtio_fs. If I am reading request_wait_answer(), correctly, it will
see fc->no_interrupt is not set. That means filesystem supports
interrupt requests and it will do wait_event_interruptible() and
not even check for FR_FORCE bit. 

Right now fc->no_interrupt is set in response to INTERRUPT request
reply. Will it make sense to also be able to set it as part of
connection negotation protocol and filesystem can tell in the
beginning itself that it does not support interrupt and virtiofs
can make use of that.

So force flag is only useful if filesystem does not support interrupt
and in that case we do wait_event_killable() and upon receiving
SIGKILL, cancel request if it is still in pending queue. For virtiofs,
we take request out of fiq->pending queue in submission path itself
and if it can't be dispatched it waits on virtiofs speicfic queue
with FR_PENDING cleared. That means, setting FR_FORCE for virtiofs
does not mean anything as caller will end up waiting for
request to finish anyway.

IOW, setting FR_FORCE will make sense when we have mechanism to
detect that request is still queued in virtiofs queues and have
mechanism to cancel it. We don't have it. In fact, given we are
a push model, we dispatch request immediately to filesystem,
until and unless virtqueue is full. So probability of a request
still in virtiofs queue is low.

So may be we can start setting force at some point of time later
when we have mechanism to cancel detect and cancel pending requests
in virtiofs.

> 
> > First thing it does is that request is allocated with flag __GFP_NOFAIL.
> > Second thing it does is that caller is forced to wait for request
> > completion and its not an interruptible sleep.
> >
> > I am wondering what makes FUSE_SETUPMAPING/FUSE_REMOVEMAPPING requests
> > special that we need to set force flag.
> 
> Maybe not for SETUPMAPPING (I was confused by the error log).
> 
> However if REMOVEMAPPING fails for some reason, than that dax mapping
> will be leaked for the lifetime of the filesystem.   Or am I
> misunderstanding it?

FUSE_REMVOEMAPPING is not must. If we send another FUSE_SETUPMAPPING, then
it will create the new mapping and free up resources associated with
the previous mapping, IIUC.

So at one point of time we were thinking that what's the point of
sending FUSE_REMOVEMAPPING. It helps a bit with freeing up filesystem
resources earlier. So if cache size is big, then there will not be
much reclaim activity going and if we don't send FUSE_REMOVEMAPPING,
all these filesystem resources will remain busy on host for a long
time.

> 
> > > > +       ret = fuse_setup_one_mapping(inode,
> > > > +                                    ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> > > > +                                    dmap, true, true);
> > > > +       if (ret < 0) {
> > > > +               printk("fuse_setup_one_mapping() failed. err=%d pos=0x%llx\n",
> > > > +                      ret, pos);
> > >
> > > Again.
> >
> > Will remove. How about converting some of them to pr_debug() instead? It
> > can help with debugging if something is not working.
> 
> Okay, and please move it to fuse_setup_one_mapping() where there's
> already a pr_debug() for the success case.

Will do.

> 
>  > > +
> > > > +       /* Do not use dax for file extending writes as its an mmap and
> > > > +        * trying to write beyong end of existing page will generate
> > > > +        * SIGBUS.
> > >
> > > Ah, here it is.  So what happens in case of a race?  Does that
> > > currently crash KVM?
> >
> > In case of race, yes, KVM hangs. So no shared directory operation yet
> > till we have designed proper error handling in kvm path.
> 
> I think before this is merged we have to fix the KVM crash; that's not
> acceptable even if we explicitly say that shared directory is not
> supported for the time being.

Ok, I will look into it. I had done some work in the past and realized
its not trivial to fix kvm error paths. There are no users and propagating
signals back into qemu instances and finding the right process is going to be
tricky.

Given the complexity of that work, I thought that for now we say that
shared directory is not supported and once basic dax patches get merged,
focus on kvm work.

Thanks
Vivek

