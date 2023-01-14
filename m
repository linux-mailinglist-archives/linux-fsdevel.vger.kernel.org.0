Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B766A8F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 04:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjANDUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 22:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjANDUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:20:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7150389BC1;
        Fri, 13 Jan 2023 19:20:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i65so14012366pfc.0;
        Fri, 13 Jan 2023 19:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCzL8v3ly3g0ylHbK5wRwT9XHRJBFF6QOfk8IB/d0Vw=;
        b=ZcItH0qs0MzglNbnC6OE+dJpknidaPXJeCgShs2GJFhT4VZOWa7eC2/U5GglcZkZiN
         x8vGjZ4hD5ITUdkzeDj5st73i0mLk7NWYSXCGU4Lu/SK5l1zrC+GqpQBlYJpFEQJDGlb
         S8S7ev5Sje0kX+zgFKmluxCmZdNDREMtY2nmeXEd4jW7Uw6SFAIeB5TUeq5w2k77qXcJ
         D0NT/zUEzt7NZwGD3uGZ2A8d9DlLxhv9p1Xn3CGxc6GbT4IahRaMgEOIGts2+VHno6n7
         dIjhQPNuSUCM44wKfy9YSEjVeAAgVK7g5cdGNUNkM4K5hC+79ycpdtOrhB0nE8Sxur1D
         h2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCzL8v3ly3g0ylHbK5wRwT9XHRJBFF6QOfk8IB/d0Vw=;
        b=yf16sbT4KEPB4MmLqr5Qxyk8/X7CRyyr7OGuYtJZdkOgnmj1wdnt0ZezR0x1IOkYHT
         2aZsNU3ZR9t3gjycjH1HRNsNkaKImqpaEi6PeHYsN0d+dBGynzh5t7UI6WIUxh0zdKPM
         +0tK9IjZ3ohRKYaPkLfGWXyBUjA6glgiA8kGWkQBdZJPhxmAHHtGB+bALEXbhPh8rvh8
         ONsykEr8oYhPQGWDfNgL1K5OdAbRS2rQtCJBZ1hR7hVbcoug6D7USoReleXm7eTW1D6x
         D2a/oUFfsLby6U/JztaDIpOo2D02IaZj3Zi4PqcDn2N+PBa9qP/+hV5mlck9/OiKirp2
         fqUw==
X-Gm-Message-State: AFqh2krMOvzO/3BcEsg+31oxOjzqvrsFQfnaAsNwODCIuwoJnSGiWfIU
        rJv5mTU4UZs1SjQKeyIQfBc=
X-Google-Smtp-Source: AMrXdXsxTIJyux/zsw+qWZlHLc7KwjNMruKvKnTEUumjp9cBXf17Q56UZFDHvotpqTKiBMqBA4bzdg==
X-Received: by 2002:a62:a510:0:b0:58b:9473:7ae0 with SMTP id v16-20020a62a510000000b0058b94737ae0mr11351716pfm.32.1673666433650;
        Fri, 13 Jan 2023 19:20:33 -0800 (PST)
Received: from debian.me (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id z4-20020aa79f84000000b00573a9d13e9esm14447722pfr.36.2023.01.13.19.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:20:33 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 1115E104B0A; Sat, 14 Jan 2023 10:20:28 +0700 (WIB)
Date:   Sat, 14 Jan 2023 10:20:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] composefs: Add documentation
Message-ID: <Y8IffF7xjyX6BzUE@debian.me>
References: <cover.1673623253.git.alexl@redhat.com>
 <a9616059dd7d094c2756cb426e29ce2ac7d8e998.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3PByOgCSIFD9ivr4"
Content-Disposition: inline
In-Reply-To: <a9616059dd7d094c2756cb426e29ce2ac7d8e998.1673623253.git.alexl@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3PByOgCSIFD9ivr4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 04:33:58PM +0100, Alexander Larsson wrote:
> Adds documentation about the composefs filesystem and
> how to use it.

s/Adds documentation/Add documentation/

