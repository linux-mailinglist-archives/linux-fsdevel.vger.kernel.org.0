Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7466DD3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 13:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjAQMMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 07:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjAQMMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3FD241EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 04:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673957497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5XtL1iqrw6LnDCtbEWHa4n3B7viLGiRVHFAG+GnKds=;
        b=OZNwPQWyLKvLXh0Iu6ezoB09NRZW9vVnEiS3uAoXCDjrNmLe+kP0Al2b5PJ6QyB8fbQY8m
        x3VHkR2yliGAKyWdfTStHPhkPG3fyxqVTbgSmDbDlt+3yHdlKbfJmTjQddqsmSoRFmbcup
        ufuTfKaQ1A/KunxlYOe4nMiqwjelENs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-58opHwvDP5iYcqsqaGMMFw-1; Tue, 17 Jan 2023 07:11:36 -0500
X-MC-Unique: 58opHwvDP5iYcqsqaGMMFw-1
Received: by mail-ed1-f70.google.com with SMTP id e6-20020a056402190600b0048ee2e45daaso20930224edz.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 04:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5XtL1iqrw6LnDCtbEWHa4n3B7viLGiRVHFAG+GnKds=;
        b=OYfEr9io8SZRTF9n5SiunjNFLJZ8vyW+1FFONKLLPTZniowDtnYyeK6yuGb/PDXrNp
         Pdquki89NaesS45a6/413410Us0nWHal9WmHntnusfJISmdfAshz1m/PXfOo44xtKhRc
         U0OggDKN6Mcjfjxv5EbGXmyUT1LXbsla0X7PFsb+j/z5ZZlBfg5JdkDaVb+s5zchk0bf
         CeQ1DpJQ9bzw+cd0Hjxvi6RNXNkFqW4iFyb6ffq1Nb1+15zoNVF25coSF9EfxZblMjdW
         dbfcit7R25rPNbyru7X4kn9Y6pm3SZnMOi2ZQvsCFoTAxgQUcjhxAf9p3hWQFB2NjnZK
         QrIQ==
X-Gm-Message-State: AFqh2kqISn14y3oo5HZlvLnNBv9O7GuwZqPLvAr+8sbM0UiXO3sdHuoA
        KHtqSMNtGI94//24sR/NvvKN9jC0PZ0kORf1akSX4XRMq+PNqI2i5aXUwkNeOAltDFsABGz0M5M
        9l5ThgmM4GPhuQhQkkIcoSwLnXw==
X-Received: by 2002:a17:907:8d18:b0:7c0:d6b6:1ee9 with SMTP id tc24-20020a1709078d1800b007c0d6b61ee9mr2889592ejc.11.1673957495189;
        Tue, 17 Jan 2023 04:11:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuiCv5WtJIlAT5LZMOrBnTf0KOydcFksql7rU6v027fGH3Z2TmSAFVhGpfQqY6vVV7fTzrwGA==
X-Received: by 2002:a17:907:8d18:b0:7c0:d6b6:1ee9 with SMTP id tc24-20020a1709078d1800b007c0d6b61ee9mr2889575ejc.11.1673957494770;
        Tue, 17 Jan 2023 04:11:34 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402150600b0049622a61f8fsm12777348edw.30.2023.01.17.04.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:11:34 -0800 (PST)
Message-ID: <c0c928880f35b40f8231036d21251ae3efa340db.camel@redhat.com>
Subject: Re: [PATCH v2 2/6] composefs: Add on-disk layout
From:   Alexander Larsson <alexl@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 17 Jan 2023 13:11:33 +0100
In-Reply-To: <20230116230647.GK2703033@dread.disaster.area>
References: <cover.1673623253.git.alexl@redhat.com>
         <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
         <20230116012904.GJ2703033@dread.disaster.area>
         <fe2e39b16d42ca871428e508935f1aa21608b4ee.camel@redhat.com>
         <20230116230647.GK2703033@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-01-17 at 10:06 +1100, Dave Chinner wrote:
