Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FC181B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 15:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgCKOlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 10:41:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729057AbgCKOlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583937699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oi39w6c8WmZF4VD2SAl+7GXpBzzUSxdZMb4is4/iUjc=;
        b=gDGVqloeKy0uQKg4vzmBANyzcKd2gl+QBhSRa2dtO3ej8UUI9ML5pEvl5XZytR6bjMeeB9
        oyrUY7e6XvyHDWON1LqpKheKvFibS/G8y6V+nOjm2llZHehHfxxFILoficoqIctwXPQKW5
        F/+s7PQ4DkGO4HSiMWdBsox21GRRXOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-oaGi-oZRO3uadCugnnOKxA-1; Wed, 11 Mar 2020 10:41:35 -0400
X-MC-Unique: oaGi-oZRO3uadCugnnOKxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B2B31088384;
        Wed, 11 Mar 2020 14:41:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F268960C18;
        Wed, 11 Mar 2020 14:41:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 84EA122021D; Wed, 11 Mar 2020 10:41:24 -0400 (EDT)
Date:   Wed, 11 Mar 2020 10:41:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
Message-ID: <20200311144124.GB83257@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
 <20200310203321.GF38440@redhat.com>
 <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
 <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:19:18PM +0100, Miklos Szeredi wrote:
> On Wed, Mar 11, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > > > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > > > will be used to setup/tear down file mapping in dax window.
> > > > >
> > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > > > ---
> > > > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 37 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > > index 5b85819e045f..62633555d547 100644
> > > > > --- a/include/uapi/linux/fuse.h
> > > > > +++ b/include/uapi/linux/fuse.h
> > > > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > > > >         uint64_t        flags;
> > > > >  };
> > > > >
> > > > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > > > +struct fuse_setupmapping_in {
> > > > > +       /* An already open handle */
> > > > > +       uint64_t        fh;
> > > > > +       /* Offset into the file to start the mapping */
> > > > > +       uint64_t        foffset;
> > > > > +       /* Length of mapping required */
> > > > > +       uint64_t        len;
> > > > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > > > +       uint64_t        flags;
> > > > > +       /* Offset in Memory Window */
> > > > > +       uint64_t        moffset;
> > > > > +};
> > > > > +
> > > > > +struct fuse_setupmapping_out {
> > > > > +       /* Offsets into the cache of mappings */
> > > > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > > > +        /* Lengths of each mapping */
> > > > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > > > +};
> > > >
> > > > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
> > >
> > > This looks like leftover from the old code. I will get rid of it. Thanks.
> > >
> >
> > Hmm. I wonder if we should keep some out args for future extensions.
> > Maybe return the mapped size even though it is all or nothing at this
> > point?
> >
> > I have interest in a similar FUSE mapping functionality that was prototyped
> > by Miklos and published here:
> > https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
> >
> > In this prototype, a FUSE_MAP command is used by the server to map a
> > range of file to the kernel for io. The command in args are quite similar to
> > those in fuse_setupmapping_in, but since the server is on the same host,
> > the mapping response is {mapfd, offset, size}.
> 
> Right.  So the difference is in which entity allocates the mapping.
> IOW whether the {fd, offset, size} is input or output in the protocol.
> 
> I don't remember the reasons for going with the mapping being
> allocated by the client, not the other way round.   Vivek?

I think one of the main reasons is memory reclaim. Once all ranges in 
a cache range are allocated, we need to free a memory range which can be
reused. And client has all the logic to free up that range so that it can
be remapped and reused for a different file/offset. Server will not know
any of this. So I will think that for virtiofs, server might not be
able to decide where to map a section of file and it has to be told
explicitly by the client.

> 
> If the allocation were to be by the server, we could share the request
> type and possibly some code between the two, although the I/O
> mechanism would still be different.
> 

So input parameters of both FUSE_SETUPMAPPING and FUSE_MAP seem
similar (except the moffset field).  Given output of FUSE_MAP reqeust
is very different, I would think it will be easier to have it as a
separate command.

Or can it be some sort of optional output args which can differentiate
between two types of requests. 

/me personally finds it simpler to have separate command instead of
overloading FUSE_SETUPMAPPING. But its your call. :-) 

Vivek

