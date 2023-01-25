Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11267AE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjAYJiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 04:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYJiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82807269E
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674639436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0j8GrShoX4pmRlaiX1pJw4zz7YnrGd9rUZWbwEPFn0=;
        b=OxRcfGUOOaghzcJsTcIP7grWAGYLfqIMa6PzFtvbEJ5qfDXdZmHjKRkIxj6TmI5MxLCyNu
        FVf7ewWClT0uHu9oeVRZ+DVswgRou9V5uc3t5QofXk3evWbcuAv7QJULvjZzU4aIORr+k5
        3Mzzn89mc5Zyw/sTsx0twmXb4TW9CnI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-YiDK6UphPaOHvtEp_UoPvA-1; Wed, 25 Jan 2023 04:37:14 -0500
X-MC-Unique: YiDK6UphPaOHvtEp_UoPvA-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b0049e1b5f6175so12443966edb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 01:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0j8GrShoX4pmRlaiX1pJw4zz7YnrGd9rUZWbwEPFn0=;
        b=XWvAtOHtS43584gLQdpm8iVdc2e1vy+MzwFeZSsWAnBvxDY9QxMgAI3cETCdh1/wNt
         b6NzmrAh9BOAf8yG29z1VA6rb/upC6ByhLsQs/6mFrHyAWxqPhMaFg6GEmRxnfj/TocO
         EmeKPWDV7r7vtBvjg9Tl5DjnyfHEyawTaJqDEpreTnQMuAHAWySxAmGImyNDC+lIG8u5
         GL1Lw8q9kn+mS7wLNeaS7yMckWBR5vHCGpOQSJbSPVRjXTJ1jL06gpicu/2w3D3q+8Ww
         jj/tg2U06t/RcPA/bjr0exuZH5Tx7jV8CpwFS/D503frA3QaNUL+jm7L6U/B3nu+miwt
         /Z1A==
X-Gm-Message-State: AFqh2kpzLfb3wwKjrwQRkCS/151saBfQvR6KUxAnoeDRDvynD3mNjRrJ
        kRlaa8IfqqKGYvBcHJL8Vdy9STa4cvF2cTo+D8fgoaFao9EDYEHH0MyC78avD8HPKfpkJp7g3Au
        E07yqgoNgkRGukwqs9fkH4vCR6g==
X-Received: by 2002:a17:906:78b:b0:7c1:9b07:32cd with SMTP id l11-20020a170906078b00b007c19b0732cdmr32865626ejc.39.1674639433399;
        Wed, 25 Jan 2023 01:37:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6UdfWRTfu/Jdd+TLR7w31rIEujCmn60idYvfiZSjr1D5repPJn/i9HGLnHShpGth252eJhQ==
X-Received: by 2002:a17:906:78b:b0:7c1:9b07:32cd with SMTP id l11-20020a170906078b00b007c19b0732cdmr32865594ejc.39.1674639433024;
        Wed, 25 Jan 2023 01:37:13 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id fx18-20020a170906b75200b0084d35ffbc20sm2137074ejb.68.2023.01.25.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:37:12 -0800 (PST)
Message-ID: <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Jan 2023 10:37:11 +0100
In-Reply-To: <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
         <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
         <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
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

On Tue, 2023-01-24 at 21:06 +0200, Amir Goldstein wrote:
> On Tue, Jan 24, 2023 at 3:13 PM Alexander Larsson <alexl@redhat.com>
> wrote:
> >=20
> > For the uncached case, composefs is still almost four times faster
> > than
> > the fastest overlay combo (squashfs), and the non-squashfs versions
> > are
> > strictly slower. For the cached case the difference is less (10%)
> > but
> > with similar order of performance.
> >=20
> > For size comparison, here are the resulting images:
> >=20
> > 8.6M large.composefs
> > 2.5G large.erofs
> > 200M large.ext4
> > 2.6M large.squashfs
> >=20
>=20
> Nice.
> Clearly, mkfs.ext4 and mkfs.erofs are not optimized for space.

For different reasons. Ext4 is meant to be writable post creation, so
it makes different choices wrt on-disk layout. Erofs is due to the lack
of sparse files, so when it copied the sparse files into it they were
made huge files full of zeros.

> Note that Android has make_ext4fs which can create a compact
> ro ext4 image without a journal.
> Found this project that builds it outside of Android, but did not
> test:
> https://github.com/iglunix/make_ext4fs

It doesn't seem to support either whiteout files or sparse files.

> > > > # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR
> > > > ovl-
> > > > mount"
> > > > Benchmark 1: ls -lR ovl-mount
> > > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.7=
38 s =C2=B1=C2=A0 0.029 s=C2=A0=C2=A0=C2=A0 [User: 0.176 s,
> > > > System: 1.688 s]
> > > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 2.699 s =E2=80=
=A6=C2=A0 2.787 s=C2=A0=C2=A0=C2=A0 10 runs
> > > >=20
> > > > With page cache between runs the difference is smaller, but
> > > > still
> > > > there:
> > >=20
> > > It is the dentry cache that mostly matters for this test and
> > > please
> > > use hyerfine -w 1 to warmup dentry cache for correct measurement
> > > of warm cache lookup.
> >=20
> > I'm not sure why the dentry cache case would be more important?
> > Starting a new container will very often not have cached the image.
> >=20
> > To me the interesting case is for a new image, but with some
> > existing
> > page cache for the backing files directory. That seems to model
> > staring
> > a new image in an active container host, but its somewhat hard to
> > test
> > that case.
> >=20
>=20
> ok, you can argue that faster cold cache ls -lR is important
> for starting new images.
> I think you will be asked to show a real life container use case
> where
> that benchmark really matters.
> >=20

My current work is in automotive, which wants to move to a
containerized workload in the car. The primary KPI is cold boot
performance, because there are legal requirements for the entire system
to boot in 2 seconds.=C2=A0It is also quite typical to have shortlived
containers in cloud workloads, and startup time there is very
important. In fact, the last few months I've been primarily spending on
optimizing container startup performance (as can be seen in the massive
improvements to this in the upcoming podman 4.4).

I'm obviously not saying that containers will actually recursively list
the container contents on start. However they will do all sorts of cold
cache metadata operation to resolve library dependencies, find config
files, etc. Just strace any typical userspace app and see for yourself.
A ls -lR is a simplified version of this kind of workload.

> > > I guess these test runs started with warm cache? but it wasn't
> > > mentioned explicitly.
> >=20
> > Yes, they were warm (because I ran the previous test before it).
> > But,
> > the new profile script explicitly adds -w 1.
> >=20
> > > > # hyperfine "ls -lR cfs-mnt"
> > > > Benchmark 1: ls -lR cfs-mnt
> > > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 390.1 ms =
=C2=B1=C2=A0=C2=A0 3.7 ms=C2=A0=C2=A0=C2=A0 [User: 140.9 ms,
> > > > System: 247.1 ms]
> > > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 381.5 ms =E2=80=A6 39=
3.9 ms=C2=A0=C2=A0=C2=A0 10 runs
> > > >=20
> > > > vs
> > > >=20
> > > > # hyperfine -i "ls -lR ovl-mount"
> > > > Benchmark 1: ls -lR ovl-mount
> > > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 431.5 ms =
=C2=B1=C2=A0=C2=A0 1.2 ms=C2=A0=C2=A0=C2=A0 [User: 124.3 ms,
> > > > System: 296.9 ms]
> > > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 429.4 ms =E2=80=A6 43=
3.3 ms=C2=A0=C2=A0=C2=A0 10 runs
> > > >=20
> > > > This isn't all that strange, as overlayfs does a lot more work
> > > > for
> > > > each lookup, including multiple name lookups as well as several
> > > > xattr
> > > > lookups, whereas composefs just does a single lookup in a pre-
> > > > computed
> > >=20
> > > Seriously, "multiple name lookups"?
> > > Overlayfs does exactly one lookup for anything but first level
> > > subdirs
> > > and for sparse files it does the exact same lookup in /objects as
> > > composefs.
> > > Enough with the hand waving please. Stick to hard facts.
> >=20
> > With the discussed layout, in a stat() call on a regular file,
> > ovl_lookup() will do lookups on both the sparse file and the
> > backing
> > file, whereas cfs_dir_lookup() will just map some page cache pages
> > and
> > do a binary search.
> >=20
> > Of course if you actually open the file, then cfs_open_file() would
> > do
> > the equivalent lookups in /objects. But that is often not what
> > happens,
> > for example in "ls -l".
> >=20
> > Additionally, these extra lookups will cause extra memory use, as
> > you
> > need dentries and inodes for the erofs/squashfs inodes in addition
> > to
> > the overlay inodes.
> >=20
>=20
> I see. composefs is really very optimized for ls -lR.
> Now only need to figure out if real users start a container and do ls
> -lR
> without reading many files is a real life use case.

A read-only filesystem does basically two things: metadata lookups and
file content loading. Composefs hands off the content loading to the
backing filesystem, so obviously then the design will focus on the
remaining part. So, yes, this means optimizing for "ls -lR".

