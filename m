Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6863664635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 17:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjAJQfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 11:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjAJQeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB4848C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673368402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMKV6nf2FFKubT9BPJN4AKDdipkI2cilqJuASvqNxbk=;
        b=JYrZWBa81zySDGlQ5qBCgOAQQvfARMtG4G7524pB8nxqR8IJ66Yjtbz8ydrvhthEaJli1n
        mQJpZRK27hi/866QH77mXKAX9XAkYdr1Uyb+wNxAG8Y6mE8e0FTAiwZ1B3rtrK48fy0m5G
        MH1PEFwZMODUvVs3dnqceMkLYRHfg5E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-F7ZDCsW6Nb61ZmtBcKPbwQ-1; Tue, 10 Jan 2023 11:33:15 -0500
X-MC-Unique: F7ZDCsW6Nb61ZmtBcKPbwQ-1
Received: by mail-lj1-f200.google.com with SMTP id s12-20020a2eb8cc000000b0027f6f40eeb3so2974762ljp.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 08:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMKV6nf2FFKubT9BPJN4AKDdipkI2cilqJuASvqNxbk=;
        b=xM3ZBGErFpf/WlxJIgQZ9X7XgaWjG1kbO029eCLm+E4O8XaMVw/5GOnjKeqrDpUfvP
         5SluvCRv6nn49mYDrc+gdhTzw/5KR8s9wI6vrW9/6mmP/Q/dyBFVHDXsDSs74c3ALATG
         Fct47VsLaR4qWnPIQ5NQ52U4e6Z07C4xpNMGlqvNf4Hm1HQ0GJ2/rEId11iPrUq3OAqr
         1qUDNoSwcm/c6InC1VNeEOkNZNUqP0D8gNSJcTBpnX6+m0oJOnLkHq3R2qOL3UTGXsMX
         i4+1JCPo4+ZC+exHf855oDrde/YBoX0OVPxfVFa9wVtA/a0+t0ZKucvEUqWA/roVLRjF
         A08A==
X-Gm-Message-State: AFqh2kptFosbgYDqng93BrfWk4JHK6vvgQjzCToaQFkIH/eGKjGdpFW4
        ZEuta72Zs+RsBZUB2iETrTSWSTFiKJM2OXxAphTjlaYYXbajPOLM0qCjAdgUfRmy0PGJVkSDZTQ
        OaQuLMpUdKGpPt6Lthens9EsNIQ==
X-Received: by 2002:a2e:9609:0:b0:286:6ae7:5068 with SMTP id v9-20020a2e9609000000b002866ae75068mr1299107ljh.26.1673368394087;
        Tue, 10 Jan 2023 08:33:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsc4Vr7VOL/Bd+eo+RY+RfRURHU0GJUp4dwwFoaFZu+5XTMPaXKMMR/spyAPXjHu6ANH3oUog==
X-Received: by 2002:a2e:9609:0:b0:286:6ae7:5068 with SMTP id v9-20020a2e9609000000b002866ae75068mr1299102ljh.26.1673368393912;
        Tue, 10 Jan 2023 08:33:13 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id p11-20020a2eb98b000000b0027fed440702sm1362364ljp.98.2023.01.10.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:33:13 -0800 (PST)
Message-ID: <3e491cfe02590cf5fce49851cf8fa040e0a4c8f6.camel@redhat.com>
Subject: Re: [PATCH 3/6] composefs: Add descriptor parsing code
From:   Alexander Larsson <alexl@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Date:   Tue, 10 Jan 2023 17:33:12 +0100
In-Reply-To: <Y7cszNNvHHUef2qO@x1>
References: <cover.1669631086.git.alexl@redhat.com>
         <1c4c49fac5bb6406a8cb55ca71f8060703aa63f6.1669631086.git.alexl@redhat.com>
         <Y7cszNNvHHUef2qO@x1>
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

On Thu, 2023-01-05 at 15:02 -0500, Brian Masney wrote:
> On Mon, Nov 28, 2022 at 12:16:59PM +0100, Alexander Larsson wrote:
> > This adds the code to load and decode the filesystem descriptor
> > file
> > format.
> >=20
> >=20
> > +#define CFS_N_PRELOAD_DIR_CHUNKS 4
>=20
> From looking through the code it appears that this is actually the
> maximum number of chunks. Should this be renamed from PRELOAD to MAX?
>=20

