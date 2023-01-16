Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAB66BC5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjAPLBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 06:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAPLA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BF1A95A
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 03:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673866808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xb4MUUiTpK7w8tFqzemDfEEoqYW+yZ8y6ombY2yLlSM=;
        b=CYKzFZajVNMBYBpyyoABXrIckjCS6gBlubp1T8Y9dvyA2eCNJIioqoSGPhrMJ0MEbv6EtM
        XpY9JjQfhKB/yyE3QWZWDH6J/Fme+UixKZWIPMOt9AChuBqZmY/jLSUZjQhvGCEGKNGwGq
        nSmZVj7gEVtsJJuR5u3NyqL7iOUWIBI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-_swOyU0xOXSOvsRCv1Oy6g-1; Mon, 16 Jan 2023 06:00:07 -0500
X-MC-Unique: _swOyU0xOXSOvsRCv1Oy6g-1
Received: by mail-lf1-f72.google.com with SMTP id y26-20020a0565123f1a00b004b4b8aabd0cso10347153lfa.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 03:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xb4MUUiTpK7w8tFqzemDfEEoqYW+yZ8y6ombY2yLlSM=;
        b=iveeKm86mh8Py2+qH86TedMNquYoPxJ1BIpevvLfnll2edrcvQ5CO+v/F+yY/cNO19
         IencSqruwBCSBScMg1vGu6uJ7F5LbgWoE/Lx4CG5PEYisaXv2gAjcZlGy+gE+5dNCZQC
         gQkFqlXHSsbRxSHihP1h9kkUUfoVFv021BdJs2WFuSCDV+1w8npoVestXGZeXquAhb3x
         Li/KWErdSpXtSDqquwBv/82nDoWR0szl8ekqvIHW0+4kOvTwTe5T01yZNaD0CRgEoaBP
         SUSWodfcnQzz+FXTm8w0/Wcf8TeO2ysbzr+Sw08BTX8BK5dto4r1fRSU9SONEt/ZqFLF
         XRmg==
X-Gm-Message-State: AFqh2koyXmIckoIM7JIMu/iO+Tg0QIeltIUhpwjaHX2qCHv78PrCeSPe
        BTtwjk5s22jqendbRgKP64bJu8eRqXsZOLLyC0C4+0CLfT5ul9qRss81AdkppjcgZS1xq0TjLei
        2Wh0AVqsw7389h3KdPqo/vbZsNg==
X-Received: by 2002:a05:6512:3053:b0:4d5:7be5:ba22 with SMTP id b19-20020a056512305300b004d57be5ba22mr721650lfb.58.1673866805668;
        Mon, 16 Jan 2023 03:00:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0diSnwlgoGqWkDapj391PD2WahbcvM1aTCb3z25vKe3m8OLjk14ZaLOgwFLm3e6E1OnEiHQ==
X-Received: by 2002:a05:6512:3053:b0:4d5:7be5:ba22 with SMTP id b19-20020a056512305300b004d57be5ba22mr721640lfb.58.1673866805208;
        Mon, 16 Jan 2023 03:00:05 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b004a2c447598fsm871289lfr.159.2023.01.16.03.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:00:04 -0800 (PST)
Message-ID: <fe2e39b16d42ca871428e508935f1aa21608b4ee.camel@redhat.com>
Subject: Re: [PATCH v2 2/6] composefs: Add on-disk layout
From:   Alexander Larsson <alexl@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Mon, 16 Jan 2023 12:00:03 +0100
In-Reply-To: <20230116012904.GJ2703033@dread.disaster.area>
References: <cover.1673623253.git.alexl@redhat.com>
         <819f49676080b05c1e87bff785849f0cc375d245.1673623253.git.alexl@redhat.com>
         <20230116012904.GJ2703033@dread.disaster.area>
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

