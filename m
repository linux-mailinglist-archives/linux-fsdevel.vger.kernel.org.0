Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33963A709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiK1LT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 06:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiK1LSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D16366
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXn8CbC4v61MSts+Slejy+sOsfCvEIm7Eo3SJJdD8pw=;
        b=dzeTi8oKtKx0G+M3Aa1z+2tGfB17WtKU8OmxMriPuBGZakNczUr8aq+KHjx1AR6jA4QFSy
        m3Vs+rZ9BVABeYPXY43Sao6+tc68q/qWJDjqTSWYnTaGT+TF2qriAt4J/W5VasHI1ZQObK
        ljhG7XEA9lSSWWZbC5P1MH2YTrsTtM4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-eDYsKbD5Ox21EYy1m0hBTQ-1; Mon, 28 Nov 2022 06:17:37 -0500
X-MC-Unique: eDYsKbD5Ox21EYy1m0hBTQ-1
Received: by mail-lf1-f72.google.com with SMTP id k19-20020ac24f13000000b004a49391ef9eso3654934lfr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXn8CbC4v61MSts+Slejy+sOsfCvEIm7Eo3SJJdD8pw=;
        b=I76zVPcmYbNoqaBA2e7hFp8cumIwaM0hP0vP263/H3QiQW8E6Pwa24IJq62N2da6DN
         EqtOC4RMW1iI4CbZe9I2lDYuii/4pqJUnnEzgnHWZRrKuNTlTYTiVBaO884Do4NPWb5d
         RGSLoak+vyxFY4ZrBT1mZk3ABRA8KKTCOnfBmKaS86QNBgHCi93xhp2pBcxAMz6ySp8Z
         XqMdvyofC7E62w5sVpkK80JW+Nct4QgdeqyBOumbkfzB8nJ7fTp3I1uvFcWYMB2S/hqS
         9a5wtQZnfqGl+TSzjwhXHFzjDzAtlsryXxSH9xjES4x+ZSKfC63fUCQWk7Mr3Fg10ING
         c32w==
X-Gm-Message-State: ANoB5pkff+vbXvZhaWH4JEjw+67+RV3OpldFTLyjoqsbIf6g5KzY8BgT
        POK+cQ2WAaCNSqgdSfUhBL5fydijR/hGxHNgQ6KBIG6J1m/SoR4QZMWhSnh4oEyo0ywX19SI8Xx
        EJxfIt5OhiRpI6v4bS+PyURXngkrUtjRqFnHNIcWXx9U6HkVduumgnxxTA0+iFoDpRDNp8J6+3A
        ==
X-Received: by 2002:ac2:41c6:0:b0:4b0:4b08:6873 with SMTP id d6-20020ac241c6000000b004b04b086873mr18214323lfi.329.1669634255703;
        Mon, 28 Nov 2022 03:17:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Oq9xM109ETn0OjdyWli6jQ9pxM8qtPSQ42EmIJgI9D6yzQXcC4Njn7FLZc0QQ5+pWnmivqQ==
X-Received: by 2002:ac2:41c6:0:b0:4b0:4b08:6873 with SMTP id d6-20020ac241c6000000b004b04b086873mr18214308lfi.329.1669634255326;
        Mon, 28 Nov 2022 03:17:35 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id g25-20020a2eb0d9000000b0026dce0a5ca9sm1187582ljl.70.2022.11.28.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:17:34 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com, alexl@redhat.com
Subject: [PATCH 5/6] composefs: Add documentation
Date:   Mon, 28 Nov 2022 12:17:26 +0100
Message-Id: <8a9aefceebe42d36164f3516c173f18189f0d7e7.1669631086.git.alexl@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669631086.git.alexl@redhat.com>
References: <cover.1669631086.git.alexl@redhat.com>
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

This adds documentation about the composefs filesystem and
how to use it.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 Documentation/filesystems/composefs.rst | 162 ++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/filesystems/composefs.rst

diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesystems/composefs.rst
new file mode 100644
index 000000000000..75fbf14aeb33
--- /dev/null
+++ b/Documentation/filesystems/composefs.rst
@@ -0,0 +1,162 @@
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
+called "/dir" you can mount it like:
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
+Composefs uses `fs-verity
+<https://www.kernel.org/doc/Documentation/filesystems/fsverity.rst>`
+for integrity validation, and extends it by making the validation also
+apply to the directory metadata.  This happens on two levels,
+validation of the descriptor and validation of the backing files.
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
+=================
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
+`basedir`: A colon separated list of directories to use as a base when resolving relative content paths.
+`verity_check=[0,1,2]`: When to verify backing file fs-verity: 0 == never, 1 == if specified in image, 2 == always and require it in image.
+`digest`: A fs-verity sha256 digest that the descriptor file must match. If set, `verity_check` defaults to 2.
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
-- 
2.38.1

