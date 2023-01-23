Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C96783BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjAWR5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjAWR5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC63029C
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674496583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u29KOOnWnk6zRd1Z2NqTVj6TzkIuaHYp5j/a2jVVjK4=;
        b=Tfdcjf/y9S8xNIm7yKUdvB8nE7eHTi/hgYeLJcNWh/w8MLAfx5W+75UrjuKQw8guiCW75k
        hwTY804us/eUg4YWkVxP6lBM3AOHqjeY4xk/BIHaZMDPgPNfyF+c6eV+H6f0GUQOs1rSzp
        8ogEW7j8k2D/Fs2mwqm23wCnph0S6i8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-328-jt3zZJjCOra6Zw_NogdmgA-1; Mon, 23 Jan 2023 12:56:22 -0500
X-MC-Unique: jt3zZJjCOra6Zw_NogdmgA-1
Received: by mail-ed1-f72.google.com with SMTP id c12-20020a05640227cc00b0049e2c079aabso8870684ede.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u29KOOnWnk6zRd1Z2NqTVj6TzkIuaHYp5j/a2jVVjK4=;
        b=5Qptdxey7BLvVx70gNj/sOrsxhndFLZnhONLpKRHI+l1OL0c2tWJUVI0djDnGRiSz/
         bB9vRDMuOqV1mvf71uIG+JPE6xpOlAkZTWZZyQXl9zMYUbKt6INBhEcWajEZt9TBGjB7
         d/7zW9LnyXrmW7WTqr4tE0gTodrqL5Xc5KgO3ZHSGWpe7T4DpkgKm6Xw4+Vj/xb6Aqcd
         dfWdGAU2pgFM/YDWLz4gk3lgAWgBEfRaH6EKdtBlX4fjD6d3W3ezoR+n7DumsoXszlLo
         ufEarF+rjJ4cBM6GF8srB5WWo/QP4lsQ7+6L3Ul/3hONaG7rakuQxisu/dTr8o9BqfRB
         4Y+Q==
X-Gm-Message-State: AFqh2kod6RZ9809c9x7fhvHwKqXio8a9XKKRPGazMO4Cxq9mevLkrjFh
        X1mgQymKCW+ybJHCcKQapuADtNlxEHWN7P2JEzJ6YBzwPDGWZyU2FSxZ50J6Ae5jPKb1N5HKmfk
        Kj9LRcMhSzkxrucrUFELNlA312w==
X-Received: by 2002:aa7:c9da:0:b0:46d:35f6:5a9b with SMTP id i26-20020aa7c9da000000b0046d35f65a9bmr24001992edt.24.1674496581157;
        Mon, 23 Jan 2023 09:56:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvLsckcUVUHHkKNQ0FMU0x0pqJjnxDdo6DqZjG9VOBO9P/OeFhyuUunfqNnDNfRIrutoyegKQ==
X-Received: by 2002:aa7:c9da:0:b0:46d:35f6:5a9b with SMTP id i26-20020aa7c9da000000b0046d35f65a9bmr24001978edt.24.1674496580987;
        Mon, 23 Jan 2023 09:56:20 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0082535e2da13sm22418402ejx.6.2023.01.23.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:56:20 -0800 (PST)
Message-ID: <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, david@fromorbit.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Jan 2023 18:56:19 +0100
In-Reply-To: <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
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

On Fri, 2023-01-20 at 21:44 +0200, Amir Goldstein wrote:
> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com>
> wrote:
> >=20
> > Giuseppe Scrivano and I have recently been working on a new project
> > we
> > call composefs. This is the first time we propose this publically
> > and
> > we would like some feedback on it.
> >=20
>=20
> Hi Alexander,
>=20
> I must say that I am a little bit puzzled by this v3.
> Gao, Christian and myself asked you questions on v2
> that are not mentioned in v3 at all.

I got lots of good feedback from Dave Chinner on V2 that caused rather
large changes to simplify the format. So I wanted the new version with
those changes out to continue that review. I think also having that
simplified version will be helpful for the general discussion.

> To sum it up, please do not propose composefs without explaining
> what are the barriers for achieving the exact same outcome with
> the use of a read-only overlayfs with two lower layer -
> uppermost with erofs containing the metadata files, which include
> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that
> refer to the lowermost layer containing the content files.

So, to be more precise, and so that everyone is on the same page, lemme
state the two options in full.

For both options, we have a directory "objects" with content-addressed
backing files (i.e. files named by sha256). In this directory all
files have fs-verity enabled. Additionally there is an image file
which you downloaded to the system that somehow references the objects
directory by relative filenames.

