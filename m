Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0067AF56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjAYKJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 05:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjAYKJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:09:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09634C06
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674641286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITYkPWXk42gwxNi7ucWyzm4+8wZnJwRiJKMXieVl4b8=;
        b=ftzfBBZe3Mu2gtUPK41FhLSI+udkv+l0UCLqG5UkblUNfVLoJHh/5cER8gXiQ34YROCKQJ
        mHsWmxSl0tHNOdog+e1hHhPsDiqRz8zW6XwzglebD0Oyj+I8P6nkL6ft7uz4Uo3du4XpCO
        bn+O1XbPS0+Bayi78EM15Cl0GC/gk2g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-R_ayUXFrPe-DqNU9ajPvDg-1; Wed, 25 Jan 2023 05:08:05 -0500
X-MC-Unique: R_ayUXFrPe-DqNU9ajPvDg-1
Received: by mail-ej1-f69.google.com with SMTP id qw29-20020a1709066a1d00b008725a1034caso11890596ejc.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 02:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITYkPWXk42gwxNi7ucWyzm4+8wZnJwRiJKMXieVl4b8=;
        b=NgI2X2+omGQZ42WONcNBJGVBOKOs0JSPAo1kytWuiHHC/BnpcS0cMnyvcZR2kIQiMY
         jHW55ZmNizYFlAYh7Po2Rztkvvl5sbzIxxC5tQT2EXI2swI6r/bXjLFjKxNlyM6Kcv7l
         +7ML9JEncYmbTndyJVymG15N1IHutlcGYZ/vP8RKZSpT+ZybJSK2MRZURiduKAPens7f
         Cwp3tXbXyKciDrNMUgafqKuENgxBVsEtAyfsjYOtb6Fk+4HirwCUvAxPcNKkOCZEcQ5N
         N8AzB64RmF5IWJ3szi3A5OgjN2CPsZ3P0XQzuLzQ+6r/IzrHTijyZcrrkV/oxN142Ksk
         ENmQ==
X-Gm-Message-State: AFqh2krt1hnbTKFqjNHGYo/RIcneEXF3tgTpgdRuU47Is2B99jo8bBrh
        O43MQY8SNj9ujHaPu0QlUFRfxwqd99OR8EsYC0RM/Bitg5LRu7P9oPvOOT8BNUVU5MF7B/5Jjzh
        QOJEdD93JVn49D3gMH4VHGHQ9Aw==
X-Received: by 2002:a17:907:2064:b0:871:5065:613a with SMTP id qp4-20020a170907206400b008715065613amr33417932ejb.47.1674641283951;
        Wed, 25 Jan 2023 02:08:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRtf653Hh8BS5B1zI6z5doE5m1cm/W6/O4HVSN8uT7dQRr8nHUEoiIwBkhdCl47sb5Wp8qxA==
X-Received: by 2002:a17:907:2064:b0:871:5065:613a with SMTP id qp4-20020a170907206400b008715065613amr33417909ejb.47.1674641283746;
        Wed, 25 Jan 2023 02:08:03 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id ia24-20020a170907a07800b00877696c015asm2157032ejc.134.2023.01.25.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:08:03 -0800 (PST)
Message-ID: <ef68afb508f85eebb40fa3926edbff145e831c63.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Jan 2023 11:08:02 +0100
In-Reply-To: <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
         <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
         <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
         <20230125041835.GD937597@dread.disaster.area>
         <CAOQ4uxhqdjRbNFs_LohwXdTpE=MaFv-e8J3D2R57FyJxp_f3nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-01-25 at 10:32 +0200, Amir Goldstein wrote:
