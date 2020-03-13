Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9726F1844AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMKS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 06:18:27 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39808 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMKS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:18:27 -0400
Received: by mail-il1-f194.google.com with SMTP id w15so1017757ilq.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyFbd+XTU4jmr46S/cr+5oxuJ4yyBlKA+WZPNk944HQ=;
        b=jbLOV/wKEBCP+egAIPuAmGI01EGi9iRz1D+M4W1UTJ1zDP7EGuZ06aIyWN1ZP2PqaS
         jt1Y6IaJZOgv5eR99mE1xIvQrt2lJqt2PMidGpfnF4LDdvdkrrGqK/CQ12baoYeXoNdR
         bMkkgu83JFDRZECx6628ZmgAPYa4D+C7IpQ4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyFbd+XTU4jmr46S/cr+5oxuJ4yyBlKA+WZPNk944HQ=;
        b=ArtrEEjTHxx9h4gQp0OyKfJgT1ozycuzxuLKL/Y4dh73Da+KiHEEgleeT2bx39YW3G
         /wKL1GywRaNNAvYt2OQ6shjwOH2VkyIwvgtKNMZ/jz2zulppp//4YS4aSIR2s+hVcC9Z
         e30+0QUrKDpWePkbUio6ZCFD+nBUjPR9PXo6lcqPRgAxufFO9+zrG4kQ/+fCswsbWjd3
         bcdYYAPOYKyH7fgKpR2hm7mLBMQpy6Z1sMkzkm2sIkxMeFM6/1pREuF/lalmQE+BR+I2
         CNnUA2fw97h/B2Jb+kYG3KAa/nQbRn+ReLymXGl1D5A00JpxyHXrXf9nHeb+YpqmssXj
         LV0g==
X-Gm-Message-State: ANhLgQ1Uz9kjgGepzZK0HWIyx6PqXXgTnjVCEAclYe1VI5LcTJJZeQ9/
        yqGF/mZeXj9vbxBK2Dp+sC4wp2HtkD1aa0BOydclsA==
X-Google-Smtp-Source: ADFU+vu5FYOgunG79LQ1WrD3HHErLWS3Yhjf9f/SMHV66YbhDMSAExoU1JWrRHjekA9AGDGKhjMz4qWzyU5gCRD2uoY=
X-Received: by 2002:a92:d745:: with SMTP id e5mr12394886ilq.285.1584094706462;
 Fri, 13 Mar 2020 03:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-14-vgoyal@redhat.com>
 <CAJfpegtpgE+vnN0hvEVMDyNkYZ0h3_kNgxWCQUb2iuBdy8kEsw@mail.gmail.com> <20200312160208.GB114720@redhat.com>
In-Reply-To: <20200312160208.GB114720@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Mar 2020 11:18:15 +0100
Message-ID: <CAJfpegtuCCRfKfctUyQBimAOpnOTvW5zodLAy307Mr_1h0+e7g@mail.gmail.com>
Subject: Re: [PATCH 13/20] fuse, dax: Implement dax read/write operations
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Mar 12, 2020 at 10:43:10AM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > This patch implements basic DAX support. mmap() is not implemented
> > > yet and will come in later patches. This patch looks into implemeting
> > > read/write.
> > >
> > > We make use of interval tree to keep track of per inode dax mappings.
> > >
> > > Do not use dax for file extending writes, instead just send WRITE message
> > > to daemon (like we do for direct I/O path). This will keep write and
> > > i_size change atomic w.r.t crash.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > ---
> > >  fs/fuse/file.c            | 597 +++++++++++++++++++++++++++++++++++++-
> > >  fs/fuse/fuse_i.h          |  23 ++
> > >  fs/fuse/inode.c           |   6 +
> > >  include/uapi/linux/fuse.h |   1 +
> > >  4 files changed, 621 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 9d67b830fb7a..9effdd3dc6d6 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -18,6 +18,12 @@
> > >  #include <linux/swap.h>
> > >  #include <linux/falloc.h>
> > >  #include <linux/uio.h>
> > > +#include <linux/dax.h>
> > > +#include <linux/iomap.h>
> > > +#include <linux/interval_tree_generic.h>
> > > +
> > > +INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
> > > +                     START, LAST, static inline, fuse_dax_interval_tree);
> >
> > Are you using this because of byte ranges (u64)?   Does it not make
> > more sense to use page offsets, which are unsigned long and so fit
> > nicely into the generic interval tree?
>
> I think I should be able to use generic interval tree. I will switch
> to that.
>
> [..]
> > > +/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
> > > +static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
> > > +                                 struct fuse_dax_mapping *dmap, bool writable,
> > > +                                 bool upgrade)
> > > +{
> > > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > +       struct fuse_setupmapping_in inarg;
> > > +       FUSE_ARGS(args);
> > > +       ssize_t err;
> > > +
> > > +       WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
> > > +       WARN_ON(fc->nr_free_ranges < 0);
> > > +
> > > +       /* Ask fuse daemon to setup mapping */
> > > +       memset(&inarg, 0, sizeof(inarg));
> > > +       inarg.foffset = offset;
> > > +       inarg.fh = -1;
> > > +       inarg.moffset = dmap->window_offset;
> > > +       inarg.len = FUSE_DAX_MEM_RANGE_SZ;
> > > +       inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
> > > +       if (writable)
> > > +               inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
> > > +       args.opcode = FUSE_SETUPMAPPING;
> > > +       args.nodeid = fi->nodeid;
> > > +       args.in_numargs = 1;
> > > +       args.in_args[0].size = sizeof(inarg);
> > > +       args.in_args[0].value = &inarg;
> >
> > args.force = true?
>
> I can do that but I am not sure what exactly does args.force do and
> why do we need it in this case.

Hm, it prevents interrupts.  Looking closely, however it will only
prevent SIGKILL from immediately interrupting the request, otherwise
it will send an INTERRUPT request and the filesystem can ignore that.
Might make sense to have a args.nonint flag to prevent the sending of
INTERRUPT...

> First thing it does is that request is allocated with flag __GFP_NOFAIL.
> Second thing it does is that caller is forced to wait for request
> completion and its not an interruptible sleep.
>
> I am wondering what makes FUSE_SETUPMAPING/FUSE_REMOVEMAPPING requests
> special that we need to set force flag.

Maybe not for SETUPMAPPING (I was confused by the error log).

However if REMOVEMAPPING fails for some reason, than that dax mapping
will be leaked for the lifetime of the filesystem.   Or am I
misunderstanding it?

> > > +       ret = fuse_setup_one_mapping(inode,
> > > +                                    ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> > > +                                    dmap, true, true);
> > > +       if (ret < 0) {
> > > +               printk("fuse_setup_one_mapping() failed. err=%d pos=0x%llx\n",
> > > +                      ret, pos);
> >
> > Again.
>
> Will remove. How about converting some of them to pr_debug() instead? It
> can help with debugging if something is not working.

Okay, and please move it to fuse_setup_one_mapping() where there's
already a pr_debug() for the success case.

 > > +
> > > +       /* Do not use dax for file extending writes as its an mmap and
> > > +        * trying to write beyong end of existing page will generate
> > > +        * SIGBUS.
> >
> > Ah, here it is.  So what happens in case of a race?  Does that
> > currently crash KVM?
>
> In case of race, yes, KVM hangs. So no shared directory operation yet
> till we have designed proper error handling in kvm path.

I think before this is merged we have to fix the KVM crash; that's not
acceptable even if we explicitly say that shared directory is not
supported for the time being.

Thanks,
Miklos