> On Mon, Jan 16, 2023 at 12:00:03PM +0100, Alexander Larsson wrote:
> > On Mon, 2023-01-16 at 12:29 +1100, Dave Chinner wrote:
> > > On Fri, Jan 13, 2023 at 04:33:55PM +0100, Alexander Larsson
> > > wrote:
> > > > This commit adds the on-disk layout header file of composefs.
> > >=20
> > > This isn't really a useful commit message.
> > >=20
> > > Perhaps it should actually explain what the overall goals of the
> > > on-disk format are - space usage, complexity trade-offs,
> > > potential
> > > issues with validation of variable payload sections, etc.
> > >=20
> >=20
> > I agree, will flesh it out. But, as for below discussions, one of
> > the
> > overall goals is to keep the on-disk file size low.
> >=20
> > > > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > > > Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > > > ---
> > > > =C2=A0fs/composefs/cfs.h | 203
> > > > +++++++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A01 file changed, 203 insertions(+)
> > > > =C2=A0create mode 100644 fs/composefs/cfs.h
> > > >=20
> > > > diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
> > > > new file mode 100644
> > > > index 000000000000..658df728e366
> > > > --- /dev/null
> > > > +++ b/fs/composefs/cfs.h
> > > > @@ -0,0 +1,203 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * composefs
> > > > + *
> > > > + * Copyright (C) 2021 Giuseppe Scrivano
> > > > + * Copyright (C) 2022 Alexander Larsson
> > > > + *
> > > > + * This file is released under the GPL.
> > > > + */
> > > > +
> > > > +#ifndef _CFS_H
> > > > +#define _CFS_H
> > > > +
> > > > +#include <asm/byteorder.h>
> > > > +#include <crypto/sha2.h>
> > > > +#include <linux/fs.h>
> > > > +#include <linux/stat.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#define CFS_VERSION 1
> > >=20
> > > This should start with a description of the on-disk format for
> > > the
> > > version 1 format.
> >=20
> > There are some format descriptions in the later document patch.
> > What is
> > the general approach here, do we document in the header, or in
> > separate
> > doc file? For example, I don't see much of format descriptions in
> > the
> > xfs headers. I mean, I should probably add *some* info here for
> > easier
> > reading of the stuff below, but I don't feel like headers are a
> > great
> > place for docs.
>=20
> it's fine to describe the format in the docs, but when reading the
> code there needs to at least an overview of the structure the code
> is implementing so that the code makes some sense without having to
> go find the external place the format is documented.

Yeah, I'll try to make format in the next series be overall more
commented.

> > >=20
> > > > +#define CFS_MAGIC 0xc078629aU
> > > > +
> > > > +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> > > > +#define CFS_MAX_XATTRS_SIZE 4096
> > >=20
> > > How do we store 64kB xattrs in this format if the max attr size
> > > is
> > > 4096 bytes? Or is that the maximum total xattr storage?
> >=20
> > This is a current limitation of the composefs file format.
>=20
> Yes, but is that 4kB limit the maximum size of a single xattr, or is
> it the total xattr storage space for an inode?

Currently it is actually the total xattrs storage. I've never seen any
container images or rootfs images in general use any large amount of
xattrs. However, given the below discussion on multi-page mappings
maybe its possible to easily drop this limit.