On Mon, 2023-01-16 at 12:29 +1100, Dave Chinner wrote:
> On Fri, Jan 13, 2023 at 04:33:55PM +0100, Alexander Larsson wrote:
> > This commit adds the on-disk layout header file of composefs.
>=20
> This isn't really a useful commit message.
>=20
> Perhaps it should actually explain what the overall goals of the
> on-disk format are - space usage, complexity trade-offs, potential
> issues with validation of variable payload sections, etc.
>=20

I agree, will flesh it out. But, as for below discussions, one of the
overall goals is to keep the on-disk file size low.

> > Signed-off-by: Alexander Larsson <alexl@redhat.com>
> > Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > ---
> > =C2=A0fs/composefs/cfs.h | 203
> > +++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 203 insertions(+)
> > =C2=A0create mode 100644 fs/composefs/cfs.h
> >=20
> > diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
> > new file mode 100644
> > index 000000000000..658df728e366
> > --- /dev/null
> > +++ b/fs/composefs/cfs.h
> > @@ -0,0 +1,203 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * composefs
> > + *
> > + * Copyright (C) 2021 Giuseppe Scrivano
> > + * Copyright (C) 2022 Alexander Larsson
> > + *
> > + * This file is released under the GPL.
> > + */
> > +
> > +#ifndef _CFS_H
> > +#define _CFS_H
> > +
> > +#include <asm/byteorder.h>
> > +#include <crypto/sha2.h>
> > +#include <linux/fs.h>
> > +#include <linux/stat.h>
> > +#include <linux/types.h>
> > +
> > +#define CFS_VERSION 1
>=20
> This should start with a description of the on-disk format for the
> version 1 format.

There are some format descriptions in the later document patch. What is
the general approach here, do we document in the header, or in separate
doc file? For example, I don't see much of format descriptions in the
xfs headers. I mean, I should probably add *some* info here for easier
reading of the stuff below, but I don't feel like headers are a great
place for docs.

> > +
> > +#define CFS_MAGIC 0xc078629aU
> > +
> > +#define CFS_MAX_DIR_CHUNK_SIZE 4096
> > +#define CFS_MAX_XATTRS_SIZE 4096
>=20
> How do we store 64kB xattrs in this format if the max attr size is
> 4096 bytes? Or is that the maximum total xattr storage?

This is a current limitation of the composefs file format. I am aware
that the kernel maximum size is 64k, but I'm not sure what use this
would have in a read-only filesystem image in practice. I could extend
this limit with some added complextity, but would it be worth the
increase in complexity?

> A comment telling us what these limits are would be nice.
>=20

Sure.

> > +
> > +static inline int cfs_digest_from_payload(const char *payload,
> > size_t payload_len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u8
> > digest_out[SHA256_DIGEST_SIZE])
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *p, *end;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 last_digit =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int digit =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t n_nibbles =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* This handles payloads (i.=
e. path names) that are
> > "essentially" a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * digest as the digest (if =
the DIGEST_FROM_PAYLOAD flag is
> > set). The
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * "essential" part means th=
at we ignore hierarchical
> > structure as well
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as any extension. So, for=
 example "ef/deadbeef.file"
