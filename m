Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FEC2FD85C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404627AbhATSeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404397AbhATS3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01941233FA;
        Wed, 20 Jan 2021 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167329;
        bh=K1YSDxxRPudAo9NFhh4HuZune1Ns0JF8rsnF25PcQdA=;
        h=From:To:Cc:Subject:Date:From;
        b=pRYgvSwNPhbioE9TkpTCb1CkKWRFF2PM4wJfxfy+7b6FwaiTHLdmNrljPEeLlzxFB
         18cD3F0d14TVBr6ewsLPgr8hagJGiK262Zlz2zZO2OgcJPJYrye7RKJZiRCRLJqUyZ
         q8ZDsj88So88w+2LLyua9+pEypHse/xu1J2hwT6dGK1SHwZmbkaEVH1oyc+EwZIsHF
         /QBQWZTdg3cE7OmBULiZ7XlOAn8vAMEvpNzkIldGf250J69scWTnCQK6/GBcNT+IDA
         eHmS/JnMD+KwYNb9XOejRnJM2DjnP+i6QwFFv4g/K5c1aQCI8gsfGtm/Di/180o1By
         pW09sM2fahphA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 00/17] ceph+fscrypt: context, filename and symlink support
Date:   Wed, 20 Jan 2021 13:28:30 -0500
Message-Id: <20210120182847.644850-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's been a while (September!) since my last posting of this series.
Main notable changes since then:

- adapt to latest version of fscrypt API in mainline
- take advantage of alternate_name feature in MDS to handle long names
- gate ioctls on MDS support
- many bugfixes

The set starts by exporting new_inode_pseudo and a few fscrypt
functions.  Hopefully those aren't too controversial, but please let me
know if they are. From there, it adds support for crypto contexts in an
xattr, and then filenames and symlinks.

The alternate name is just an extra field that gets stored in the dentry
on the MDS on creation and transmitted to clients as part of the dentry
lease. For fscrypt, we're using it to store the full binary crypttext
name when it's too long to store without hashing the last characters in
the name. This allows us to handle long filenames properly, while still
making the underlying filesystem accessible to clients that don't
support fscrypt.

Note that we use our own encoding scheme for "nokey names" that is
similar to the usual fscrypt one but lacks the dirhash fields (which we
don't use). We don't want to enshrine the fscrypt_nokey_name format onto
stable storage, and this scheme allows us to avoid that, and preserve
compatibility with legacy clients that don't support fscrypt.

For now, this is still a RFC. This all works pretty well so far, but
I don't want to merge any of it until we can handle encrypting the file
contents as well. I'll (hopefully!) be working toward that end in the
near future.

Jeff Layton (17):
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
  ceph: add support to readdir for encrypted filenames
  ceph: add fscrypt support to ceph_fill_trace
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: create symlinks with encrypted and base64-encoded targets
  ceph: add fscrypt ioctls

 fs/ceph/Makefile            |   1 +
 fs/ceph/crypto.c            | 185 ++++++++++++++++++++++++
 fs/ceph/crypto.h            | 101 +++++++++++++
 fs/ceph/dir.c               | 161 ++++++++++++++++-----
 fs/ceph/file.c              |  56 +++++---
 fs/ceph/inode.c             | 246 +++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c             |  61 ++++++++
 fs/ceph/mds_client.c        | 275 ++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/super.c             |  80 ++++++++++-
 fs/ceph/super.h             |  16 ++-
 fs/ceph/xattr.c             |  32 +++++
 fs/crypto/fname.c           |  53 +++++--
 fs/crypto/fscrypt_private.h |   9 +-
 fs/crypto/hooks.c           |   6 +-
 fs/crypto/policy.c          |  34 ++++-
 fs/inode.c                  |   1 +
 include/linux/fscrypt.h     |  10 ++
 18 files changed, 1181 insertions(+), 160 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.29.2

