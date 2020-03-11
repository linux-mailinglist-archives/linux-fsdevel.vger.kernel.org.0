Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483D1181167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgCKHDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 03:03:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45508 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKHDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:03:55 -0400
Received: by mail-io1-f65.google.com with SMTP id w9so793464iob.12;
        Wed, 11 Mar 2020 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hb6iJ/Efn6V2wxOcA+ehqPLCrGm2i7aFEcinNiAwTg=;
        b=rd8rhWCgH//f6swHt00TfU44oSyrPrCf9zNhKCp43xO5/c/lia8gyyB94BWGxKw6yV
         QOm0DqL9P4U5T2uB6Inj7XI/UlbsEfDNG3do1rbezI/44mNdmxVEQCDVkll8kGrYaAts
         AnQLHHVMbGjbmGMLgv1f/s/a2ayaX6Up7a8Mk/4/8kxlP++P1jSBtRfGYdv1fszrCbxB
         J4YKst/ZXrjqvQcelfdiL548nQVPzdxVY02bdopH9Vz+v97xEl+GHknDNi4r2tcrPYJy
         YXna9QlT8wDB2bvqb0c0qdd8LBkPPhhTwJblfNdloF3Yaj4tR2lznGCBm/Z0Trm4sqID
         A62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hb6iJ/Efn6V2wxOcA+ehqPLCrGm2i7aFEcinNiAwTg=;
        b=TX7LGqKGbxq1x76/M/8XNQL5kyj+DCfnxUWJg3toJsSTu54H90gp/KvgmWB5kwvM5h
         x0za7uKNM95b19RcgoCuPPGVt65D/tS/Zgf4DmhSswhuYawVAFxwRLIWRFYmbdScUnp5
         nEJo68k9lMJdqgDgCkNwQUk1iUHKMdYq0uHshSXG2/QF56M+CV/YlUfhA7i8p73hpZNd
         zQ36fIFEKxjymXmn8q6mnegtl6OU9HMi2jRNbnObAOC9QCmlGdIR3duvxaSmnFOmUeXC
         70TkusCaGFCNscOXKWO91dOY7wysHaOZpnC5cGD6YebpoEZajQ0Jv89LDcHJU3x7tiBy
         q6Ig==
X-Gm-Message-State: ANhLgQ0mrH0KxJfCVRGrpY1DW0O1JsU/Ras63fDjRLOaN9IIDc+u4L33
        ogIORnBht69iiwmHIu/sgK8l8U2eHoZ3wi4D/4s=
X-Google-Smtp-Source: ADFU+vsVx9UgJ7cAQ6SG+cvSpbW4652fcOa7BWrz3sf2jEUSFhkJmAIC862rB5+gVmJyC7VWx0RpfWNz15LQu2ii7R0=
X-Received: by 2002:a6b:f718:: with SMTP id k24mr1627720iog.186.1583910234416;
 Wed, 11 Mar 2020 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com> <20200310203321.GF38440@redhat.com>
In-Reply-To: <20200310203321.GF38440@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Mar 2020 09:03:42 +0200
Message-ID: <CAOQ4uxh2WdLdbcMp+qvQCX2hiBx+hLO1z5wkZtc-7GCuDdsthw@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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

On Tue, Mar 10, 2020 at 10:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Introduce two new fuse commands to setup/remove memory mappings. This
> > > will be used to setup/tear down file mapping in dax window.
> > >
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > ---
> > >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index 5b85819e045f..62633555d547 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> > >         uint64_t        flags;
> > >  };
> > >
> > > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > > +struct fuse_setupmapping_in {
> > > +       /* An already open handle */
> > > +       uint64_t        fh;
> > > +       /* Offset into the file to start the mapping */
> > > +       uint64_t        foffset;
> > > +       /* Length of mapping required */
> > > +       uint64_t        len;
> > > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > > +       uint64_t        flags;
> > > +       /* Offset in Memory Window */
> > > +       uint64_t        moffset;
> > > +};
> > > +
> > > +struct fuse_setupmapping_out {
> > > +       /* Offsets into the cache of mappings */
> > > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > > +        /* Lengths of each mapping */
> > > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > > +};
> >
> > fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.
>
> This looks like leftover from the old code. I will get rid of it. Thanks.
>

Hmm. I wonder if we should keep some out args for future extensions.
Maybe return the mapped size even though it is all or nothing at this
point?

I have interest in a similar FUSE mapping functionality that was prototyped
by Miklos and published here:
https://lore.kernel.org/linux-fsdevel/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/

In this prototype, a FUSE_MAP command is used by the server to map a
range of file to the kernel for io. The command in args are quite similar to
those in fuse_setupmapping_in, but since the server is on the same host,
the mapping response is {mapfd, offset, size}.

I wonder, if we decide to go forward with this prototype (and I may well decide
to drive this forward), should the new command be overloading
FUSE_SETUPMAPPING, by using new flags or should it be a new
command? In either case, I think it would be best to try and make a decision
now in order to avoid ambiguity with protocol command/flag names later on.

If we decide that those are completely different beasts and it is agreed that
the future command will be named, for example, FUSE_SETUPIOMAP
with different arguments and that this naming will not create confusion and
ambiguity with FUSE_SETUPMAPPING, then there is no actionable item at
this time.

But it is possible that there is something to gain from using the same
command(?) and same book keeping mechanism for both types of
mappings. Even server on same host could decide that it wants
to map some file regions via mmap and some via iomap.
In that case, perhaps we should make the FUSE_SETUPMAPPING
response args expressive enough to be able to express an iomap
mapping in the future and perhaps dax code should explicitly request
for FUSE_SETUPMAPPING_FLAG_DAX mapping type?

Thoughts?

Amir.
