Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C31D2B4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgENJYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 05:24:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgENJYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 05:24:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so2932712wrn.6;
        Thu, 14 May 2020 02:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80LUdNwveCgDKH5LIakdxC++ApFkWqVk9A6Kl2+ExLI=;
        b=XLKj//BiGoBvAORlsOAPwfYQda+VHJES9DfQLSnbyGzHi1AsvP3V9cJWG9Ug5uYjNL
         Xzxyq3WOWdE9vtPUyTSVvrmuGXBCJuAODn4raQMcQBJm4XO8kHkD2dFu6kFN+y4eyejx
         RqvN3ueLjyxMop9+9jsnXUHmfPQxVCUwoGSaRst4sOqhn5EwuG/29Y+krov2VdyUaAOE
         Y8F1eJNtOY2KHHWGhbQNrvWlFSdk6BfnkcvwyfUuB8rfxzWwWs/sQTgvzTuM1FwmGZhK
         r+IpCWovVVfEs/jKJ/eljD7U2WxeJXKZvB34k/BIQsapwpuLUUKfAKaXHu9CqdaYdhaK
         d9Rw==
X-Gm-Message-State: AOAM532Jly47SKMImzbx2YXzsMioKz/4liLirnTsVKaR/WiXtMoAH+z6
        dEYktD0T/YqnrQaT1fuducc=
X-Google-Smtp-Source: ABdhPJzicvH+ra/nFQ9SaGCBu22VOQIX1mvpOZSNAj5K/U+GW3iZIBto+GEJ9ZZ1erCjMRiJJ52PJw==
X-Received: by 2002:adf:dc81:: with SMTP id r1mr4798347wrj.0.1589448283010;
        Thu, 14 May 2020 02:24:43 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id z132sm38877763wmc.29.2020.05.14.02.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:24:42 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 3/3] btrfs: document btrfs authentication
Date:   Thu, 14 May 2020 11:24:15 +0200
Message-Id: <20200514092415.5389-4-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514092415.5389-1-jth@kernel.org>
References: <20200514092415.5389-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Document the design, guarantees and limitations of an authenticated BTRFS
file-system.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 .../filesystems/btrfs-authentication.rst      | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/filesystems/btrfs-authentication.rst

