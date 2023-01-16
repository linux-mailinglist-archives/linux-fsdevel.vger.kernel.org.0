Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2066BDE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjAPMeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 07:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAPMeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA121DB8D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673872437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TkizSrCv3vV9qMaD0TfLrxklc0cIvGQ9ectgjNKDa5s=;
        b=f2pMCSZmXnxwooNqPAaD8ftrW+xyLA5PKyyTUZ67mklGZbirOH622QN8Sj1g9ngRY58vqV
        xzNzL4LMZmERAtzwwQ9546lbKlUDfwrFKLvmz0FtUna1i+mKojLJQ8vxCBgNhQdouUnxgT
        BfJg0tZ5S8fM6gYoJOYa2qxlAUhKbwk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-2d5QRo4NPnOATjvJ5UrcFg-1; Mon, 16 Jan 2023 07:33:55 -0500
X-MC-Unique: 2d5QRo4NPnOATjvJ5UrcFg-1
Received: by mail-lj1-f199.google.com with SMTP id bx14-20020a05651c198e00b0027b58179b0aso7338568ljb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 04:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkizSrCv3vV9qMaD0TfLrxklc0cIvGQ9ectgjNKDa5s=;
        b=v0aUZrsPomeFdidLymJ+mq4G3+EgQRPU5q+IPp5x5XHzWpmCSZKWiEyGb3COUuwEy2
         WMeLhM8LIkmzXnTecJC7Ei6o60W7F05JPs4Jrtq8iseXdriJkZX/8yGyrHvgLElKV6Tm
         1iHxTxjbEa/81Fampr9IkFYPSg06S3HiDBC7WSjyX7nFYD059JNqqyvFNFl116VqYTC+
         NTnucqasXMR4TWhwg9QBQcL3fErmAB4wffkM/X1YnzUicVxZ6Gf58yLajDFiz8jBURur
         3EN6ZqiGcrQ8xmVOFJ88s9iL6FgULvn68IR1p+tCRWQuht+rYVtbuqDUrBFy0VRPJj14
         QfyA==
X-Gm-Message-State: AFqh2kqPrBRrxgV75Bd8jIv1gfND5DqcG5pgzVMgWPqPyhaP9jQjlaUo
        lTdYD/IsHVPZv/nxUlnW4vR+13usfNPSb/KH4+evKT4LquRPOJa8cbZAoL6biReFMiwj03+CNWy
        arDeuloxYanqH6qbzgcKLs2nFhg==
X-Received: by 2002:a05:651c:12c4:b0:285:bdde:bb4f with SMTP id 4-20020a05651c12c400b00285bddebb4fmr8535622lje.25.1673872434094;
        Mon, 16 Jan 2023 04:33:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtO9rWX1tkTT/Zfl5wi/eC51aVJ6XGkZQH0k2654veSaAdp7U4lu1Gr5k3PiDHs5U6jOE1iIg==
X-Received: by 2002:a05:651c:12c4:b0:285:bdde:bb4f with SMTP id 4-20020a05651c12c400b00285bddebb4fmr8535616lje.25.1673872433815;
        Mon, 16 Jan 2023 04:33:53 -0800 (PST)
Received: from greebo.mooo.com ([85.226.165.230])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b0027fb9e64bd0sm932865ljn.86.2023.01.16.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:33:53 -0800 (PST)
Message-ID: <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
Date:   Mon, 16 Jan 2023 13:33:50 +0100
In-Reply-To: <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
References: <cover.1673623253.git.alexl@redhat.com>
         <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
         <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
         <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
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

On Mon, 2023-01-16 at 18:19 +0800, Gao Xiang wrote:
> Hi Alexander,
>=20
> On 2023/1/16 17:30, Alexander Larsson wrote:
> >=20
> > I mean, you're not wrong about this being possible. But I don't see
> > that this is necessarily a new problem. For example, consider the
> > case
> > of loopback mounting an ext4 filesystem containing a setuid /bin/su
> > file. If you have the right permissions, nothing prohibits you from
> > modifying the loopback mounted file and replacing the content of
> > the su
> > file with a copy of bash.
> >=20
> > In both these cases, the security of the system is fully defined by
> > the
> > filesystem permissions of the backing file data. I think viewing
> > composefs as a "new type" of overlayfs gets the wrong idea across.
> > Its
> > more similar to a "new type" of loopback mount. In particular, the
> > backing file metadata is completely unrelated to the metadata
> > exposed
> > by the filesystem, which means that you can chose to protect the
> > backing files (and directories) in ways which protect against
> > changes
> > from non-privileged users.
> >=20
> > Note: The above assumes that mounting either a loopback mount or a
> > composefs image is a privileged operation. Allowing unprivileged
> > mounts
> > is a very different thing.
>=20
> Thanks for the reply.=C2=A0 I think if I understand correctly, I could
> answer some of your questions.=C2=A0 Hopefully help to everyone
> interested.
>=20
> Let's avoid thinking unprivileged mounts first, although Giuseppe
> told
> me earilier that is also a future step of Composefs. But I don't know
> how it could work reliably if a fs has some on-disk format, we could
> discuss it later.
>=20
> I think as a loopback mount, such loopback files are quite under
> control
> (take ext4 loopback mount as an example, each ext4 has the only one
> file
> =C2=A0 to access when setting up loopback devices and such loopback file
> was
> =C2=A0 also opened when setting up loopback mount so it cannot be
> replaced.
>=20
> =C2=A0 If you enables fsverity for such loopback mount before, it cannot
> be
> =C2=A0 modified as well) by admins.
>=20
>=20
> But IMHO, here composefs shows a new model that some stackable
> filesystem can point to massive files under a random directory as
> what
> ostree does (even files in such directory can be bind-mounted later
> in
> principle).=C2=A0 But the original userspace ostree strictly follows
> underlayfs permission check but Composefs can override
> uid/gid/permission instead.

