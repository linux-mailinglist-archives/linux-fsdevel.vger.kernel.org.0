Return-Path: <linux-fsdevel+bounces-19606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7898C7CD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C02283CF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771091581E4;
	Thu, 16 May 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="X1ZVGNQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11889157A6B;
	Thu, 16 May 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886310; cv=none; b=ksklpbFZbyxUmsdxR5A9rSo/ZM0BoNEl3yWtkogpaXF9X1l/h8KyaqiubO+sfLHG5L5Pco3LxcQ70iq0dA6ZQyHTHEy4ugQNgr6v9HHd472H34XIu4fDISa8S3CsHinTZ+84IbMAtFopKrmdxQCyBTOTguhoxJbu/CtFHI1JEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886310; c=relaxed/simple;
	bh=LwM6Q7N7celQik3aLROsh7bNCTpSPzrCzPk7LQD/80E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7RfbdVehzBkU1pWk9duD0g7dkPYnQdRyx8BzmrspqHMsA033l9vyJndW2vdWZt72LolNPLvIuFQ0Cy193n/auvtAbzvy2BW/gnAtMiWRICRQWz1SY/YTvvt9C2BHZgcz0hPjRtyNaOYmBn/BI+0XewQsC0Gl/aDT3Z8WaM76N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=X1ZVGNQN; arc=none smtp.client-ip=173.38.203.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11704; q=dns/txt;
  s=iport; t=1715886308; x=1717095908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A3lDHlbk+GP8IXzeSGYbBPbUBsIIzGz1hTrxygjQfAA=;
  b=X1ZVGNQN2h6oUMZoxnodZEVDPpxEr+R5OrYLNeTEERv6uEaUZxVo+7sN
   wZ4TVBCokBkS+wk2g8RmTMRyMn4MJJaQZlE9QDJmhl2/zsRilYGZ37ovR
   ddcwGtDQtipJribtDYCBiFt7xLkcGmZr+a9oLOKFhufPXJ1yVm6Tj3TEY
   4=;
X-CSE-ConnectionGUID: gU6/GG8FRGGuoWlA8O6Nzw==
X-CSE-MsgGUID: uEN4wxPZRouaM2osWk+PHQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12419630"
Received: from aer-iport-nat.cisco.com (HELO aer-core-12.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:03:57 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-12.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ3uV3100626
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:03:56 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 00/22] Rust PuzzleFS filesystem driver
Date: Thu, 16 May 2024 22:03:23 +0300
Message-Id: <20240516190345.957477-1-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-12.cisco.com

Hello everyone,

This series is the third version of the proof-of-concept PuzzleFS
filesystem driver, an open-source next-generation container filesystem
[1], designed to address the limitation of the existing OCI format. It
supports direct mounting of container filesystems without an extraction
step, and it uses content defined chunking (CDC) in order to often
achieve substantial disk space savings. It is similar to casync [9] in
this regard. For more details, I had a presentation last year at Open
Source Summit Europe [2]. There's also a dedicated PuzzleFS page on the
rust-for-linux website [3] and an LWN article about PuzzleFS [4].

This patch series is based on the latest filesystem abstraction patches
[5] sent to LKML a few days ago. I've been keeping PuzzleFS up-to-date
with the multiple versions of the filesystem abstractions, even though I
haven't sent patches after each change. However, Cisco is still
interested in upstreaming PuzzleFS and I would like to gather another
round of feedback.

I have described my kernel setup and how to get started with the
PuzzleFS kernel driver in this blog post [7]. Below I've included a
short demo of the PuzzleFS kernel driver.

To mount a PuzzleFS driver, we must pass the `oci_root_dir` and
`image_manifest` as parameters.
```
~ # mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_xattr" -o \
image_manifest="ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab" \
none /mnt
[ 6789.110219] PuzzleFS: opened puzzlefs [/home/puzzlefs_xattr]:[ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab]

~ # cd /mnt/
/mnt # ls -la
total 1
drwxr-xr-x    2 1000     1000             0 Jan  1  1970 test
drwxr-xr-x    2 1000     1000             0 Jan  1  1970 test-2
-rw-r--r--    1 1000     1000            20 Jan  1  1970 test.txt

/mnt # cat test.txt
The quick brown fox
```

