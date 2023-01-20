Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F1676013
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjATWTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 17:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjATWTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735F3756D
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 14:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674253135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttCtnEhmcdmpjXT22WyUtaA03omrvJCxRoqh5h6JIuI=;
        b=QgRbng8nOJ8iC0BTdqxJD5+lVnPjboEffX0VNRMyhyjSbpZN1/XaApP+ORaI6r8S9c7QZA
        33K3A4b0p0gh05H1BAj9f2nKau8Px5+iCGyjvHHxk/Ad6LK1Fb+spWRTRdqp1h525u8jHu
        LbfFOzql6Oo7uDYjkj0TUKuWZNGSzpE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-4ISMl0y1NpmIY0VAfhs5Iw-1; Fri, 20 Jan 2023 17:18:52 -0500
X-MC-Unique: 4ISMl0y1NpmIY0VAfhs5Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 325241C05B12;
        Fri, 20 Jan 2023 22:18:52 +0000 (UTC)
Received: from localhost (unknown [10.39.194.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 163C72026D68;
        Fri, 20 Jan 2023 22:18:50 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
References: <cover.1674227308.git.alexl@redhat.com>
        <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
Date:   Fri, 20 Jan 2023 23:18:48 +0100
In-Reply-To: <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 20 Jan 2023 21:44:46 +0200")
Message-ID: <87ilh0g88n.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrot=
e:
>>
>> Giuseppe Scrivano and I have recently been working on a new project we
>> call composefs. This is the first time we propose this publically and
>> we would like some feedback on it.
>>
>> At its core, composefs is a way to construct and use read only images
>> that are used similar to how you would use e.g. loop-back mounted
>> squashfs images. On top of this composefs has two fundamental
>> features. First it allows sharing of file data (both on disk and in
>> page cache) between images, and secondly it has dm-verity like
>> validation on read.
>>
>> Let me first start with a minimal example of how this can be used,
>> before going into the details:
>>
>> Suppose we have this source for an image:
>>
>> rootfs/
>> =E2=94=9C=E2=94=80=E2=94=80 dir
>> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 another_a
>> =E2=94=9C=E2=94=80=E2=94=80 file_a
>> =E2=94=94=E2=94=80=E2=94=80 file_b
>>
>> We can then use this to generate an image file and a set of
>> content-addressed backing files:
>>
>> # mkcomposefs --digest-store=3Dobjects rootfs/ rootfs.img
>> # ls -l rootfs.img objects/*/*
>> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb699191=
87bb78d394e235ce444eeb0a890d37e955827fe4bf4
>> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc9944=
3f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
>>
>> The rootfs.img file contains all information about directory and file
>> metadata plus references to the backing files by name. We can now
>> mount this and look at the result:
>>
>> # mount -t composefs rootfs.img -o basedir=3Dobjects /mnt
>> # ls  /mnt/
>> dir  file_a  file_b
>> # cat /mnt/file_a
>> content_a
>>
>> When reading this file the kernel is actually reading the backing
>> file, in a fashion similar to overlayfs. Since the backing file is
>> content-addressed, the objects directory can be shared for multiple
>> images, and any files that happen to have the same content are
>> shared. I refer to this as opportunistic sharing, as it is different
>> than the more course-grained explicit sharing used by e.g. container
>> base images.
>>
>> The next step is the validation. Note how the object files have
>> fs-verity enabled. In fact, they are named by their fs-verity digest:
>>
>> # fsverity digest objects/*/*
>> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 =
objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
>> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f =
objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>
>> The generated filesystm image may contain the expected digest for the
>> backing files. When the backing file digest is incorrect, the open
>> will fail, and if the open succeeds, any other on-disk file-changes
>> will be detected by fs-verity:
>>
>> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d=
43e173f
>> content_a
>> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b2=
3d43e173f
>> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d1=
8883dc89b23d43e173f
>> # cat /mnt/file_a
>> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0=
a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
>> cat: /mnt/file_a: Input/output error
>>
>> This re-uses the existing fs-verity functionallity to protect against
>> changes in file contents, while adding on top of it protection against
>> changes in filesystem metadata and structure. I.e. protecting against
>> replacing a fs-verity enabled file or modifying file permissions or
>> xattrs.
>>
>> To be fully verified we need another step: we use fs-verity on the
>> image itself. Then we pass the expected digest on the mount command
>> line (which will be verified at mount time):
>>
>> # fsverity enable rootfs.img
>> # fsverity digest rootfs.img
>> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 =
rootfs.img
>> # mount -t composefs rootfs.img -o basedir=3Dobjects,digest=3Dda42003782=
992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
>>
>> So, given a trusted set of mount options (say unlocked from TPM), we
>> have a fully verified filesystem tree mounted, with opportunistic
>> finegrained sharing of identical files.
>>
>> So, why do we want this? There are two initial users. First of all we
>> want to use the opportunistic sharing for the podman container image
>> baselayer. The idea is to use a composefs mount as the lower directory
>> in an overlay mount, with the upper directory being the container work
>> dir. This will allow automatical file-level disk and page-cache
>> sharning between any two images, independent of details like the
>> permissions and timestamps of the files.
>>
>> Secondly we are interested in using the verification aspects of
>> composefs in the ostree project. Ostree already supports a
>> content-addressed object store, but it is currently referenced by
>> hardlink farms. The object store and the trees that reference it are
>> signed and verified at download time, but there is no runtime
>> verification. If we replace the hardlink farm with a composefs image
>> that points into the existing object store we can use the verification
>> to implement runtime verification.
>>
>> In fact, the tooling to create composefs images is 100% reproducible,
>> so all we need is to add the composefs image fs-verity digest into the
>> ostree commit. Then the image can be reconstructed from the ostree
>> commit info, generating a file with the same fs-verity digest.
>>
>> These are the usecases we're currently interested in, but there seems
>> to be a breadth of other possible uses. For example, many systems use
>> loopback mounts for images (like lxc or snap), and these could take
>> advantage of the opportunistic sharing. We've also talked about using
>> fuse to implement a local cache for the backing files. I.e. you would
>> have the second basedir be a fuse filesystem. On lookup failure in the
>> first basedir it downloads the file and saves it in the first basedir
>> for later lookups. There are many interesting possibilities here.
>>
>> The patch series contains some documentation on the file format and
>> how to use the filesystem.
>>
>> The userspace tools (and a standalone kernel module) is available
>> here:
>>   https://github.com/containers/composefs
>>
>> Initial work on ostree integration is here:
>>   https://github.com/ostreedev/ostree/pull/2640
>>
>> Changes since v2:
>> - Simplified filesystem format to use fixed size inodes. This resulted
>>   in simpler (now < 2k lines) code as well as higher performance at
>>   the cost of slightly (~40%) larger images.
>> - We now use multi-page mappings from the page cache, which removes
>>   limits on sizes of xattrs and makes the dirent handling code simpler.
>> - Added more documentation about the on-disk file format.
>> - General cleanups based on review comments.
>>
>
> Hi Alexander,
>
> I must say that I am a little bit puzzled by this v3.
> Gao, Christian and myself asked you questions on v2
> that are not mentioned in v3 at all.
>
> To sum it up, please do not propose composefs without explaining
> what are the barriers for achieving the exact same outcome with
> the use of a read-only overlayfs with two lower layer -
> uppermost with erofs containing the metadata files, which include
> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
> to the lowermost layer containing the content files.

I think Dave explained quite well why using overlay is not comparable to
what composefs does.

One big difference is that overlay still requires at least a syscall for
each file in the image, and then we need the equivalent of "rm -rf" to
clean it up.  It is somehow acceptable for long-running services, but it
is not for "serverless" containers where images/containers are created
and destroyed frequently.  So even in the case we already have all the
image files available locally, we still need to create a checkout with
the final structure we need for the image.

I also don't see how overlay would solve the verified image problem.  We
would have the same problem we have today with fs-verity as it can only
validate a single file but not the entire directory structure.  Changes
that affect the layer containing the trusted.overlay.{metacopy,redirect}
xattrs won't be noticed.

There are at the moment two ways to handle container images, both somehow
guided by the available file systems in the kernel.

- A single image mounted as a block device.
- A list of tarballs (OCI image) that are unpacked and mounted as
  overlay layers.

One big advantage of the block devices model is that you can use
dm-verity, this is something we miss today with OCI container images
that use overlay.

What we are proposing with composefs is a way to have "dm-verity" style
validation based on fs-verity and the possibility to share individual
files instead of layers.  These files can also be on different file
systems, which is something not possible with the block device model.

The composefs manifest blob could be generated remotely and signed.  A
client would need just to validate the signature for the manifest blob
and from there retrieve the files that are not in the local CAS (even
from an insecure source) and mount directly the manifest file.

Regards,
Giuseppe

> Any current functionality gap in erofs and/or in overlayfs
> cannot be considered as a reason to maintain a new filesystem
> driver unless you come up with an explanation why closing that
> functionality gap is not possible or why the erofs+overlayfs alternative
> would be inferior to maintaining a new filesystem driver.
>
> From the conversations so far, it does not seem like Gao thinks
> that the functionality gap in erofs cannot be closed and I don't
> see why the functionality gap in overlayfs cannot be closed.
>
> Are we missing something?
>
> Thanks,
> Amir.

