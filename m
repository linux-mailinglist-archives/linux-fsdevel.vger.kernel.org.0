Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B162253824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHZTRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 15:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgHZTR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598469446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwcANZhA8W6K53dylWiceQBVhU3tV8RvSRl3XFIVabA=;
        b=Ykrm1ekWopx0jyFA1Z9NMmrDrIJWsib/Pi0HO0GCikyLsQnucI9j65o9UD1n5nuttXLK/t
        +H7nyVygpWnO+HYbZRkyAXTaqPMzTQqcoX1QhXPlOOaNaY5Q9kRF1T9IzB/2Ec6bqs3igq
        +SaBCfvRu7oZqPazvSHU+nhBTdY+d5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-UyPiH8JVNKCHGWvTJiA_xA-1; Wed, 26 Aug 2020 15:17:23 -0400
X-MC-Unique: UyPiH8JVNKCHGWvTJiA_xA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AEE1DDFC;
        Wed, 26 Aug 2020 19:17:22 +0000 (UTC)
Received: from work-vm (ovpn-112-133.ams2.redhat.com [10.36.112.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6267618B59;
        Wed, 26 Aug 2020 19:17:14 +0000 (UTC)
Date:   Wed, 26 Aug 2020 20:17:11 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
Message-ID: <20200826191711.GF3932@work-vm>
References: <20200819221956.845195-1-vgoyal@redhat.com>
 <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com>
 <20200826173408.GA11480@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826173408.GA11480@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Aug 26, 2020 at 11:51:42AM -0400, Vivek Goyal wrote:
> > On Wed, Aug 26, 2020 at 04:06:35PM +0200, Miklos Szeredi wrote:
> > > On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> > > > constraints via the FUST_INIT map_alignment field.  Parse this field and
> > > > ensure our DAX mappings meet the alignment constraints.
> > > >
> > > > We don't actually align anything differently since our mappings are
> > > > already 2MB aligned.  Just check the value when the connection is
> > > > established.  If it becomes necessary to honor arbitrary alignments in
> > > > the future we'll have to adjust how mappings are sized.
> > > >
> > > > The upshot of this commit is that we can be confident that mappings will
> > > > work even when emulating x86 on Power and similar combinations where the
> > > > host page sizes are different.
> > > >
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |  5 ++++-
> > > >  fs/fuse/inode.c           | 18 ++++++++++++++++--
> > > >  include/uapi/linux/fuse.h |  4 +++-
> > > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 478c940b05b4..4a46e35222c7 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -47,7 +47,10 @@
> > > >  /** Number of dentries for each connection in the control filesystem */
> > > >  #define FUSE_CTL_NUM_DENTRIES 5
> > > >
> > > > -/* Default memory range size, 2MB */
> > > > +/*
> > > > + * Default memory range size.  A power of 2 so it agrees with common FUSE_INIT
> > > > + * map_alignment values 4KB and 64KB.
> > > > + */
> > > >  #define FUSE_DAX_SZ    (2*1024*1024)
> > > >  #define FUSE_DAX_SHIFT (21)
> > > >  #define FUSE_DAX_PAGES (FUSE_DAX_SZ/PAGE_SIZE)
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index b82eb61d63cc..947abdd776ca 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -980,9 +980,10 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
> > > >  {
> > > >         struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
> > > >         struct fuse_init_out *arg = &ia->out;
> > > > +       bool ok = true;
> > > >
> > > >         if (error || arg->major != FUSE_KERNEL_VERSION)
> > > > -               fc->conn_error = 1;
> > > > +               ok = false;
> > > >         else {
> > > >                 unsigned long ra_pages;
> > > >
> > > > @@ -1045,6 +1046,13 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
> > > >                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> > > >                                         max_t(unsigned int, arg->max_pages, 1));
> > > >                         }
> > > > +                       if ((arg->flags & FUSE_MAP_ALIGNMENT) &&
> > > > +                           (FUSE_DAX_SZ % (1ul << arg->map_alignment))) {
> > > 
> > > This just obfuscates "arg->map_alignment != FUSE_DAX_SHIFT".
> > > 
> > > So the intention was that userspace can ask the kernel for a
> > > particular alignment, right?
> > 
> > My understanding is that device will specify alignment for
> > the foffset/moffset fields in fuse_setupmapping_in/fuse_removemapping_one.
> > And DAX mapping can be any size meeting that alignment contraint.
> > 
> > > 
> > > In that case kernel can definitely succeed if the requested alignment
> > > is smaller than the kernel provided one, no? 
> > 
> > Yes. So if map_alignemnt is 64K and DAX mapping size is 2MB, that's just
> > fine because it meets 4K alignment contraint. Just that we can't use
> > 4K size DAX mapping in that case.
> > 
> > > It would also make
> > > sense to make this a two way negotiation.  I.e. send the largest
> > > alignment (FUSE_DAX_SHIFT in this implementation) that the kernel can
> > > provide in fuse_init_in.   In that case the only error would be if
> > > userspace ignored the given constraints.
> > 
> > We could make it two way negotiation if it helps. So if we support
> > multiple mapping sizes in future, say 4K, 64K, 2MB, 1GB. So idea is
> > to send alignment of largest mapping size to device/user_space (1GB)
> > in this case? And that will allow device to choose an alignment
> > which best fits its needs?
> > 
> > But problem here is that sending (log2(1GB)) does not mean we support
> > all the alignments in that range. For example, if device selects say
> > 256MB as minimum alignment, kernel might not support it.
> > 
> > So there seem to be two ways to handle this.
> > 
> > A.Let device be conservative and always specify the minimum aligment
> >   it can work with and let guest kernel automatically choose a mapping
> >   size which meets that min_alignment contraint.
> > 
> > B.Send all the mapping sizes supported by kernel to device and then
> >   device chooses an alignment as it sees fit. We could probably send
> >   a 64bit field and set a bit for every size we support as dax mapping.
> >   If we were to go down this path, I think in that case client should
> >   respond back with exact mapping size we should use (and not with
> >   minimum alignment).
> > 
> > I thought intent behind this patch was to implement A.
> > 
> > Stefan/David, this patch came from you folks. What do you think?
> 
> Yes, I agree with Vivek.
> 
> The FUSE server is telling the client the minimum alignment for
> foffset/moffset. The client can map any size it likes as long as
> foffset/moffset meet the alignment constraint. I can't think of a reason
> to do two-way negotiation.

Agreed, because there's not much that the server can do about it if the
client would like a smaller granularity - the servers granularity might
be dictated by it's mmap/pagesize/filesystem.  If the client wants a
larger granularity that's it's choice when it sends the setupmapping
calls.

Dave

> Stefan


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

