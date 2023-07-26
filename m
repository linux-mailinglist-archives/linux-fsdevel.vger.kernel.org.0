Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6139763CE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGZQrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGZQrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:36 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 09:47:07 PDT
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D42D55
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10425; q=dns/txt;
  s=iport; t=1690390027; x=1691599627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RgxjGgiQ5SJUO9wS9HWJikylDrE74cotselp8L+YHT8=;
  b=fbekU1tPXsK7CZOr/IonIQtIA/6idZXOZADVKloijLLwlusboPFo48w3
   pmRgqnfHYzGNPY4BH+lrT4Zor1UciWH6S+uS+fuJsXq9T69FHw/9QD+H8
   1DuhgTanfiAQOceZ5pHj82ymZTRJKYerulsSdFJ7GJ8ZCe+k7BEilGRNu
   s=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="8416067"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:00 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTq022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:00 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 00/10] Rust PuzleFS filesystem driver
Date:   Wed, 26 Jul 2023 19:45:24 +0300
Message-ID: <20230726164535.230515-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas
X-Outbound-SMTP-Client: 10.61.98.211, dhcp-10-61-98-211.cisco.com
X-Outbound-Node: aer-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This is a proof of concept driver written for the PuzzleFS
next-generation container filesystem [1]. This patch series is based on
top of the puzzlefs_dependencies [4] branch, which contain the
backported filesystem abstractions of Wedson Almeida Filho [2][3] and
the additional third-party crates capnp [5] and hex [6]. The code is
also available on github [11]. I've adapted the user space puzzlefs code
[1] so that the puzzlefs kernel module could present the directory
hierarchy and implement the basic read functionality.  For some
additional context, puzzlefs was started by Tycho Andersen and it's the
successor of atomfs. This FOSDEM presentation from 2019 [10] covers the
rationale for a new oci image format and presents a higher level
overview of our goals with puzzlefs.

Changes since v1:
* the main change is that I've replaced serde_cbor with Cap'n proto at
  Kent Overstreet's suggestion; this simplifies the dependency tree of
  puzzlefs and results in cleaner code
* I've also modified the filesystem abstractions to follow the latest
  "Rust for Linux" best practices (in the puzzlefs_dependencies_v2
  branch [4])

I've split the rest of the cover letter in following sections (using a
markdown style):
* Example: it describes a practical example of what was achieved
* Limitations: it presents the existing limitations of this POC
* Setup: it shows how to setup the necessary environment for testing the
  puzzlefs driver

# Example
An example is provided below:

```
~ # cat /proc/filesystems | grep puzzlefs
nodev   puzzlefs
~ # mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_oci" -o image_manifest="c4
3e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09" none /mnt
~ # ls -lR /mnt/
/mnt/:
total 0
drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-1
drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-2
drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-3
drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-4
-rw-r--r--    1 0        0                0 Jun  8 12:26 file1
-rw-r--r--    1 0        0                0 Jun  8 12:26 file2

/mnt/dir-1:
total 0

/mnt/dir-2:
total 0

/mnt/dir-3:
total 0

/mnt/dir-4:
total 0
~ # cat /mnt/file2
ana are mere bla bla bla
~ # wc /mnt/file1
      202       202      5454 /mnt/file1
```

In this example, /home/puzzlefs_oci is the puzzlefs oci directory:
```
~ # ls -lR /home/puzzlefs_oci/
/home/puzzlefs_oci/:
total 8
drwxr-xr-x    3 1000     1000             0 Jul 26 14:37 blobs
-rw-r--r--    1 1000     1000           267 Jul 26 14:37 index.json
-rw-r--r--    1 1000     1000            37 Jul 26 14:37 oci-layout

/home/puzzlefs_oci/blobs:
total 0
drwxr-xr-x    2 1000     1000             0 Jul 26 14:37 sha256

/home/puzzlefs_oci/blobs/sha256:
total 16
-rw-------    1 1000     1000           272 Jul 26 14:37 c43e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09
-rw-------    1 1000     1000          5479 Jul 26 14:37 d86a87b19bd9a2fec0d31687c1d669cdb59e8fb579b0b2bfe354473699732bfb
-rw-------    1 1000     1000           752 Jul 26 14:37 fe6ee75ca93ded15da5f6e0abf335e6a4eb24277c59acd47282d8ed2475f3384
```

