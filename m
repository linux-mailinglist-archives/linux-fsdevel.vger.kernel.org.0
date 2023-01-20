Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31190675874
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjATPYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjATPYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A8DA8C4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6aN4iSq6f2NKkm15lOcpvifLgSoZtZP9ornyemZH/YU=;
        b=BdR9afJ7drgn1Pu27D+bEabVi7XzBBi3hjTMkBO+lSbw2oi/nPtR2+/OnX7xSt8So5X3c9
        QFG+iDhwpCEhg9vheZN1wKaElzB7SyTeoAOOx0RLcSqcsS0KjXKaVGJeN5Xgv0XU+s/ZSe
        2GCWdvToIQSCwMOfV429dOah3zw7Bks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-TjX0zFK_OE6uP7nZw5hOrA-1; Fri, 20 Jan 2023 10:23:51 -0500
X-MC-Unique: TjX0zFK_OE6uP7nZw5hOrA-1
Received: by mail-ej1-f69.google.com with SMTP id hc30-20020a170907169e00b0086d90ee8b17so4036033ejc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aN4iSq6f2NKkm15lOcpvifLgSoZtZP9ornyemZH/YU=;
        b=ajEFqaFDdTvOpyzN4HgvsQds5aRkndkcTP+kRxRtEBEgF6xcybdLfqnU+5twVCmDec
         TdFrul9uimILHWqZHW1iQx42lVCTHpfUkaaWIgL/VcLq2uo6aiiijawhjxlZCxF3RJDc
         NQ6MGzOCannZghQUcZJjXelARezPN13iGS0KC7o/g0R69DWG8jWdE+GzEJjzbhXV40oM
         X6a4S/Lej3qlgjE/LMmLDKcEF6Qo0RzE0OXrQlO5k0c0QlGbUOAj0lQMuUcaiUZswvKk
         +gxxD3IuNUhPO7nyVqtsYZA19hnIABKn1Sp4Ltd9Pt8EGTYgjtR/Y9gprr/Q2Qyvvph/
         88sw==
X-Gm-Message-State: AFqh2kraQNDP875se+H0AjNgL667eJaCskqMo7pW9o2NrnfSc+fWQXrL
        l/OuTSxAAkJ+s+gqTkArmmHyBAGOXEkPveNKiT4VWeotMaO2IVr+7RPeJidSFdxgCuwq/Jx8CWI
        4Ffh36YED0BUw8pOTfCCHzYKxXhVNgIZvEUlXedkyi6c56UvnsIF/HpNqJRSYIofA8QbXxAZQWg
        ==
X-Received: by 2002:a17:906:6c8b:b0:867:f167:43be with SMTP id s11-20020a1709066c8b00b00867f16743bemr13738528ejr.77.1674228229211;
        Fri, 20 Jan 2023 07:23:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWgmRExmHCmV2gjDxF/J3GvRP7x1ByJUTlGNC7I9020SFkJl2IjBat8yhST0xInvUu7BEOQQ==
X-Received: by 2002:a17:906:6c8b:b0:867:f167:43be with SMTP id s11-20020a1709066c8b00b00867f16743bemr13738500ejr.77.1674228228865;
        Fri, 20 Jan 2023 07:23:48 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:48 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 0/6] Composefs: an opportunistically sharing verified image filesystem
Date:   Fri, 20 Jan 2023 16:23:28 +0100
Message-Id: <cover.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Giuseppe Scrivano and I have recently been working on a new project we
call composefs. This is the first time we propose this publically and
we would like some feedback on it.

At its core, composefs is a way to construct and use read only images
that are used similar to how you would use e.g. loop-back mounted
squashfs images. On top of this composefs has two fundamental
features. First it allows sharing of file data (both on disk and in
page cache) between images, and secondly it has dm-verity like
validation on read.

Let me first start with a minimal example of how this can be used,
before going into the details:

Suppose we have this source for an image:

rootfs/
├── dir
│   └── another_a
├── file_a
└── file_b

We can then use this to generate an image file and a set of
content-addressed backing files:

# mkcomposefs --digest-store=objects rootfs/ rootfs.img
# ls -l rootfs.img objects/*/*
-rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
-rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
-rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img

The rootfs.img file contains all information about directory and file
metadata plus references to the backing files by name. We can now
mount this and look at the result:

# mount -t composefs rootfs.img -o basedir=objects /mnt
# ls  /mnt/
dir  file_a  file_b
# cat /mnt/file_a
content_a

When reading this file the kernel is actually reading the backing
file, in a fashion similar to overlayfs. Since the backing file is
content-addressed, the objects directory can be shared for multiple
images, and any files that happen to have the same content are
shared. I refer to this as opportunistic sharing, as it is different
than the more course-grained explicit sharing used by e.g. container
base images.

