Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F7181C17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCKPM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 11:12:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44602 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:12:27 -0400
Received: by mail-io1-f68.google.com with SMTP id t26so2235017ios.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDINA0vZuHEOMHgRG8O8q8Cv6r3DuQRO69eZhFF5eEI=;
        b=LPUXGEF5amYOBlrop1rcjSx8ZchMVTTL0Q8j/pP8BHayJceQuBOOq8WUjqMDAPx895
         9IIyKqEalpT/MkO9z+NdQ49IQUNX1zj6RNQIdOLxH8Ewy+cMoKO32n73pUaLUprt9QaW
         PJp5aNh7zDbiZn+7g0tDB0pJIQuBIRNfXjjoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDINA0vZuHEOMHgRG8O8q8Cv6r3DuQRO69eZhFF5eEI=;
        b=sNuL9UkW2uEk9H9eoeVAJrnC48d05USy6cx8/yxzT+ioUJqYxfzbS8wnISVPczQ4VN
         4vtnGDlnHW3wCr7+cklZaYXfSuvPSnWrOb5R8jJLbQSmt41EBLS7XJN7u0EsnR1q9GW6
         oDpgs0vj99XO8njDiaDze9wOoR+lDJUANF5OvaH+cXxh9AHx4X8noCT/cKiZuoHW7SXr
         OLhUbnKH7UIFkgA5GQxZR8E08cFiqE/bPiMQkDP3/4V6U6xjTdVQBXjIP9ZNXazsafFA
         fKktRjY3rnzSf6yfJMKYhGq/A7YOG+7nUd1z2KKxUeg1T/6DDU5TtPWQEIa4rSfkRiYy
         L6bg==
X-Gm-Message-State: ANhLgQ11Z163d9bevyPmSd/wckvY60TAp3uq+VxhKeGgYiRP/m+yJUnI
        TzFRUkrbR4aK2WRS6S3lm5Xo1nnc5eGyhUfSZ7Gp/w==
X-Google-Smtp-Source: ADFU+vvcCJuciXit7oxjlwuLQPMyjyQkvi+E6T6WbAs28DGpKmuWEM2zqBlhtPKMYLB1eY3XtFE56zv57fsgFipCP3s=
X-Received: by 2002:a6b:9386:: with SMTP id v128mr3374290iod.15.1583939546534;
 Wed, 11 Mar 2020 08:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
 <20200310203321.GF38440@redhat.com> <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
 <CAJfpeguwqEsPLtph73AG7bhm1Dp4ahyJtyW=Ud7L-OFwyEmwWg@mail.gmail.com> <20200311144124.GB83257@redhat.com>
In-Reply-To: <20200311144124.GB83257@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Mar 2020 16:12:15 +0100
Message-ID: <CAJfpegvTo=FX5y+8R3hdkv6mOTAUQgg9qmzvL5oStddFW0OBgg@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 3:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Mar 11, 2020 at 03:19:18PM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 11, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > > > > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > > > > will be used to setup/tear down file mapping in dax window.
> > > > > >
> > > > > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > > > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > > > > ---
> > > > > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 37 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > > > > index 5b85819e045f..62633555d547 100644
> > > > > > --- a/include/uapi/linux/fuse.h
> > > > > > +++ b/include/uapi/linux/fuse.h
> > > > > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > > > > >         uint64_t        flags;
> > > > > >  };
> > > > > >
> > > > > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > > > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > > > > +struct fuse_setupmapping_in {
> > > > > > +       /* An already open handle */
> > > > > > +       uint64_t        fh;
> > > > > > +       /* Offset into the file to start the mapping */
> > > > > > +       uint64_t        foffset;
> > > > > > +       /* Length of mapping required */
> > > > > > +       uint64_t        len;
> > > > > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > > > > +       uint64_t        flags;
> > > > > > +       /* Offset in Memory Window */
> > > > > > +       uint64_t        moffset;
> > > > > > +};
> > > > > > +
> > > > > > +struct fuse_setupmapping_out {
> > > > > > +       /* Offsets into the cache of mappings */
> > > > > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > > > > +        /* Lengths of each mapping */
> > > > > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > > > > +};
> > > > >
> > > > > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
> > > >
> > > > This looks like leftover from the old code. I will get rid of it. Thanks.
> > > >
> > >
> > > Hmm. I wonder if we should keep some out args for future extensions.
> > > Maybe return the mapped size even though it is all or nothing at this
> > > point?
> > >
> > > I have interest in a similar FUSE mapping functionality that was prototyped
> > > by Miklos and published here:
> > > https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
> > >
> > > In this prototype, a FUSE_MAP command is used by the server to map a
> > > range of file to the kernel for io. The command in args are quite similar to
> > > those in fuse_setupmapping_in, but since the server is on the same host,
> > > the mapping response is {mapfd, offset, size}.
> >
> > Right.  So the difference is in which entity allocates the mapping.
> > IOW whether the {fd, offset, size} is input or output in the protocol.
> >
> > I don't remember the reasons for going with the mapping being
> > allocated by the client, not the other way round.   Vivek?
>
> I think one of the main reasons is memory reclaim. Once all ranges in
> a cache range are allocated, we need to free a memory range which can be
> reused. And client has all the logic to free up that range so that it can
> be remapped and reused for a different file/offset. Server will not know
> any of this. So I will think that for virtiofs, server might not be
> able to decide where to map a section of file and it has to be told
> explicitly by the client.

Okay.

> >
> > If the allocation were to be by the server, we could share the request
> > type and possibly some code between the two, although the I/O
> > mechanism would still be different.
> >
>
> So input parameters of both FUSE_SETUPMAPPING and FUSE_MAP seem
> similar (except the moffset field).  Given output of FUSE_MAP reqeust
> is very different, I would think it will be easier to have it as a
> separate command.
>
> Or can it be some sort of optional output args which can differentiate
> between two types of requests.
>
> /me personally finds it simpler to have separate command instead of
> overloading FUSE_SETUPMAPPING. But its your call. :-)

I too prefer a separate request type.

Thanks,
Miklos
