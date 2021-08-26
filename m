Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2C3F8BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhHZQVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243060AbhHZQVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C9B610A6;
        Thu, 26 Aug 2021 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994816;
        bh=9TMoeajy1RbxXoqRpxkEA8HrWNAbaAsewikQ1du4G9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=DW8s57imt0rSsLG4HJe5e0FNWtm8Ikf8pD7ebKSfZt4nQAz9u+U6SCPqDmIlDhO8L
         xXrDKRMjORC1BStWlti2HiYaSkIXHfAjV56ZIrE+nWG3RqntxvoJ7G8insKMehAsjc
         clT3xCL1wNgv4Eg1Gq7G6YV8/btMaBjiF5pJ6TsHkhEvhS/FPQJ+vCTvPApYg9kzG8
         sjiSqziUBmF3xstNdxRAu2p4KH/9fkAR7/wEv7JUT0eiUA6vHq9Se1M/dYmdHFpy6k
         X8gYvXwpRFhHsbYnQe+aTR8+AaFc+vrpqX8AkxBSSZJlfK3HwWIvHfPIAcKZvTGJLO
         +zcq3d3IvGBOQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 00/24] ceph+fscrypt: context, filename and symlink support
Date:   Thu, 26 Aug 2021 12:19:50 -0400
Message-Id: <20210826162014.73464-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v8: bugfixes, comment cleanups, etc.

It's been a little while since my last posting of this series. Not a lot
has changed in this series since then. This is mostly addressing review
comments on the v7 posting. Many thanks to Eric, Xiubo and Luis for
helping review the last set.

There are a few smaller bugfixes, some comment fixes, and a new helper
to determine the length of a ceph_fscrypt_auth field was added.

This support requires changes to the MDS that are currently being
tracked here:

    https://github.com/ceph/ceph/pull/41284

This patchset also requires a patch that's not yet in tree from Eric
Biggers:

    [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url

Hopefully, that will go into v5.15.

Work continues on the content piece, but I don't think we want to merge
any of this until we have a fully-working prototype. I'm planning to
send a ceph+fscrypt state of the union email in a bit that covers the
state of the larger project.

Stay tuned...

Jeff Layton (24):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: preallocate inode for ops that may create one
  ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
  ceph: add fscrypt_* handling to caps.c
  ceph: crypto context handling for ceph
  ceph: add ability to set fscrypt_auth via setattr
  ceph: implement -o test_dummy_encryption mount option
  ceph: add fscrypt ioctls
  ceph: decode alternate_name in lease info
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

 fs/ceph/Makefile             |   1 +
 fs/ceph/acl.c                |   4 +-
 fs/ceph/caps.c               |  93 ++++++++--
 fs/ceph/crypto.c             | 254 ++++++++++++++++++++++++++
 fs/ceph/crypto.h             | 129 +++++++++++++
 fs/ceph/dir.c                | 198 +++++++++++++++-----
 fs/ceph/export.c             |  44 +++--
 fs/ceph/file.c               |  64 ++++---
 fs/ceph/inode.c              | 304 ++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c              |  83 +++++++++
 fs/ceph/mds_client.c         | 342 +++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h         |  22 ++-
 fs/ceph/super.c              |  82 ++++++++-
 fs/ceph/super.h              |  31 +++-
 fs/ceph/xattr.c              |  25 +++
 fs/crypto/fname.c            |  40 +++-
 fs/crypto/fscrypt_private.h  |   9 +-
 fs/crypto/hooks.c            |   6 +-
 fs/crypto/policy.c           |  34 +++-
 fs/inode.c                   |   1 +
 include/linux/ceph/ceph_fs.h |  21 ++-
 include/linux/fscrypt.h      |  10 +
 22 files changed, 1572 insertions(+), 225 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.31.1

