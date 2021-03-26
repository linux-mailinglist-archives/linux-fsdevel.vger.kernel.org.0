Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691134AD6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 18:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCZRcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 13:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCZRce (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E74D61999;
        Fri, 26 Mar 2021 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616779949;
        bh=Hzcg4uW865GDKCUyP1KJdGg/QHNyOV4bvwCKbPtkEUE=;
        h=From:To:Cc:Subject:Date:From;
        b=enyDiw9P0EKC6hY6H3B80L6Bx3N3JnDClFzYOh57TbBRxB5CJyCHPQsfo6p24rQoL
         Defczp9XyxTSdvq3DfOYB141tSn+uaYm2wHbFnH4ZSsgpeh0aVrK3/h7bSF0ZAx5RH
         7pEP7jNCjZL09Nx2IE+SdL9t2zmR+KKbP9YPlraveoeqFWIsFqE0TGv3q3jn5FT9DI
         qBIa68/EnnnQoD8oTHUkMdn7/GTGZP998fI3cgJVkLzmDCYBkwpgnnDxdB7e/ZCzF9
         bNJNEq8jPCA2k0qKE1VMdq6p3wkj0i+buSfkCVvYfB62CKZCOSI3fw44E6vqqdxHLX
         v/aa3yLc/+lIw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v5 00/19] ceph+fscrypt: context, filename and symlink support
Date:   Fri, 26 Mar 2021 13:32:08 -0400
Message-Id: <20210326173227.96363-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I haven't posted this in a while and there were some bugs shaken out of
the last posting. This adds (partial) support for fscrypt to kcephfs,
including crypto contexts, filenames and encrypted symlink targets. At
this point, the xfstests quick tests that generally pass without fscrypt
also pass with test_dummy_encryption enabled.

There is one lingering bug that I'm having trouble tracking down: xfstest
generic/477 (an open_by_handle_at test) sometimes throws a "Busy inodes
after umount" warning. I'm narrowed down the issue a bit, but there is
some raciness involved so I haven't quite nailed it down yet.

This set is quite invasive. There is probably some further work to be
done to add common code helpers and the like, but the final diffstat
probably won't look too different.

This set does not include encryption of file contents. That is turning
out to be a bit trickier than first expected owing to the fact that the
MDS is usually what handles truncation, and the i_size no longer
represents the amount of data stored in the backing store. That will
probably require an MDS change to fix, and we're still sorting out the
details.

Jeff Layton (19):
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
  ceph: add fscrypt ioctls

 fs/ceph/Makefile            |   1 +
 fs/ceph/crypto.c            | 185 +++++++++++++++++++++++
 fs/ceph/crypto.h            | 101 +++++++++++++
 fs/ceph/dir.c               | 178 ++++++++++++++++++-----
 fs/ceph/file.c              |  56 ++++---
 fs/ceph/inode.c             | 255 +++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c             |  94 ++++++++++++
 fs/ceph/mds_client.c        | 283 ++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/super.c             |  80 +++++++++-
 fs/ceph/super.h             |  16 +-
 fs/ceph/xattr.c             |  32 ++++
 fs/crypto/fname.c           |  53 +++++--
 fs/crypto/fscrypt_private.h |   9 +-
 fs/crypto/hooks.c           |   6 +-
 fs/crypto/policy.c          |  34 ++++-
 fs/inode.c                  |   1 +
 include/linux/fscrypt.h     |  10 ++
 18 files changed, 1246 insertions(+), 162 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.30.2