`c43e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09` is the puzzlefs image manifest
hash for the `first_try` tag:
```
❯ cat index.json | jq .
{
  "schemaVersion": -1,
  "manifests": [
    {
      "digest": "sha256:c43e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09",
      "size": 272,
      "media_type": "application/vnd.puzzlefs.image.rootfs.v1",
      "annotations": {
        "org.opencontainers.image.ref.name": "first_try"
      }
    }
  ],
  "annotations": {}
}
```

I will describe how to build a puzzlefs image in step 5 of the `Setup` section.

# Limitations
One limitation is that the puzzlefs driver doesn't implement any lookup
functionality and instead it inserts every directory entry into the
dcache during init (see the `DCACHE_BASED` constant). This is similar to
how the sample `rust_fs` driver works, but the goal is to implement
proper lookup functions.  However, more filesystem abstractions need to
be implemented before this can be achieved.

# Setup
My setup is based on Wedson's tutorial [8]. Next, I will describe the
necessary steps to build an initrd and run a custom kernel under qemu.

1. Get the code from the puzzlefs_rfc_v2 branch on github [11]

2. Follow the rust quickstart guide [9]

3. configure and build the kernel
```
$ make LLVM=1 allnoconfig qemu-busybox-min.config rust.config
$ make LLVM=1 -j$(nproc)
```

4. setup busybox
```
git clone git://git.busybox.net/busybox
cd busybox
make menuconfig # enable 'Build static binary' config
make
make install
```
This will create the `_install` directory with the rootfs inside it.

5. create a home directory in the rootfs and copy a puzzlefs oci
directory in home/puzzlefs_oci
To create a puzzlefs oci directory:
* clone the puzzlefs repository [1]

* run `make release`

