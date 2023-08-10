Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209C777A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjHJOIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHJOIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:08:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432F1B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:08:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcc0adab4so135895366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1691676526; x=1692281326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqsJpU7LFb3GLTAfKEbp8lhEqnnez3erI34FjCCVUt0=;
        b=oLBy2DGzKYdHZux1tS2W41KakaRW9SY0HZKBF7I2HLFTkVO5Em4dedsZCSvSJSlmZG
         qb8UbIz1WxgIzdx4tY99yIV+vqbTlmN23UamoaqNNDm+SAUwAd+tqsGflKDTQts6RCTR
         y60S3Gk0QeD0XjAU41PdqS6T08XDbrEAfOoo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676526; x=1692281326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqsJpU7LFb3GLTAfKEbp8lhEqnnez3erI34FjCCVUt0=;
        b=LwjOP5stbQVhCM8vaL7mROjQB9M3nu36QGtm3M4P2Uv5pozBIFLmixq4vxkCir3w3s
         Ys7YQbee+d2+aD03CsnesgvwZ+QvQAT8HLvoOTu29Ub9yeESlMo4Yfsu4dUvHPecJMFF
         CVsEk5n+vHJjD/v+JHceC9XsaLdIbYOaRxzhkuDVTvKItehySI5ArkSwSyjU5ZCP3mbM
         FJF54WYy/NEdJ4LC1x7awWwScqPib6xQUVqT+II1LpZsojtVJds4M/x+UVobrloiwlcy
         e0EPak0XURJ4+uNWB1dGzTWrWOA1EzjdtvcOc3yH7aflVbR84wzMP/qLmX9b0iHbTv1/
         soAg==
X-Gm-Message-State: AOJu0YxH+emsqXB25L0Snb6qllU6JnU5wqtjHYECc+8mMZJ1TkCWxBu9
        wwDpznvcLVsxNcXhA25MeRh5rEPzfuJ5WJDzDxXCsg==
X-Google-Smtp-Source: AGHT+IEh9Byy+qklcNWdN5y35mnUr0YKMoeLeOg+FRbqCdBL0HqzUOAgQm6FExfxXyWJpFL9rLwyWD2o3LjRCJkm5EI=
X-Received: by 2002:a17:906:3101:b0:99c:40f2:a402 with SMTP id
 1-20020a170906310100b0099c40f2a402mr2229590ejx.6.1691676525853; Thu, 10 Aug
 2023 07:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230810105501.1418427-1-mszeredi@redhat.com> <20230810105501.1418427-3-mszeredi@redhat.com>
 <e7979772-7e7b-9078-7b25-24e5bdb91342@fastmail.fm>
In-Reply-To: <e7979772-7e7b-9078-7b25-24e5bdb91342@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Aug 2023 16:08:34 +0200
Message-ID: <CAJfpegugchRF8JagD7-zViQVeT_7-h33F+AvpmHhr8FHUcZ4sg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: add STATX request
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Aug 2023 at 15:23, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/10/23 12:54, Miklos Szeredi wrote:
> > Use the same structure as statx.
>
> Wouldn't it be easier to just include struct statx? Or is there an issue
> with __u32, etc? If so, just a sufficiently large array could be used
> and statx values just mem-copied in/out?

<linux/uapi/fuse.h> is OS independent.  Ports can grab it and use it
in their userspace and kernel implementations.


>
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >   include/uapi/linux/fuse.h | 56 ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 55 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index b3fcab13fcd3..fe700b91b33b 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -207,6 +207,9 @@
> >    *  - add FUSE_EXT_GROUPS
> >    *  - add FUSE_CREATE_SUPP_GROUP
> >    *  - add FUSE_HAS_EXPIRE_ONLY
> > + *
> > + *  7.39
> > + *  - add FUSE_STATX and related structures
> >    */
> >
> >   #ifndef _LINUX_FUSE_H
> > @@ -242,7 +245,7 @@
> >   #define FUSE_KERNEL_VERSION 7
> >
> >   /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 38
> > +#define FUSE_KERNEL_MINOR_VERSION 39
> >
> >   /** The node ID of the root inode */
> >   #define FUSE_ROOT_ID 1
> > @@ -269,6 +272,40 @@ struct fuse_attr {
> >       uint32_t        flags;
> >   };
> >
> > +/*
> > + * The following structures are bit-for-bit compatible with the statx(2) ABI in
> > + * Linux.
> > + */
> > +struct fuse_sx_time {
> > +     int64_t         tv_sec;
> > +     uint32_t        tv_nsec;
> > +     int32_t         __reserved;
> > +};
> > +
> > +struct fuse_statx {
> > +     uint32_t        mask;
> > +     uint32_t        blksize;
> > +     uint64_t        attributes;
> > +     uint32_t        nlink;
> > +     uint32_t        uid;
> > +     uint32_t        gid;
> > +     uint16_t        mode;
> > +     uint16_t        __spare0[1];
> > +     uint64_t        ino;
> > +     uint64_t        size;
> > +     uint64_t        blocks;
> > +     uint64_t        attributes_mask;
> > +     struct fuse_sx_time     atime;
> > +     struct fuse_sx_time     btime;
> > +     struct fuse_sx_time     ctime;
> > +     struct fuse_sx_time     mtime;
> > +     uint32_t        rdev_major;
> > +     uint32_t        rdev_minor;
> > +     uint32_t        dev_major;
> > +     uint32_t        dev_minor;
> > +     uint64_t        __spare2[14];
> > +};
>
> Looks like some recent values are missing?

It doesn't matter, since those parts are not used.

>
>         /* 0x90 */
>         __u64   stx_mnt_id;
>         __u32   stx_dio_mem_align;      /* Memory buffer alignment for direct I/O */
>         __u32   stx_dio_offset_align;   /* File offset alignment for direct I/O */
>         /* 0xa0 */
>         __u64   __spare3[12];   /* Spare space for future expansion */
>         /* 0x100 */
>
> Which is basically why my personal preference would be not to do have a
> copy of the struct - there is maintenance overhead.

Whenever the new fields would be used in the kernel the fields can be
added.  So no need to continually update the one in fuse, since those
fields cannot be referenced by the kernel.   Userspace might actually
access those fields through struct statx, but that's okay, the
interface was designed so that the producer and consumer can use
different versions of the API.

Thanks,
Miklos