> > would match the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (too short) digest "efdea=
dbeef".
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows images to avo=
id storing both the digest and
> > the pathname,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * yet work with pre-existin=
g object store formats of
> > various kinds.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end =3D payload + payload_le=
n;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (p =3D payload; p !=3D e=
nd; p++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Skip subdir structure */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (*p =3D=3D '/')
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0contin=
ue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Break at (and ignore) extension */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (*p =3D=3D '.')
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (n_nibbles =3D=3D SHA256_DIGEST_SIZE * 2)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EINVAL; /* Too long */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0digit =3D hex_to_bin(*p);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (digit =3D=3D -1)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EINVAL; /* Not hex digit */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0n_nibbles++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ((n_nibbles % 2) =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0digest=
_out[n_nibbles / 2 - 1] =3D (last_digit
> > << 4) | digit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0last_digit =3D digit;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (n_nibbles !=3D SHA256_DI=
GEST_SIZE * 2)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL; /* Too short */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
>=20
> Too big to be a inline function.
>=20

Yeah, I'm aware of this. I mainly put it in the header as the
implementation of it is sort of part of the on-disk format. But, I can
move it to a .c file instead.


> > +
> > +struct cfs_vdata_s {
>=20
> Drop the "_s" suffix to indicate the type is a structure - that's
> waht "struct" tells us.

Sure.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 len;
>=20
> If these are on-disk format structures, why aren't the defined as
> using the specific endian they are encoded in? i.e. __le64, __le32,
> etc? Otherwise a file built on a big endian machine won't be
> readable on a little endian machine (and vice versa).

On disk all fields are little endian. However, when we read them from
disk we convert them using e.g. le32_to_cpu(), and then we use the same
structure in memory, with native endian. So, it seems wrong to mark
them as little endian.

>=20
> > +} __packed;
> > +
> > +struct cfs_header_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 version;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 unused1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 unused2;
>=20
> Why are you hyper-optimising these structures for minimal space
> usage? This is 2023 - we can use a __le32 for the version number,
> the magic number and then leave....
>
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 magic;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 data_offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 root_inode;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 unused3[2];
>=20
> a whole heap of space to round it up to at least a CPU cacheline
> size using something like "__le64 unused[15]".
>=20
> That way we don't need packed structures nor do we care about having
> weird little holes in the structures to fill....

Sure.

> > +} __packed;
> > +
> > +enum cfs_inode_flags {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_NONE =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_PAYLOAD =3D =
1 << 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_MODE =3D 1 <=
< 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_NLINK =3D 1 =
<< 2,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_UIDGID =3D 1=
 << 3,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_RDEV =3D 1 <=
< 4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_TIMES =3D 1 =
<< 5,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_TIMES_NSEC =
=3D 1 << 6,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_LOW_SIZE =3D=
 1 << 7, /* Low 32bit of st_size
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_HIGH_SIZE =
=3D 1 << 8, /* High 32bit of
> > st_size */
>=20
> Why do we need to complicate things by splitting the inode size
> like this?
>=20

The goal is to minimize the image size for a typical rootfs or
container image. Almost zero files in any such images are > 4GB.=C2=A0

Also, we don't just "not decode" the items with the flag not set, they
are not even stored on disk.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_XATTRS =3D 1=
 << 9,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_DIGEST =3D 1=
 << 10, /* fs-verity sha256
> > digest */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CFS_INODE_FLAGS_DIGEST_FROM_=
PAYLOAD =3D 1 << 11, /* Compute
> > digest from payload */
> > +};
> > +
> > +#define CFS_INODE_FLAG_CHECK(_flag,
> > _name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((_flag) & (CFS_INODE_FLAGS=
_##_name)) !=3D 0)
>=20
> Check what about a flag? If this is a "check that a feature is set",
> then open coding it better, but if you must do it like this, then
> please use static inline functions like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cfs_inode_has_xattrs(=
inode->flags)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.....
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20

The check is if the flag is set, so maybe CFS_INODE_FLAG_IS_SET is a
better name. This is used only when decoding the on-disk version of the
inode to the in memory one, which is a bunch of:

	if (CFS_INODE_FLAG_CHECK(ino->flags, THE_FIELD))
		ino->the_field =3D cfs_read_u32(&data);
	else
		ino->the_field =3D THE_FIELD_DEFUALT;

I can easily open-code these checks, although I'm not sure it makes a
great difference either way.

> > +#define CFS_INODE_FLAG_CHECK_SIZE(_flag, _name,
> > _size)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(CFS_INODE_FLAG_CHECK(_flag,=
 _name) ? (_size) : 0)
>=20
> This doesn't seem particularly useful, because you've still got to
> test is the return value is valid. i.e.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size =3D CFS_INODE_FLAG_C=
HECK_SIZE(inode->flags, XATTRS, 32);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (size =3D=3D 32) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* got xattrs, decode! */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> vs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cfs_inode_has_xattrs(=
inode->flags)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* decode! */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

This macro is only uses by the cfs_inode_encoded_size() function that
computes the size of the on-disk format of an inode, given its flags:

static inline u32 cfs_inode_encoded_size(u32 flags)
{
	return sizeof(u32) /* flags */ +
	       CFS_INODE_FLAG_CHECK_SIZE(flags, PAYLOAD, sizeof(u32))
+
	       CFS_INODE_FLAG_CHECK_SIZE(flags, MODE, sizeof(u32)) +
	       CFS_INODE_FLAG_CHECK_SIZE(flags, NLINK, sizeof(u32)) +
...

It is only useful in the sense that it makes this function easy to
read/write. I should maybe move the definion of the macro to that
function.

>=20
> > +
> > +#define CFS_INODE_DEFAULT_MODE 0100644
> > +#define CFS_INODE_DEFAULT_NLINK 1
> > +#define CFS_INODE_DEFAULT_NLINK_DIR 2
> > +#define CFS_INODE_DEFAULT_UIDGID 0
> > +#define CFS_INODE_DEFAULT_RDEV 0
> > +#define CFS_INODE_DEFAULT_TIMES 0
>=20
> Where do these get used? Are they on disk defaults or something
> else? (comment, please!)

They are the defaults that are used when inode fields on disk are
missing. I'll add some comments.

> > +struct cfs_inode_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 flags;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Optional data: (selected =
by flags) */
>=20
> WHy would you make them optional given that all the fields are still
> defined in the structure?
>=20
> It's much simpler just to decode the entire structure into memory
> than to have to check each flag value to determine if a field needs
> to be decoded...
>=20

I guess I need to clarify these comments a bit, but they are optional
on-disk, and decoded and extended with the above defaults by
cfs_get_ino_index() when read into memory. So, they are not optional in
memory.


> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* This is the size of the t=
ype specific data that comes
> > directly after
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the inode in the file. Of=
 this type:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * directory: cfs_dir_s
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * regular file: the backing=
 filename
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * symlink: the target link
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Canonically payload_lengt=
h is 0 for empty
> > dir/file/symlink.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 payload_length;
>=20
> How do you have an empty symlink?

In terms of the file format, empty would mean a zero length target
string. But you're right that this isn't allowed. I'll change this
comment.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_mode; /* File type an=
d mode.=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_nlink; /* Number of h=
ard links, only for regular
> > files.=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_uid; /* User ID of ow=
ner.=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_gid; /* Group ID of o=
wner.=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_rdev; /* Device ID (i=
f special file).=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 st_size; /* Size of file=
, only used for regular files
> > */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cfs_vdata_s xattrs; /=
* ref to variable data */
>=20
> This is in the payload that follows the inode?=C2=A0 Is it included in
> the payload_length above?
>=20
> If not, where is this stuff located, how do we validate it points to
> the correct place in the on-disk format file, the xattrs belong to
> this specific inode, etc? I think that's kinda important to
> describe, because xattrs often contain important security
> information...

No, all inodes are packed into the initial part of the file, each
containing a flags set, a variable size (from flags) chunk of fixed
size elements and an variable size payload. The payload is either the
target symlink for symlinks, or the path of the backing file for
regular files. Other data, such as xattrs and dirents are stored in a
separate part of the file and the offsets for those in the inode refer
to offsets into that area.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 digest[SHA256_DIGEST_SIZE=
]; /* fs-verity digest */
>=20
> Why would you have this in the on-disk structure, then also have
> "digest from payload" that allows the digest to be in the payload
> section of the inode data?

The payload is normally the path to the backing file, and then you need
to store the verity digest separately. This is what would be needed
when using this with ostree for instance, because we have an existing
backing file repo format we can't change. However, if your backing
store files are stored by their fs-verity digest already (which is the
default for mkcomposefs), then we can set this flag and avoid storing
the digest unnecessary.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct timespec64 st_mtim; /=
* Time of last modification.=C2=A0
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct timespec64 st_ctim; /=
* Time of last status change.=C2=A0
> > */
> > +};
>=20
> This really feels like an in-memory format inode, not an on-disk
> format inode, because this:
>=20
> > +
> > +static inline u32 cfs_inode_encoded_size(u32 flags)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sizeof(u32) /* flags =
*/ +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, PAYLOAD,
> > sizeof(u32)) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, MODE, sizeof(u32))
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, NLINK, sizeof(u32))
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, UIDGID, sizeof(u32)
> > + sizeof(u32)) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, RDEV, sizeof(u32))
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES, sizeof(u64)
> > * 2) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES_NSEC,
> > sizeof(u32) * 2) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, LOW_SIZE,
> > sizeof(u32)) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, HIGH_SIZE,
> > sizeof(u32)) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, XATTRS, sizeof(u64)
> > + sizeof(u32)) +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CFS_INODE_FLAG_CHECK_SIZE(flags, DIGEST,
> > SHA256_DIGEST_SIZE);
> > +}
>=20
> looks like the on-disk format is an encoded format hyper-optimised
> for minimal storage space usage?

