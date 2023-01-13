Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61B7669CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAMPql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjAMPpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDF10FEB
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673624121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvJzqEosng1OpNEPlrOtQogHviQchssO2KpZoQllqEw=;
        b=OSBhNhu0WVkLxefEefjdB2d2ZjYaK7WsNVY78Vuru3zYD1RuQ5R2M0VH0kHjssIiI92AXp
        OMV1xdlv7ci7MIlLVja+WEj4Dv402V1fk8Ybego65qL1q83GLvpgfjKpqKwVLTOPwcGeuq
        OFGhC9JC3Mnw821ticuNOA6kSCO1uGI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-yqHKZoDJOcW-IVqyxPok0g-1; Fri, 13 Jan 2023 10:35:19 -0500
X-MC-Unique: yqHKZoDJOcW-IVqyxPok0g-1
Received: by mail-lf1-f70.google.com with SMTP id a20-20020ac25214000000b004b57756f937so8449304lfl.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 07:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvJzqEosng1OpNEPlrOtQogHviQchssO2KpZoQllqEw=;
        b=pFjDdjg5Y31sdNr4btSWvXecfjLSUG0SoQ8DbDI2Vrx/ZnACfgx+lE0ScJD8jKbJch
         M3quUaIYekZCoIe/OZVWxhzECD0wuFjuMz3dtG1H1MG72Z8O4rLLnJQlDuV9qXCt5UT+
         RGqwuDdXy83p4p1hpbBPpr1YAR6NTeKSUUkXtWZGnauwOIc1zywqYwA/RZwOKNe38ved
         mW0gZ4mj1Edznif+h2PRRPPtvVU3wXPy0peANMWF3OPW2inIjLhfn0PlGP7o9xjVbocB
         jnngKvGyiGQPkiWJXDWmi6rMgMtmk5zmc1tmq5AVF4XHwwsbhePU28WlKtsWjAjdRp9Z
         gIng==
X-Gm-Message-State: AFqh2krnH74JjO8SV5IA+vOF4sN+2iqsFHjEEFrI2NNPjpOd7qXw1KBN
        NepK06P56I7GXUW4rihJ56EIHVpFVYP6YWF/7pKR+q2J9zWKyRoUAR96Ny23/5OSK0LCb+bK3YW
        8shqTg6KBNl8eXrzf06I/z0KHpxIOZKXuZ6EKcPuOI+VjOxG2PxO6DM+KK1WDA/Axji4vkZGeQw
        ==
X-Received: by 2002:a2e:9b08:0:b0:287:625a:4d4f with SMTP id u8-20020a2e9b08000000b00287625a4d4fmr3770290lji.1.1673624117464;
        Fri, 13 Jan 2023 07:35:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv+ze9h67KJIs16Cr55BBtE2xAUuhHj16YyQ+bpHXDt6402ykHQKaDiw0TwcySUBJFWTi6GZg==
X-Received: by 2002:a2e:9b08:0:b0:287:625a:4d4f with SMTP id u8-20020a2e9b08000000b00287625a4d4fmr3770281lji.1.1673624117126;
        Fri, 13 Jan 2023 07:35:17 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id p20-20020a2e9a94000000b00289bb528b8dsm725473lji.49.2023.01.13.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:35:16 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        Alexander Larsson <alexl@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 5/6] composefs: Add documentation
Date:   Fri, 13 Jan 2023 16:33:58 +0100
Message-Id: <a9616059dd7d094c2756cb426e29ce2ac7d8e998.1673623253.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673623253.git.alexl@redhat.com>
References: <cover.1673623253.git.alexl@redhat.com>
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

Adds documentation about the composefs filesystem and
how to use it.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 Documentation/filesystems/composefs.rst | 169 ++++++++++++++++++++++++
 Documentation/filesystems/index.rst     |   1 +
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst

diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesystems/composefs.rst
new file mode 100644
index 000000000000..306f0e2e22ba
--- /dev/null
+++ b/Documentation/filesystems/composefs.rst
@@ -0,0 +1,169 @@
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
+descriptors using this basedir. Any file that happen to be shared
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
+directory metadata. Additionally you can pass a `digest` mount option,
+which composefs verifies against the descriptor fs-verity
+measure. Such a mount option could be encoded in a trusted source
+(like a signed kernel command line) and be used as a root of trust if
+using composefs for the root filesystem.
+
+For file validation, the descriptor can contain digest for each
+backing file, and you can enable fs-verity on the backing
+files. Composefs will validate the digest before using the backing
+files. This means any (accidental or malicious) modification of the
+basedir will be detected at the time the file is used.
+
+Expected use-cases
+==================
+
+Container Image Storage
+```````````````````````
+
+Typically a container image is stored as a set of "layer"
+directories. merged into one mount by using overlayfs.  The lower
+layers are read-only image content and the upper layer is the
+writable state of a running container. Multiple uses of the same
+layer can be shared this way, but it is hard to share individual
+files between unrelated layers.
+
+Using composefs, we can instead use a shared, content-addressed
+store for all the images in the system, and use a composefs image
+for the read-only image content of each image, pointing into the
+shared store. Then for a running container we use an overlayfs
+with the lower dir being the composefs and the upper dir being
+the writable state.
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
+directory is created, nothing validates the directory structure of
+that.
+
+Instead of a chroot we can we can use composefs. We create a composefs
+image pointing into the object store, enable fs-verity for everything
+and encode the fs-verity digest of the descriptor in the
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
+    When to verify backing file fs-verity: 0 == never, 1 == if specified in
+    image, 2 == always and require it in image.
+
+digest
+    A fs-verity sha256 digest that the descriptor file must match. If set,
+    `verity_check` defaults to 2.
+
+
+Filesystem format
+=================
+
+The format of the descriptor is contains three sections: header,
+inodes and variable data. All data in the file is stored in
+little-endian form.
+
+The header starts at the beginning of the file and contains version,
+magic value, offsets to the variable data and the root inode nr.
+
+The inode section starts at a fixed location right after the
+header. It is a array of inode data, where for each inode there is
+first a variable length chunk and then a fixed size chunk. An inode nr
+is the offset in the inode data to the start of the fixed chunk.
+
+The fixed inode chunk starts with a flag that tells what parts of the
+inode are stored in the file (meaning it is only the maximal size that
+is fixed). After that the various inode attributes are serialized in
+order, such as mode, ownership, xattrs, and payload length. The
+payload length attribute gives the size of the variable chunk.
+
+The inode variable chunk contains different things depending on the
+file type.  For regular files it is the backing filename. For symlinks
+it is the symlink target. For directories it is a list of references to
+dentries, stored in chunks of maximum 4k. The dentry chunks themselves
+are stored in the variable data section.
+
+The variable data section is stored after the inode section, and you
+can find it from the offset in the header. It contains dentries and
+Xattrs data. The xattrs are referred to by offset and size in the
+xattr attribute in the inode data. Each xattr data can be used by many
+inodes in the filesystem. The variable data chunks are all smaller than
+a page (4K) and are padded to not span pages.
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

