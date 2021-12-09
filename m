Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DE46EB77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhLIPk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42314 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhLIPk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EED62CE263D;
        Thu,  9 Dec 2021 15:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7447C004DD;
        Thu,  9 Dec 2021 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064209;
        bh=CjgPHIzdY9OrTgVzvwCJt5X3hd5T077uC9M+g37Rh2E=;
        h=From:To:Cc:Subject:Date:From;
        b=grwXIG4KuMSksRwzGolUrsqFaSOqkCNGd5oWjj1LbCnIMkGLcP3HHZUcRvsdk/Kqt
         PYjCR8Hmm2sDLDtFSY26xmKPCIvd2PuNykv0lbyv3UMdo/D3JL9PeHcE5aOU/w3Noc
         U8b5Ip6Xq6a5GzfSImnG9eX26TAvASNw8ZyifjYoxe9hajDaxa1gq7QJ4LegWA+emD
         H6kcVLrm0qMhqiclL6D/X7/b17eg2xerKFc3aHfFrPewvQGbOoVIiF9EFNuBNSCs/i
         F+RO6YT68YZCP4S2STaUYYfAR4HXk1E7j4/9FmqSFl+FUpTzQui6m96M2eQWL0i+gQ
         bMIPkbb4NT69w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/36] ceph+fscrypt: context, filename, symlink and size handling support
Date:   Thu,  9 Dec 2021 10:36:11 -0500
Message-Id: <20211209153647.58953-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've not posted this in a while, so I figured it was a good time to do
so. This patchset is a pile of the mostly settled parts of the fscrypt
integration series. With this, pretty much everything but the actual
content encryption in files now works.

This series is also in the wip-fscrypt-size branch of the ceph-client
tree:

    https://github.com/ceph/ceph-client/tree/wip-fscrypt-size

It would also be nice to have an ack from Al Viro on patch #1, and from
Eric Biggers on #2-5. Those touch code outside of the ceph parts. If
they aren't acceptable for some reason, I'll need to find other ways to
handle them.

Jeff Layton (31):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  fscrypt: uninline and export fscrypt_require_key
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

Luis Henriques (1):
  ceph: don't allow changing layout on encrypted files/directories

Xiubo Li (4):
  ceph: add __ceph_get_caps helper support
  ceph: add __ceph_sync_read helper support
  ceph: add object version support for sync read
  ceph: add truncate size handling support for fscrypt

 fs/ceph/Makefile                |   1 +
 fs/ceph/acl.c                   |   4 +-
 fs/ceph/caps.c                  | 211 ++++++++++--
 fs/ceph/crypto.c                | 253 ++++++++++++++
 fs/ceph/crypto.h                | 154 +++++++++
 fs/ceph/dir.c                   | 209 +++++++++---
 fs/ceph/export.c                |  44 ++-
 fs/ceph/file.c                  | 125 ++++---
 fs/ceph/inode.c                 | 566 +++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c                 |  87 +++++
 fs/ceph/mds_client.c            | 349 +++++++++++++++++---
 fs/ceph/mds_client.h            |  24 +-
 fs/ceph/super.c                 |  82 ++++-
 fs/ceph/super.h                 |  42 ++-
 fs/ceph/xattr.c                 |  29 ++
 fs/crypto/fname.c               |  40 ++-
 fs/crypto/fscrypt_private.h     |  35 +-
 fs/crypto/hooks.c               |   6 +-
 fs/crypto/keysetup.c            |  27 ++
 fs/crypto/policy.c              |  34 +-
 fs/inode.c                      |   1 +
 include/linux/ceph/ceph_fs.h    |  21 +-
 include/linux/ceph/osd_client.h |   6 +-
 include/linux/ceph/rados.h      |   4 +
 include/linux/fscrypt.h         |  15 +
 net/ceph/osd_client.c           |   5 +
 26 files changed, 2087 insertions(+), 287 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.33.1

