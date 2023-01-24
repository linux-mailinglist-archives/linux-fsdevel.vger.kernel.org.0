Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505406798F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjAXNOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjAXNOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E713D7E
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674566042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Emzd1HKGN0ujzhuIhntpCm3h4NrLAL7ce2dgllE03k=;
        b=bCLq+UEHNH/Nc1DP51vL/n0exSc2l6GJpBuRxTD8ZtEahF7bvpLIA3+qwctM+V7Hh70keT
        04E81NMaNu2VvZPykeS9pZlqJeffgXLGoj+n+u6CJS/dqOyZ7867gKmNXlls5w4acDzXy0
        MFDDdoO8YFLF734WovpjjGTnh6vDM/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-8mKtGAdnNiuRwo2M_uaQvg-1; Tue, 24 Jan 2023 08:10:48 -0500
X-MC-Unique: 8mKtGAdnNiuRwo2M_uaQvg-1
Received: by mail-ed1-f70.google.com with SMTP id z18-20020a05640235d200b0049d84165065so10709166edc.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Emzd1HKGN0ujzhuIhntpCm3h4NrLAL7ce2dgllE03k=;
        b=DUlvY6kNi4pJ4tP7Bu9z0l8u8jF84gVGfaL9vKRf/qSigpaYLYMg/NLkNR29FYROd1
         JYvAu/3hP2yoXxIntznhGmw4olGfUURAp3oRT0asX6zqJ2SBvWxIaZvLyL56YZaQPh81
         RmdBQ8zoGRXElghbDV6OTLpYNTMV7rNwh/5NlHzEMc7AqDLEVZ2NxZY/LDxgtjcCUnkU
         gxpmEys8rGTC0s2s7vw3OAMxPMj3ezD+PbV+5WHbpos6MOFQaGEh5o8oqLM+CA9cbGYU
         0LSSrPVrQZu1d3wZnngXsFDZ8FUrZkEgmplSCd4kfGKP8a1cRojx+CPq5dLE87aVfuMc
         lbNw==
X-Gm-Message-State: AFqh2kokbWGD7sfzq6owyl2ge6nzL314PgWfsd5EaXpUUjW8KWuCd27P
        OIdk3uBFmQTW283JVsWuKHcYq7yBoOdWS+H8TSBW6P2vWmoTqFlHKd1DVS0le/14YI9l9BMq8Se
        Xf122HeqHXI7S1UxAFop9s3T/Gg==
X-Received: by 2002:a05:6402:120d:b0:472:c7fe:475e with SMTP id c13-20020a056402120d00b00472c7fe475emr28797443edw.27.1674565847187;
        Tue, 24 Jan 2023 05:10:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7cBl9gqeePAfNJH5eK1eFkA5aEbVWR75joAHDBO4MVXDp0rw/+VUgBsC714dZeHTP+dP2Yw==
X-Received: by 2002:a05:6402:120d:b0:472:c7fe:475e with SMTP id c13-20020a056402120d00b00472c7fe475emr28797424edw.27.1674565846751;
        Tue, 24 Jan 2023 05:10:46 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id k6-20020a05640212c600b0049c4e3d4139sm1022290edx.89.2023.01.24.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:10:45 -0800 (PST)
Message-ID: <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Jan 2023 14:10:44 +0100
In-Reply-To: <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-2g5wawcPgEVWtcRT749L"
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

--=-2g5wawcPgEVWtcRT749L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-01-24 at 05:24 +0200, Amir Goldstein wrote:
> On Mon, Jan 23, 2023 at 7:56 PM Alexander Larsson <alexl@redhat.com>
> wrote:
> >=20
> > On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> > > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson
> > > <alexl@redhat.com>
> > > wrote:
> > > >=20
> > > > Giuseppe Scrivano and I have recently been working on a new
> > > > project
> > > > we
> > > > call composefs. This is the first time we propose this
> > > > publically
> > > > and
> > > > we would like some feedback on it.
> > > >=20
> > >=20
> > > Hi Alexander,
> > >=20
> > > I must say that I am a little bit puzzled by this v3.
> > > Gao, Christian and myself asked you questions on v2
> > > that are not mentioned in v3 at all.
> >=20
> > I got lots of good feedback from Dave Chinner on V2 that caused
> > rather
> > large changes to simplify the format. So I wanted the new version
> > with
> > those changes out to continue that review. I think also having that
> > simplified version will be helpful for the general discussion.
> >=20
>=20
> That's ok.
> I was not puzzled about why you posted v3.
> I was puzzled by why you did not mention anything about the
> alternatives to adding a new filesystem that were discussed on
> v2 and argue in favor of the new filesystem option.
> If you post another version, please make sure to include a good
> explanation for that.