> > I am aware
> > that the kernel maximum size is 64k,
>=20
> For a single xattr, yes. Hence my question....
>=20
> > > > +static inline int cfs_digest_from_payload(const char *payload,
> > > > size_t payload_len,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 u8
> > > > digest_out[SHA256_DIGEST_SIZE])
> .....
> > > Too big to be a inline function.
> >=20
> > Yeah, I'm aware of this. I mainly put it in the header as the
> > implementation of it is sort of part of the on-disk format. But, I
> > can
> > move it to a .c file instead.
>=20
> Please do - it's really part of the reader implementation, not the
> structure definition.
>=20
> > > > +struct cfs_vdata_s {
> > >=20
> > > Drop the "_s" suffix to indicate the type is a structure - that's
> > > waht "struct" tells us.
> >=20
> > Sure.
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 off;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 len;
> > >=20
> > > If these are on-disk format structures, why aren't the defined as
> > > using the specific endian they are encoded in? i.e. __le64,
> > > __le32,
> > > etc? Otherwise a file built on a big endian machine won't be
> > > readable on a little endian machine (and vice versa).
> >=20
> > On disk all fields are little endian. However, when we read them
> > from
> > disk we convert them using e.g. le32_to_cpu(), and then we use the
> > same
> > structure in memory, with native endian. So, it seems wrong to mark
> > them as little endian.
>=20
> Then these structures do not define "on-disk format". Looking a bit
> further through the patchset, these are largely intermediate
> structures that are read once to instatiate objects in memory, then
> never used again. The cfs_inode_s is a good example of this - I'll
> come back to that.

The header/superblock is actually just read from the fs as-is, as are
most of the other structures. Only the inode data is packed.

> > > > +} __packed;
> > > > +
> > > > +struct cfs_header_s {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 version;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 unused1;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 unused2;
> > >=20
> > > Why are you hyper-optimising these structures for minimal space
> > > usage? This is 2023 - we can use a __le32 for the version number,
> > > the magic number and then leave....
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 magic;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 data_offset;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 root_inode;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 unused3[2];
> > >=20
> > > a whole heap of space to round it up to at least a CPU cacheline
> > > size using something like "__le64 unused[15]".
> > >=20
> > > That way we don't need packed structures nor do we care about
> > > having
> > > weird little holes in the structures to fill....
> >=20
> > Sure.
>=20
> FWIW, now I see how this is used, this header kinda defines what
> we'd call the superblock in the on-disk format of a filesystem. It's
> at a fixed location in the image file, so there should be a #define
> somewhere in this file to document it's fixed location.

It is at offset zero. I don't really think that needs a define, does
it? Maybe a comment though.

> Also, if this is the in-memory representation of the structure and
> not the actual on-disk format, why does it even need padding,
> packing or even store the magic number?

In this case it is the on-disk format though.

> i.e. this information could simply be stored in a few fields in the
> cfs
> superblock structure that wraps the vfs superblock, and the
> superblock read function could decode straight into those fields...

We just read this header from disk, validate the magic and then convert
the fields to native endian, then the few used fields (data_offset and
root_inode) to the vfs superblock structure.


> > > > +} __packed;
> > > > +
> > > > +enum cfs_inode_flags {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_NONE =3D=
 0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_PAYLOAD =
=3D 1 << 0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_MODE =3D=
 1 << 1,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_NLINK =
=3D 1 << 2,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_UIDGID =
=3D 1 << 3,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_RDEV =3D=
 1 << 4,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_TIMES =
=3D 1 << 5,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_TIMES_NS=
EC =3D 1 << 6,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_LOW_SIZE=
 =3D 1 << 7, /* Low 32bit of
> > > > st_size
> > > > */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_HIGH_SIZ=
E =3D 1 << 8, /* High 32bit of
> > > > st_size */
> > >=20
> > > Why do we need to complicate things by splitting the inode size
> > > like this?
> > >=20
> >=20
> > The goal is to minimize the image size for a typical rootfs or
> > container image. Almost zero files in any such images are > 4GB.=C2=A0
>=20
> Sure, but how much space does this typically save, versus how much
> complexity it adds to runtime decoding of inodes?
>=20
> I mean, in a dense container system the critical resources that need
> to be saved is runtime memory and CPU overhead of operations, not
> the storage space. Saving a 30-40 bytes of storage space per inode
> means a typical image might ber a few MB smaller, but given the
> image file is not storing data we're only talking about images the
> use maybe 500 bytes of data per inode. Storage space for images
> is not a limiting factor, nor is network transmission (because
> compression), so it comes back to runtime CPU and memory usage.

Here are some example sizes of composefs images with the current packed
inodes:=20

6.2M cs9-developer-rootfs.composefs
2.1M cs9-minimal-rootfs.composefs
1.2M fedora-37-container.composefs
433K ubuntu-22.04-container.composefs

If we set all the flags for the inodes (i.e. fixed size inodes) we get:

8.8M cs9-developer-rootfs.composefs
3.0M cs9-minimal-rootfs.composefs
1.6M fedora-37-container.composefs
625K ubuntu-22.04-container.composefs

So, images are about 40% larger with fixed size inodes.

> The inodes are decoded out of the page cache, so the memory for the
> raw inode information is volatile and reclaimed when needed.
> Similarly, the VFS inode built from this information is reclaimable
> when not in use, too. So the only real overhead for runtime is the
> decoding time to find the inode in the image file and then decode
> it.

I disagree with this characterization. It is true that page cache is
volatile, but if you can fit 40% less inode data in the page cache then
there is additional overhead where you need to read this from disk. So,
decoding time is not the only thing that affects overhead.

Additionally, just by being larger and less dense, more data has to be
read from disk, which itself is slower.

> Given the decoding of the inode -all branches- and is not
> straight-line code, it cannot be well optimised and the CPU branch
> predictor is not going to get it right every time. Straight line
> code that decodes every field whether it is zero or not is going to
> be faster.
>
> Further, with a fixed size inode in the image file, the inode table
> can be entirely fixed size, getting rid of the whole unaligned data
> retreival problem that code currently has (yes, all that
> "le32_to_cpu(__get_unaligned(__le32, data)" code) because we can
> ensure that all the inode fields are aligned in the data pages. This
> will significantly speed up decoding into the in-memory inode
> structures.

I agree it could be faster. But is inode decode actually the limiting
factor, compared to things like disk i/o or better use of page cache?

> And to take it another step, the entire struct cfs_inode_s structure
> could go away - it is entirely a temporary structure used to shuffle
> data from the on-disk encoded format to the the initialisation of
> the VFS inode. The on-disk inode data could be decoded directly into
> the VFS inode after it has been instantiated, rather than decoding
> the inode from the backing file and the instantiating the in-memory
> inode.
>=20
> i.e. instead of:
>=20
> cfs_lookup()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_dir_lookup(&index)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_get_ino_index(index, =
&inode_s)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0cfs_get_inode_data_max(index, &data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode_s->st_.... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode_s->st_.... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode_s->st_.... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode_s->st_.... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_make_inode(inode_s, &=
vfs_inode)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode =3D new_inode(sb)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D inode_s->st_....;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D inode_s->st_....;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D inode_s->st_....;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D inode_s->st_....;
>=20
> You could collapse this straight down to:
>=20
> cfs_lookup()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_dir_lookup(&index)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_make_inode(index, &vf=
s_inode)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode =3D new_inode(sb)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0cfs_get_inode_data_max(index, &data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D cfs_read_....(&data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0inode->i_... =3D cfs_read_....(&data);
>=20
> This removes an intermediately layer from the inode instantiation
> fast path completely. ANd if the inode table is fixed size and
> always well aligned, then the cfs_make_inode() code that sets up the
> VFS inode is almost unchanged from what it is now. There are no new
> branches, the file image format is greatly simplified, and the
> runtime overhead of instantiating inodes is significantly reduced.

I'm not sure the performance win is clear compared to the extra size,
as generally inodes are only decoded once and kept around in memory for
most of its use. However, I agree that there are clear advantages in
simplifying the format. That makes it easier to maintain and
understand. I'll give this some thought.

> Similar things can be done with the rest of the "descriptor"
> abstraction - the intermediate in-memory structures can be placed
> directly in the cfs_inode structure that wraps the VFS inode, and
> the initialisation of them can call the decoding code directly
> instead of using intermediate structures as is currently done.
>=20
> This will remove a chunk of code from the implemenation and make it
> run faster....
>=20
> > Also, we don't just "not decode" the items with the flag not set,
> > they
> > are not even stored on disk.
>=20
> Yup, and I think that is a mistake - premature optimisation and all
> that...
>=20
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_XATTRS =
=3D 1 << 9,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_DIGEST =
=3D 1 << 10, /* fs-verity sha256
> > > > digest */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_DIGEST_F=
ROM_PAYLOAD =3D 1 << 11, /*
> > > > Compute
> > > > digest from payload */
> > > > +};
> > > > +
> > > > +#define CFS_INODE_FLAG_CHECK(_flag,
> > > > _name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((_flag) & (CFS_INODE_F=
LAGS_##_name)) !=3D 0)
> > >=20
> > > Check what about a flag? If this is a "check that a feature is
> > > set",
> > > then open coding it better, but if you must do it like this, then
> > > please use static inline functions like:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cfs_inode_has_xat=
trs(inode->flags)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.....
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> >=20
> > The check is if the flag is set, so maybe CFS_INODE_FLAG_IS_SET is
> > a
> > better name. This is used only when decoding the on-disk version of
> > the
> > inode to the in memory one, which is a bunch of:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (CFS_INODE_FLAG_CHEC=
K(ino->flags, THE_FIELD))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ino->the_field =3D cfs_read_u32(&data);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ino->the_field =3D THE_FIELD_DEFUALT;
> >=20
> > I can easily open-code these checks, although I'm not sure it makes
> > a
> > great difference either way.
>=20
> If they are used only once, then it should be open coded. But I
> think the whole "optional inode fields" stuff should just go away
> entirely at this point...
>=20
> > > > +#define CFS_INODE_DEFAULT_MODE 0100644
> > > > +#define CFS_INODE_DEFAULT_NLINK 1
> > > > +#define CFS_INODE_DEFAULT_NLINK_DIR 2
> > > > +#define CFS_INODE_DEFAULT_UIDGID 0
> > > > +#define CFS_INODE_DEFAULT_RDEV 0
> > > > +#define CFS_INODE_DEFAULT_TIMES 0
> > >=20
> > > Where do these get used? Are they on disk defaults or something
> > > else? (comment, please!)
> >=20
> > They are the defaults that are used when inode fields on disk are
> > missing. I'll add some comments.
>=20
> They go away entirely with fixed size on-disk inodes.
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_mode; /* File typ=
e and mode.=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_nlink; /* Number =
of hard links, only for regular
> > > > files.=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_uid; /* User ID o=
f owner.=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_gid; /* Group ID =
of owner.=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_rdev; /* Device I=
D (if special file).=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 st_size; /* Size of =
file, only used for regular
> > > > files
> > > > */
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cfs_vdata_s xattr=
s; /* ref to variable data */
> > >=20
> > > This is in the payload that follows the inode?=C2=A0 Is it included i=
n
> > > the payload_length above?
> > >=20
> > > If not, where is this stuff located, how do we validate it points
> > > to
> > > the correct place in the on-disk format file, the xattrs belong
> > > to
> > > this specific inode, etc? I think that's kinda important to
> > > describe, because xattrs often contain important security
> > > information...
> >=20
> > No, all inodes are packed into the initial part of the file, each
> > containing a flags set, a variable size (from flags) chunk of fixed
> > size elements and an variable size payload. The payload is either
> > the
> > target symlink for symlinks, or the path of the backing file for
> > regular files.
>=20
> Ok, I think you need to stop calling that a "payload", then. It's
> the path name to the backing file. The backing file is only relevant
> for S_IFREG and S_IFLINK types - directories don't need path names
> as they only contain pointers to other inodes in the image file.
> Types like S_IFIFO, S_IFBLK, etc should not have backing files,
> either - they should just be instantiated as the correct type in the
> VFS inode and not require any backing file interactions at all...
>=20
> Hence I think this "payload" should be called something like
> "backing path" or something similar.

Yeah, that may be better.

>=20
> .....
>=20
> > > > +struct cfs_dir_s {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 n_chunks;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cfs_dir_chunk_s c=
hunks[];
> > > > +} __packed;
> > >=20
> > > So directory data is packed in discrete chunks? Given that this
> > > is a
> > > static directory format, and the size of the directory is known
> > > at
> > > image creation time, why does the storage need to be chunked?
> >=20
> > We chunk the data such that each chunk fits inside a single page in
> > the
> > image file. I did this to make accessing image data directly from
> > the
> > page cache easier.
>=20
> Hmmmm. So you defined a -block size- that matched the x86-64 -page
> size- to avoid page cache issues.=C2=A0 Now, what about ARM or POWER
> which has 64kB page sizes?
>=20
> IOWs, "page size" is not the same on all machines, whilst the
> on-disk format for a filesystem image needs to be the same on all
> machines. Hence it appears that this:
>=20
> > > > +#define CFS_MAX_DIR_CHUNK_SIZE 4096
>=20
> should actually be defined in terms of the block size for the
> filesystem image, and this size of these dir chunks should be
> recorded in the superblock of the filesystem image. That way it
> is clear that the image has a specific chunk size, and it also paves
> the way for supporting more efficient directory structures using
> larger-than-page size chunks in future.

Yes, its true that assuming a (min) 4k page size is wasteful on some
arches, but it would be hard to read a filesystem created for 64k pages
on a 4k page machine, which is not ideal. However, wrt your commend on
multi-page mappings, maybe we can just totally drop these limits. I'll
have a look at that.

> > If we had dirent data spanning multiple pages
> > then we would either need to map the pages consecutively (which
> > seems
> > hard/costly) or have complex in-kernel code to handle the case
> > where a
> > dirent straddles two pages.
>=20
> Actually pretty easy - we do this with XFS for multi-page directory
> buffers. We just use vm_map_ram() on a page array at the moment,
> but in the near future there will be other options based on
> multipage folios.
>=20
> That is, the page cache now stores folios rather than pages, and is
> capable of using contiguous multi-page folios in the cache. As a
> result, multipage folios could be used to cache multi-page
> structures in the page cache and efficiently map them as a whole.
>=20
> That mapping code isn't there yet - kmap_local_folio() only maps the
> page within the folio at the offset given - but the foundation is
> there for supporting this functionality natively....
>=20
> I certainly wouldn't be designing a new filesystem these days that
> has it's on-disk format constrained by the x86-64 4kB page size...

Yes, I agree. I'm gonna look at using multi-page mapping for both
dirents and xattr data, which should completely drop these limits, as
well as get rid of the dirent chunking.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a witless playboy firefighter fleeing from a secret government=20
programme. She's a ditzy streetsmart socialite from the wrong side of
the=20
tracks. They fight crime!=20

