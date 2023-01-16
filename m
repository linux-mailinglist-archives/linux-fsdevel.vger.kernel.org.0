Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8866C3FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 16:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjAPPeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjAPPdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843323C6C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673882855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ4OGwTgw4cJhkIplo7X4/QUQ1+d3JUOeKdxVyTX/H8=;
        b=dr0/hzGF/zW7MqwPefdPBmg3g687WohSsiyxILJBkYp6V8FHjbzxzGN3MMWzHcZ5J1Lndx
        toi79cLdt6lDeToRpbfCFs6tWnguZem8Vdn0IGMKnNf1oR7S9OQtvvVXj///qL2yjTaG90
        9GAAAXgkZ4uCoB3OZPv+lkk0H2p4GhQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-fGJ2ihYbPVeqvcwLx7bzlA-1; Mon, 16 Jan 2023 10:27:34 -0500
X-MC-Unique: fGJ2ihYbPVeqvcwLx7bzlA-1
Received: by mail-lf1-f70.google.com with SMTP id bf20-20020a056512259400b004b57544aad2so10562791lfb.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 07:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4OGwTgw4cJhkIplo7X4/QUQ1+d3JUOeKdxVyTX/H8=;
        b=iTmynCnOHDXNcxVTxAb0QRGmVGxUiWepAvk3bwsKREFKaiCfwg8TsMTBtM4OI1tSrb
         B6dpxANI9Z8obfIeTsUExox8Lo+DwmZ6Lqri54wEoEcmz66oWAM8c11hoIitR7CGlH6U
         oZ10dSceJu50UnCAKM/fwmVHLWD2upJgkAIn2Xw9N+u42V9q0+/hq6NAbfMQlf05KYfY
         Bwbywi5VljRfVVoHA6dpKMWxVdQLfQfFzcb0mJ3qg098/qpCmwfiOi2ZA0jHYo2glx4b
         illQFg6punMJbOWtDCmElHkKDmsxljqn8V3jUQXLq2LiTFVy0itN2cJpPB6DsLV08/UB
         UvKg==
X-Gm-Message-State: AFqh2krdlXkduO/9P+YTUee6wu3HcpBSsWL+eBYW6sAq8uXLrajO62lt
        H3FFenjxtDkXYuySG6g89MbAtqERKdtOwzCxrDpcJt/VloZA2Fxg8XIuZYnZ0rol4l9SDK+TaYj
        lIcfkDMOUg5DIQYPbyI71+lVTzQ==
X-Received: by 2002:ac2:5088:0:b0:4b6:d28a:2558 with SMTP id f8-20020ac25088000000b004b6d28a2558mr35066439lfm.49.1673882852704;
        Mon, 16 Jan 2023 07:27:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhOFMC1x/fRsz471Q9zCvdHuMgMXuhx1hXLHuNXFiv0FbUrLGOhUHaFdR095jm3K/X0kJEpA==
X-Received: by 2002:ac2:5088:0:b0:4b6:d28a:2558 with SMTP id f8-20020ac25088000000b004b6d28a2558mr35066436lfm.49.1673882852426;
        Mon, 16 Jan 2023 07:27:32 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id t13-20020a195f0d000000b004b5774726dcsm5057617lfb.236.2023.01.16.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 07:27:31 -0800 (PST)
Message-ID: <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
Date:   Mon, 16 Jan 2023 16:27:31 +0100
In-Reply-To: <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
References: <cover.1673623253.git.alexl@redhat.com>
         <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
         <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
         <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
         <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
         <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
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