Sure, I will add something to the next version. But like, there was
already a discussion about this, duplicating that discussion in the v3
announcement when the v2->v3 changes are unrelated to it doesn't seem
like it makes a ton of difference.

> > > To sum it up, please do not propose composefs without explaining
> > > what are the barriers for achieving the exact same outcome with
> > > the use of a read-only overlayfs with two lower layer -
> > > uppermost with erofs containing the metadata files, which include
> > > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that
> > > refer to the lowermost layer containing the content files.
> >=20
> > So, to be more precise, and so that everyone is on the same page,
> > lemme
> > state the two options in full.
> >=20
> > For both options, we have a directory "objects" with content-
> > addressed
> > backing files (i.e. files named by sha256). In this directory all
> > files have fs-verity enabled. Additionally there is an image file
> > which you downloaded to the system that somehow references the
> > objects
> > directory by relative filenames.
> >=20
> > Composefs option:
> >=20
> > =C2=A0The image file has fs-verity enabled. To use the image, you mount
> > it
> > =C2=A0with options "basedir=3Dobjects,digest=3D$imagedigest".
> >=20
> > Overlayfs option:
> >=20
> > =C2=A0The image file is a loopback image of a gpt disk with two
> > partitions,
> > =C2=A0one partition contains the dm-verity hashes, and the other
> > contains
> > =C2=A0some read-only filesystem.
> >=20
> > =C2=A0The read-only filesystem has regular versions of directories and
> > =C2=A0symlinks, but for regular files it has sparse files with the
> > xattrs
> > =C2=A0"trusted.overlay.metacopy" and "trusted.overlay.redirect" set, th=
e
> > =C2=A0later containing a string like like "/de/adbeef..." referencing a
> > =C2=A0backing file in the "objects" directory. In addition, the image
> > also
> > =C2=A0contains overlayfs whiteouts to cover any toplevel filenames from
> > the
> > =C2=A0objects directory that would otherwise appear if objects is used
> > as
> > =C2=A0a lower dir.
> >=20
> > =C2=A0To use this you loopback mount the file, and use dm-verity to set
> > up
> > =C2=A0the combined partitions, which you then mount somewhere. Then you
> > =C2=A0mount an overlayfs with options:
> > =C2=A0 "metacopy=3Don,redirect_dir=3Dfollow,lowerdir=3Dveritydev:object=
s"
> >=20
> > I would say both versions of this can work. There are some minor
> > technical issues with the overlay option:
> >=20
> > * To get actual verification of the backing files you would need to
> > add support to overlayfs for an "trusted.overlay.digest" xattrs,
> > with
> > behaviour similar to composefs.
> >=20
> > * mkfs.erofs doesn't support sparse files (not sure if the kernel
> > code
> > does), which means it is not a good option for the backing all
> > these
> > sparse files. Squashfs seems to support this though, so that is an
> > option.
> >=20
>=20
> Fair enough.
> Wasn't expecting for things to work without any changes.
> Let's first agree that these alone are not a good enough reason to
> introduce a new filesystem.
> Let's move on..

Yeah.

> > However, the main issue I have with the overlayfs approach is that
> > it
> > is sort of clumsy and over-complex. Basically, the composefs
> > approach
> > is laser focused on read-only images, whereas the overlayfs
> > approach
> > just chains together technologies that happen to work, but also do
> > a
> > lot of other stuff. The result is that it is more work to use it,
> > it
> > uses more kernel objects (mounts, dm devices, loopbacks) and it has
>=20
> Up to this point, it's just hand waving, and a bit annoying if I am
> being honest.
> overlayfs+metacopy feature were created for the containers use case
> for very similar set of requirements - they do not just "happen to
> work"
> for the same use case.
> Please stick to technical arguments when arguing in favor of the new
> "laser focused" filesystem option.
>=20
> > worse performance.
> >=20
> > To measure performance I created a largish image (2.6 GB centos9
> > rootfs) and mounted it via composefs, as well as overlay-over-
> > squashfs,
> > both backed by the same objects directory (on xfs).
> >=20
> > If I clear all caches between each run, a `ls -lR` run on composefs
> > runs in around 700 msec:
> >=20
> > # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR cfs-
> > mount"
> > Benchmark 1: ls -lR cfs-mount
> > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 701.0 ms =C2=
=B1=C2=A0 21.9 ms=C2=A0=C2=A0=C2=A0 [User: 153.6 ms,
> > System: 373.3 ms]
> > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 662.3 ms =E2=80=A6 725.3 =
ms=C2=A0=C2=A0=C2=A0 10 runs
> >=20
> > Whereas same with overlayfs takes almost four times as long:
>=20
> No it is not overlayfs, it is overlayfs+squashfs, please stick to
> facts.
> As Gao wrote, squashfs does not optimize directory lookup.
> You can run a test with ext4 for POC as Gao suggested.
> I am sure that mkfs.erofs sparse file support can be added if needed.