* create a simple filesystem structure with a few directories and files
  (I've created one at ../test-puzzlefs/simple_rootfs)

* build a puzzlefs oci image at
  `~/work/busybox/_install/home/puzzlefs_oci` (replace this path with
  your busybox path) with the tag `first_try`:
```
$ target/release/puzzlefs build ../test-puzzlefs/simple_rootfs \
 ~/work/busybox/_install/home/puzzlefs_oci first_try
```

* get first_try's image manifest from index.json (inside `puzzlefs_oci`)
```
$ cat index.json | jq . | grep digest
      "digest": "sha256:c43e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09",
```

6. add the following 'init' script in the busybox rootfs (rootfs path
defaults to `./_install'):
```
#!/bin/sh
mount -t devtmpfs none /dev
mkdir -p /proc
mount -t proc none /proc

ifconfig lo up
udhcpc -i eth0

mkdir /mnt
mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_oci" -o \
image_manifest="c43e5ab9d0cee1dcfbf442d18023b34410de3deb0f6dbffcec72732b6830db09" \
none /mnt

setsid sh -c 'exec sh -l </dev/ttyS0 >/dev/ttyS0 2>&1'
```

Make sure to replace the `image_manifest` with your own digest. This
init script will be passed to rdinit in the kernel command line.

7. generate the initramfs

Assuming busybox is in `~/work/busybox`:
```
cd ~/work/busybox/_install && find . | cpio -H newc -o | gzip > ../ramdisk.img
```
This will generate a compressed ramdisk image in
`~/work/busybox/ramdisk.img`.

8. run with qemu (this assumes the linux tree is at '../linux' and busybox
is at '../busybox'):
```
qemu-system-x86_64 \
    -accel kvm \
    -cpu host \
    -m 4G \
    -initrd ../busybox/ramdisk.img \
    -kernel ../linux/arch/x86/boot/bzImage \
    -nographic \
    -append 'console=ttyS0 nokaslr debug rdinit=/init' \
    -nic user,model=rtl8139 \
    -no-reboot
```

9. Check whether puzzlefs has been successfully mounted
```
~ # mount | grep puzzlefs
none on /mnt type puzzlefs (rw,relatime)
~ # ls /mnt/
dir-1  dir-2  dir-3  dir-4  file1  file2
```

[1] https://github.com/project-machine/puzzlefs
[2] https://github.com/wedsonaf/linux/tree/fs
[3] https://github.com/Rust-for-Linux/linux/issues/1004
[4] https://github.com/ariel-miculas/linux/tree/puzzlefs_dependencies_v2
[5] https://docs.rs/capnp/latest/capnp/
[6] https://docs.rs/hex/0.4.3/hex/
[7] https://hackmd.io/@cyphar/ociv2-brainstorm
[8] https://www.youtube.com/watch?v=tPs1uRqOnlk
[9] https://docs.kernel.org/rust/quick-start.html
[10] https://archive.fosdem.org/2019/schedule/event/containers_atomfs/
[11] https://github.com/ariel-miculas/linux/tree/puzzlefs_rfc_v2

Ariel Miculas (10):
  samples: puzzlefs: add initial puzzlefs sample, copied from rust_fs.rs
  kernel: configs: enable rust samples in rust.config
  rust: kernel: add an abstraction over vfsmount to allow cloning a new
    private mount
  rust: file: Add a new RegularFile newtype useful for reading files
  samples: puzzlefs: add basic deserializing support for the puzzlefs
    metadata
  rust: file: pass the filesystem context to the open function
  samples: puzzlefs: populate the directory entries with the inodes from
    the puzzlefs metadata file
  rust: puzzlefs: read the puzzlefs image manifest instead of an
    individual metadata layer
  rust: puzzlefs: add support for reading files
  rust: puzzlefs: add oci_root_dir and image_manifest filesystem
    parameters

 kernel/configs/rust.config                  |   10 +
 rust/alloc/vec/mod.rs                       |   17 +
 rust/bindings/bindings_helper.h             |    1 +
 rust/helpers.c                              |    6 +
 rust/kernel/error.rs                        |    6 +-
 rust/kernel/file.rs                         |  146 +-
 rust/kernel/fs.rs                           |    4 +-
 rust/kernel/lib.rs                          |    1 +
 rust/kernel/mount.rs                        |   71 +
 samples/rust/Kconfig                        |   10 +
 samples/rust/Makefile                       |    1 +
 samples/rust/puzzle.rs                      |    5 +
 samples/rust/puzzle/error.rs                |  106 +
 samples/rust/puzzle/inode.rs                |  101 +
 samples/rust/puzzle/oci.rs                  |   71 +
 samples/rust/puzzle/types.rs                |  340 ++
 samples/rust/puzzle/types/manifest.capnp    |   15 +
 samples/rust/puzzle/types/manifest_capnp.rs |  773 ++++
 samples/rust/puzzle/types/metadata.capnp    |   69 +
 samples/rust/puzzle/types/metadata_capnp.rs | 4458 +++++++++++++++++++
 samples/rust/puzzlefs.rs                    |  220 +
 samples/rust/rust_fs.rs                     |    3 +-
 22 files changed, 6425 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/mount.rs
 create mode 100644 samples/rust/puzzle.rs
 create mode 100644 samples/rust/puzzle/error.rs
 create mode 100644 samples/rust/puzzle/inode.rs
 create mode 100644 samples/rust/puzzle/oci.rs
 create mode 100644 samples/rust/puzzle/types.rs
 create mode 100644 samples/rust/puzzle/types/manifest.capnp
 create mode 100644 samples/rust/puzzle/types/manifest_capnp.rs
 create mode 100644 samples/rust/puzzle/types/metadata.capnp
 create mode 100644 samples/rust/puzzle/types/metadata_capnp.rs
 create mode 100644 samples/rust/puzzlefs.rs

-- 
2.41.0