On Mon, 2023-01-16 at 21:26 +0800, Gao Xiang wrote:
>=20
>=20
> On 2023/1/16 20:33, Alexander Larsson wrote:
> >=20
> >=20
> > Suppose you have:
> >=20
> > -rw-r--r-- root root image.ext4
> > -rw-r--r-- root root image.composefs
> > drwxr--r-- root root objects/
> > -rw-r--r-- root root objects/backing.file
> >=20
> > Are you saying it is easier for someone to modify backing.file than
> > image.ext4?
> >=20
> > I argue it is not, but composefs takes some steps to avoid issues
> > here.
> > At mount time, when the basedir ("objects/" above) argument is
> > parsed,
> > we resolve that path and then create a private vfsmount for it:
> >=20
> > =C2=A0 resolve_basedir(path) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mnt =3D clone_private_m=
ount(&path);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0 }
> >=20
> > =C2=A0 fsi->bases[i] =3D resolve_basedir(path);
> >=20
> > Then we open backing files with this mount as root:
> >=20
> > =C2=A0 real_file =3D file_open_root_mnt(fsi->bases[i], real_path,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file->f_flags, 0);
> >=20
> > This will never resolve outside the initially specified basedir,
> > even
> > with symlinks or whatever. It will also not be affected by later
> > mount
> > changes in the original mount namespace, as this is a private
> > mount.
> >=20
> > This is the same mechanism that overlayfs uses for its upper dirs.
>=20
> Ok.=C2=A0 I have no problem of this part.
>=20
> >=20
> > I would argue that anyone who has rights to modify the contents of
> > files in "objects" (supposing they were created with sane
> > permissions)
> > would also have rights to modify "image.ext4".
>=20
> But you don't have any permission check for files in such
> "objects/" directory in composefs source code, do you?

I don't see how permission checks would make any difference to the
ability to modify the image by anyone? Do you mean the kernel should
validate the basedir so that is has sane permissions rather than
trusting the user? That seems weird to me.

Or do you mean that someone would create a composefs image that
references a file they could not otherwise read, and then use it as a
basedir in a composefs mount to read the file? Such a mount can only
happen if you are root, and it can only read files inside that
particular directory. However, maybe we should use the callers
credentials to ensure that they are allowed to read the backing file,
just in case. That can't hurt.

> As I said in my original reply, don't assume random users or
> malicious people just passing in or behaving like your expected
> way.=C2=A0 Sometimes they're not but I think in-kernel fses should
> handle such cases by design.=C2=A0 Obviously, any system written by
> human can cause unexpected bugs, but that is another story.
> I think in general it needs to have such design at least.

You need to be root to mount a fs, an operation which is generally
unsafe (because few filesystems are completely resistant to hostile
filesystem data). Therefore I think we can expect a certain amount of
sanity in its use, such as "don't pass in directories that are world
writable".

> >=20
> > > That is also why we selected fscache at the first time to manage
> > > all
> > > local cache data for EROFS, since such content-defined directory
> > > is
> > > quite under control by in-kernel fscache instead of selecting a
> > > random directory created and given by some userspace program.
> > >=20
> > > If you are interested in looking info the current in-kernel
> > > fscache
> > > behavior, I think that is much similar as what ostree does now.
> > >=20
> > > It just needs new features like
> > > =C2=A0=C2=A0=C2=A0 - multiple directories;
> > > =C2=A0=C2=A0=C2=A0 - daemonless
> > > to match.
> > >=20
> >=20
> > Obviously everything can be extended to support everything. But
> > composefs is very small and simple (2128 lines of code), while at
> > the
> > same time being easy to use (just mount it with one syscall) and
> > needs
> > no complex userspace machinery and configuration. But even without
> > the
> > above feature additions fscache + cachefiles is 7982 lines, plus
> > erofs
> > is 9075 lines, and then on top of that you need userspace
> > integration
> > to even use the thing.
>=20
> I've replied this in the comment of LWN.net.=C2=A0 EROFS can handle both
> device-based or file-based images. It can handle FSDAX, compression,
> data deduplication, rolling-hash finer compressed data duplication,
> etc.=C2=A0 Of course, for your use cases, you can just turn them off by
> Kconfig, I think such code is useless to your use cases as well.
>
> And as a team work these years, EROFS always accept useful features
> from other people.=C2=A0 And I've been always working on cleaning up
> EROFS, but as long as it gains more features, the code can expand
> of course.
>=20
> Also take your project -- flatpak for example, I don't think the
> total line of current version is as same as the original version.
>=20
> Also you will always maintain Composefs source code below 2.5k Loc?
>=20
> >=20
> > Don't take me wrong, EROFS is great for its usecases, but I don't
> > really think it is the right choice for my usecase.
> >=20
> > > > >=20
> > > > Secondly, the use of fs-cache doesn't stack, as there can only
> > > > be
> > > > one
> > > > cachefs agent. For example, mixing an ostree EROFS boot with a
> > > > container backend using EROFS isn't possible (at least without
> > > > deep
> > > > integration between the two userspaces).
> > >=20
> > > The reasons above are all current fscache implementation
> > > limitation:
> > >=20
> > > =C2=A0=C2=A0 - First, if such overlay model really works, EROFS can d=
o it
> > > without
> > > fscache feature as well to integrate userspace ostree.=C2=A0 But even
> > > that
> > > I hope this new feature can be landed in overlayfs rather than
> > > some
> > > other ways since it has native writable layer so we don't need
> > > another
> > > overlayfs mount at all for writing;
> >=20
> > I don't think it is the right approach for overlayfs to integrate
> > something like image support. Merging the two codebases would
> > complicate both while adding costs to users who need only support
> > for
> > one of the features. I think reusing and stacking separate features
> > is
> > a better idea than combining them.
>=20
> Why? overlayfs could have metadata support as well, if they'd like
> to support advanced features like partial copy-up without fscache
> support.
>=20
> >=20
> > >=20
> > > >=20
> > > > Instead what we have done with composefs is to make filesystem
> > > > image
> > > > generation from the ostree repository 100% reproducible. Then
> > > > we
> > > > can
> > >=20
> > > EROFS is all 100% reproduciable as well.
> > >=20
> >=20
> >=20
> > Really, so if I today, on fedora 36 run:
> > # tar xvf oci-image.tar
> > # mkfs.erofs oci-dir/ oci.erofs
> >=20
> > And then in 5 years, if someone on debian 13 runs the same, with
> > the
> > same tar file, then both oci.erofs files will have the same sha256
> > checksum?
>=20
> Why it doesn't?=C2=A0 Reproducable builds is a MUST for Android use cases
> as well.

