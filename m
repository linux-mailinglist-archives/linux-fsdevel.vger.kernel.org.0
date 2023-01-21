Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF06766FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAUPCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 10:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUPB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644C1F91E
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674313273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8nNIstqHDK1jcJR7rp1LMlx2AdOMHJ0AHKTD8S+pTw=;
        b=BbN3PLzbVcTaNd15zT0uqxRbkuuWioyAMclB44wuzRVIyye0FTzLCMy1DXlGFNr62KdAr2
        pArQ6Jl8+nFuPwu5eyk7Eg6FgWxQqAvZi+X7MqCkQvKQTOfN3BwJtVVp1O4+gq49Sk9sU5
        5UXLegG/WWu5Bl/woG1LNLmBxWmjW7U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-Q75lJskbNtubTZD7ezHjPQ-1; Sat, 21 Jan 2023 10:01:09 -0500
X-MC-Unique: Q75lJskbNtubTZD7ezHjPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 055191C0514D;
        Sat, 21 Jan 2023 15:01:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19D1E492C3C;
        Sat, 21 Jan 2023 15:01:01 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
In-Reply-To: <CAOQ4uxi7wT09MPf+edS6AkJzBCxjzOnCTfcdwn===q-+G2C4Gw@mail.gmail.com>
        (Amir Goldstein's message of "Sat, 21 Jan 2023 12:57:24 +0200")
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        <87ilh0g88n.fsf@redhat.com>
        <CAOQ4uxi7wT09MPf+edS6AkJzBCxjzOnCTfcdwn===q-+G2C4Gw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Sat, 21 Jan 2023 16:01:00 +0100
Message-ID: <87cz78exub.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Sat, Jan 21, 2023 at 12:18 AM Giuseppe Scrivano <gscrivan@redhat.com> =
wrote:
>>
>> Hi Amir,
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>>
>> > On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> w=
rote:
>> >>
>> >> Giuseppe Scrivano and I have recently been working on a new project we
>> >> call composefs. This is the first time we propose this publically and
>> >> we would like some feedback on it.
>> >>
>> >> At its core, composefs is a way to construct and use read only images
>> >> that are used similar to how you would use e.g. loop-back mounted
>> >> squashfs images. On top of this composefs has two fundamental
>> >> features. First it allows sharing of file data (both on disk and in
>> >> page cache) between images, and secondly it has dm-verity like
>> >> validation on read.
>> >>
>> >> Let me first start with a minimal example of how this can be used,
>> >> before going into the details:
>> >>
>> >> Suppose we have this source for an image:
>> >>
>> >> rootfs/
>> >> =E2=94=9C=E2=94=80=E2=94=80 dir
>> >> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 another_a
>> >> =E2=94=9C=E2=94=80=E2=94=80 file_a
>> >> =E2=94=94=E2=94=80=E2=94=80 file_b
>> >>
>> >> We can then use this to generate an image file and a set of
>> >> content-addressed backing files:
>> >>
>> >> # mkcomposefs --digest-store=3Dobjects rootfs/ rootfs.img
>> >> # ls -l rootfs.img objects/*/*
>> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb699=
19187bb78d394e235ce444eeb0a890d37e955827fe4bf4
>> >> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc9=
9443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>> >> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
>> >>
>> >> The rootfs.img file contains all information about directory and file
>> >> metadata plus references to the backing files by name. We can now
>> >> mount this and look at the result:
>> >>
>> >> # mount -t composefs rootfs.img -o basedir=3Dobjects /mnt
>> >> # ls  /mnt/
>> >> dir  file_a  file_b
>> >> # cat /mnt/file_a
>> >> content_a
>> >>
>> >> When reading this file the kernel is actually reading the backing
>> >> file, in a fashion similar to overlayfs. Since the backing file is
>> >> content-addressed, the objects directory can be shared for multiple
>> >> images, and any files that happen to have the same content are
>> >> shared. I refer to this as opportunistic sharing, as it is different
>> >> than the more course-grained explicit sharing used by e.g. container
>> >> base images.
>> >>
>> >> The next step is the validation. Note how the object files have
>> >> fs-verity enabled. In fact, they are named by their fs-verity digest:
>> >>
>> >> # fsverity digest objects/*/*
>> >> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4b=
f4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
>> >> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e17=
3f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>> >>
>> >> The generated filesystm image may contain the expected digest for the
>> >> backing files. When the backing file digest is incorrect, the open
>> >> will fail, and if the open succeeds, any other on-disk file-changes
>> >> will be detected by fs-verity:
>> >>
>> >> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b=
23d43e173f
>> >> content_a
>> >> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc8=
9b23d43e173f
>> >> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a=
1d18883dc89b23d43e173f
>> >> # cat /mnt/file_a
>> >> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e8=
5e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
>> >> cat: /mnt/file_a: Input/output error
>> >>
>> >> This re-uses the existing fs-verity functionallity to protect against
>> >> changes in file contents, while adding on top of it protection against
>> >> changes in filesystem metadata and structure. I.e. protecting against
>> >> replacing a fs-verity enabled file or modifying file permissions or
>> >> xattrs.
>> >>
>> >> To be fully verified we need another step: we use fs-verity on the
>> >> image itself. Then we pass the expected digest on the mount command
>> >> line (which will be verified at mount time):
>> >>
>> >> # fsverity enable rootfs.img
>> >> # fsverity digest rootfs.img
>> >> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a=
76 rootfs.img
>> >> # mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda42003=
782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
>> >>
>> >> So, given a trusted set of mount options (say unlocked from TPM), we
>> >> have a fully verified filesystem tree mounted, with opportunistic
>> >> finegrained sharing of identical files.
>> >>
>> >> So, why do we want this? There are two initial users. First of all we
>> >> want to use the opportunistic sharing for the podman container image
>> >> baselayer. The idea is to use a composefs mount as the lower directory
>> >> in an overlay mount, with the upper directory being the container work
>> >> dir. This will allow automatical file-level disk and page-cache
>> >> sharning between any two images, independent of details like the
>> >> permissions and timestamps of the files.
>> >>
>> >> Secondly we are interested in using the verification aspects of
>> >> composefs in the ostree project. Ostree already supports a
>> >> content-addressed object store, but it is currently referenced by
>> >> hardlink farms. The object store and the trees that reference it are
>> >> signed and verified at download time, but there is no runtime
>> >> verification. If we replace the hardlink farm with a composefs image
>> >> that points into the existing object store we can use the verification
>> >> to implement runtime verification.
>> >>
>> >> In fact, the tooling to create composefs images is 100% reproducible,
>> >> so all we need is to add the composefs image fs-verity digest into the
>> >> ostree commit. Then the image can be reconstructed from the ostree
>> >> commit info, generating a file with the same fs-verity digest.
>> >>
>> >> These are the usecases we're currently interested in, but there seems
>> >> to be a breadth of other possible uses. For example, many systems use
>> >> loopback mounts for images (like lxc or snap), and these could take
>> >> advantage of the opportunistic sharing. We've also talked about using
>> >> fuse to implement a local cache for the backing files. I.e. you would
>> >> have the second basedir be a fuse filesystem. On lookup failure in the
>> >> first basedir it downloads the file and saves it in the first basedir
>> >> for later lookups. There are many interesting possibilities here.
>> >>
>> >> The patch series contains some documentation on the file format and
>> >> how to use the filesystem.
>> >>
>> >> The userspace tools (and a standalone kernel module) is available
>> >> here:
>> >>   https://github.com/containers/composefs
>> >>
>> >> Initial work on ostree integration is here:
>> >>   https://github.com/ostreedev/ostree/pull/2640
>> >>
>> >> Changes since v2:
>> >> - Simplified filesystem format to use fixed size inodes. This resulted
>> >>   in simpler (now < 2k lines) code as well as higher performance at
>> >>   the cost of slightly (~40%) larger images.
>> >> - We now use multi-page mappings from the page cache, which removes
>> >>   limits on sizes of xattrs and makes the dirent handling code simple=
r.
>> >> - Added more documentation about the on-disk file format.
>> >> - General cleanups based on review comments.
>> >>
>> >
>> > Hi Alexander,
>> >
>> > I must say that I am a little bit puzzled by this v3.
>> > Gao, Christian and myself asked you questions on v2
>> > that are not mentioned in v3 at all.
>> >
>> > To sum it up, please do not propose composefs without explaining
>> > what are the barriers for achieving the exact same outcome with
>> > the use of a read-only overlayfs with two lower layer -
>> > uppermost with erofs containing the metadata files, which include
>> > trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
>> > to the lowermost layer containing the content files.
>>
>> I think Dave explained quite well why using overlay is not comparable to
>> what composefs does.
>>
>
> Where? Can I get a link please?

I am referring to this message: https://lore.kernel.org/lkml/20230118002242=
.GB937597@dread.disaster.area/

> If there are good reasons why composefs is superior to erofs+overlayfs
> Please include them in the submission, since several developers keep
> raising the same questions - that is all I ask.
>
>> One big difference is that overlay still requires at least a syscall for
>> each file in the image, and then we need the equivalent of "rm -rf" to
>> clean it up.  It is somehow acceptable for long-running services, but it
>> is not for "serverless" containers where images/containers are created
>> and destroyed frequently.  So even in the case we already have all the
>> image files available locally, we still need to create a checkout with
>> the final structure we need for the image.
>>
>
> I think you did not understand my suggestion:
>
> overlay read-only mount:
>     layer 1: erofs mount of a precomposed image (same as mkcomposefs)
>     layer 2: any pre-existing fs path with /blocks repository
>     layer 3: any per-existing fs path with /blocks repository
>     ...
>
> The mkcomposefs flow is exactly the same in this suggestion
> the upper layer image is created without any syscalls and
> removed without any syscalls.

mkcomposefs is supposed to be used server side, when the image is built.
The clients that will mount the image don't have to create it (at least
for images that will provide the manifest).