diff --git a/Documentation/filesystems/btrfs-authentication.rst b/Documentation/filesystems/btrfs-authentication.rst
new file mode 100644
index 000000000000..f13cab248fc0
--- /dev/null
+++ b/Documentation/filesystems/btrfs-authentication.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:orphan:
+
+.. BTRFS Authentication
+.. Western Digital or it's affiliates
+.. 2020
+
+Introduction
+============
+
+This document describes an approach get file contents _and_ full meta-data
+authentication for BTRFS.
+
+This is possible because BTRFS uses checksums embedded in its on-disk
+meta-data structures as well as checksums for each individual extent of data.
+The primary intent of these checksums was to detect bit-flips of data at rest.
+But this mechanism can be extended to provide authentication of all on-disk
+data when the checksum algorithm is replaced by a cryptographically secure
+keyed hash.
+
+BTRFS Data Structures
+---------------------
+
+BTRFS utilizes a special copy-on-write b-tree to store all contents of the
+file-system on disk.
+
+Meta-Data
+~~~~~~~~~
+
+On-disk meta-data in BTRFS is stored in copy-on-write b-trees. These b-trees
+are build using two data structures, ``struct btrfs_node`` and ``struct
+btrfs_leaf``. Both of these structures start with a ``struct btrfs_header``.
+This structure has amongst other fields a checksum field, protecting it's
+contents. As the checksum is the first entry in the structure, the whole
+structure is protected by this checksum. The superblock (``struct
+btrfs_super_block``) is the first on-disk structure which is read on mount and
+it as well starts with a checksum field protecting the rest of the structure.
+The super block is also needed to read the addresses of the other file system
+b-trees, so their location on disk is protected by the checksum.
+
+::
+
+          BTRFS Header
+          +------+------+--------+-------+-----------------+----+-------+---------+
+          | csum | fsid | bytenr | flags | chunk_tree_uuid | gen| owner | nritems |
+          +------+------+--------+-------+-----------------+----+-------+---------+
+          BTRFS Node
+          +--------+-------------+-------------+-----+
+          | Header | key pointer | key pointer | ... |
+          +--------+-------------+-------------+-----+
+          BTRFS Leaf
+          +--------+------+------+-----+
+          | Header | item | item | ... |
+          +--------+------+------+-----+
+
+            Figure 1: BTRFS Header, Node and Leaf data structures
+
+User-Data
+~~~~~~~~~
+
+User data in BRTFS is also protected by checksums, but this checksum is not
+stored alongside the data, as it is with meta-data, but stored in a separate
+b-tree, the checksum tree. The leafs of this tree store the checksums of the
+user-data.  The tree nodes and leafs are of ``struct btrfs_node`` or ``struct
+btrfs_leaf``, so integrity of this tree is protected as well.
+
+BTRFS Authentication
+====================
+
+This chapter introduces BTRFS authentication which enables BTRFS to verify
+the authenticity and integrity of metadata and file contents stored on disk.
+
+Threat Model
+------------
+
+BTRFS authentication enables detection of offline data modification. While it
+does not prevent it, it enables (trusted) code to check the integrity and
+authenticity of on-disk file contents and filesystem metadata. This covers
+attacks where file contents are swapped.
+
+BTRFS authentication will not protect against a rollback of full disk
+contents. Ie. an attacker can still dump the disk and restore it at a later
+time without detection. It will also not protect against a rollback of one
+transaction. That means an attacker is able to partially undo changes. This is
+possible, because BTRFS does not immediately overwrite obsolete versions of
+its meta-data but keeps older generations until they get garbage collected.
+
+BTRFS authentication does not cover attacks where an attacker is able to
+execute code on the device after the authentication key was provided.
+Additional measures like secure boot and trusted boot have to be taken to
+ensure that only trusted code is executed on a device.
+
+As the file-system authentication key is also needed to update data structures
+on disk, the key has to be in the kernel's keyring for the whole time the
+file-system is mounted. An attacker that is able to compromise the kernel can
+be able to extract the key from the kernel's keyring and thus can gain the
+ability to modify the file-system later on.
+
+Authentication
+--------------
+
+To be able to fully trust data read from disk, all BTRFS data structures
+stored on disk are authenticated. That is:
+
+- The super blocks
+- The file-system b-trees
+- The user-data
+
+
+Super-block
+~~~~~~~~~~~
+
+In order to be able to authenticate the file-system's super-block, the
+checksum stored in the checksum field at the beginning of ``struct
+btrfs_super_block`` protecting its contents is replaced by a
+cryptographically secure keyed hash. In order to generate a valid super-block
+or to validate the super-block, one has to provide a key as an additional
+input for the hash function. The super-block is the starting point to read all
+on disk tree structures, so if we cannot trust the authenticity of the
+super-block anymore, we cannot trust the whole file-system.
+
+B-Trees
+~~~~~~~
+
+Starting from the super-block's root-tree root, the root tree holds the b-tree
+roots of all other on disk b-trees. All other file-system meta-data can be
+derived from the trees stored in this tree. As all b-trees in BTRFS are built
+using ``struct btrfs_node`` and ``struct btrfs_leaf`` each building block of
+each tree is checksummed. These checksums are replaced with the cryptographically
+secure keyed hash algorithm and the authentication key used to verify the
+super-block in the mount phase. Without this key it is impossible to alter any
+of the file-system structure without generating invalid hashes.
+
+User-data
+~~~~~~~~~
+
+The checksums for the user or file-data are stored in a separate b-tree, the
+checksum tree. As this tree in itself is authenticated, only the data stored
+in it needs to be authenticated. This is done by replacing the checksums
+stored on disk by the cryptographically secure keyed hash algorithm used for
+the super-block and other meta-data. So each written file block will get
+checksummed with the authentication key and without supplying the correct key
+it is impossible to write data on disk, which can be read back without
+failing the authentication test. If this test is failed, an I/O error is
+reported back to the user.
+
+Key Management
+--------------
+
+For simplicity, BTRFS authentication uses a single key to compute the keyed
+hashes of the super-block, b-tree nodes and leafs as well as file-blocks. This
+key has to be available on creation of the file-system (`mkfs.btrfs`) to
+authenticate all b-tree elements and the super-blocks. Further, it has to be
+available on mount of the file-system to verify the meta-data and user-data
+stored in the file-system.
+
+Limitations
+-----------
+
+As some optional features of BTRFS disable the generation of checksums, these
+features are incompatible with an authenticated BTRFS.
+These features are:
+- nodatacow
+- nodatasum
+
+As well as any offline modifications to the file-system, like setting an FS
+label while the FS is unmounted.
-- 
2.26.1