That is not quite the same requirements. A reproducible build in the
traditional sense is limited to a particular build configuration. You
define a set of tools for the build, and use the same ones for each
build, and get a fixed output. You don't expect to be able to change
e.g. the compiler and get the same result. Similarly, it is often the
case that different builds or versions of compression libraries gives
different results, so you can't expect to use e.g. a different libz and
get identical images.

> Yes, it may break between versions by mistake, but I think
> reproducable builds is a basic functionalaity for all image
> use cases.
>=20
> >=20
> > How do you handle things like different versions or builds of
> > compression libraries creating different results? Do you guarantee
> > to
> > not add any new backwards compat changes by default, or change any
> > default options? Do you guarantee that the files are read from
> > "oci-
> > dir" in the same order each time? It doesn't look like it.
>=20
> If you'd like to say like that, why mkcomposefs doesn't have the
> same issue that it may be broken by some bug.
>=20

libcomposefs defines a normalized form for everything like file order,
xattr orders, etc, and carefully normalizes everything such that we can
guarantee these properties. It is possible that some detail was missed,
because we're humans. But it was a very conscious and deliberate design
choice that is deeply encoded in the code and format. For example, this
is why we don't use compression but try to minimize size in other ways.

> > >=20
> > > But really, personally I think the issue above is different from
> > > loopback devices and may need to be resolved first. And if
> > > possible,
> > > I hope it could be an new overlayfs feature for everyone.
> >=20
> > Yeah. Independent of composefs, I think EROFS would be better if
> > you
> > could just point it to a chunk directory at mount time rather than
> > having to route everything through a system-wide global cachefs
> > singleton. I understand that cachefs does help with the on-demand
> > download aspect, but when you don't need that it is just in the
> > way.
>=20
> Just check your reply to Dave's review, it seems that how
> composefs dir on-disk format works is also much similar to
> EROFS as well, see:
>=20
> https://docs.kernel.org/filesystems/erofs.html=C2=A0-- Directories
>=20
> a block vs a chunk =3D dirent + names
>=20
> cfs_dir_lookup -> erofs_namei + find_target_block_classic;
> cfs_dir_lookup_in_chunk -> find_target_dirent.

Yeah, the dirent layout looks very similar. I guess great minds think
alike!=C2=A0My approach was simpler initially, but it kinda converged on
this when I started optimizing the kernel lookup code with binary
search.

> Yes, great projects could be much similar to each other
> occasionally, not to mention opensource projects ;)
>=20
> Anyway, I'm not opposed to Composefs if folks really like a
> new read-only filesystem for this. That is almost all I'd like
> to say about Composefs formally, have fun!
>=20
> Thanks,
> Gao Xiang

Cool, thanks for the feedback.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a maverick guitar-strumming senator with a passion for fast cars.=20
She's an orphaned winged angel with her own daytime radio talk show.
They=20
fight crime!=20