Yes.


> Without comments to explain it, I'm not exactly sure what is stored
> in the on-disk format inodes, nor the layout of the variable
> payload section or how payload sections are defined and verified.
>=20
> Seems overly complex to me - it's far simpler just to have a fixed
> inode structure and just decode it directly into the in-memory
> structure when it is read....

We have a not-fixed-size on disk inode structure (for size reasons)
which we decode directly into the above in-memory structure when read.
So I don't think we're that far from what you expect. However, yes,
this could easily be explained better.

>=20
> > +struct cfs_dentry_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Index of struct cfs_inode=
_s */
>=20
> Not a useful (or correct!) comment :/

Its not really incorrect, but I agree its not neccessary a great
comment. At this specific offset in the inode section we can decode the
cfs_inode_s that this inode refers to, and his offset is also the inode
number of the inode.

> Also, the typical term for this on disk structure in a filesystem is
> a "dirent", and this is also what readdir() returns to userspace.
> dentry is typically used internally in the kernel to refer to the
> VFS cache layer objects, not the filesystem dirents the VFS layers
> look up to populate it's dentry cache.
>=20

Yeah, i'll rename it.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 inode_index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 d_type;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 name_offset;
>=20
> What's this name_offset refer to?=20

Dirents are stored in chunks, each chunk < 4k. These chunks are a list
of these dirents, followed by the strings for the names, the
name_offset is the offset from the start of the chunk to the name.