New measurements follow, they now include also erofs over loopback,
although that isn't strictly fair, because that image is much larger
due to the fact that it didn't store the files sparsely. It also
includes a version where the topmost lower is directly on the backing
xfs (i.e. not via loopback). I attached the scripts used to create the
images and do the profiling in case anyone wants to reproduce.

Here are the results (on x86-64, xfs base fs):

overlayfs + loopback squashfs - uncached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):      2.483 s =C2=B1  0.029 s    [User: 0.167 s=
, System: 1.656 s]
  Range (min =E2=80=A6 max):    2.427 s =E2=80=A6  2.530 s    10 runs
=20
overlayfs + loopback squashfs - cached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):     429.2 ms =C2=B1   4.6 ms    [User: 123.6 m=
s, System: 295.0 ms]
  Range (min =E2=80=A6 max):   421.2 ms =E2=80=A6 435.3 ms    10 runs
=20
overlayfs + loopback ext4 - uncached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):      4.332 s =C2=B1  0.060 s    [User: 0.204 s=
, System: 3.150 s]
  Range (min =E2=80=A6 max):    4.261 s =E2=80=A6  4.442 s    10 runs
=20
overlayfs + loopback ext4 - cached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):     528.3 ms =C2=B1   4.0 ms    [User: 143.4 m=
s, System: 381.2 ms]
  Range (min =E2=80=A6 max):   521.1 ms =E2=80=A6 536.4 ms    10 runs
=20
overlayfs + loopback erofs - uncached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):      3.045 s =C2=B1  0.127 s    [User: 0.198 s=
, System: 1.129 s]
  Range (min =E2=80=A6 max):    2.926 s =E2=80=A6  3.338 s    10 runs
=20
overlayfs + loopback erofs - cached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):     516.9 ms =C2=B1   5.7 ms    [User: 139.4 m=
s, System: 374.0 ms]
  Range (min =E2=80=A6 max):   503.6 ms =E2=80=A6 521.9 ms    10 runs
=20
overlayfs + direct - uncached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):      2.562 s =C2=B1  0.028 s    [User: 0.199 s=
, System: 1.129 s]
  Range (min =E2=80=A6 max):    2.497 s =E2=80=A6  2.585 s    10 runs
=20
overlayfs + direct - cached
Benchmark 1: ls -lR mnt-ovl
  Time (mean =C2=B1 =CF=83):     524.5 ms =C2=B1   1.6 ms    [User: 148.7 m=
s, System: 372.2 ms]
  Range (min =E2=80=A6 max):   522.8 ms =E2=80=A6 527.8 ms    10 runs
=20
composefs - uncached
Benchmark 1: ls -lR mnt-fs
  Time (mean =C2=B1 =CF=83):     681.4 ms =C2=B1  14.1 ms    [User: 154.4 m=
s, System: 369.9 ms]
  Range (min =E2=80=A6 max):   652.5 ms =E2=80=A6 703.2 ms    10 runs
=20
composefs - cached
Benchmark 1: ls -lR mnt-fs
  Time (mean =C2=B1 =CF=83):     390.8 ms =C2=B1   4.7 ms    [User: 144.7 m=
s, System: 243.7 ms]
  Range (min =E2=80=A6 max):   382.8 ms =E2=80=A6 399.1 ms    10 runs

For the uncached case, composefs is still almost four times faster than
the fastest overlay combo (squashfs), and the non-squashfs versions are
strictly slower. For the cached case the difference is less (10%) but
with similar order of performance.

For size comparison, here are the resulting images:

8.6M large.composefs
2.5G large.erofs
200M large.ext4
2.6M large.squashfs

> > # hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR ovl-
> > mount"
> > Benchmark 1: ls -lR ovl-mount
> > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.738 s=
 =C2=B1=C2=A0 0.029 s=C2=A0=C2=A0=C2=A0 [User: 0.176 s,
> > System: 1.688 s]
> > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 2.699 s =E2=80=A6=
=C2=A0 2.787 s=C2=A0=C2=A0=C2=A0 10 runs
> >=20
> > With page cache between runs the difference is smaller, but still
> > there:
>=20
> It is the dentry cache that mostly matters for this test and please
> use hyerfine -w 1 to warmup dentry cache for correct measurement
> of warm cache lookup.

I'm not sure why the dentry cache case would be more important?
Starting a new container will very often not have cached the image.

To me the interesting case is for a new image, but with some existing
page cache for the backing files directory. That seems to model staring
a new image in an active container host, but its somewhat hard to test
that case.

> I guess these test runs started with warm cache? but it wasn't
> mentioned explicitly.

Yes, they were warm (because I ran the previous test before it). But,
the new profile script explicitly adds -w 1.

> > # hyperfine "ls -lR cfs-mnt"
> > Benchmark 1: ls -lR cfs-mnt
> > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 390.1 ms =C2=
=B1=C2=A0=C2=A0 3.7 ms=C2=A0=C2=A0=C2=A0 [User: 140.9 ms,
> > System: 247.1 ms]
> > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 381.5 ms =E2=80=A6 393.9 =
ms=C2=A0=C2=A0=C2=A0 10 runs
> >=20
> > vs
> >=20
> > # hyperfine -i "ls -lR ovl-mount"
> > Benchmark 1: ls -lR ovl-mount
> > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 431.5 ms =C2=
=B1=C2=A0=C2=A0 1.2 ms=C2=A0=C2=A0=C2=A0 [User: 124.3 ms,
> > System: 296.9 ms]
> > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 429.4 ms =E2=80=A6 433.3 =
ms=C2=A0=C2=A0=C2=A0 10 runs
> >=20
> > This isn't all that strange, as overlayfs does a lot more work for
> > each lookup, including multiple name lookups as well as several
> > xattr
> > lookups, whereas composefs just does a single lookup in a pre-
> > computed
>=20
> Seriously, "multiple name lookups"?
> Overlayfs does exactly one lookup for anything but first level
> subdirs
> and for sparse files it does the exact same lookup in /objects as
> composefs.
> Enough with the hand waving please. Stick to hard facts.

With the discussed layout, in a stat() call on a regular file,
ovl_lookup() will do lookups on both the sparse file and the backing
file, whereas cfs_dir_lookup() will just map some page cache pages and
do a binary search.=20

Of course if you actually open the file, then cfs_open_file() would do
the equivalent lookups in /objects. But that is often not what happens,
for example in "ls -l".=20

Additionally, these extra lookups will cause extra memory use, as you
need dentries and inodes for the erofs/squashfs inodes in addition to
the overlay inodes.

> > table. But, given that we don't need any of the other features of
> > overlayfs here, this performance loss seems rather unnecessary.
> >=20
> > I understand that there is a cost to adding more code, but
> > efficiently
> > supporting containers and other forms of read-only images is a
> > pretty
> > important usecase for Linux these days, and having something
> > tailored
> > for that seems pretty useful to me, even considering the code
> > duplication.
> >=20
> >=20
> >=20
> > I also understand Cristians worry about stacking filesystem, having
> > looked a bit more at the overlayfs code. But, since composefs
> > doesn't
> > really expose the metadata or vfs structure of the lower
> > directories it
> > is much simpler in a fundamental way.
> >=20
>=20
> I agree that composefs is simpler than overlayfs and that its
> security
> model is simpler, but this is not the relevant question.
> The question is what are the benefits to the prospect users of
> composefs
> that justify this new filesystem driver if overlayfs already
> implements
> the needed functionality.
>=20
> The only valid technical argument I could gather from your email is -
> 10% performance improvement in warm cache ls -lR on a 2.6 GB
> centos9 rootfs image compared to overlayfs+squashfs.
>=20
> I am not counting the cold cache results until we see results of
> a modern ro-image fs.

They are all strictly worse than squashfs in the above testing.

