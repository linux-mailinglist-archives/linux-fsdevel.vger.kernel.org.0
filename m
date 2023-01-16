Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF066BA60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjAPJb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 04:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjAPJbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:31:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082016AC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673861431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0zbe5Wv4qmr2PUPl8qLqbaGH6Ky1QQLhULVocB+QQ68=;
        b=IFoJCpLY0+pPF9jugbAyJL81y3j15Wn4tSGzTl1yWzF7T54rQd3qzsZxEJc3FujUEzfeeN
        daVCopJJzHhC+Li1iPluUnnmaCMo7EI4XjCMMawqcCHm0CIIFO9CfU3X8DMMwKe9lySCBK
        GrHofvl9xx7sJZcU4BLuxBbQKgWH/iQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-w8DU3TSTOnmoSMNWvPUY1g-1; Mon, 16 Jan 2023 04:30:30 -0500
X-MC-Unique: w8DU3TSTOnmoSMNWvPUY1g-1
Received: by mail-lj1-f197.google.com with SMTP id z26-20020a2e885a000000b0028b760713a3so1232075ljj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 01:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0zbe5Wv4qmr2PUPl8qLqbaGH6Ky1QQLhULVocB+QQ68=;
        b=sibXawBhzrRE6xBhgDN9sK7cDhdnayB/F7LLfbQIe0biVAiqorjfL8j0GZdg6XXkDX
         UfyazzzKVZBtpYcyCQqwWVzRe5vSiiQQYOnejVrtMJUYSaweq1yi0ALZuhGMBQvvv6sf
         dYD1I8lV+CkwenNh5ayz/5MiRrdmnfhKg4rOeHpoNnmWU5PwSNDRJAsOKW9E1ha7z5fh
         1APLZhWwi54D+Ot1QsR6G1Q4ohGNEy/3hVD5Y3t9Cpp6i45RcJ5GPNRhxVIRJM7Rw8Pj
         oCMj/Mjl/ZMzLJi5giI2mq7yVIhb1+Seub2J6d8xUL/jlFLDmcwb7P2L7gZ3gC4GO5zb
         L6kA==
X-Gm-Message-State: AFqh2kq07Lc3AgYPY3PPy7BmwLSUjbadqImQhqesOzXElO2d+OAQas6K
        IgxXY8XIVyxfCFuwF/CADML79QS8AgQ/02kjnTmU3gIL1CBjxgdp8o8LPncD2g77Q3yj2+xGkfD
        RsK5h4YimqvPXEmPPLb5Wb/i3aw==
X-Received: by 2002:a05:6512:108f:b0:4cc:7b49:a2f6 with SMTP id j15-20020a056512108f00b004cc7b49a2f6mr11073840lfg.19.1673861428757;
        Mon, 16 Jan 2023 01:30:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvtCfu1+sVpejm0bMRKGIemtrDusfhD4vLSyb5d/7mafJ9f0dW33NYYaJ+rOz0lqEvdi8jIkA==
X-Received: by 2002:a05:6512:108f:b0:4cc:7b49:a2f6 with SMTP id j15-20020a056512108f00b004cc7b49a2f6mr11073835lfg.19.1673861428416;
        Mon, 16 Jan 2023 01:30:28 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id t11-20020a056512208b00b004cc83be556dsm3854624lfr.247.2023.01.16.01.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:30:27 -0800 (PST)
Message-ID: <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
Date:   Mon, 16 Jan 2023 10:30:27 +0100
In-Reply-To: <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
References: <cover.1673623253.git.alexl@redhat.com>
         <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
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

On Mon, 2023-01-16 at 12:44 +0800, Gao Xiang wrote:
> Hi Alexander and folks,
>=20
> I'd like to say sorry about comments in LWN.net article.=C2=A0 If it help=
s
> to the community,=C2=A0 my own concern about this new overlay model was
> (which is different from overlayfs since overlayfs doesn't have
> =C2=A0 different permission of original files) somewhat a security issue
> (as
> I told Giuseppe Scrivano before when he initially found me on slack):
>=20
> As composefs on-disk shown:
>=20
> struct cfs_inode_s {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_mode; /* File type=
 and mode.=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_nlink; /* Number o=
f hard links, only for regular
> files.=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_uid; /* User ID of=
 owner.=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 st_gid; /* Group ID o=
f owner.=C2=A0 */
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> };
>=20
> It seems Composefs can override uid / gid and mode bits of the
> original file
>=20
> =C2=A0=C2=A0=C2=A0 considering a rootfs image:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 /bin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=
=E2=94=80 su
>=20
> /bin/su has SUID bit set in the Composefs inode metadata, but I
> didn't
> find some clues if ostree "objects/abc" could be actually replaced
> with data of /bin/sh if composefs fsverity feature is disabled (it
> doesn't seem composefs enforcely enables fsverity according to
> documentation).
>=20
> I think that could cause _privilege escalation attack_ of these SUID
> files is replaced with some root shell.=C2=A0 Administrators cannot keep
> all the time of these SUID files because such files can also be
> replaced at runtime.
>=20
> Composefs may assume that ostree is always for such content-addressed
> directory.=C2=A0 But if considering it could laterly be an upstream fs, I
> think we cannot always tell people "no, don't use this way, it
> doesn't
> work" if people use Composefs under an untrusted repo (maybe even
> without ostree).
>=20
> That was my own concern at that time when Giuseppe Scrivano told me
> to enhance EROFS as this way, and I requested him to discuss this in
> the fsdevel mailing list in order to resolve this, but it doesn't
> happen.
>=20
> Otherwise, EROFS could face such issue as well, that is why I think
> it needs to be discussed first.