Composefs option:

 The image file has fs-verity enabled. To use the image, you mount it
 with options "basedir=3Dobjects,digest=3D$imagedigest".

Overlayfs option:

 The image file is a loopback image of a gpt disk with two partitions,
 one partition contains the dm-verity hashes, and the other contains
 some read-only filesystem.

 The read-only filesystem has regular versions of directories and
 symlinks, but for regular files it has sparse files with the xattrs
 "trusted.overlay.metacopy" and "trusted.overlay.redirect" set, the
 later containing a string like like "/de/adbeef..." referencing a
 backing file in the "objects" directory. In addition, the image also
 contains overlayfs whiteouts to cover any toplevel filenames from the
 objects directory that would otherwise appear if objects is used as
 a lower dir.

 To use this you loopback mount the file, and use dm-verity to set up
 the combined partitions, which you then mount somewhere. Then you
 mount an overlayfs with options:
  "metacopy=3Don,redirect_dir=3Dfollow,lowerdir=3Dveritydev:objects"

I would say both versions of this can work. There are some minor
technical issues with the overlay option:

* To get actual verification of the backing files you would need to
add support to overlayfs for an "trusted.overlay.digest" xattrs, with
behaviour similar to composefs.

* mkfs.erofs doesn't support sparse files (not sure if the kernel code
does), which means it is not a good option for the backing all these
sparse files. Squashfs seems to support this though, so that is an
option.

However, the main issue I have with the overlayfs approach is that it
is sort of clumsy and over-complex. Basically, the composefs approach
is laser focused on read-only images, whereas the overlayfs approach
just chains together technologies that happen to work, but also do a
lot of other stuff. The result is that it is more work to use it, it
uses more kernel objects (mounts, dm devices, loopbacks) and it has
worse performance.

To measure performance I created a largish image (2.6 GB centos9
rootfs) and mounted it via composefs, as well as overlay-over-squashfs,
both backed by the same objects directory (on xfs).

If I clear all caches between each run, a `ls -lR` run on composefs
runs in around 700 msec:

# hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR cfs-mount"
Benchmark 1: ls -lR cfs-mount
  Time (mean =C2=B1 =CF=83):     701.0 ms =C2=B1  21.9 ms    [User: 153.6 m=
s, System: 373.3 ms]
  Range (min =E2=80=A6 max):   662.3 ms =E2=80=A6 725.3 ms    10 runs

Whereas same with overlayfs takes almost four times as long:

# hyperfine -i -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR ovl-mount"
Benchmark 1: ls -lR ovl-mount
  Time (mean =C2=B1 =CF=83):      2.738 s =C2=B1  0.029 s    [User: 0.176 s=
, System: 1.688 s]
  Range (min =E2=80=A6 max):    2.699 s =E2=80=A6  2.787 s    10 runs

With page cache between runs the difference is smaller, but still
there:

# hyperfine "ls -lR cfs-mnt"
Benchmark 1: ls -lR cfs-mnt
  Time (mean =C2=B1 =CF=83):     390.1 ms =C2=B1   3.7 ms    [User: 140.9 m=
s, System: 247.1 ms]
  Range (min =E2=80=A6 max):   381.5 ms =E2=80=A6 393.9 ms    10 runs

vs

# hyperfine -i "ls -lR ovl-mount"
Benchmark 1: ls -lR ovl-mount
  Time (mean =C2=B1 =CF=83):     431.5 ms =C2=B1   1.2 ms    [User: 124.3 m=
s, System: 296.9 ms]
  Range (min =E2=80=A6 max):   429.4 ms =E2=80=A6 433.3 ms    10 runs

This isn't all that strange, as overlayfs does a lot more work for
each lookup, including multiple name lookups as well as several xattr
lookups, whereas composefs just does a single lookup in a pre-computed
table. But, given that we don't need any of the other features of
overlayfs here, this performance loss seems rather unnecessary.

I understand that there is a cost to adding more code, but efficiently
supporting containers and other forms of read-only images is a pretty
important usecase for Linux these days, and having something tailored
for that seems pretty useful to me, even considering the code
duplication.



I also understand Cristians worry about stacking filesystem, having
looked a bit more at the overlayfs code. But, since composefs doesn't
really expose the metadata or vfs structure of the lower directories it
is much simpler in a fundamental way.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a fast talking sweet-toothed farmboy who must take medication to=20
keep him sane. She's a wealthy streetsmart magician's assistant who=20
dreams of becoming Elvis. They fight crime!=20