> Considering that most real life workloads include reading the data
> and that most of the time inodes and dentries are cached, IMO,
> the 10% ls -lR improvement is not a good enough reason
> for a new "laser focused" filesystem driver.
>=20
> Correct me if I am wrong, but isn't the use case of ephemeral
> containers require that composefs is layered under a writable tmpfs
> using overlayfs?
>=20
> If that is the case then the warm cache comparison is incorrect
> as well. To argue for the new filesystem you will need to compare
> ls -lR of overlay{tmpfs,composefs,xfs} vs. overlay{tmpfs,erofs,xfs}

That very much depends. For the ostree rootfs uscase there would be no
writable layer, and for containers I'm personally primarily interested
in "--readonly" containers (i.e. without an writable layer) in my
current automobile/embedded work. For many container cases however,
that is true, and no doubt that would make the overhead of overlayfs
less of a issue.

> Alexander,
>=20
> On a more personal note, I know this discussion has been a bit
> stormy, but am not trying to fight you.

I'm overall not getting a warm fuzzy feeling from this discussion.
Getting weird complaints that I'm somehow "stealing" functions or weird
"who did $foo first" arguments for instance. You haven't personally
attacked me like that, but some of your comments can feel rather
pointy, especially in the context of a stormy thread like this. I'm
just not used to kernel development workflows, so have patience with me
if I do things wrong.

> I think that {mk,}composefs is a wonderful thing that will improve
> the life of many users.
> But mount -t composefs vs. mount -t overlayfs is insignificant
> to those users, so we just need to figure out based on facts
> and numbers, which is the best technical alternative.

In reality things are never as easy as one thing strictly being
technically best. There is always a multitude of considerations. Is
composefs technically better if it uses less memory and performs better
for a particular usecase? Or is overlayfs technically better because it
is useful for more usecases and already exists? A judgement needs to be
made depending on things like complexity/maintainability of the new fs,
ease of use, measured performance differences, relative importance of
particular performance measurements, and importance of the specific
usecase.

It is my belief that the advantages of composefs outweight the cost of
the code duplication, but I understand the point of view of a
maintainer of an existing codebase and that saying "no" is often the
right thing. I will continue to try to argue for my point of view, but
will try to make it as factual as possible.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a shy shark-wrestling librarian whom everyone believes is mad.
She's=20
an enchanted tempestuous stripper operating on the wrong side of the
law.=20
They fight crime!=20

--=-2g5wawcPgEVWtcRT749L
Content-Type: application/x-shellscript; name="mkhack.sh"
Content-Disposition: attachment; filename="mkhack.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZQoKU09VUkNFPS4uL3Rlc3QtaW1hZ2VzL2NzOS1kZXZlbG9wZXIt
cm9vdGZzCk9CSkRJUj10ZXN0LW9iamVjdHMKTE9XRVJESVI9dG1wZGlyCmV4cG9ydCBTT1VSQ0Ug
T0JKRElSIExPV0VSRElSCgojIENsZWFuIHVwCnJtIC1yZiAkT0JKRElSICRMT1dFUkRJUiBsYXJn
ZS5zcXVhc2hmcyBsYXJnZS5lcm9mcyBsYXJnZS5leHQ0IGxhcmdlLmNvbXBvc2VmcwoKZWNobyBj
b3B5aW5nIGRhdGEKY3AgLXJhIC0tYXR0cmlidXRlcy1vbmx5ICIkU09VUkNFIiAiJExPV0VSRElS
IgoKbWtkaXIgLXAgJE9CSkRJUgoKcHJvY2Vzc19yZWd1bGFyX2ZpbGUgKCkgewogICAgbG9jYWwg
U0laRT0kKHN0YXQgLWMgIiVzIiAiJDEiKQogICAgbG9jYWwgUkVMPSIkKHJlYWxwYXRoIC0tcmVs
YXRpdmUtdG89IiRTT1VSQ0UiICIkMSIpIgogICAgbG9jYWwgRFNUPSIkTE9XRVJESVIvJFJFTCIK
CiAgICBsb2NhbCBESUdFU1Q9JChmc3Zlcml0eSBkaWdlc3QgLS1oYXNoLWFsZz1zaGEyNTYgLS1j
b21wYWN0ICIkMSIpCiAgICBsb2NhbCBQQVJUMj0ke0RJR0VTVCM/P30KICAgIGxvY2FsIFBBUlQx
PSR7RElHRVNUJSR7UEFSVDJ9fQoKICAgIG1rZGlyIC1wICRPQkpESVIvJFBBUlQxCiAgICBjcCAt
LW5vLXByZXNlcnZlPWFsbCAiJDEiICRPQkpESVIvJFBBUlQxLyRQQVJUMgoKICAgIHRydW5jYXRl
IC0tc2l6ZT0kU0laRSAiJERTVCIKICAgIGF0dHIgLVIgLXMgb3ZlcmxheS5tZXRhY29weSAtViAi
IiAiJERTVCIgPiAvZGV2L251bGwKICAgIGF0dHIgLVIgLXMgb3ZlcmxheS5yZWRpcmVjdCAtViAi
LyRQQVJUMS8kUEFSVDIiICIkRFNUIiAgPiAvZGV2L251bGwKfQpleHBvcnQgLWYgcHJvY2Vzc19y
ZWd1bGFyX2ZpbGUKCmZpbmQgJFNPVVJDRSAtdHlwZSBmIC1leGVjIGJhc2ggLWMgJ3Byb2Nlc3Nf
cmVndWxhcl9maWxlICIkMCInIHt9IFw7CgplY2hvIHdoaXRlbGlzdGluZwpmb3IgZiBpbiAkT0JK
RElSLyo7IGRvCiAgICBGPSQoYmFzZW5hbWUgJGYpCiAgICBta25vZCAkTE9XRVJESVIvJEYgYyAw
IDAKZG9uZQoKbWtzcXVhc2hmcyAgJExPV0VSRElSLyBsYXJnZS5zcXVhc2hmcwpta2ZzLmV4dDQg
LWQgJExPV0VSRElSIGxhcmdlLmV4dDQgMjAwTQpta2ZzLmVyb2ZzIGxhcmdlLmVyb2ZzICRMT1dF
UkRJUgoKLi4vdG9vbHMvbWtjb21wb3NlZnMgLS1jb21wdXRlLWRpZ2VzdCAkU09VUkNFIGxhcmdl
LmNvbXBvc2Vmcwo=