In this example, `/home/puzzlefs_xattr` is the puzzlefs oci directory,
obtained by building a PuzzleFS image via the `puzzlefs build` command.
Here's the disk layout of the image (for more details about the image
format, consult the README in the github repository [1]):
```
/mnt # ls -lR /home/puzzlefs_xattr/
/home/puzzlefs_xattr/:
total 8
drwxr-xr-x    3 1000     1000             0 May 15 20:24 blobs
-rw-r--r--    1 1000     1000           263 May 15 20:24 index.json
-rw-r--r--    1 1000     1000            37 May 15 20:24 oci-layout

/home/puzzlefs_xattr/blobs:
total 0
drwxr-xr-x    2 1000     1000             0 May 15 20:24 sha256

/home/puzzlefs_xattr/blobs/sha256:
total 12
-rw-------    1 1000     1000            20 May 15 20:24 35fb7cc2337d10d618a1bad35c7a9e957c213f00d0ed32f2454b2a99a9718
-rw-------    1 1000     1000           752 May 15 20:24 d1cbb5b11a9044ecb3889397e0df8c594484cc630294cf208e57ad9dcf6ca
-rw-------    1 1000     1000           272 May 15 20:24 ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953b
```

To get the PuzzleFS image manifest, we can look into the `index.json`
file. The following digest, corresponding to the `xattr` tag, must be
passed as a parameter when mounting the filesystem:
ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab

In userspace we can pass the `xattr` tag directly, but we don't want to
parse the json format in the kernel.
```
$ cat index.json | jq
{
  "schemaVersion": -1,
  "manifests": [
    {
      "digest": "sha256:ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab",
      "size": 272,
      "media_type": "application/vnd.puzzlefs.image.rootfs.v1",
      "annotations": {
        "org.opencontainers.image.ref.name": "xattr"
      }
    }
  ],
  "annotations": {}
}
```

For testing extended attributes, I've written a small cli program called
`xattr-cli` which is available here [8]. No reason to use this over
`getfattr`, except it is not available in a busybox environment.

```
/mnt # /home/xattr-cli test
Extended attributes of test:
user.comment -> this is a dir
user.groceries -> want to buy a file
/mnt # /home/xattr-cli test-2/
Extended attributes of test-2/:
user.whatever -> want to buy a file
```

A git tree for this patch series is available here:
git://github.com/ariel-miculas/linux.git puzzlefs_rfc_v3

Web:
https://github.com/ariel-miculas/linux/tree/puzzlefs_rfc_v3

[1] https://github.com/project-machine/puzzlefs
[2] https://osseu2023.sched.com/event/1OGjk/puzzlefs-the-next-generation-container-filesystem-armand-ariel-miculas-cisco-systems
[3] https://rust-for-linux.com/puzzlefs-filesystem-driver
[4] https://lwn.net/Articles/945320/
[5] https://lore.kernel.org/rust-for-linux/20240514131711.379322-1-wedsonaf@gmail.com/
[6] https://lore.kernel.org/rust-for-linux/20230726164535.230515-1-amiculas@cisco.com/
[7] https://machinerun.io/puzzlefs/2023/10/30/Linux-kernel-setup.html
[8] https://github.com/ariel-miculas/xattr-cli
[9] https://0pointer.net/blog/casync-a-tool-for-distributing-file-system-images.html

--- 

Main changes since v2 [6]:
* PuzzleFS now uses the latest filesystem abstractions [5]
* added extended attributes support

--- 

Alice Ryhl (1):
  rust: add improved version of `ForeignOwnable::borrow_mut`

Ariel Miculas (19):
  kernel: configs: add qemu-busybox-min.config
  rust: hex: import crate
  rust: hex: add SPDX license identifiers
  rust: Kbuild: enable `hex`
  rust: hex: add encode_hex_iter and encode_hex_upper_iter methods
  rust: capnp: import crate
  rust: capnp: add SPDX License Identifiers
  rust: capnp: return an error when trying to display floating point
    values
  rust: Kbuild: enable `capnp`
  rust: kernel: add an abstraction over vfsmount to allow cloning a new
    private mount
  rust: file: Add support for reading files using their path
  fs: puzzlefs: Implement the initial version of PuzzleFS
  rust: kernel: add from_iter_fallible for Vec<T>
  kernel: configs: add puzzlefs config fragment
  scripts: add fs directory to rust-analyzer
  fs: puzzlefs: add extended attributes support
  Add borrow_mut implementation to a ForeignOwnable CString
  fs: puzzlefs: add oci_root_dir and image_manifest mount parameters
  fs: puzzlefs: implement statfs for puzzlefs