No, this is the number of directory chunks we statically pre-load while
loading the inode. If there are more (i.e. for larger directories) we
load chunks dynamically as needed during the directory operations.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->magic =3D cfs_u32_fr=
om_file(header->magic);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->data_offset =3D cfs_=
u64_from_file(header-
> > >data_offset);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->root_inode =3D cfs_u=
64_from_file(header->root_inode);
>=20
> Should the cpu to little endian conversion occur in cfs_read_data()?

cfs_read_data() reads just a block of opaque data. It can't know which
parts make up individual values to convert.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (header->magic !=3D CFS_M=
AGIC ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header->d=
ata_offset > ctx.descriptor_len ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(st=
ruct cfs_header_s) + header->root_inode >
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.descriptor_len) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0res =3D -EINVAL;
>=20
> Should this be -EFSCORRUPTED?
>=20

I don't think so. I can see the argument for it, but at this point we
just looked at a file based on a mount argument, and it seems
completely wrong (not just corrupt in the middle). Reporting EINVAL in
the mount syscall for "invalid argument" seems more right to me.


> >=20
> > +static void *cfs_get_vdata_buf(struct cfs_context_s *ctx, u64
> > offset, u32 len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cfs_buf *buf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (offset > ctx->descriptor=
_len - ctx->header.data_offset)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len > ctx->descriptor_le=
n - ctx->header.data_offset -
> > offset)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
>=20
> It appears that these same checks are already done in cfs_get_buf().
>=20

Not quite. It is true that we check in cfs_get_buf() that the arguments
are not completely outside the file. However, this part checks that the
offset is specifically within the vdata part of the file. In
particular, if we rely on the checks in cfs_get_buf() we could get
confused if the below data_offset + offset wrapped.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return cfs_get_buf(ctx, ctx-=
>header.data_offset + offset,
> > len, buf);
> > +}


>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ino->flags =3D cfs_read_u32(=
&data);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode_size =3D cfs_inode_enc=
oded_size(ino->flags);
>=20
> Should CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD also be accounted for in
> cfs_inode_encoded_size()?

No, that flag just means that the already existing payload (which
contains the pathname for the backing data) should be used as the
source for the digest (to avoid storing it twice). It doesn't take up
any extra space otherwise.

> Also, cfs_inode_encoded_size() is only used here so can be brought
> into this file.
>=20

I see this as sort of part of the filesystem on-disk format, so I
rather have it in the cfs.h header with the rest of the fs definition.

>=20
> > +static bool cfs_validate_filename(const char *name, size_t
> > name_len)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (name_len =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (name_len =3D=3D 1 && nam=
e[0] =3D=3D '.')
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (name_len =3D=3D 2 && nam=
e[0] =3D=3D '.' && name[1] =3D=3D '.')
>=20
> Can strcmp() be used here?
>=20

name is not zero-terminated, so I don't think so. At least not in any
natural way.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inode_data->has_digest =3D r=
et !=3D 0;
>=20
> Can you do 'has_digest =3D inode_data->digest !=3D NULL;' to get rid of
> the need for return 1 in cfs_get_digest().

No, because ->digest is an in-line array, not a pointer.

> > +static inline int memcmp2(const void *a, const size_t a_size,
> > const void *b,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 size_t b_size)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t common_size =3D min(a=
_size, b_size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int res;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D memcmp(a, b, common_=
size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res !=3D 0 || a_size =3D=
=3D b_size)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return res;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return a_size < b_size ? -1 =
: 1;
>=20
> This function appears to be used only in one place below. It doesn't
> seem like it matters for the common_size. Can this just be dropped
> and use memcmp()?

Not sure what you mean by this. This is used as a sort/order function,
not just as an "is-the-same" check, so we have to report e.g. that
"prefixXYZ" is after "prefix". In other words, this is essentially
strcmp(), but the strings are not zero terminated.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a deeply religious Amish hairdresser who hides his scarred face=20
behind a mask. She's a mentally unstable gypsy bodyguard in the witness
protection program. They fight crime!=20