So this is quite different as in the overlay model we must create the
layout, that is the equivalent of the composefs manifest, on any node
the image is pulled to.

> Overlayfs already has the feature of redirecting from upper layer
> to relative paths in lower layers.

Could you please provide more information on how you would compose the
overlay image first?

From what I can see, it still requires at least one syscall for each
file in the image to be created and these images are not portable to a
different machine.

Should we always make "/blocks" a whiteout to prevent it is leaked in
the container?

And what prevents files under "/blocks" to be replaced with a different
version?  I think fs-verity on the EROFS image itself won't cover it.

>> I also don't see how overlay would solve the verified image problem.  We
>> would have the same problem we have today with fs-verity as it can only
>> validate a single file but not the entire directory structure.  Changes
>> that affect the layer containing the trusted.overlay.{metacopy,redirect}
>> xattrs won't be noticed.
>>
>
> The entire erofs image would be fsverified including the overlayfs xattrs.
> That is exactly the same model as composefs.
> I am not even saying that your model is wrong, only that you are within
> reach of implementing it with existing subsystems.

now we can do:

mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda4200378299285=
6240a3e25264b19601016114775debd80c01620260af86a76 /mnt

that is quite useful for mounting the OS image, as is the OSTree case.

How would that be possible with the setup you are proposing?  Would
overlay gain a new "digest=3D" kind of option to validate its first layer?

