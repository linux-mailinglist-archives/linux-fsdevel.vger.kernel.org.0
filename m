Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84363A6E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiK1LO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 06:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK1LOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007EF1B1EA
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+00GV0ZFHOZDgJN8jFBjOilk/3K1Mik3DzvPDiYXgTg=;
        b=eV5Li5+ZjZ38nm7gFsX0uvqJhZAGbqkQnM/r/agm4qr2fGodiBNqT4mytV2Sz6/DVurn2R
        5uJECU/NlTOZ+9lDk++tUpYKpuuJOB8/pIUrAcPexnUOS2LAUM+LF9JjIQtOFWEv+nwXDL
        w9kL9rC1hmZBVcGiSACSuUn2dTjyPoM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-nVEzp8q3PXaSWvcUpr3YOQ-1; Mon, 28 Nov 2022 06:13:49 -0500
X-MC-Unique: nVEzp8q3PXaSWvcUpr3YOQ-1
Received: by mail-lf1-f72.google.com with SMTP id t8-20020a056512208800b004b1abbe7021so3639178lfr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+00GV0ZFHOZDgJN8jFBjOilk/3K1Mik3DzvPDiYXgTg=;
        b=ecZF98oFf1rxIV95PKIF8oSqNNiQxwnQxSsSTMLmGl5L6qYJ8CaLWJej7gxFkCiOi5
         q+pR5wJV0yDRJZB+o3fKiAQ6n+Snh6aMIbfkL8nTVPF8lWxbNu4i63Mc7OKO6GSpMlfY
         U7jVsN3CIsqMkwaHSNhb1i1+Bm6C+u7XnGM6FHVxZU9jqT/ivq7l0KxlhnLfYwEdTe4j
         pY7nFcN7kg0JEnpNdlXcWFobBcOvOvGoljGC0cDuJHjeYTsNz6qj1oX1BP3HqAJgFwvA
         0Rd/tBF/IU4qPgI53Vp/TeJ46hbDKBODfO6OrbvUAlz6/oxORD83sHUulR1U/gyTKdad
         BJtQ==
X-Gm-Message-State: ANoB5pmPq7rrr89dEE5ec+NAaWG/pvUXmmm72vEsSc3L1731+AY/iTWO
        nCz9wtyAIGByr0xqpyjTuCPXd4gNDA0hT/QFQWsYTucLlAkG1/klimBJXRb0WNkUfu3ulBXjqwO
        qOWqkKv7QkVO1b0or9A0G34ReUjOQISa2EMy0naCG7Q63YcIdqOQf7XBps0gY6kQOQ+HnQsHLeA
        ==
X-Received: by 2002:a2e:908f:0:b0:279:8717:54ca with SMTP id l15-20020a2e908f000000b00279871754camr5960885ljg.468.1669634026855;
        Mon, 28 Nov 2022 03:13:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6BMEFao9J5/6rUh51o8E4G4GawvboeW1GdkVT9oiLhQrxSD1bW3JEw7Q958lJ+x7dg3A6i+Q==
X-Received: by 2002:a2e:908f:0:b0:279:8717:54ca with SMTP id l15-20020a2e908f000000b00279871754camr5960870ljg.468.1669634026308;
        Mon, 28 Nov 2022 03:13:46 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id q22-20020a2e8756000000b0027703e09b71sm1141250ljj.64.2022.11.28.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:13:45 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com, alexl@redhat.com
Subject: [PATCH RFC 0/6] Composefs: an opportunistically sharing verified image filesystem
Date:   Mon, 28 Nov 2022 12:13:31 +0100
Message-Id: <cover.1669631086.git.alexl@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
that are used similarly to how you would use e.g. loop-back mounted
squashfs images. On top of this composefs has two new fundamental
features. First it allows sharing of file data (both on disk and in
page cache) between images, and secondly it has dm-verity like
validation on read.

Let me first start with a minimal example of how this can be used,
before going into the details:

Suppose we have this source for an image:

rootfs/
├── dir
│   └── another_a
├── file_a
└── file_b

We can then use this to generate an image file and a set of
content-addressed backing files:

$ mkcomposefs --digest-store=objects rootfs/ rootfs.img
$ ls -l rootfs.img objects/*/*
-rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
-rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
-rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img

The rootfs.img file contains all information about directory and file
metadata plus references to the backing files by name. We can now
mount this and look at the result:

$ mount -t composefs rootfs.img -o basedir=objects,verity_check=2 /mnt
$ ls  /mnt/
dir  file_a  file_b
$ cat /mnt/file_a
content_a

When reading this file the kernel is actually reading the backing
file, in a fashion similar to overlayfs. Since the backing file is
content-addressed, the objects directory can be shared for multiple
images, and any files that happen to have the same content are
shared. I refer to this as opportunistic sharing, as it is different
than the more coarse-grained explicit sharing used by e.g. container
base images.

The next step is the validation. Note how the object files have
fs-verity enabled. In fact, they are named by their fs-verity digest:

$ fsverity digest objects/*/*
sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f

The generated filesystem image can contain the expected digest for the
backing files. If you mount the filesystem with the verity_check
option, then open will fail when the backing file digest is incorrect.
And if the open succeeds, any other on-disk file-changes will be
detected by fs-verity:

$ cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
content_a
$ rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
$ echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
$ cat /mnt/file_a
WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
cat: /mnt/file_a: Input/output error

This re-uses the existing fs-verity functionality to protect against
changes in file contents, while adding on top of it protection against
changes in filesystem metadata and structure. In other words, it
protects against replacing a fs-verity enabled file or modifying file
permissions, xattrs or other metadata not verified by fs-verity.

To be fully verified we need another step: we use fs-verity on the
image itself. Then we pass the expected digest on the mount command
line (which will be verified at mount time):

$ fsverity enable rootfs.img
$ fsverity digest rootfs.img
sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 rootfs.img
$ mount -t composefs rootfs.img -o basedir=objects,digest=da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt

So, given a trusted set of mount options (say unlocked from TPM), we
have a fully verified filesystem tree mounted, with opportunistic
fine-grained sharing of identical files.

So, why do we want this? There are two initial user cases. First of
all we want to use the opportunistic sharing for podman container
layers. The idea is to use a composefs mount as the lower directory in
an overlay mount, with the upper directory being the container work
dir. This will allow automatic file-level disk and page-cache sharing
between any two images, independent of details like the permissions
and timestamps of the files and the origin of the images.

Secondly we are interested in using the verification aspects of
composefs in the ostree project. Ostree already uses a
content-addressed object store, but it is currently referenced to by
hardlink farms. The object store and the trees that reference it are
signed and verified at download time, but there is no runtime
verification. If we replace the hardlink farm with a composefs image
that points into the existing object store we can use the verification
to implement runtime verification.

In fact, the tooling to create composefs images is fully reproducible,
so all we need is to add the fs-verity digest of the composefs image
into the ostree commit metadata. Then the image can be reconstructed
from the ostree commit, generating a composefs image with the same
fs-verity digest.

These are the use cases we're currently interested in, but there seems
to be a wealth of other possible uses. For example, many systems use
loopback mounts for images (like lxc or snap), and these could take
advantage of the opportunistic sharing. We've also talked about using
fuse to implement a local cache for the backing files. I.e. you would
have a second basedir be a fuse filesystem, and on lookup failure in
the first basedir the fuse one triggers a download which is also saved
in the first dir for later lookups. There are many interesting
possibilities here.

The patch series contains documentation on the file format and how to
use the filesystem.

The userspace tools (and a standalone kernel module) is available
here:
  https://github.com/containers/composefs

Initial work on ostree integration is here:
  https://github.com/ostreedev/ostree/pull/2640

This patchset in git is available here:
  https://github.com/alexlarsson/linux/tree/composefs-v1

Alexander Larsson (6):
  fsverity: Export fsverity_get_digest
  composefs: Add on-disk layout
  composefs: Add descriptor parsing code
  composefs: Add filesystem implementation
  composefs: Add documentation
  composefs: Add kconfig and build support

 Documentation/filesystems/composefs.rst | 162 ++++
 fs/Kconfig                              |   1 +
 fs/Makefile                             |   1 +
 fs/composefs/Kconfig                    |  18 +
 fs/composefs/Makefile                   |   5 +
 fs/composefs/cfs-internals.h            |  65 ++
 fs/composefs/cfs-reader.c               | 958 ++++++++++++++++++++++++
 fs/composefs/cfs.c                      | 941 +++++++++++++++++++++++
 fs/composefs/cfs.h                      | 242 ++++++
 fs/verity/measure.c                     |   1 +
 10 files changed, 2394 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst
 create mode 100644 fs/composefs/Kconfig
 create mode 100644 fs/composefs/Makefile
 create mode 100644 fs/composefs/cfs-internals.h
 create mode 100644 fs/composefs/cfs-reader.c
 create mode 100644 fs/composefs/cfs.c
 create mode 100644 fs/composefs/cfs.h

-- 
2.38.1

