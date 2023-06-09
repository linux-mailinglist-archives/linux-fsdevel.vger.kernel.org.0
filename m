Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC438729716
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjFIKiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjFIKhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B21B9;
        Fri,  9 Jun 2023 03:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64EB26567C;
        Fri,  9 Jun 2023 10:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD3C433EF;
        Fri,  9 Jun 2023 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686306993;
        bh=+mpsFKCys+NrOZk8ve8jzCz1Wn07/Wg/eFllXH/9d2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ0VnLqV2yoYHrg/F2+XUbacbveWgkZXR/symgSHiV1Kbk1dUEBXr5eljWMEi3sWR
         vuJVB/sJtqiEt4e4IGdBZy9rACY3sZATxQ6P7OfZzkYPx+83XjuJVgZhVx6ZJ3dTeH
         rsTKYitpC+Bcv8dHva/wG4I1fTG8sX4UfLjMdpM3VmkmYxHn5YBU3V8TXqsyBCDUf9
         ZKFS0d+DaKyjmHFGJpz94fMUB4DoUZ3qbZIQWcMNaa47iO1DN56uW5CyhH7gW/Wl4o
         CBTS0TgWWNahUf11b3CmTaHE3bo54FlIWPb9T0Noce/QFCf+iIo6dolkuB/IunHfc4
         68Cmz8274QlFg==
Date:   Fri, 9 Jun 2023 12:36:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ariel Miculas <amiculas@cisco.com>, linux-fsdevel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
References: <20230609063118.24852-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609063118.24852-1-amiculas@cisco.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:29:58AM +0300, Ariel Miculas wrote:
> Hi all!
> 
> This is a proof of concept driver written for the PuzzleFS

Uhm, the PuzzleFS filesystem isn't actually sent to fsdevel? Yet I see
tons of patches in there that add wrappers to our core fs data
structures. I even see a ton of new files that all fall clearly into
fsdevel territory:

create mode 100644 rust/kernel/cred.rs
create mode 100644 rust/kernel/delay.rs
create mode 100644 rust/kernel/driver.rs
create mode 100644 rust/kernel/file.rs
create mode 100644 rust/kernel/fs.rs
create mode 100644 rust/kernel/fs/param.rs
create mode 100644 rust/kernel/io_buffer.rs
create mode 100644 rust/kernel/iov_iter.rs
create mode 100644 rust/kernel/mm.rs
create mode 100644 rust/kernel/mount.rs
create mode 100644 rust/kernel/pages.rs

There's also quite a lot of new mm/ in there, no?

Any wrappers and code for core fs should be maintained as part of fs.
Rust shouldn't become a way to avoid our reviews once you have a few
wrappers added somewhere.