Wedson Almeida Filho (2):
  rust: file: add bindings for `struct file`
  rust: add support for file system parameters

 arch/x86/configs/qemu-busybox-min.config      |    11 +
 fs/Kconfig                                    |     1 +
 fs/Makefile                                   |     1 +
 fs/puzzlefs/Kconfig                           |    14 +
 fs/puzzlefs/Makefile                          |     8 +
 fs/puzzlefs/puzzle.rs                         |     5 +
 fs/puzzlefs/puzzle/error.rs                   |   105 +
 fs/puzzlefs/puzzle/inode.rs                   |   122 +
 fs/puzzlefs/puzzle/oci.rs                     |    70 +
 fs/puzzlefs/puzzle/types.rs                   |   377 +
 fs/puzzlefs/puzzle/types/manifest.capnp       |    15 +
 fs/puzzlefs/puzzle/types/manifest_capnp.rs    |   757 +
 fs/puzzlefs/puzzle/types/metadata.capnp       |    65 +
 fs/puzzlefs/puzzle/types/metadata_capnp.rs    |  4049 +++++
 fs/puzzlefs/puzzlefs.rs                       |   330 +
 kernel/configs/puzzlefs.config                |     4 +
 kernel/configs/qemu-busybox-min.config        |    56 +
 rust/Makefile                                 |    41 +-
 rust/bindings/bindings_helper.h               |     3 +
 rust/capnp/any_pointer.rs                     |   315 +
 rust/capnp/any_pointer_list.rs                |   210 +
 rust/capnp/capability.rs                      |   365 +
 rust/capnp/capability_list.rs                 |   299 +
 rust/capnp/constant.rs                        |    56 +
 rust/capnp/data.rs                            |    97 +
 rust/capnp/data_list.rs                       |   220 +
 rust/capnp/dynamic_list.rs                    |   410 +
 rust/capnp/dynamic_struct.rs                  |   784 +
 rust/capnp/dynamic_value.rs                   |   319 +
 rust/capnp/enum_list.rs                       |   239 +
 rust/capnp/introspect.rs                      |   284 +
 rust/capnp/io.rs                              |   204 +
 rust/capnp/lib.rs                             |   653 +
 rust/capnp/list_list.rs                       |   298 +
 rust/capnp/message.rs                         |   880 +
 rust/capnp/primitive_list.rs                  |   281 +
 rust/capnp/private/arena.rs                   |   419 +
 rust/capnp/private/capability.rs              |   157 +
 rust/capnp/private/layout.rs                  |  4212 +++++
 rust/capnp/private/layout_test.rs             |   194 +
 rust/capnp/private/mask.rs                    |    64 +
 rust/capnp/private/mod.rs                     |    38 +
 rust/capnp/private/primitive.rs               |   121 +
 rust/capnp/private/read_limiter.rs            |   115 +
 rust/capnp/private/units.rs                   |    70 +
 rust/capnp/private/zero.rs                    |    48 +
 rust/capnp/raw.rs                             |    71 +
 rust/capnp/schema.rs                          |   432 +
 rust/capnp/schema_capnp.rs                    | 14450 ++++++++++++++++
 rust/capnp/serialize.rs                       |   963 +
 .../serialize/no_alloc_buffer_segments.rs     |   629 +
 rust/capnp/serialize_packed.rs                |   620 +
 rust/capnp/stringify.rs                       |   187 +
 rust/capnp/struct_list.rs                     |   302 +
 rust/capnp/text.rs                            |   296 +
 rust/capnp/text_list.rs                       |   218 +
 rust/capnp/traits.rs                          |   235 +
 rust/helpers.c                                |    16 +
 rust/hex/error.rs                             |    61 +
 rust/hex/lib.rs                               |   495 +
 rust/hex/serde.rs                             |   104 +
 rust/kernel/alloc/vec_ext.rs                  |    12 +
 rust/kernel/error.rs                          |     4 +-
 rust/kernel/file.rs                           |   298 +
 rust/kernel/fs.rs                             |   212 +-
 rust/kernel/fs/inode.rs                       |    66 +-
 rust/kernel/fs/param.rs                       |   576 +
 rust/kernel/lib.rs                            |     9 +
 rust/kernel/mount.rs                          |    73 +
 rust/kernel/str.rs                            |    24 +
 rust/kernel/sync/arc.rs                       |    25 +-
 rust/kernel/types.rs                          |    93 +-
 samples/rust/rust_rofs.rs                     |    32 +-
 scripts/Makefile.build                        |     2 +-
 scripts/generate_rust_analyzer.py             |     2 +-
 75 files changed, 37843 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/configs/qemu-busybox-min.config
 create mode 100644 fs/puzzlefs/Kconfig
 create mode 100644 fs/puzzlefs/Makefile
 create mode 100644 fs/puzzlefs/puzzle.rs
 create mode 100644 fs/puzzlefs/puzzle/error.rs
 create mode 100644 fs/puzzlefs/puzzle/inode.rs
 create mode 100644 fs/puzzlefs/puzzle/oci.rs
 create mode 100644 fs/puzzlefs/puzzle/types.rs
 create mode 100644 fs/puzzlefs/puzzle/types/manifest.capnp
 create mode 100644 fs/puzzlefs/puzzle/types/manifest_capnp.rs
 create mode 100644 fs/puzzlefs/puzzle/types/metadata.capnp
 create mode 100644 fs/puzzlefs/puzzle/types/metadata_capnp.rs
 create mode 100644 fs/puzzlefs/puzzlefs.rs
 create mode 100644 kernel/configs/puzzlefs.config
 create mode 100644 kernel/configs/qemu-busybox-min.config
 create mode 100644 rust/capnp/any_pointer.rs
 create mode 100644 rust/capnp/any_pointer_list.rs
 create mode 100644 rust/capnp/capability.rs
 create mode 100644 rust/capnp/capability_list.rs
 create mode 100644 rust/capnp/constant.rs
 create mode 100644 rust/capnp/data.rs
 create mode 100644 rust/capnp/data_list.rs
 create mode 100644 rust/capnp/dynamic_list.rs
 create mode 100644 rust/capnp/dynamic_struct.rs
 create mode 100644 rust/capnp/dynamic_value.rs
 create mode 100644 rust/capnp/enum_list.rs
 create mode 100644 rust/capnp/introspect.rs
 create mode 100644 rust/capnp/io.rs
 create mode 100644 rust/capnp/lib.rs
 create mode 100644 rust/capnp/list_list.rs
 create mode 100644 rust/capnp/message.rs
 create mode 100644 rust/capnp/primitive_list.rs
 create mode 100644 rust/capnp/private/arena.rs
 create mode 100644 rust/capnp/private/capability.rs
 create mode 100644 rust/capnp/private/layout.rs
 create mode 100644 rust/capnp/private/layout_test.rs
 create mode 100644 rust/capnp/private/mask.rs
 create mode 100644 rust/capnp/private/mod.rs
 create mode 100644 rust/capnp/private/primitive.rs
 create mode 100644 rust/capnp/private/read_limiter.rs
 create mode 100644 rust/capnp/private/units.rs
 create mode 100644 rust/capnp/private/zero.rs
 create mode 100644 rust/capnp/raw.rs
 create mode 100644 rust/capnp/schema.rs
 create mode 100644 rust/capnp/schema_capnp.rs
 create mode 100644 rust/capnp/serialize.rs
 create mode 100644 rust/capnp/serialize/no_alloc_buffer_segments.rs
 create mode 100644 rust/capnp/serialize_packed.rs
 create mode 100644 rust/capnp/stringify.rs
 create mode 100644 rust/capnp/struct_list.rs
 create mode 100644 rust/capnp/text.rs
 create mode 100644 rust/capnp/text_list.rs
 create mode 100644 rust/capnp/traits.rs
 create mode 100644 rust/hex/error.rs
 create mode 100644 rust/hex/lib.rs
 create mode 100644 rust/hex/serde.rs
 create mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/fs/param.rs
 create mode 100644 rust/kernel/mount.rs

-- 
2.34.1