>> There are at the moment two ways to handle container images, both somehow
>> guided by the available file systems in the kernel.
>>
>> - A single image mounted as a block device.
>> - A list of tarballs (OCI image) that are unpacked and mounted as
>>   overlay layers.
>>
>> One big advantage of the block devices model is that you can use
>> dm-verity, this is something we miss today with OCI container images
>> that use overlay.
>>
>> What we are proposing with composefs is a way to have "dm-verity" style
>> validation based on fs-verity and the possibility to share individual
>> files instead of layers.  These files can also be on different file
>> systems, which is something not possible with the block device model.
>>
>> The composefs manifest blob could be generated remotely and signed.  A
>> client would need just to validate the signature for the manifest blob
>> and from there retrieve the files that are not in the local CAS (even
>> from an insecure source) and mount directly the manifest file.
>>
>
> Excellent description of the problem.
> I agree that we need a hybrid solution between the block
> and tarball image model.
>
> All I am saying is that this solution can use existing kernel
> components and existing established on-disk formats
> (erofs+overlayfs).
>
> What was missing all along was the userspace component
> (i.e. composefs) and I am very happy that you guys are
> working on this project.
>
> These userspace tools could be useful for other use cases.
> For example, overlayfs is able to describe a large directory
> rename with redirect xattr since v4.9, but image composing
> tools do not make use of that, so an OCI image describing a
> large dir rename will currently contain all the files within.
>
> Once again, you may or may not be able to use erofs and
> overlayfs out of the box for your needs, but so far I did not
> see any functionality gap that is not possible to close.
>
> Please let me know if you know of such gaps or if my
> proposal does not meet the goals of composefs.

thanks for your helpful comments.

Regards,
Giuseppe