> > > > table. But, given that we don't need any of the other features
> > > > of
> > > > overlayfs here, this performance loss seems rather unnecessary.
> > > >=20
> > > > I understand that there is a cost to adding more code, but
> > > > efficiently
> > > > supporting containers and other forms of read-only images is a
> > > > pretty
> > > > important usecase for Linux these days, and having something
> > > > tailored
> > > > for that seems pretty useful to me, even considering the code
> > > > duplication.
> > > >=20
> > > >=20
> > > >=20
> > > > I also understand Cristians worry about stacking filesystem,
> > > > having
> > > > looked a bit more at the overlayfs code. But, since composefs
> > > > doesn't
> > > > really expose the metadata or vfs structure of the lower
> > > > directories it
> > > > is much simpler in a fundamental way.
> > > >=20
> > >=20
> > > I agree that composefs is simpler than overlayfs and that its
> > > security
> > > model is simpler, but this is not the relevant question.
> > > The question is what are the benefits to the prospect users of
> > > composefs
> > > that justify this new filesystem driver if overlayfs already
> > > implements
> > > the needed functionality.
> > >=20
> > > The only valid technical argument I could gather from your email
> > > is -
> > > 10% performance improvement in warm cache ls -lR on a 2.6 GB
> > > centos9 rootfs image compared to overlayfs+squashfs.
> > >=20
> > > I am not counting the cold cache results until we see results of
> > > a modern ro-image fs.
> >=20
> > They are all strictly worse than squashfs in the above testing.
> >=20
>=20
> It's interesting to know why and if an optimized mkfs.erofs
> mkfs.ext4 would have done any improvement.

Even the non-loopback mounted (direct xfs backed) version performed
worse than the squashfs one. I'm sure a erofs with sparse files would
do better due to a more compact file, but I don't really see how it
would perform significantly different than the squashfs code. Yes,
squashfs lookup is linear in directory length, while erofs is log(n),
but the directories are not so huge that this would dominate the
runtime.

To get an estimate of this I made a broken version of the erofs image,
where the metacopy files are actually 0 byte size rather than sparse.
This made the erofs file 18M instead, and gained 10% in the cold cache
case. This, while good, is not near enough to matter compared to the
others.

I don't think the base performance here is really much dependent on the
backing filesystem. An ls -lR workload is just a measurement of the
actual (i.e. non-dcache) performance of the filesystem implementation
of lookup and iterate, and overlayfs just has more work to do here,
especially in terms of the amount of i/o needed.

> > > Considering that most real life workloads include reading the
> > > data
> > > and that most of the time inodes and dentries are cached, IMO,
> > > the 10% ls -lR improvement is not a good enough reason
> > > for a new "laser focused" filesystem driver.
> > >=20
> > > Correct me if I am wrong, but isn't the use case of ephemeral
> > > containers require that composefs is layered under a writable
> > > tmpfs
> > > using overlayfs?
> > >=20
> > > If that is the case then the warm cache comparison is incorrect
> > > as well. To argue for the new filesystem you will need to compare
> > > ls -lR of overlay{tmpfs,composefs,xfs} vs.
> > > overlay{tmpfs,erofs,xfs}
> >=20
> > That very much depends. For the ostree rootfs uscase there would be
> > no
> > writable layer, and for containers I'm personally primarily
> > interested
> > in "--readonly" containers (i.e. without an writable layer) in my
> > current automobile/embedded work. For many container cases however,
> > that is true, and no doubt that would make the overhead of
> > overlayfs
> > less of a issue.
> >=20
> > > Alexander,
> > >=20
> > > On a more personal note, I know this discussion has been a bit
> > > stormy, but am not trying to fight you.
> >=20
> > I'm overall not getting a warm fuzzy feeling from this discussion.
> > Getting weird complaints that I'm somehow "stealing" functions or
> > weird
> > "who did $foo first" arguments for instance. You haven't personally
> > attacked me like that, but some of your comments can feel rather
> > pointy, especially in the context of a stormy thread like this. I'm
> > just not used to kernel development workflows, so have patience
> > with me
> > if I do things wrong.
> >=20
>=20
> Fair enough.
> As long as the things that we discussed are duly
> mentioned in future posts, I'll do my best to be less pointy.

Thanks!

> > > I think that {mk,}composefs is a wonderful thing that will
> > > improve
> > > the life of many users.
> > > But mount -t composefs vs. mount -t overlayfs is insignificant
> > > to those users, so we just need to figure out based on facts
> > > and numbers, which is the best technical alternative.
> >=20
> > In reality things are never as easy as one thing strictly being
> > technically best. There is always a multitude of considerations. Is
> > composefs technically better if it uses less memory and performs
> > better
> > for a particular usecase? Or is overlayfs technically better
> > because it
> > is useful for more usecases and already exists? A judgement needs
> > to be
> > made depending on things like complexity/maintainability of the new
> > fs,
> > ease of use, measured performance differences, relative importance
> > of
> > particular performance measurements, and importance of the specific
> > usecase.
> >=20
> > It is my belief that the advantages of composefs outweight the cost
> > of
> > the code duplication, but I understand the point of view of a
> > maintainer of an existing codebase and that saying "no" is often
> > the
> > right thing. I will continue to try to argue for my point of view,
> > but
> > will try to make it as factual as possible.
> >=20
>=20
> Improving overlayfs and erofs has additional advantages -
> improving performance and size of erofs image may benefit
> many other users regardless of the ephemeral containers
> use case, so indeed, there are many aspects to consider.

Yes.



--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a hate-fuelled umbrella-wielding card sharp fleeing from a secret=20
government programme. She's a violent antique-collecting lawyer in the=20
wrong place at the wrong time. They fight crime!=20