> > +} __packed;
> > +
> > +struct cfs_dir_chunk_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 n_dentries;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 chunk_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 chunk_offset;
>=20
> What's this chunk offset refer to?
>=20

This is the offset in the "variable data" section of the image. This
section follows the packed inode data section. Again, better comments
needed.

> > +} __packed;
> > +
> > +struct cfs_dir_s {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 n_chunks;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cfs_dir_chunk_s chunk=
s[];
> > +} __packed;
>=20
> So directory data is packed in discrete chunks? Given that this is a
> static directory format, and the size of the directory is known at
> image creation time, why does the storage need to be chunked?

We chunk the data such that each chunk fits inside a single page in the
image file. I did this to make accessing image data directly from the
page cache easier. We can just kmap_page_local() each chunk and treat
it as a non-split continuous dirent array, then move on to the next
chunk in the next page. If we had dirent data spanning multiple pages
then we would either need to map the pages consecutively (which seems
hard/costly) or have complex in-kernel code to handle the case where a
dirent straddles two pages.

> > +
> > +#define
> > cfs_dir_size(_n_chunks)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(sizeof(struct cfs_dir_s) + =
(_n_chunks) * sizeof(struct
> > cfs_dir_chunk_s))
>=20
> static inline, at least.
>=20
> Also, this appears to be the size of the encoded directory
> header, not the size of the directory itself. cfs_dir_header_size(),
> perhaps, to match the cfs_xattr_header_size() function that does the
> same thing?

Yeah, that makes sense.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a suicidal hunchbacked cyborg who knows the secret of the alien=20
invasion. She's a time-travelling out-of-work snake charmer with a song
in her heart and a spring in her step. They fight crime!=20