> diff --git a/Documentation/filesystems/composefs.rst b/Documentation/file=
systems/composefs.rst
> new file mode 100644
> index 000000000000..306f0e2e22ba
> --- /dev/null
> +++ b/Documentation/filesystems/composefs.rst
> @@ -0,0 +1,169 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Composefs Filesystem
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Composefs is a read-only file system that is backed by regular files
> +(rather than a block device). It is designed to help easily share
> +content between different directory trees, such as container images in
> +a local store or ostree checkouts. In addition it also has support for
> +integrity validation of file content and directory metadata, in an
> +efficient way (using fs-verity).
> +
> +The filesystem mount source is a binary blob called the descriptor. It
> +contains all the inode and directory entry data for the entire
> +filesystem. However, instead of storing the file content each regular
> +file inode stores a relative path name, and the filesystem gets the
> +file content from the filesystem by looking up that filename in a set
> +of base directories.
> +
> +Given such a descriptor called "image.cfs" and a directory with files
> +called "/dir" you can mount it like::
> +
> +  mount -t composefs image.cfs -o basedir=3D/dir /mnt
> +
> +Content sharing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Suppose you have a single basedir where the files are content
> +addressed (i.e. named by content digest), and a set of composefs
> +descriptors using this basedir. Any file that happen to be shared
> +between two images (same content, so same digest) will now only be
> +stored once on the disk.
> +
> +Such sharing is possible even if the metadata for the file in the
> +image differs (common reasons for metadata difference are mtime,
> +permissions, xattrs, etc). The sharing is also anonymous in the sense
> +that you can't tell the difference on the mounted files from a
> +non-shared file (for example by looking at the link count for a
> +hardlinked file).
> +
> +In addition, any shared files that are actively in use will share
> +page-cache, because the page cache for the file contents will be
> +addressed by the backing file in the basedir, This means (for example)
> +that shared libraries between images will only be mmap:ed once across
> +all mounts.
> +
> +Integrity validation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Composefs uses :doc:`fs-verity <fsverity>` for integrity validation,
> +and extends it by making the validation also apply to the directory
> +metadata.  This happens on two levels, validation of the descriptor
> +and validation of the backing files.
> +
> +For descriptor validation, the idea is that you enable fs-verity on
> +the descriptor file which seals it from changes that would affect the
> +directory metadata. Additionally you can pass a `digest` mount option,
> +which composefs verifies against the descriptor fs-verity
> +measure. Such a mount option could be encoded in a trusted source
> +(like a signed kernel command line) and be used as a root of trust if
> +using composefs for the root filesystem.

Quote mount option names (like other keywords for consistency):

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index c96f9b99d72979..cc65945e3d5302 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -58,7 +58,7 @@ and validation of the backing files.
=20
 For descriptor validation, the idea is that you enable fs-verity on
 the descriptor file which seals it from changes that would affect the
-directory metadata. Additionally you can pass a `digest` mount option,
+directory metadata. Additionally you can pass a "digest" mount option,
 which composefs verifies against the descriptor fs-verity
 measure. Such a mount option could be encoded in a trusted source
 (like a signed kernel command line) and be used as a root of trust if
@@ -125,7 +125,7 @@ verity_check=3D[0,1,2]
=20
 digest
     A fs-verity sha256 digest that the descriptor file must match. If set,
-    `verity_check` defaults to 2.
+    "verity_check" defaults to 2.
=20
=20
 Filesystem format