The next step is the validation. Note how the object files have
fs-verity enabled. In fact, they are named by their fs-verity digest:

# fsverity digest objects/*/*
sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f

The generated filesystm image may contain the expected digest for the
backing files. When the backing file digest is incorrect, the open
will fail, and if the open succeeds, any other on-disk file-changes
will be detected by fs-verity:

# cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
content_a
# rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
# echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
# cat /mnt/file_a
WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
cat: /mnt/file_a: Input/output error

This re-uses the existing fs-verity functionallity to protect against
changes in file contents, while adding on top of it protection against
changes in filesystem metadata and structure. I.e. protecting against
replacing a fs-verity enabled file or modifying file permissions or
xattrs.

To be fully verified we need another step: we use fs-verity on the
image itself. Then we pass the expected digest on the mount command
line (which will be verified at mount time):

# fsverity enable rootfs.img
# fsverity digest rootfs.img
sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 rootfs.img
# mount -t composefs rootfs.img -o basedir=objects,digest=da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt

So, given a trusted set of mount options (say unlocked from TPM), we
have a fully verified filesystem tree mounted, with opportunistic
finegrained sharing of identical files.

So, why do we want this? There are two initial users. First of all we
want to use the opportunistic sharing for the podman container image
baselayer. The idea is to use a composefs mount as the lower directory
in an overlay mount, with the upper directory being the container work
dir. This will allow automatical file-level disk and page-cache
sharning between any two images, independent of details like the
permissions and timestamps of the files.

Secondly we are interested in using the verification aspects of
composefs in the ostree project. Ostree already supports a
content-addressed object store, but it is currently referenced by
hardlink farms. The object store and the trees that reference it are
signed and verified at download time, but there is no runtime
verification. If we replace the hardlink farm with a composefs image
that points into the existing object store we can use the verification
to implement runtime verification.

In fact, the tooling to create composefs images is 100% reproducible,
so all we need is to add the composefs image fs-verity digest into the
ostree commit. Then the image can be reconstructed from the ostree
commit info, generating a file with the same fs-verity digest.

These are the usecases we're currently interested in, but there seems
to be a breadth of other possible uses. For example, many systems use
loopback mounts for images (like lxc or snap), and these could take
advantage of the opportunistic sharing. We've also talked about using
fuse to implement a local cache for the backing files. I.e. you would
have the second basedir be a fuse filesystem. On lookup failure in the
first basedir it downloads the file and saves it in the first basedir
for later lookups. There are many interesting possibilities here.

The patch series contains some documentation on the file format and
how to use the filesystem.

The userspace tools (and a standalone kernel module) is available
here:
  https://github.com/containers/composefs

Initial work on ostree integration is here:
  https://github.com/ostreedev/ostree/pull/2640

Changes since v2:
- Simplified filesystem format to use fixed size inodes. This resulted
  in simpler (now < 2k lines) code as well as higher performance at
  the cost of slightly (~40%) larger images.
- We now use multi-page mappings from the page cache, which removes
  limits on sizes of xattrs and makes the dirent handling code simpler.
- Added more documentation about the on-disk file format.
- General cleanups based on review comments.

Changes since v1:
- Fixed some minor compiler warnings
- Fixed build with !CONFIG_MMU
- Documentation fixes from review by Bagas Sanjaya
- Code style and cleanup from review by Brian Masney
- Use existing kernel helpers for hex digit conversion
- Use kmap_local_page() instead of deprecated kmap()

Alexander Larsson (6):
  fsverity: Export fsverity_get_digest
  composefs: Add on-disk layout header
  composefs: Add descriptor parsing code
  composefs: Add filesystem implementation
  composefs: Add documentation
  composefs: Add kconfig and build support

 Documentation/filesystems/composefs.rst | 159 +++++
 Documentation/filesystems/index.rst     |   1 +
 fs/Kconfig                              |   1 +
 fs/Makefile                             |   1 +
 fs/composefs/Kconfig                    |  18 +
 fs/composefs/Makefile                   |   5 +
 fs/composefs/cfs-internals.h            |  55 ++
 fs/composefs/cfs-reader.c               | 720 +++++++++++++++++++++++
 fs/composefs/cfs.c                      | 750 ++++++++++++++++++++++++
 fs/composefs/cfs.h                      | 172 ++++++
 fs/verity/measure.c                     |   1 +
 11 files changed, 1883 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst
 create mode 100644 fs/composefs/Kconfig
 create mode 100644 fs/composefs/Makefile
 create mode 100644 fs/composefs/cfs-internals.h
 create mode 100644 fs/composefs/cfs-reader.c
 create mode 100644 fs/composefs/cfs.c
 create mode 100644 fs/composefs/cfs.h

-- 
2.39.0

