Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C648B69B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiAKTQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346195AbiAKTQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AEDC06173F;
        Tue, 11 Jan 2022 11:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D1D1B81D1D;
        Tue, 11 Jan 2022 19:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ECEC36AE3;
        Tue, 11 Jan 2022 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928570;
        bh=5BUHsZ9mGh050IH+xm5b4ysTK9i/h+DirJuEJvn88JY=;
        h=From:To:Cc:Subject:Date:From;
        b=f4drrTGzhbEETcKj4P78b8o8tb0pGg/IWlkV6uGoS8BFsuUPQy+Czdau9v+IVUayj
         FOQxBCGZfL1xFiHcCcKYIX+0wNWKw2mwGFUF2HK7r3gff5zS8uhgNp1txEyKenN9vc
         pSM2gq1EQdVHl0qtRYRrcgLD9Eml7Wz+AmcDmVjnXK/NTQdA/CCLtcGAs5sCEycuxb
         kqJ5HgyttS6azpg9dPzorrnz4uxgagxZc1gz3Ge1UROOpOkk6xOf9qi/cqcUs0YFWH
         0cnMH8bdJAGrGbUtuHXNHWTW1BEWurFUj9ZvsxDSB0b/HVQvKJ+RND+thl5rZFrBmW
         tmbuRu8NBvIfA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 00/48] ceph+fscrypt: full support
Date:   Tue, 11 Jan 2022 14:15:20 -0500
Message-Id: <20220111191608.88762-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset represents a (mostly) complete rough draft of fscrypt
support for cephfs. The context, filename and symlink support is more or
less the same as the versions posted before, and comprise the first half
of the patches.

The new bits here are the size handling changes and support for content
encryption, in buffered, direct and synchronous codepaths. Much of this
code is still very rough and needs a lot of cleanup work.

fscrypt support relies on some MDS changes that are being tracked here:

    https://github.com/ceph/ceph/pull/43588

In particular, this PR adds some new opaque fields in the inode that we
use to store fscrypt-specific information, like the context and the real
size of a file. That is slated to be merged for the upcoming Quincy
release (which is sometime this northern spring).

There are still some notable bugs:

1/ we've identified a few more potential races in truncate handling
which will probably necessitate a protocol change, as well as changes to
the MDS and kclient patchsets. The good news is that we think we have
an approach that will resolve this.

2/ the kclient doesn't handle reading sparse regions in OSD objects
properly yet. The client can end up writing to a non-zero offset in a
non-existent object. Then, if the client tries to read the written
region back later, it'll get back zeroes and give you garbage when you
try to decrypt them.

It turns out that the OSD already supports a SPARSE_READ operation, so
I'm working on implementing that in the kclient to make it not try to
decrypt the sparse regions.

Still, I was able to run xfstests on this set yesterday. Bug #2 above
prevented all of the tests from passing, but it didn't oops! I call that
progress! Given that, I figured this is a good time to post what I have
so far.

Note that the buffered I/O changes in this set are not suitable for
merge and will likely end up being discarded. We need to plumb the
encryption in at the netfs layer, so that we can store encrypted data
in fscache.

The non-buffered codepaths will likely also need substantial changes
before merging. It may be simpler to just move that into the netfs layer
too as cifs will need something similar anyway.

My goal is to get most of this into v5.18, but v5.19 might be more
realistiv. Hopefully I'll have a non-RFC patchset to send in a few
weeks.

Special thanks to Xiubo who came through with the MDS patches. Also,
thanks to everyone (especially Eric Biggers) for all of the previous
reviews. It's much appreciated!

Jeff Layton (43):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: preallocate inode for ops that may create one
  ceph: crypto context handling for ceph
  ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
  ceph: add fscrypt_* handling to caps.c
  ceph: add ability to set fscrypt_auth via setattr
  ceph: implement -o test_dummy_encryption mount option
  ceph: decode alternate_name in lease info
  ceph: add fscrypt ioctls
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: send altname in MClientRequest
  ceph: encode encrypted name in dentry release
  ceph: properly set DCACHE_NOKEY_NAME flag in lookup
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: add helpers for converting names for userland presentation
  ceph: add fscrypt support to ceph_fill_trace
  ceph: add support to readdir for encrypted filenames
  ceph: create symlinks with encrypted and base64-encoded targets
  ceph: make ceph_get_name decrypt filenames
  ceph: add a new ceph.fscrypt.auth vxattr
  ceph: add some fscrypt guardrails
  libceph: add CEPH_OSD_OP_ASSERT_VER support
  ceph: size handling for encrypted inodes in cap updates
  ceph: fscrypt_file field handling in MClientRequest messages
  ceph: get file size from fscrypt_file when present in inode traces
  ceph: handle fscrypt fields in cap messages from MDS
  ceph: add infrastructure for file encryption and decryption
  libceph: allow ceph_osdc_new_request to accept a multi-op read
  ceph: disable fallocate for encrypted inodes
  ceph: disable copy offload on encrypted inodes
  ceph: don't use special DIO path for encrypted inodes
  ceph: set encryption context on open
  ceph: align data in pages in ceph_sync_write
  ceph: add read/modify/write to ceph_sync_write
  ceph: plumb in decryption during sync reads
  ceph: set i_blkbits to crypto block size for encrypted inodes
  ceph: add fscrypt decryption support to ceph_netfs_issue_op
  ceph: add encryption support to writepage
  ceph: fscrypt support for writepages

Luis Henriques (1):
  ceph: don't allow changing layout on encrypted files/directories

Xiubo Li (4):
  ceph: add __ceph_get_caps helper support
  ceph: add __ceph_sync_read helper support
  ceph: add object version support for sync read
  ceph: add truncate size handling support for fscrypt

 fs/ceph/Makefile                |   1 +
 fs/ceph/acl.c                   |   4 +-
 fs/ceph/addr.c                  | 128 +++++--
 fs/ceph/caps.c                  | 211 ++++++++++--
 fs/ceph/crypto.c                | 374 +++++++++++++++++++++
 fs/ceph/crypto.h                | 237 +++++++++++++
 fs/ceph/dir.c                   | 209 +++++++++---
 fs/ceph/export.c                |  44 ++-
 fs/ceph/file.c                  | 476 +++++++++++++++++++++-----
 fs/ceph/inode.c                 | 576 +++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c                 |  87 +++++
 fs/ceph/mds_client.c            | 349 ++++++++++++++++---
 fs/ceph/mds_client.h            |  24 +-
 fs/ceph/super.c                 |  90 ++++-
 fs/ceph/super.h                 |  43 ++-
 fs/ceph/xattr.c                 |  29 ++
 fs/crypto/fname.c               |  44 ++-
 fs/crypto/fscrypt_private.h     |   9 +-
 fs/crypto/hooks.c               |   6 +-
 fs/crypto/policy.c              |  35 +-
 fs/inode.c                      |   1 +
 include/linux/ceph/ceph_fs.h    |  21 +-
 include/linux/ceph/osd_client.h |   6 +-
 include/linux/ceph/rados.h      |   4 +
 include/linux/fscrypt.h         |  10 +
 net/ceph/osd_client.c           |  32 +-
 26 files changed, 2700 insertions(+), 350 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.34.1

