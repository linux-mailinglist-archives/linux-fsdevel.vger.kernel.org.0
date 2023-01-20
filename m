Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3396C675878
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjATPY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjATPYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DCDB795
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QF5J0+urAsLTcSPqBu0CZ6ZRujp7qsmZ8yBe1kN5g6U=;
        b=eqjSvtqLB4gUQ2nACD7z5jBE/yGjnVmgs/CHGQVwQl54W4q2ph46aEc8196K+BpB+GZ1qG
        jF6517xR36D3vBMlE2Wp1OrQ6NZlH/DVR/8gt7tdCxLpj8fJXGmX4PiZGbmX+TGloOJ+/N
        LCns7ogJeJqmlkSFRD5B8Ux1xX7oyaI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-UPTgNiGUNsCcSRSr3rXbZQ-1; Fri, 20 Jan 2023 10:23:57 -0500
X-MC-Unique: UPTgNiGUNsCcSRSr3rXbZQ-1
Received: by mail-ej1-f69.google.com with SMTP id hc30-20020a170907169e00b0086d90ee8b17so4036224ejc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF5J0+urAsLTcSPqBu0CZ6ZRujp7qsmZ8yBe1kN5g6U=;
        b=wyilqb/5Sm59xErMy7oOvt/vQddJKb9mMgp05jo0kBgHQxHxyBXFQmi5oCQS9du5XW
         nhCgn9bDRpdX4Jbf62z6saAZ2l+sv4/ySvjiFsmLhg5YA+jgtCPQKfM7sMW+mbHbWSUU
         BhUYQQ3JbgDlKr3eJXgp1i0fmkWqupwlFHl7yPxA0ke6YLIdS+9uhUoI0MnFdjyZPwTk
         PulNRMIrso7OjwlHSo61v8Dmfl87lWC55yBw5LmZMX4zElOrC3xkRtiiVHi5A4oSBlZz
         igF758kldFosZUM0387vRJ05ygiZ+JNh85sSN7m16VQ8CiuYK5uth7xn5fQh+a8saGc7
         tm7g==
X-Gm-Message-State: AFqh2kpalBXeVDkpRysPzw5E7DPn6Flhqwe0scMLWkRe7VS2aE6ZWdq2
        SHKjfdFlufRQZqalyRlFRK7492vPm5PjB3+FiKO+pmBkUv96W9QELt+fQhw4Bvr0UiWn0a7yC8P
        IOcHY1b/QZ5FZ4mG3TDmtXVP29xpU0Zd4vUX249u4f+vWPXo+OyepvUlLaeqO4HSevjlR6gYn4w
        ==
X-Received: by 2002:a17:907:94ce:b0:870:ab89:3dd3 with SMTP id dn14-20020a17090794ce00b00870ab893dd3mr15032275ejc.70.1674228235041;
        Fri, 20 Jan 2023 07:23:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9l14RqKgZGgwS+5Q69X+B7w0S3j2d7ypp/QCEwKT5hv3rjo4LziJLs4jhOsXdUrvIIrw6zQ==
X-Received: by 2002:a17:907:94ce:b0:870:ab89:3dd3 with SMTP id dn14-20020a17090794ce00b00870ab893dd3mr15032221ejc.70.1674228234720;
        Fri, 20 Jan 2023 07:23:54 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:54 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 5/6] composefs: Add documentation
Date:   Fri, 20 Jan 2023 16:23:33 +0100
Message-Id: <20baca7da01c285b2a77c815c9d4b3080ce4b279.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
References: <cover.1674227308.git.alexl@redhat.com>
MIME-Version: 1.0
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

Add documentation about the composefs filesystem and how to use it.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 Documentation/filesystems/composefs.rst | 159 ++++++++++++++++++++++++
 Documentation/filesystems/index.rst     |   1 +
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst

diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesystems/composefs.rst
new file mode 100644
index 000000000000..f270a66f4204
--- /dev/null
+++ b/Documentation/filesystems/composefs.rst
@@ -0,0 +1,159 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Composefs Filesystem
+====================
+
+Introduction
+============
+
+Composefs is a read-only file system that is backed by regular files
+(rather than a block device). It is designed to help easily share
+content between different directory trees, such as container images in
+a local store or ostree checkouts. In addition it also has support for
+integrity validation of file content and directory metadata, in an
+efficient way (using fs-verity).
+
+The filesystem mount source is a binary blob called the descriptor. It
+contains all the inode and directory entry data for the entire
+filesystem. However, instead of storing the file content each regular
+file inode stores a relative path name, and the filesystem gets the
+file content from the filesystem by looking up that filename in a set
+of base directories.
+
+Given such a descriptor called "image.cfs" and a directory with files
+called "/dir" you can mount it like::
+
+  mount -t composefs image.cfs -o basedir=/dir /mnt
+
+Content sharing
+===============
+
+Suppose you have a single basedir where the files are content
+addressed (i.e. named by content digest), and a set of composefs
+descriptors using this basedir. Any file that happens to be shared
+between two images (same content, so same digest) will now only be
+stored once on the disk.
+
+Such sharing is possible even if the metadata for the file in the
+image differs (common reasons for metadata difference are mtime,
+permissions, xattrs, etc). The sharing is also anonymous in the sense
+that you can't tell the difference on the mounted files from a
+non-shared file (for example by looking at the link count for a
+hardlinked file).
+
+In addition, any shared files that are actively in use will share
+page-cache, because the page cache for the file contents will be
+addressed by the backing file in the basedir, This means (for example)
+that shared libraries between images will only be mmap:ed once across
+all mounts.
+
+Integrity validation
+====================
+
+Composefs uses :doc:`fs-verity <fsverity>` for integrity validation,
+and extends it by making the validation also apply to the directory
+metadata.  This happens on two levels, validation of the descriptor
+and validation of the backing files.
+
+For descriptor validation, the idea is that you enable fs-verity on
+the descriptor file which seals it from changes that would affect the
+directory metadata. Additionally you can pass a "digest" mount option,
+which composefs verifies against the descriptor fs-verity measure. Such
+an option could be embedded in a trusted source (like a signed kernel
+command line) and be used as a root of trust if using composefs for the
+root filesystem.
+
+For file validation, the descriptor can contain digests for each
+backing file, and you can enable fs-verity on them too. Composefs will
+validate the digest before using the backing files. This means any
+(accidental or malicious) modification of the basedir will be detected
+at the time the file is used.
+
+Expected use-cases
+==================
+
+Container Image Storage
+```````````````````````
+
+Typically a container image is stored as a set of "layer" directories,
+merged into one mount by using overlayfs.  The lower layers are
+read-only image and the upper layer is the writable directory of a
+running container. Multiple uses of the same layer can be shared this
+way, but it is hard to share individual files between unrelated layers.
+
+Using composefs, we can instead use a shared, content-addressed
+store for all the images in the system, and use composefs
+for the read-only image of each container, pointing into the
+shared store. Then for a running container we use an overlayfs
+with the lower dir being the composefs and the upper dir being
+the writable directory.
+
+
+Ostree root filesystem validation
+`````````````````````````````````
+
+Ostree uses a content-addressed on-disk store for file content,
+allowing efficient updates and sharing of content. However to actually
+use these as a root filesystem it needs to create a real
+"chroot-style" directory, containing hard links into the store. The
+store itself is validated when created, but once the hard-link
+directory is created, nothing validates the directory structure for
+post-creation changes.
+
+Instead of a chroot we can use composefs. The composefs image pointing
+to the object store is created, then fs-verity is enabled for
+everything and the descriptor digest is encoded in the
+kernel-command line. This will allow booting a trusted system where
+all directory metadata and file content is validated lazily at use.
+
+
+Mount options
+=============
+
+basedir
+    A colon separated list of directories to use as a base when resolving
+    relative content paths.
+
+verity_check=[0,1,2]
+    When to verify backing file fs-verity:
+
+    * 0: never verify
+    * 1: if the digest is specified in image
+    * 2: always verify the file (and require digests in image)
+
+digest
+    A fs-verity sha256 digest that the descriptor file must match. If set,
+    "verity_check" defaults to 2.
+
+
+Filesystem format
+=================
+
+The format of the descriptor contains three sections: superblock,
+inodes and variable data. All data in the file is stored in
+little-endian form.
+
+The superblock starts at the beginning of the file and contains
+version, magic value, and offsets to the variable data section.
+
+The inode table starts at a fixed location right after the
+header. It is a array of fixed size inode data. The first inode
+is the root inode, and inode numbers are index into this array.
+
+The variable data section is stored after the inode section, and you
+can find it from the offset in the header. It contains paths, digests,
+dirents and Xattrs data. The xattrs are referred to by offset and size
+in the xattr attribute in the inode data. Each xattr data can be used
+by many inodes in the filesystem.
+
+For more details, see cfs.h.
+
+Tools
+=====
+
+Tools for composefs can be found at https://github.com/containers/composefs
+
+There is a mkcomposefs tool which can be used to create images on the
+CLI, and a library that applications can use to create composefs
+images.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index bee63d42e5ec..9b7cf136755d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -75,6 +75,7 @@ Documentation for filesystem implementations.
    cifs/index
    ceph
    coda
+   composefs
    configfs
    cramfs
    dax
-- 
2.39.0