> +
> +For file validation, the descriptor can contain digest for each
> +backing file, and you can enable fs-verity on the backing
> +files. Composefs will validate the digest before using the backing
> +files. This means any (accidental or malicious) modification of the
> +basedir will be detected at the time the file is used.
> +
> +Expected use-cases
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Container Image Storage
> +```````````````````````
> +
> +Typically a container image is stored as a set of "layer"
> +directories. merged into one mount by using overlayfs.  The lower
> +layers are read-only image content and the upper layer is the
> +writable state of a running container. Multiple uses of the same
> +layer can be shared this way, but it is hard to share individual
> +files between unrelated layers.
> +
> +Using composefs, we can instead use a shared, content-addressed
> +store for all the images in the system, and use a composefs image
> +for the read-only image content of each image, pointing into the
> +shared store. Then for a running container we use an overlayfs
> +with the lower dir being the composefs and the upper dir being
> +the writable state.
> +
> +
> +Ostree root filesystem validation
> +`````````````````````````````````
> +
> +Ostree uses a content-addressed on-disk store for file content,
> +allowing efficient updates and sharing of content. However to actually
> +use these as a root filesystem it needs to create a real
> +"chroot-style" directory, containing hard links into the store. The
> +store itself is validated when created, but once the hard-link
> +directory is created, nothing validates the directory structure of
> +that.
> +
> +Instead of a chroot we can we can use composefs. We create a composefs
> +image pointing into the object store, enable fs-verity for everything
> +and encode the fs-verity digest of the descriptor in the
> +kernel-command line. This will allow booting a trusted system where
> +all directory metadata and file content is validated lazily at use.
> +
> +
> +Mount options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +basedir
> +    A colon separated list of directories to use as a base when resolving
> +    relative content paths.
> +
> +verity_check=3D[0,1,2]
> +    When to verify backing file fs-verity: 0 =3D=3D never, 1 =3D=3D if s=
pecified in
> +    image, 2 =3D=3D always and require it in image.

I think bullet lists should do the job for verity_check values:

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index 306f0e2e22baf5..c96f9b99d72979 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -117,8 +117,11 @@ basedir
     relative content paths.
=20
 verity_check=3D[0,1,2]
-    When to verify backing file fs-verity: 0 =3D=3D never, 1 =3D=3D if spe=
cified in
-    image, 2 =3D=3D always and require it in image.
+    When to verify backing file fs-verity:
+
+    * 0: never
+    * 1: if specified in image
+    * 2: always and require it in image.
=20
 digest
     A fs-verity sha256 digest that the descriptor file must match. If set,

> +
> +digest
> +    A fs-verity sha256 digest that the descriptor file must match. If se=
t,
> +    `verity_check` defaults to 2.
> +
> +
> +Filesystem format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The format of the descriptor is contains three sections: header,
> +inodes and variable data. All data in the file is stored in
> +little-endian form.
> +
> +The header starts at the beginning of the file and contains version,
> +magic value, offsets to the variable data and the root inode nr.
> +
> +The inode section starts at a fixed location right after the
> +header. It is a array of inode data, where for each inode there is
> +first a variable length chunk and then a fixed size chunk. An inode nr
> +is the offset in the inode data to the start of the fixed chunk.
> +
> +The fixed inode chunk starts with a flag that tells what parts of the
> +inode are stored in the file (meaning it is only the maximal size that
> +is fixed). After that the various inode attributes are serialized in
> +order, such as mode, ownership, xattrs, and payload length. The
> +payload length attribute gives the size of the variable chunk.
> +
> +The inode variable chunk contains different things depending on the
> +file type.  For regular files it is the backing filename. For symlinks
> +it is the symlink target. For directories it is a list of references to
> +dentries, stored in chunks of maximum 4k. The dentry chunks themselves
> +are stored in the variable data section.
> +
> +The variable data section is stored after the inode section, and you
> +can find it from the offset in the header. It contains dentries and
> +Xattrs data. The xattrs are referred to by offset and size in the
> +xattr attribute in the inode data. Each xattr data can be used by many
> +inodes in the filesystem. The variable data chunks are all smaller than
> +a page (4K) and are padded to not span pages.
> +
> +Tools
> +=3D=3D=3D=3D=3D
> +
> +Tools for composefs can be found at https://github.com/containers/compos=
efs
> +
> +There is a mkcomposefs tool which can be used to create images on the
> +CLI, and a library that applications can use to create composefs
> +images.

The rest can be slightly reworded:

---- >8 ----
diff --git a/Documentation/filesystems/composefs.rst b/Documentation/filesy=
stems/composefs.rst
index cc65945e3d5302..9bd5a6f4e5d676 100644
--- a/Documentation/filesystems/composefs.rst
+++ b/Documentation/filesystems/composefs.rst
@@ -59,16 +59,16 @@ and validation of the backing files.
 For descriptor validation, the idea is that you enable fs-verity on
 the descriptor file which seals it from changes that would affect the
 directory metadata. Additionally you can pass a "digest" mount option,