Suppose you have:

-rw-r--r-- root root image.ext4
-rw-r--r-- root root image.composefs
drwxr--r-- root root objects/
-rw-r--r-- root root objects/backing.file

Are you saying it is easier for someone to modify backing.file than
image.ext4?=C2=A0

I argue it is not, but composefs takes some steps to avoid issues here.
At mount time, when the basedir ("objects/" above) argument is parsed,
we resolve that path and then create a private vfsmount for it:=20

 resolve_basedir(path) {
        ...
	mnt =3D clone_private_mount(&path);
        ...
 }

 fsi->bases[i] =3D resolve_basedir(path);

Then we open backing files with this mount as root:

 real_file =3D file_open_root_mnt(fsi->bases[i], real_path,
 			        file->f_flags, 0);

This will never resolve outside the initially specified basedir, even
with symlinks or whatever. It will also not be affected by later mount
changes in the original mount namespace, as this is a private mount.=C2=A0

This is the same mechanism that overlayfs uses for its upper dirs.

I would argue that anyone who has rights to modify the contents of
files in "objects" (supposing they were created with sane permissions)
would also have rights to modify "image.ext4".

> That is also why we selected fscache at the first time to manage all
> local cache data for EROFS, since such content-defined directory is
> quite under control by in-kernel fscache instead of selecting a
> random directory created and given by some userspace program.
>=20
> If you are interested in looking info the current in-kernel fscache
> behavior, I think that is much similar as what ostree does now.
>=20
> It just needs new features like
> =C2=A0=C2=A0 - multiple directories;
> =C2=A0=C2=A0 - daemonless
> to match.
>=20

Obviously everything can be extended to support everything. But
composefs is very small and simple (2128 lines of code), while at the
same time being easy to use (just mount it with one syscall) and needs
no complex userspace machinery and configuration. But even without the
above feature additions fscache + cachefiles is 7982 lines, plus erofs
is 9075 lines, and then on top of that you need userspace integration
to even use the thing.

Don't take me wrong, EROFS is great for its usecases, but I don't
really think it is the right choice for my usecase.

> > >=20
> > Secondly, the use of fs-cache doesn't stack, as there can only be
> > one
> > cachefs agent. For example, mixing an ostree EROFS boot with a
> > container backend using EROFS isn't possible (at least without deep
> > integration between the two userspaces).
>=20
> The reasons above are all current fscache implementation limitation:
>=20
> =C2=A0 - First, if such overlay model really works, EROFS can do it
> without
> fscache feature as well to integrate userspace ostree.=C2=A0 But even tha=
t
> I hope this new feature can be landed in overlayfs rather than some
> other ways since it has native writable layer so we don't need
> another
> overlayfs mount at all for writing;

I don't think it is the right approach for overlayfs to integrate
something like image support. Merging the two codebases would
complicate both while adding costs to users who need only support for
one of the features. I think reusing and stacking separate features is
a better idea than combining them.=20

>=20
> >=20
> > Instead what we have done with composefs is to make filesystem
> > image
> > generation from the ostree repository 100% reproducible. Then we
> > can
>=20
> EROFS is all 100% reproduciable as well.
>=20


Really, so if I today, on fedora 36 run:
# tar xvf oci-image.tar
# mkfs.erofs oci-dir/ oci.erofs

And then in 5 years, if someone on debian 13 runs the same, with the
same tar file, then both oci.erofs files will have the same sha256
checksum?

How do you handle things like different versions or builds of
compression libraries creating different results? Do you guarantee to
not add any new backwards compat changes by default, or change any
default options? Do you guarantee that the files are read from "oci-
dir" in the same order each time? It doesn't look like it.

>=20
> But really, personally I think the issue above is different from
> loopback devices and may need to be resolved first. And if possible,
> I hope it could be an new overlayfs feature for everyone.

Yeah. Independent of composefs, I think EROFS would be better if you
could just point it to a chunk directory at mount time rather than
having to route everything through a system-wide global cachefs
singleton. I understand that cachefs does help with the on-demand
download aspect, but when you don't need that it is just in the way.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a one-legged guitar-strumming firefighter who hides his scarred
face=20
behind a mask. She's an orphaned gypsy lawyer with a flame-thrower.
They=20
fight crime!=20

