Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE035E55E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347368AbhDMRvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhDMRvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D64361244;
        Tue, 13 Apr 2021 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336253;
        bh=DlDT1M7h71Y7EqwYU9oXuhe3iLixwu61+KibTJnRKkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KuTSMgw0joLAycxkw/Yoh7uyQIY1JW1Nqq3tJ0W2YnnG20cfy30uYQFmWlAday8qJ
         w4SicVMPojdPPZiFb6PxaEulgEq1ZBmXEo2ojluUCk2SFU/yGfP34XdVoPI17M3M0O
         zK0xKJ5adczVcYoNqr/mg5eJWcIyocDAN9H4kv5HsWxuTiEKjsbB727FW4LiHDCrZh
         qzNFmkRpHcm6S+qzbYa9CpJI+WoNboYtf4wFHrZIubBKhxBr1uddj3FEk1XbLqmo35
         sOVD/gVNoqyRZanLU6nb/cUVdiHH/Xm+u8F2G0S2WspwHnhih3TqKQ6PTia6ISjyZC
         7ZOkHMSDuZ7qg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 00/20] ceph+fscrypt: context, filename and symlink support
Date:   Tue, 13 Apr 2021 13:50:32 -0400
Message-Id: <20210413175052.163865-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The main change in this posting is in the detection of fscrypted inodes.
The older set would grovel around in the xattr blob to see if it had an
"encryption.ctx" xattr. This was problematic if the MDS didn't send
xattrs in the trace, and not very efficient.

This posting changes it to use the new "fscrypt" flag, which should
always be reported by the MDS (Luis, I'm hoping this may fix the issues
you were seeing with dcache coherency).

This unfortunately requires an MDS fix, but that should hopefully make
it in and be backported to Pacific fairly soon:

    https://github.com/ceph/ceph/pull/40828

We also now handle get_name in the NFS export code correctly.

Aside from that, there are better changelogs, particularly on the
fscrypt and vfs patches, and some smaller bugfixes and optimizations.

Jeff Layton (20):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: crypto context handling for ceph
  ceph: implement -o test_dummy_encryption mount option
  ceph: preallocate inode for ops that may create one
  ceph: add routine to create fscrypt context prior to RPC
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: decode alternate_name in lease info
  ceph: send altname in MClientRequest
  ceph: properly set DCACHE_NOKEY_NAME flag in lookup
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: add helpers for converting names for userland presentation
  ceph: add fscrypt support to ceph_fill_trace
  ceph: add support to readdir for encrypted filenames
  ceph: create symlinks with encrypted and base64-encoded targets
  ceph: make ceph_get_name decrypt filenames
  ceph: add fscrypt ioctls

 fs/ceph/Makefile            |   1 +
 fs/ceph/crypto.c            | 185 ++++++++++++++++++++++
 fs/ceph/crypto.h            | 101 ++++++++++++
 fs/ceph/dir.c               | 178 ++++++++++++++++-----
 fs/ceph/export.c            |  42 +++--
 fs/ceph/file.c              |  58 ++++---
 fs/ceph/inode.c             | 248 ++++++++++++++++++++++++++---
 fs/ceph/ioctl.c             |  93 +++++++++++
 fs/ceph/mds_client.c        | 303 ++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h        |  15 +-
 fs/ceph/super.c             |  80 +++++++++-
 fs/ceph/super.h             |  15 +-
 fs/ceph/xattr.c             |   5 +
 fs/crypto/fname.c           |  53 +++++--
 fs/crypto/fscrypt_private.h |   9 +-
 fs/crypto/hooks.c           |   6 +-
 fs/crypto/policy.c          |  34 +++-
 fs/inode.c                  |   1 +
 include/linux/fscrypt.h     |  10 ++
 19 files changed, 1263 insertions(+), 174 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.30.2

