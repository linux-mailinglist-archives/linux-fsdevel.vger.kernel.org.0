Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2506C3B44EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhFYOA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYOA4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:00:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1056135A;
        Fri, 25 Jun 2021 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629515;
        bh=F1lwLqpvDEkehPKIBaQvRyDNmcvRtgxkBxyITMp/SZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=ojMsr8sJR9gofEBsVO65y5SqV3ssFqcHRLECWv2HHRIvPP7T8C4voeEBGnUP/6heO
         6TgmfCqqiUPrw7SgKzHDJ6yBzzH9H3nnVG9nzgDxLLuqLe45LuwdwAggP+ihrTeB2t
         wmdcpPGcGdMaVAV2/n97akSbWk2L+nqph0hbdm76/wd6CP+VIwVDCDOd9j19Wg4q+G
         l9tD0eTJc0rx/UfvGbcg01IxrF6CwFMHYcwojCqruG3P4SUvp/hDMCd9Grg1CFhZvI
         Kr2myqQPI4FNmWpdGauM43acV8BAAUjPJRNe31eE2Hbz37pGuW7CdxK8iDDEmPwAak
         8D31E0hk1F53Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 00/24] ceph+fscrypt: context, filename and symlink support
Date:   Fri, 25 Jun 2021 09:58:10 -0400
Message-Id: <20210625135834.12934-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is a fairly substantial rework since the last set. Rather
than storing the crypto context in an xattr, this one stores it in a new
field associated with AUTH caps. That ensures that it's always
available whenever an inode is instantiated, and should prevent the
deadlock that Luis reported. This means that we need to do a setattr
request to set the context now, so support for that is also added.

The required MDS patches are currently here:

    https://github.com/ceph/ceph/pull/41284

...but it's marked as draft for now. I don't want to merge this until
the content encryption piece is more clearly defined. These patches are
also available in my git tree under the ceph-fscrypt-fnames-v7 tag:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/

This seems to be reasonably robust in testing. The next step is content
encryption. I have a start on some of those patches, but it's still very
much a WIP.

Jeff Layton (24):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: preallocate inode for ops that may create one
  ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
  ceph: add fscrypt_* handling to caps.c
  ceph: add ability to set fscrypt_auth via setattr
  ceph: crypto context handling for ceph
  ceph: implement -o test_dummy_encryption mount option
  ceph: add routine to create fscrypt context prior to RPC
  ceph: add fscrypt ioctls
  ceph: decode alternate_name in lease info
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: send altname in MClientRequest
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
 fs/ceph/caps.c               |  62 +++++--
 fs/ceph/crypto.c             | 206 +++++++++++++++++++++
 fs/ceph/crypto.h             | 119 ++++++++++++
 fs/ceph/dir.c                | 198 +++++++++++++++-----
 fs/ceph/export.c             |  44 +++--
 fs/ceph/file.c               |  64 ++++---
 fs/ceph/inode.c              | 302 +++++++++++++++++++++++++++---
 fs/ceph/ioctl.c              |  83 +++++++++
 fs/ceph/mds_client.c         | 345 ++++++++++++++++++++++++++++++-----
 fs/ceph/mds_client.h         |  22 ++-
 fs/ceph/super.c              |  80 +++++++-
 fs/ceph/super.h              |  32 +++-
 fs/ceph/xattr.c              |  20 ++
 fs/crypto/fname.c            |  53 ++++--
 fs/crypto/fscrypt_private.h  |   9 +-
 fs/crypto/hooks.c            |   6 +-
 fs/crypto/policy.c           |  34 +++-
 fs/inode.c                   |   1 +
 include/linux/ceph/ceph_fs.h |  21 ++-
 include/linux/fscrypt.h      |  10 +
 22 files changed, 1498 insertions(+), 218 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.31.1

