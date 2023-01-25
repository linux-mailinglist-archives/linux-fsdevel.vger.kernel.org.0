Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D746C67AF7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 11:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjAYKQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjAYKQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3124491
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674641763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5qeGFKBSRr+kwZlDb48jnVzaPiHRNkZlEPfgWj2/lw=;
        b=B7GHKRzNxvxGohaNQ9J3nkXB1pKWKgXYg7Xbf/w+v1SoGxWS1EhHGSp4JsuBl+e43NYse6
        vZXm7reI/qE5rppxvbCRNB699JNAB7AsKE0s7LQxijMmsbHV0gGegEOwJ54czcGD8Xp96e
        EsLihWwJlZCbc0UwVoiucOWFW3jXH3k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-dIYtIcHbPPS849YqmSJvyw-1; Wed, 25 Jan 2023 05:16:02 -0500
X-MC-Unique: dIYtIcHbPPS849YqmSJvyw-1
Received: by mail-ed1-f69.google.com with SMTP id q20-20020a056402519400b0049e5b8c71b3so12570119edd.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 02:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5qeGFKBSRr+kwZlDb48jnVzaPiHRNkZlEPfgWj2/lw=;
        b=KnQpSUGaSGejUR6TDOGWHEz7dzWKDqdK1yhggwCKvTYoECFt0OicILJr2fvlo/H6My
         /uhyheMMxmxJ433Jttbc+xcN5VXF/MwNVe48nXYk0UnqLjg2N7wLAKz9+YwctNK1gBWR
         L1ICo25XFc1MF53dip8NHo0XcFoUz6CpJCMnIs5RJ8c4zQHbBX0tZkMv6TpCeEG4UhYd
         DNhAFOnB/eQD/JnSA+eXYIYi3k8Fp39Iy0OCyZ9yToXl9lQcN4txo7nmg1FTgY4p2B/l
         6uOOhY4cJTSK9o/j+d4TYtMHQbt4oDj8m3wjO9nucopvGnHFeDeLl7/1ySMoEi2BsCiC
         OjTA==
X-Gm-Message-State: AFqh2krMsA29AKKhdGa4HSMjMliVf71xiL+kerR/HTpZDaou4RqHnrSo
        O3hPpS06jWSBYESlE5kIOaMS3G61ecpbLUdOkqsj/5PMlo+M8gyeGkgltr7JxKR70Tgnfpl8b46
        ogkmZ3S41GWaaDEX1im59ZKqs7A==
X-Received: by 2002:a17:906:ced0:b0:870:5ed6:74b4 with SMTP id si16-20020a170906ced000b008705ed674b4mr32453488ejb.61.1674641761452;
        Wed, 25 Jan 2023 02:16:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsz/EIskzfmm3gedIZzqyypQVO/xKGeWVH2p8YM0BX8XO8y15Ts7QahD4qr5ZRrSyziktbNww==
X-Received: by 2002:a17:906:ced0:b0:870:5ed6:74b4 with SMTP id si16-20020a170906ced000b008705ed674b4mr32453475ejb.61.1674641761274;
        Wed, 25 Jan 2023 02:16:01 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b0084c62b7b7d8sm2121300ejc.187.2023.01.25.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:16:00 -0800 (PST)
Message-ID: <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Jan 2023 11:15:59 +0100
In-Reply-To: <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
         <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
         <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
         <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
         <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
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

On Wed, 2023-01-25 at 18:05 +0800, Gao Xiang wrote:
>=20
>=20
> On 2023/1/25 17:37, Alexander Larsson wrote:
> > On Tue, 2023-01-24 at 21:06 +0200, Amir Goldstein wrote:
> > > On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson
> > > <alexl@redhat.com>
>=20
> ...
>=20
> > > >=20
> > > > They are all strictly worse than squashfs in the above testing.
> > > >=20
> > >=20
> > > It's interesting to know why and if an optimized mkfs.erofs
> > > mkfs.ext4 would have done any improvement.
> >=20
> > Even the non-loopback mounted (direct xfs backed) version performed
> > worse than the squashfs one. I'm sure a erofs with sparse files
> > would
> > do better due to a more compact file, but I don't really see how it
> > would perform significantly different than the squashfs code. Yes,
> > squashfs lookup is linear in directory length, while erofs is
> > log(n),
> > but the directories are not so huge that this would dominate the
> > runtime.
> >=20
> > To get an estimate of this I made a broken version of the erofs
> > image,
> > where the metacopy files are actually 0 byte size rather than
> > sparse.
> > This made the erofs file 18M instead, and gained 10% in the cold
> > cache
> > case. This, while good, is not near enough to matter compared to
> > the
> > others.
> >=20
> > I don't think the base performance here is really much dependent on
> > the
> > backing filesystem. An ls -lR workload is just a measurement of the
> > actual (i.e. non-dcache) performance of the filesystem
> > implementation
> > of lookup and iterate, and overlayfs just has more work to do here,
> > especially in terms of the amount of i/o needed.
>=20
> I will form a formal mkfs.erofs version in one or two days since
> we're
> cerebrating Lunar New year now.
>=20
> Since you don't have more I/O traces for analysis, I have to do
> another
> wild guess.
>=20
> Could you help benchmark your v2 too? I'm not sure if such
> performance also exists in v2.=C2=A0 The reason why I guess as this is
> that it seems that you read all dir inode pages when doing the first
> lookup, it can benefit to seq dir access.
>=20
> I'm not sure if EROFS can make a similar number by doing forcing
> readahead on dirs to read all dir data at once as well.
>=20
> Apart from that I don't see significant difference, at least
> personally
> I'd like to know where it could have such huge difference.=C2=A0 I don't
> think that is all because of read-only on-disk format differnce.

I think the performance difference between v2 and v3 would be rather
minor in this case, because I don't think a lot of the directories are
large enough to be split in chunks. I also don't believe erofs and
composefs should fundamentally differ much in performance here, given
that both use a compact binary searchable layout for dirents. However,
the full comparison is "composefs" vs "overlayfs + erofs", and in that
case composefs wins.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an obese Catholic messiah who knows the secret of the alien=20
invasion. She's a provocative Bolivian single mother living on borrowed
time. They fight crime!=20