I mean, you're not wrong about this being possible. But I don't see
that this is necessarily a new problem. For example, consider the case
of loopback mounting an ext4 filesystem containing a setuid /bin/su
file. If you have the right permissions, nothing prohibits you from
modifying the loopback mounted file and replacing the content of the su
file with a copy of bash.

In both these cases, the security of the system is fully defined by the
filesystem permissions of the backing file data. I think viewing
composefs as a "new type" of overlayfs gets the wrong idea across. Its
more similar to a "new type" of loopback mount. In particular, the
backing file metadata is completely unrelated to the metadata exposed
by the filesystem, which means that you can chose to protect the
backing files (and directories) in ways which protect against changes
from non-privileged users.

Note: The above assumes that mounting either a loopback mount or a
composefs image is a privileged operation. Allowing unprivileged mounts
is a very different thing.

> > To be fully verified we need another step: we use fs-verity on the
> > image itself. Then we pass the expected digest on the mount command
> > line (which will be verified at mount time):
> >=20
> > # fsverity enable rootfs.img
> > # fsverity digest rootfs.img
> > sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af8
> > 6a76 rootfs.img
> > # mount -t composefs rootfs.img -o
> > basedir=3Dobjects,digest=3Dda42003782992856240a3e25264b19601016114775de
> > bd80c01620260af86a76 /mnt
> >=20
>=20
>=20
> It seems that Composefs uses fsverity_get_digest() to do fsverity
> check.=C2=A0 If Composefs uses symlink-like payload to redirect a file to
> another underlayfs file, such underlayfs file can exist in any other
> fses.
>=20
> I can see Composefs could work with ext4, btrfs, f2fs, and later XFS
> but I'm not sure how it could work with overlayfs, FUSE, or other
> network fses.=C2=A0 That could limit the use cases as well.

Yes, if you chose to store backing files on a non-fs-verity enabled
filesystem you cannot use the fs-verity feature. But this is just a
decision users of composefs have to take if they wish to use this
particular feature. I think re-using fs-verity like this is a better
approach than re-implementing verity.

> Except for the above, I think EROFS could implement this in about
> 300~500 new lines of code as Giuseppe found me, or squashfs or
> overlayfs.
>=20
> I'm very happy to implement such model if it can be proved as safe
> (I'd also like to say here by no means I dislike ostree) and I'm
> also glad if folks feel like to introduce a new file system for
> this as long as this overlay model is proved as safe.

My personal target usecase is that of the ostree trusted root
filesystem, and it has a lot of specific requirements that lead to
choices in the design of composefs. I took a look at EROFS a while ago,
and I think that even with some verify-like feature it would not fit
this usecase.=20

EROFS does indeed do some of the file-sharing aspects of composefs with
its use of fs-cache (although the current n_chunk limit would need to
be raised). However, I think there are two problems with this.=C2=A0

First of all is the complexity of having to involve a userspace for the
cache. For trusted boot to work we have to have all the cachefs
userspace machinery on the (signed) initrd, and then have to properly
transition this across the pivot-root into the full os boot. I'm sure
it is technically *possible*, but it is very complex and a pain to set
up and maintain.

Secondly, the use of fs-cache doesn't stack, as there can only be one
cachefs agent. For example, mixing an ostree EROFS boot with a
container backend using EROFS isn't possible (at least without deep
integration between the two userspaces).

Also, f we ignore the file sharing aspects there is the question of how
to actually integrate a new digest-based image format with the pre-
existing ostree formats and distribution mechanisms. If we just replace
everything with distributing a signed image file then we can easily use
existing technology (say dm-verity + squashfs + loopback). However,
this would be essentially A/B booting and we would lose all the
advantages of ostree.=C2=A0

Instead what we have done with composefs is to make filesystem image
generation from the ostree repository 100% reproducible. Then we can
keep the entire pre-existing ostree distribution mechanism and on-disk
repo format, adding just a single piece of metadata to the ostree
commit, containing the composefs toplevel digest. Then the client can
easily and efficiently re-generate the composefs image locally, and
boot into it specifying the trusted not-locally-generated digest. A
filesystem that doesn't have this reproduceability feature isn't going
to be possible to integrate with ostree without enormous changes to
ostree, and a filesystem more complex that composefs will have a hard
time giving such guarantees.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's an unconventional gay card sharp moving from town to town, helping
folk in trouble. She's a virginal goth bounty hunter descended from a=20
line of powerful witches. They fight crime!=20