-which composefs verifies against the descriptor fs-verity
-measure. Such a mount option could be encoded in a trusted source
-(like a signed kernel command line) and be used as a root of trust if
-using composefs for the root filesystem.
+which composefs verifies against the descriptor fs-verity measure. Such
+an option could be embedded in a trusted source (like a signed kernel
+command line) and be used as a root of trust if using composefs for the
+root filesystem.
=20
 For file validation, the descriptor can contain digest for each
-backing file, and you can enable fs-verity on the backing
-files. Composefs will validate the digest before using the backing
-files. This means any (accidental or malicious) modification of the
-basedir will be detected at the time the file is used.
+backing file, and you can enable fs-verity on them too. Composefs will
+validate the digest before using the backing files. This means any
+(accidental or malicious) modification of the basedir will be detected
+at the time the file is used.
=20
 Expected use-cases
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -76,19 +76,18 @@ Expected use-cases
 Container Image Storage
 ```````````````````````
=20
-Typically a container image is stored as a set of "layer"
-directories. merged into one mount by using overlayfs.  The lower
-layers are read-only image content and the upper layer is the
-writable state of a running container. Multiple uses of the same
-layer can be shared this way, but it is hard to share individual
-files between unrelated layers.
+Typically a container image is stored as a set of "layer" directories,
+merged into one mount by using overlayfs.  The lower layers are
+read-only image and the upper layer is the writable directory of a
+running container. Multiple uses of the same layer can be shared this
+way, but it is hard to share individual files between unrelated layers.
=20
 Using composefs, we can instead use a shared, content-addressed
-store for all the images in the system, and use a composefs image
-for the read-only image content of each image, pointing into the
+store for all the images in the system, and use composefs
+for the read-only image of each container, pointing into the
 shared store. Then for a running container we use an overlayfs
 with the lower dir being the composefs and the upper dir being
-the writable state.
+the writable directory.
=20
=20
 Ostree root filesystem validation
@@ -99,12 +98,12 @@ allowing efficient updates and sharing of content. Howe=
ver to actually
 use these as a root filesystem it needs to create a real
 "chroot-style" directory, containing hard links into the store. The
 store itself is validated when created, but once the hard-link
-directory is created, nothing validates the directory structure of
-that.
+directory is created, the directory structure is impossible to
+verify.
=20
-Instead of a chroot we can we can use composefs. We create a composefs
-image pointing into the object store, enable fs-verity for everything
-and encode the fs-verity digest of the descriptor in the
+Instead of a chroot we can use composefs. The composefs image pointing
+to the object store is created, then fs-verity is enabled for
+everything and the descriptor digest is encoded in the
 kernel-command line. This will allow booting a trusted system where
 all directory metadata and file content is validated lazily at use.
=20
@@ -119,9 +118,9 @@ basedir
 verity_check=3D[0,1,2]
     When to verify backing file fs-verity:
=20
-    * 0: never
-    * 1: if specified in image
-    * 2: always and require it in image.
+    * 0: never verify
+    * 1: if the digest is specified in the image
+    * 2: always verify the image (and requires verification).
=20
 digest
     A fs-verity sha256 digest that the descriptor file must match. If set,
@@ -147,7 +146,7 @@ The fixed inode chunk starts with a flag that tells wha=
t parts of the
 inode are stored in the file (meaning it is only the maximal size that
 is fixed). After that the various inode attributes are serialized in
 order, such as mode, ownership, xattrs, and payload length. The
-payload length attribute gives the size of the variable chunk.
+latter attribute gives the size of the variable chunk.
=20
 The inode variable chunk contains different things depending on the
 file type.  For regular files it is the backing filename. For symlinks
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3PByOgCSIFD9ivr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8IfdAAKCRD2uYlJVVFO
o51qAQCB0PgDA0cD3NdbS0zuFtqaUYl07Qxv6h728IvLIjHBqQD/b2mpVxEZKL3W
lcruSRLGsQq80T9axetF4h9UCGklZws=
=thWP
-----END PGP SIGNATURE-----

--3PByOgCSIFD9ivr4--