> next-generation container filesystem [1]. I've included a short abstract
> about puzzlefs further below. This driver is based on the rust-next
> branch, on top of which I've backported the filesystem abstractions from
> Wedson Almeida Filho [2][3] and Miguel Ojeda's third-party crates
> support: proc-macro2, quote, syn, serde and serde_derive [4]. I've added
> the additional third-party crates serde_cbor[5] and hex [6]. Then I've
> adapted the user space puzzlefs code [1] so that the puzzlefs kernel
> module could present the directory hierarchy and implement the basic
> read functionality.
> For some additional context, puzzlefs was started by Tycho Andersen and
> it's the successor of atomfs. This FOSDEM presentation from 2019 [12]
> covers the rationale for a new oci image format and presents a higher
> level overview of our goals with puzzlefs.
> I've split the rest of the cover letter in following sections (using a
> markdown style):
> * Example: it describes a practical example of what was achieved
> * Limitations: it presents the existing limitations of this POC
> * Upstreaming steps: it describes the steps needed for upstreaming this
>   driver
> * Setup: it shows how to setup the necessary environment for testing the
>   puzzlefs driver
> * Puzzlefs abstract: it provides a short overview of puzzlefs
> 
> # Example
> An example is provided below:
> 
> ```
> ~ # cat /proc/filesystems | grep puzzlefs
> nodev   puzzlefs
> ~ # mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_oci" -o image_manifest="2d
> 6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b" none /mnt
> ~ # ls -lR /mnt/
> /mnt/:
> total 0
> drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-1
> drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-2
> drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-3
> drwxr-xr-x    2 0        0                0 Jun  8 12:26 dir-4
> -rw-r--r--    1 0        0                0 Jun  8 12:26 file1
> -rw-r--r--    1 0        0                0 Jun  8 12:26 file2
> 
> /mnt/dir-1:
> total 0
> 
> /mnt/dir-2:
> total 0
> 
> /mnt/dir-3:
> total 0
> 
> /mnt/dir-4:
> total 0
> ~ # cat /mnt/file2
> ana are mere bla bla bla
> ~ # wc /mnt/file1
>       202       202      5454 /mnt/file1
> ```
> 
> In this example, /home/puzzlefs_oci is the puzzlefs oci directory:
> ```
> ~ # ls -lR /home/puzzlefs_oci/
> /home/puzzlefs_oci/:
> total 8
> drwxr-xr-x    3 1000     1000             0 Jun  8 14:33 blobs
> -rw-r--r--    1 1000     1000           266 Jun  8 14:33 index.json
> -rw-r--r--    1 1000     1000            37 Jun  8 14:33 oci-layout
> 
> /home/puzzlefs_oci/blobs:
> total 0
> drwxr-xr-x    2 1000     1000             0 Jun  8 14:33 sha256
> 
> /home/puzzlefs_oci/blobs/sha256:
> total 16
> -rw-------    1 1000     1000            89 Jun  8 14:33 2d6602d678140540dc7e96de652a76a8b16eb
> -rw-------    1 1000     1000           925 Jun  8 14:33 4df03518eea406343dbb55046720f6a478881
> -rw-------    1 1000     1000          5479 Jun  8 14:33 d86a87b19bd9a2fec0d31687c1d669cdb59eb
> ```
> 
> `2d6602d678140540dc7e96de652a76a8b16eb` is the puzzlefs image manifest
> hash for the first_try tag:
> ```
> $ cat /tmp/oci-simple/index.json | jq .
> {
>   "schemaVersion": -1,
>   "manifests": [
>     {
>       "digest": "sha256:2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b",
>       "size": 89,
>       "media_type": "application/vnd.puzzlefs.image.rootfs.v1",
>       "annotations": {
>         "org.opencontainers.image.ref.name": "first_try"
>       }
>     }
>   ],
>   "annotations": {}
> }
> ```
> 
> I will describe how to build a puzzlefs image in the `Setup` section, at
> step 5.
> 
> # Limitations
> One limitation is that the puzzlefs driver doesn't implement any lookup
> functionality and instead it inserts every directory entry into the
> dcache during init (see the `DCACHE_BASED` constant). This is similar to
> how the sample `rust_fs` driver works, but the goal is to implement
> proper lookup functions.  However, more filesystem abstractions need to
> be implemented before this can be achieved.
> 
> # Upstreaming steps
> Before the puzzlefs driver can be upstreamed, the following need to be
> merged:
> * Wedson's filesystem abstractions [3]
> * the necessary third-party crates [4] (with the preliminary discussion
> about whether this is desirable)
> 
> # Setup
> My setup is based on Wedson's tutorial [8]. Next, I will describe the
> necessary steps to build an initrd and run a custom kernel under qemu.
> 
> 1. Get the linux rust-next branch [9] and apply this patchset
> 
> 2. Follow the rust quickstart guide [10]
> 
> 3. configure and build the kernel
> ```
> $ make LLVM=1 allnoconfig qemu-busybox-min.config rust.config
> $ make LLVM=1 -j$(nproc)
> ```
> 
> 4. setup busybox
> ```
> git clone git://git.busybox.net/busybox
> cd busybox
> make menuconfig # enable 'Build static binary' config
> make
> make install
> ```
> This will create the `_install` directory with the rootfs inside it.
> 
> 5. create a home directory in the rootfs and copy a puzzlefs oci
> directory in home/puzzlefs_oci
> To create a puzzlefs oci directory:
> * download this custom puzzlefs repository [11] (it's custom because we
>   want to build an image without verity data)
> * run `make release`
> * create a simple filesystem structure with a few directories and files
>   (I've created one at ../test-puzzlefs/simple_rootfs)
> * build a puzzlefs oci image at
>   `~/work/busybox/_install/home/puzzlefs_oci` (replace this path with
>   your busybox path) with the tag `first_try`:
> ```
> $ target/release/puzzlefs build --omit-verity \
> ../test-puzzlefs/simple_rootfs ~/work/busybox/_install/home/puzzlefs_oci \
> first_try
> ```
> * get first_try's image manifest from index.json (inside `puzzlefs_oci`)
> ```
> $ cat index.json | jq . | grep digest
>       "digest": "sha256:2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b",
> ```
> 
> 6. add the following 'init' script in the busybox rootfs (rootfs path
> defaults to `./_install'):
> ```
> #!/bin/sh
> mount -t devtmpfs none /dev
> mkdir -p /proc
> mount -t proc none /proc
> 
> ifconfig lo up
> udhcpc -i eth0
> 
> mkdir /mnt
> mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_oci" -o \
> image_manifest="2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b" \
> none /mnt
> 
> setsid sh -c 'exec sh -l </dev/ttyS0 >/dev/ttyS0 2>&1'
> ```
> 
> Make sure to replace the `image_manifest` with your own digest. This
> init script will be passed to rdinit in the kernel command line.
> 
> 7. generate the initramfs
> 
> Assuming busybox is in `~/work/busybox`:
> ```
> cd ~/work/busybox/_install && find . | cpio -H newc -o | gzip > ../ramdisk.img
> ```
> This will generate a compressed ramdisk image in
> `~/work/busybox/ramdisk.img`.
> 
> 8. run with qemu (this assumes the linux tree is at '../linux' and busybox
> is at '../busybox'):
> ```
> qemu-system-x86_64 \
>     -accel kvm \
>     -cpu host \
>     -m 4G \
>     -initrd ../busybox/ramdisk.img \
>     -kernel ../linux/arch/x86/boot/bzImage \
>     -nographic \
>     -append 'console=ttyS0 nokaslr debug rdinit=/init' \
>     -nic user,model=rtl8139 \
>     -no-reboot
> ```
> 
> 9. Check whether puzzlefs has been successfully mounted
> ```
> ~ # mount | grep puzzlefs
> none on /mnt type puzzlefs (rw,relatime)
> ~ # ls /mnt/
> dir-1  dir-2  dir-3  dir-4  file1  file2
> ```
> 
> 
> # Puzzlefs abstract
> Puzzlefs [1] is a container filesystem designed to address the
> limitations of the existing OCI format. The main goals of the project
> are reduced duplication, reproducible image builds, direct mounting
> support and memory safety guarantees, some inspired by the OCIv2 design
> document [7].
> 
> Reduced duplication is achieved using the content defined chunking
> algorithm FastCDC. This implementation allows chunks to be shared among
> layers. Building a new layer starting from an existing one allows
> reusing most of the chunks.
> 
> Another goal of the project is reproducible image builds, which is
> achieved by defining a canonical representation of the image format.
> 
> Direct mounting support is a key feature of puzzlefs and, together with
> fs-verity, it provides data integrity. Currently, puzzlefs is
> implemented as a userspace filesystem (FUSE). A read-only kernel
> filesystem driver is underway.
> 
> Lastly, memory safety is critical to puzzlefs, leading to the decision
> to implement it in Rust. Another goal is to share the same code between
> user space and kernel space in order to provide one secure
> implementation.
> 
> 
> [1] https://github.com/anuvu/puzzlefs
> [2] https://github.com/wedsonaf/linux/tree/fs
> [3] https://github.com/Rust-for-Linux/linux/issues/1004
> [4] https://github.com/Rust-for-Linux/linux/pull/1007
> [5] https://docs.rs/serde_cbor/latest/serde_cbor/
> [6] https://docs.rs/hex/0.4.3/hex/
> [7] https://hackmd.io/@cyphar/ociv2-brainstorm
> [8] https://www.youtube.com/watch?v=tPs1uRqOnlk
> [9] https://github.com/Rust-for-Linux/linux/tree/rust-next
> [10] https://docs.kernel.org/rust/quick-start.html
> [11] https://github.com/ariel-miculas/puzzlefs/tree/support-no-verity-data
> [12] https://archive.fosdem.org/2019/schedule/event/containers_atomfs/
> 
> Ariel Miculas (58):
>   rust: kernel: add libraries required by the filesystem abstractions
>   rust: kernel: backport the delay module from the rust branch
>   rust: kernel: add container_of macro
>   rust: kernel: add offset_of macro
>   drop: Add crate::pr_warn declaration
>   rust: kernel: rename from_kernel_errno to from_errno
>   rust: kernel: Rename from_pointer to from_foreing and into_pointer to
>     into_foreign
>   rust: kernel: add count_paren_items macro, needed by define_fs_params
>     macro
>   rust: helpers: add missing rust helper 'alloc_pages'
>   kernel: configs: add qemu-busybox-min.config
>   rust: kernel: format the rust code
>   samples: puzzlefs: add initial puzzlefs sample, copied from rust_fs.rs
>   kernel: configs: enable rust samples in rust.config
>   Add SAMPLE_RUST_SERDE in rust.config
>   rust: kernel: fix compile errors after rebase to rust-next
>   rust: serde_cbor: import crate
>   rust: serde_cbor: add SPDX License Identifiers
>   rust: serde_cbor: add no_fp_fmt_parse support
>   rust: Kbuild: enable serde_cbor
>   samples: rust: add cbor serialize/deserialize example
>   rust: serde_cbor: add support for serde_cbor's from_slice method by
>     using a custom alloc_kernel feature
>   rust: serde: add support for deserializing Vec with kernel_alloc
>     feature
>   rust: file: Replace UnsafeCell with Opaque for File
>   rust: kernel: implement fmt::Debug for CString
>   samples: puzzlefs: rename RustFs to PuzzleFs
>   samples: puzzlefs: add basic deserializing support for the puzzlefs
>     metadata
>   rust: file: present the filesystem context to the open function
>   rust: kernel: add an abstraction over vfsmount to allow cloning a new
>     private mount
>   rust: file: add from_path, from_path_in_root_mnt and read_with_offset
>     methods to File
>   samples: puzzlefs: pass the Vfsmount structure from open to read and
>     return the contents of the data file inside /home/puzzlefs_oci
>   rust: file: move from_path, from_path_in_root_mnt and read_with_offset
>     methods to a RegularFile newtype
>   rust: file: ensure RegularFile can only create regular files
>   rust: file: add get_pos method to RegularFile
>   rust: file: add methods read_to_end, get_file_size and update_pos to
>     RegularFile
>   rust: file: define a minimal Read trait and implement it for
>     RegularFile
>   samples: puzzlefs: add cbor_get_array_size method
>   samples: puzzlefs: add KernelError to WireFormatError and implement
>     From conversion
>   samples: puzzlefs: implement new for MetadataBlob
>   samples: puzzlefs: build puzzlefs into the kernel, thus avoiding the
>     need to export rust symbols
>   rust: alloc: add try_clone for Vec<T>
>   rust: alloc: add from_iter_fallible for Vec<T>
>   samples: puzzlefs: implement to_errno and from_errno for
>     WireFormatError
>   samples: puzzlefs: add TryReserveError (and from conversion) to
>     WireFormatError
>   samples: puzzlefs: add higher level inode related functionality
>   samples: puzzlefs: populate the directory entries with the inodes from
>     the puzzlefs metadata file
>   rust: hex: import crate
>   rust: hex: add SPDX license identifiers
>   rust: Kbuild: enable `hex`
>   rust: hex: implement FromHex trait and hex::decode using a custom
>     kernel_alloc feature
>   rust: hex: add encode_hex_iter and encode_hex_upper_iter methods
>   rust: puzzlefs: add HexError to WireFormatError and implement the From
>     conversion
>   rust: puzzlefs: display the error value for
>     WireFormatError::KernelError
>   samples: puzzlefs: add Rootfs and Digest structs to types.rs
>   samples: puzzlefs: implement the conversion from WireFormatError to
>     kernel::error::Error
>   rust: puzzlefs: read the puzzlefs image manifest instead of an
>     individual metadata layer
>   rust: puzzlefs: rename PuzzleFs to PuzzleFsModule to avoid confusion
>     with the PuzzleFS struct
>   rust: puzzlefs: add support for reading files
>   rust: puzzlefs: add oci_root_dir and image_manifest filesystem
>     parameters
> 
> Miguel Ojeda (15):
>   rust: proc-macro2: import crate
>   rust: proc-macro2: add SPDX License Identifiers
>   rust: proc-macro2: remove `unicode_ident` dependency
>   rust: quote: import crate
>   rust: quote: add SPDX License Identifiers
>   rust: syn: import crate
>   rust: syn: add SPDX License Identifiers
>   rust: syn: remove `unicode-ident` dependency
>   rust: serde: import crate
>   rust: serde: add `no_fp_fmt_parse` support
>   rust: serde: add SPDX License Identifiers
>   rust: serde_derive: import crate
>   rust: serde_derive: add SPDX License Identifiers
>   rust: Kbuild: enable `proc-macro2`, `quote`, `syn`, `serde` and
>     `serde_derive`
>   rust: test `serde` support
> 
> Wedson Almeida Filho (7):
>   rust: add definitions for ref-counted inodes and dentries
>   rust: add ability to register a file system
>   rust: define fs context
>   rust: add support for file system parameters
>   rust: allow fs driver to initialise new superblocks
>   rust: add `module_fs` macro
>   WIP: rust: allow fs to be populated
> 
>  Makefile                                  |   14 +-
>  arch/x86/configs/qemu-busybox-min.config  |   11 +
>  kernel/configs/qemu-busybox-min.config    |   56 +
>  kernel/configs/rust.config                |   11 +
>  rust/.gitignore                           |    1 +
>  rust/Makefile                             |  232 +-
>  rust/alloc/vec/mod.rs                     |   48 +
>  rust/bindings/bindings_helper.h           |   14 +
>  rust/bindings/lib.rs                      |    5 +
>  rust/helpers.c                            |   76 +
>  rust/hex/error.rs                         |   78 +
>  rust/hex/lib.rs                           |  506 +++
>  rust/hex/serde.rs                         |  104 +
>  rust/kernel/cred.rs                       |   46 +
>  rust/kernel/delay.rs                      |  104 +
>  rust/kernel/driver.rs                     |   28 +
>  rust/kernel/error.rs                      |   52 +-
>  rust/kernel/file.rs                       | 1117 ++++++
>  rust/kernel/fs.rs                         | 1478 ++++++++
>  rust/kernel/fs/param.rs                   |  558 +++
>  rust/kernel/io_buffer.rs                  |  153 +
>  rust/kernel/iov_iter.rs                   |   81 +
>  rust/kernel/lib.rs                        |   83 +
>  rust/kernel/mm.rs                         |  149 +
>  rust/kernel/mount.rs                      |   66 +
>  rust/kernel/pages.rs                      |  144 +
>  rust/kernel/str.rs                        |    6 +
>  rust/kernel/test_serde.rs                 |   26 +
>  rust/kernel/test_serde/de.rs              |  439 +++
>  rust/kernel/test_serde/error.rs           |   73 +
>  rust/kernel/test_serde/ser.rs             |  466 +++
>  rust/kernel/user_ptr.rs                   |  175 +
>  rust/proc-macro2/detection.rs             |   77 +
>  rust/proc-macro2/fallback.rs              | 1004 ++++++
>  rust/proc-macro2/lib.rs                   | 1341 ++++++++
>  rust/proc-macro2/marker.rs                |   20 +
>  rust/proc-macro2/parse.rs                 |  874 +++++
>  rust/proc-macro2/rcvec.rs                 |  144 +
>  rust/proc-macro2/wrapper.rs               |  996 ++++++
>  rust/quote/ext.rs                         |  112 +
>  rust/quote/format.rs                      |  170 +
>  rust/quote/ident_fragment.rs              |   88 +
>  rust/quote/lib.rs                         | 1436 ++++++++
>  rust/quote/runtime.rs                     |  440 +++
>  rust/quote/spanned.rs                     |   45 +
>  rust/quote/to_tokens.rs                   |  211 ++
>  rust/serde/de/format.rs                   |   32 +
>  rust/serde/de/ignored_any.rs              |  246 ++
>  rust/serde/de/impls.rs                    | 2755 +++++++++++++++
>  rust/serde/de/mod.rs                      | 2313 +++++++++++++
>  rust/serde/de/seed.rs                     |   21 +
>  rust/serde/de/utf8.rs                     |   48 +
>  rust/serde/de/value.rs                    | 1718 ++++++++++
>  rust/serde/integer128.rs                  |   84 +
>  rust/serde/lib.rs                         |  351 ++
>  rust/serde/macros.rs                      |  238 ++
>  rust/serde/private/de.rs                  | 2997 ++++++++++++++++
>  rust/serde/private/doc.rs                 |  161 +
>  rust/serde/private/mod.rs                 |   52 +
>  rust/serde/private/ser.rs                 | 1316 +++++++
>  rust/serde/private/size_hint.rs           |   23 +
>  rust/serde/ser/fmt.rs                     |  180 +
>  rust/serde/ser/impls.rs                   |  987 ++++++
>  rust/serde/ser/impossible.rs              |  218 ++
>  rust/serde/ser/mod.rs                     | 1992 +++++++++++
>  rust/serde/std_error.rs                   |   50 +
>  rust/serde_cbor/de.rs                     | 1370 ++++++++
>  rust/serde_cbor/error.rs                  |  320 ++
>  rust/serde_cbor/lib.rs                    |  371 ++
>  rust/serde_cbor/read.rs                   |  647 ++++
>  rust/serde_cbor/ser.rs                    |  748 ++++
>  rust/serde_cbor/tags.rs                   |  224 ++
>  rust/serde_cbor/value/de.rs               |  168 +
>  rust/serde_cbor/value/mod.rs              |  158 +
>  rust/serde_cbor/value/ser.rs              |  447 +++
>  rust/serde_cbor/write.rs                  |  177 +
>  rust/serde_derive/bound.rs                |  408 +++
>  rust/serde_derive/de.rs                   | 3148 +++++++++++++++++
>  rust/serde_derive/dummy.rs                |   46 +
>  rust/serde_derive/fragment.rs             |   76 +
>  rust/serde_derive/internals/ast.rs        |  204 ++
>  rust/serde_derive/internals/attr.rs       | 1908 +++++++++++
>  rust/serde_derive/internals/case.rs       |  199 ++
>  rust/serde_derive/internals/check.rs      |  445 +++
>  rust/serde_derive/internals/ctxt.rs       |   64 +
>  rust/serde_derive/internals/mod.rs        |   30 +
>  rust/serde_derive/internals/receiver.rs   |  287 ++
>  rust/serde_derive/internals/respan.rs     |   18 +
>  rust/serde_derive/internals/symbol.rs     |   71 +
>  rust/serde_derive/lib.rs                  |  112 +
>  rust/serde_derive/pretend.rs              |  203 ++
>  rust/serde_derive/ser.rs                  | 1342 ++++++++
>  rust/serde_derive/this.rs                 |   34 +
>  rust/serde_derive/try.rs                  |   26 +
>  rust/syn/attr.rs                          |  664 ++++
>  rust/syn/await.rs                         |    4 +
>  rust/syn/bigint.rs                        |   68 +
>  rust/syn/buffer.rs                        |  400 +++
>  rust/syn/custom_keyword.rs                |  255 ++
>  rust/syn/custom_punctuation.rs            |  302 ++
>  rust/syn/data.rs                          |  495 +++
>  rust/syn/derive.rs                        |  276 ++
>  rust/syn/discouraged.rs                   |  196 ++
>  rust/syn/error.rs                         |  430 +++
>  rust/syn/export.rs                        |   41 +
>  rust/syn/expr.rs                          | 3560 +++++++++++++++++++
>  rust/syn/ext.rs                           |  141 +
>  rust/syn/file.rs                          |  127 +
>  rust/syn/gen/clone.rs                     | 2243 ++++++++++++
>  rust/syn/gen/debug.rs                     | 3044 +++++++++++++++++
>  rust/syn/gen/eq.rs                        | 2197 ++++++++++++
>  rust/syn/gen/fold.rs                      | 3343 ++++++++++++++++++
>  rust/syn/gen/hash.rs                      | 2871 ++++++++++++++++
>  rust/syn/gen/visit.rs                     | 3788 +++++++++++++++++++++
>  rust/syn/gen/visit_mut.rs                 | 3788 +++++++++++++++++++++
>  rust/syn/gen_helper.rs                    |  156 +
>  rust/syn/generics.rs                      | 1339 ++++++++
>  rust/syn/group.rs                         |  284 ++
>  rust/syn/ident.rs                         |  103 +
>  rust/syn/item.rs                          | 3315 ++++++++++++++++++
>  rust/syn/lib.rs                           |  985 ++++++
>  rust/syn/lifetime.rs                      |  156 +
>  rust/syn/lit.rs                           | 1602 +++++++++
>  rust/syn/lookahead.rs                     |  171 +
>  rust/syn/mac.rs                           |  221 ++
>  rust/syn/macros.rs                        |  179 +
>  rust/syn/op.rs                            |  236 ++
>  rust/syn/parse.rs                         | 1316 +++++++
>  rust/syn/parse_macro_input.rs             |  181 +
>  rust/syn/parse_quote.rs                   |  169 +
>  rust/syn/pat.rs                           |  929 +++++
>  rust/syn/path.rs                          |  856 +++++
>  rust/syn/print.rs                         |   18 +
>  rust/syn/punctuated.rs                    | 1070 ++++++
>  rust/syn/reserved.rs                      |   46 +
>  rust/syn/sealed.rs                        |    6 +
>  rust/syn/span.rs                          |   69 +
>  rust/syn/spanned.rs                       |  116 +
>  rust/syn/stmt.rs                          |  351 ++
>  rust/syn/thread.rs                        |   43 +
>  rust/syn/token.rs                         | 1015 ++++++
>  rust/syn/tt.rs                            |  109 +
>  rust/syn/ty.rs                            | 1288 +++++++
>  rust/syn/verbatim.rs                      |   35 +
>  rust/syn/whitespace.rs                    |   67 +
>  samples/rust/Kconfig                      |   28 +
>  samples/rust/Makefile                     |    3 +
>  samples/rust/local_data_format/de.rs      |  422 +++
>  samples/rust/local_data_format/error.rs   |   73 +
>  samples/rust/local_data_format/ser.rs     |  443 +++
>  samples/rust/puzzle.rs                    |    4 +
>  samples/rust/puzzle/error.rs              |   91 +
>  samples/rust/puzzle/inode.rs              |  150 +
>  samples/rust/puzzle/oci.rs                |   71 +
>  samples/rust/puzzle/types.rs              |  389 +++
>  samples/rust/puzzle/types/cbor_helpers.rs |   50 +
>  samples/rust/puzzlefs.rs                  |  220 ++
>  samples/rust/rust_fs.rs                   |  105 +
>  samples/rust/rust_serde.rs                |  125 +
>  scripts/Makefile.build                    |    4 +-
>  160 files changed, 89204 insertions(+), 29 deletions(-)
>  create mode 100644 arch/x86/configs/qemu-busybox-min.config
>  create mode 100644 kernel/configs/qemu-busybox-min.config
>  create mode 100644 rust/hex/error.rs
>  create mode 100644 rust/hex/lib.rs
>  create mode 100644 rust/hex/serde.rs
>  create mode 100644 rust/kernel/cred.rs
>  create mode 100644 rust/kernel/delay.rs
>  create mode 100644 rust/kernel/driver.rs
>  create mode 100644 rust/kernel/file.rs
>  create mode 100644 rust/kernel/fs.rs
>  create mode 100644 rust/kernel/fs/param.rs
>  create mode 100644 rust/kernel/io_buffer.rs
>  create mode 100644 rust/kernel/iov_iter.rs
>  create mode 100644 rust/kernel/mm.rs
>  create mode 100644 rust/kernel/mount.rs
>  create mode 100644 rust/kernel/pages.rs
>  create mode 100644 rust/kernel/test_serde.rs
>  create mode 100644 rust/kernel/test_serde/de.rs
>  create mode 100644 rust/kernel/test_serde/error.rs
>  create mode 100644 rust/kernel/test_serde/ser.rs
>  create mode 100644 rust/kernel/user_ptr.rs
>  create mode 100644 rust/proc-macro2/detection.rs
>  create mode 100644 rust/proc-macro2/fallback.rs
>  create mode 100644 rust/proc-macro2/lib.rs
>  create mode 100644 rust/proc-macro2/marker.rs
>  create mode 100644 rust/proc-macro2/parse.rs
>  create mode 100644 rust/proc-macro2/rcvec.rs
>  create mode 100644 rust/proc-macro2/wrapper.rs
>  create mode 100644 rust/quote/ext.rs
>  create mode 100644 rust/quote/format.rs
>  create mode 100644 rust/quote/ident_fragment.rs
>  create mode 100644 rust/quote/lib.rs
>  create mode 100644 rust/quote/runtime.rs
>  create mode 100644 rust/quote/spanned.rs
>  create mode 100644 rust/quote/to_tokens.rs
>  create mode 100644 rust/serde/de/format.rs
>  create mode 100644 rust/serde/de/ignored_any.rs
>  create mode 100644 rust/serde/de/impls.rs
>  create mode 100644 rust/serde/de/mod.rs
>  create mode 100644 rust/serde/de/seed.rs
>  create mode 100644 rust/serde/de/utf8.rs
>  create mode 100644 rust/serde/de/value.rs
>  create mode 100644 rust/serde/integer128.rs
>  create mode 100644 rust/serde/lib.rs
>  create mode 100644 rust/serde/macros.rs
>  create mode 100644 rust/serde/private/de.rs
>  create mode 100644 rust/serde/private/doc.rs
>  create mode 100644 rust/serde/private/mod.rs
>  create mode 100644 rust/serde/private/ser.rs
>  create mode 100644 rust/serde/private/size_hint.rs
>  create mode 100644 rust/serde/ser/fmt.rs
>  create mode 100644 rust/serde/ser/impls.rs
>  create mode 100644 rust/serde/ser/impossible.rs
>  create mode 100644 rust/serde/ser/mod.rs
>  create mode 100644 rust/serde/std_error.rs
>  create mode 100644 rust/serde_cbor/de.rs
>  create mode 100644 rust/serde_cbor/error.rs
>  create mode 100644 rust/serde_cbor/lib.rs
>  create mode 100644 rust/serde_cbor/read.rs
>  create mode 100644 rust/serde_cbor/ser.rs
>  create mode 100644 rust/serde_cbor/tags.rs
>  create mode 100644 rust/serde_cbor/value/de.rs
>  create mode 100644 rust/serde_cbor/value/mod.rs
>  create mode 100644 rust/serde_cbor/value/ser.rs
>  create mode 100644 rust/serde_cbor/write.rs
>  create mode 100644 rust/serde_derive/bound.rs
>  create mode 100644 rust/serde_derive/de.rs
>  create mode 100644 rust/serde_derive/dummy.rs
>  create mode 100644 rust/serde_derive/fragment.rs
>  create mode 100644 rust/serde_derive/internals/ast.rs
>  create mode 100644 rust/serde_derive/internals/attr.rs
>  create mode 100644 rust/serde_derive/internals/case.rs
>  create mode 100644 rust/serde_derive/internals/check.rs
>  create mode 100644 rust/serde_derive/internals/ctxt.rs
>  create mode 100644 rust/serde_derive/internals/mod.rs
>  create mode 100644 rust/serde_derive/internals/receiver.rs
>  create mode 100644 rust/serde_derive/internals/respan.rs
>  create mode 100644 rust/serde_derive/internals/symbol.rs
>  create mode 100644 rust/serde_derive/lib.rs
>  create mode 100644 rust/serde_derive/pretend.rs
>  create mode 100644 rust/serde_derive/ser.rs
>  create mode 100644 rust/serde_derive/this.rs
>  create mode 100644 rust/serde_derive/try.rs
>  create mode 100644 rust/syn/attr.rs
>  create mode 100644 rust/syn/await.rs
>  create mode 100644 rust/syn/bigint.rs
>  create mode 100644 rust/syn/buffer.rs
>  create mode 100644 rust/syn/custom_keyword.rs
>  create mode 100644 rust/syn/custom_punctuation.rs
>  create mode 100644 rust/syn/data.rs
>  create mode 100644 rust/syn/derive.rs
>  create mode 100644 rust/syn/discouraged.rs
>  create mode 100644 rust/syn/error.rs
>  create mode 100644 rust/syn/export.rs
>  create mode 100644 rust/syn/expr.rs
>  create mode 100644 rust/syn/ext.rs
>  create mode 100644 rust/syn/file.rs
>  create mode 100644 rust/syn/gen/clone.rs
>  create mode 100644 rust/syn/gen/debug.rs
>  create mode 100644 rust/syn/gen/eq.rs
>  create mode 100644 rust/syn/gen/fold.rs
>  create mode 100644 rust/syn/gen/hash.rs
>  create mode 100644 rust/syn/gen/visit.rs
>  create mode 100644 rust/syn/gen/visit_mut.rs
>  create mode 100644 rust/syn/gen_helper.rs
>  create mode 100644 rust/syn/generics.rs
>  create mode 100644 rust/syn/group.rs
>  create mode 100644 rust/syn/ident.rs
>  create mode 100644 rust/syn/item.rs
>  create mode 100644 rust/syn/lib.rs
>  create mode 100644 rust/syn/lifetime.rs
>  create mode 100644 rust/syn/lit.rs
>  create mode 100644 rust/syn/lookahead.rs
>  create mode 100644 rust/syn/mac.rs
>  create mode 100644 rust/syn/macros.rs
>  create mode 100644 rust/syn/op.rs
>  create mode 100644 rust/syn/parse.rs
>  create mode 100644 rust/syn/parse_macro_input.rs
>  create mode 100644 rust/syn/parse_quote.rs
>  create mode 100644 rust/syn/pat.rs
>  create mode 100644 rust/syn/path.rs
>  create mode 100644 rust/syn/print.rs
>  create mode 100644 rust/syn/punctuated.rs
>  create mode 100644 rust/syn/reserved.rs
>  create mode 100644 rust/syn/sealed.rs
>  create mode 100644 rust/syn/span.rs
>  create mode 100644 rust/syn/spanned.rs
>  create mode 100644 rust/syn/stmt.rs
>  create mode 100644 rust/syn/thread.rs
>  create mode 100644 rust/syn/token.rs
>  create mode 100644 rust/syn/tt.rs
>  create mode 100644 rust/syn/ty.rs
>  create mode 100644 rust/syn/verbatim.rs
>  create mode 100644 rust/syn/whitespace.rs
>  create mode 100644 samples/rust/local_data_format/de.rs
>  create mode 100644 samples/rust/local_data_format/error.rs
>  create mode 100644 samples/rust/local_data_format/ser.rs
>  create mode 100644 samples/rust/puzzle.rs
>  create mode 100644 samples/rust/puzzle/error.rs
>  create mode 100644 samples/rust/puzzle/inode.rs
>  create mode 100644 samples/rust/puzzle/oci.rs
>  create mode 100644 samples/rust/puzzle/types.rs
>  create mode 100644 samples/rust/puzzle/types/cbor_helpers.rs
>  create mode 100644 samples/rust/puzzlefs.rs
>  create mode 100644 samples/rust/rust_fs.rs
>  create mode 100644 samples/rust/rust_serde.rs
> 
> -- 
> 2.40.1
> 