--=-2g5wawcPgEVWtcRT749L
Content-Type: application/x-shellscript; name="profile.sh"
Content-Disposition: attachment; filename="profile.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZQoKcHJvZmlsZSAoKSB7CiAgICBsb2NhbCBUWVBFPSQxCiAgICBs
b2NhbCBESVI9JDIKCiAgICBzeW5jCgogICAgZWNobyAiJFRZUEUgLSB1bmNhY2hlZCIKICAgIGh5
cGVyZmluZSAtcCAiZWNobyAzID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIiAibHMgLWxSICRE
SVIiCgogICAgZWNobyAiJFRZUEUgLSBjYWNoZWQiCiAgICBoeXBlcmZpbmUgLXcgMSAibHMgLWxS
ICRESVIiCn0KCnByb2ZpbGVfb3ZlcmxheSAoKSB7CiAgICBsb2NhbCBmcz0kMQogICAgbG9jYWwg
c291cmNlPSQyCgogICAgbW91bnQgLXQgb3ZlcmxheSAtbyAibWV0YWNvcHk9b24scmVkaXJlY3Rf
ZGlyPWZvbGxvdyxsb3dlcmRpcj0kc291cmNlOnRlc3Qtb2JqZWN0cyIgb3ZlcmxheSBtbnQtb3Zs
CgogICAgcHJvZmlsZSAib3ZlcmxheWZzICsgJGZzIiBtbnQtb3ZsCgogICAgdW1vdW50IG1udC1v
dmwKfQoKbWtkaXIgLXAgbW50LWZzIG1udC1vdmwKCmZvciBmcyBpbiBzcXVhc2hmcyBleHQ0IGVy
b2ZzOyBkbwogICAgbW91bnQgLW8gbG9vcCBsYXJnZS4kZnMgbW50LWZzCiAgICBwcm9maWxlX292
ZXJsYXkgImxvb3BiYWNrICRmcyIgbW50LWZzCiAgICB1bW91bnQgbW50LWZzCmRvbmUKCnByb2Zp
bGVfb3ZlcmxheSBkaXJlY3QgdG1wZGlyCgptb3VudCAtdCBjb21wb3NlZnMgLW8gYmFzZWRpcj10
ZXN0LW9iamVjdHMgbGFyZ2UuY29tcG9zZWZzIG1udC1mcwpwcm9maWxlIGNvbXBvc2VmcyBtbnQt
ZnMKdW1vdW50IG1udC1mcwo=


--=-2g5wawcPgEVWtcRT749L--