> On Wed, Jan 25, 2023 at 6:18 AM Dave Chinner <david@fromorbit.com>
> wrote:
> >=20
> >=20
> >=20
> > I've already described the real world production system bottlenecks
> > that composefs is designed to overcome in a previous thread.
> >=20
> > Please go back an read this:
> >=20
> > https://lore.kernel.org/linux-fsdevel/20230118002242.GB937597@dread.dis=
aster.area/
> >=20
>=20
> I've read it and now re-read it.
> Most of the post talks about the excess time of creating the
> namespace,
> which is addressed by erofs+overlayfs.
>=20
> I guess you mean this requirement:
> "When you have container instances that might only be needed for a
> few seconds, taking half a minute to set up the container instance
> and then another half a minute to tear it down just isn't viable -
> we need instantiation and teardown times in the order of a second or
> two."
>=20
> Forgive for not being part of the containers world, so I have to ask
> -
> Which real life use case requires instantiation and teardown times in
> the order of a second?
>
> What is the order of number of files in the manifest of those
> ephemeral
> images?
>=20
> The benchmark was done on a 2.6GB centos9 image.

What does this matter? We want to measure a particular kind of
operation, so, we use a sample with a lot of those operations. What
would it help running some operation on a smaller image that does much
less of the critical operations. That would just make it harder to see
the data for all the noise. Nobody is saying that reading all the
metadata in a 2.6GB image is something a container would do. It is
however doing lots of the operations that constrains container startup,
and it allows us to compare the performance of these operation between
different alternatives.

> My very minimal understanding of containers world, is that
> A large centos9 image would be used quite often on a client so it
> would be deployed as created inodes in disk filesystem
> and the ephemeral images are likely to be small changes
> on top of those large base images.
>=20
> Furthermore, the ephmeral images would likely be composed
> of cenos9 + several layers, so the situation of single composefs
> image as large as centos9 is highly unlikely.
>=20
> Am I understanding the workflow correctly?

In a composefs based container storage implementation one would likely
not use a layered approach for the "derived" images. Since all file
content is shared anyway its more useful to just combine the metadata
of the layers into a single composefs image. It is not going to be very
large anyway, and it will make lookups much faster as you don't need to
do all the negative lookups in the upper layers when looking for files
in the base layer.

> If I am, then I would rather see benchmarks with images
> that correspond with the real life use case that drives composefs,
> such as small manifests and/or composefs in combination with
> overlayfs as it would be used more often.

I feel like there is a constant moving of the goal post here. I've
provided lots of raw performance numbers, and explained that they are
important to our usecases, there has to be an end to how detailed they
need to be. I'm not interested in implementing a complete container
runtime based on overlayfs just to show that it performs poorly.

> > Cold cache performance dominates the runtime of short lived
> > containers as well as high density container hosts being run to
> > their container level memory limits. `ls -lR` is just a
> > microbenchmark that demonstrates how much better composefs cold
> > cache behaviour is than the alternatives being proposed....
> >=20
> > This might also help explain why my initial review comments
> > focussed
> > on getting rid of optional format features, straight lining the
> > processing, changing the format or search algorithms so more
> > sequential cacheline accesses occurred resulting in less memory
> > stalls, etc. i.e. reductions in cold cache lookup overhead will
> > directly translate into faster container workload spin up.
> >=20
>=20
> I agree that this technology is novel and understand why it results
> in faster cold cache lookup.
> I do not know erofs enough to say if similar techniques could be
> applied to optimize erofs lookup at mkfs.erofs time, but I can guess
> that this optimization was never attempted.

> > > > >=20
On the contrary, erofs lookup is very similar to composefs. There is
nothing magical about it, we're talking about pre-computed, static
lists of names. What you do is you sort the names, put them in a
compact seek-free form, and then you binary search on them. Composefs
v3 has some changes to make larger directories slightly more efficient
(no chunking), but the general performance should be comparable.

I believe Gao said that mkfs.erofs could do slightly better at how data
arranged so that related things are closer to each other. That may help
some, but I don't think this is gonna be a massive difference.
> > > > >=20

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a short-sighted guerilla filmmaker with a winning smile and a way=20
with the ladies. She's a scantily clad mutant magician's assistant
living=20
on borrowed time. They fight crime!=20

