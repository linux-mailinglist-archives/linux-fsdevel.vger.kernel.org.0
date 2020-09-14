Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC2269552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgINTRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgINTRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:11 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1B0208E4;
        Mon, 14 Sep 2020 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111030;
        bh=ODgC0pauYDlLRX/uoPHe+zarHUVYZig+XStM01WP09Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Qr5iUWnGzP+8huPAjKpPrch8QGC+h/D0m01nbcyb4/bqEp/suObzzg24BY2Jurvj1
         Ns/MVA3nfR2v/spSyNMyVloyO/Z0zepVTxhYUMWVfQXvINp6MXGIHhC/UZhWmsiFQ9
         r/FiBK+mu9XITFq8W/KQ3SWqxJDnRemTmtmsSFLs=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 00/16] ceph+fscrypt: context, filename and symlink support
Date:   Mon, 14 Sep 2020 15:16:51 -0400
Message-Id: <20200914191707.380444-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third posting of the ceph+fscrypt integration work. This
just covers context handling, filename and symlink support.

The main changes since the last set are mainly to address Eric's review
comments. Hopefully this will be much closer to mergeable. Some highlights:

1/ rebase onto Eric's fscrypt-file-creation-v2 tag

2/ fscrypt_context_for_new_inode now takes a void * to hold the context

3/ make fscrypt_fname_disk_to_usr designate whether the returned name
   is a nokey name. This is necessary to close a potential race in
   readdir support

4/ fscrypt_base64_encode/decode remain in fs/crypto (not moved into lib/)

5/ test_dummy_encryption handling is moved into a separate patch, and
   several bugs fixed that resulted in context not being set up
   properly.

6/ symlink handling now works

Content encryption is the next step, but I want to get the fscache
rework done first. It would be nice if we were able to store encrypted
files in the cache, for instance.

This set has been tagged as "ceph-fscrypt-rfc.3" in my tree here:

    https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git

Note that this is still quite preliminary, but my goal is to get a set
merged for v5.11.

Jeff Layton (16):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64_encode and fscrypt_base64_decode
  fscrypt: export fscrypt_d_revalidate
  fscrypt: add fscrypt_context_for_new_inode
  fscrypt: make fscrypt_fname_disk_to_usr return whether result is nokey
    name
  ceph: add fscrypt ioctls
  ceph: crypto context handling for ceph
  ceph: implement -o test_dummy_encryption mount option
  ceph: preallocate inode for ops that may create one
  ceph: add routine to create context prior to RPC
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: add support to readdir for encrypted filenames
  ceph: add fscrypt support to ceph_fill_trace
  ceph: create symlinks with encrypted and base64-encoded targets

 fs/ceph/Makefile        |   1 +
 fs/ceph/crypto.c        | 156 ++++++++++++++++++++++++++++++
 fs/ceph/crypto.h        |  67 +++++++++++++
 fs/ceph/dir.c           | 141 ++++++++++++++++++++-------
 fs/ceph/file.c          |  56 +++++++----
 fs/ceph/inode.c         | 204 ++++++++++++++++++++++++++++++++++------
 fs/ceph/ioctl.c         |  25 +++++
 fs/ceph/mds_client.c    |  94 +++++++++++++-----
 fs/ceph/mds_client.h    |   1 +
 fs/ceph/super.c         |  73 +++++++++++++-
 fs/ceph/super.h         |  18 +++-
 fs/ceph/xattr.c         |  32 +++++++
 fs/crypto/fname.c       |  67 ++++++++++---
 fs/crypto/hooks.c       |   4 +-
 fs/crypto/policy.c      |  35 +++++--
 fs/ext4/dir.c           |   3 +-
 fs/ext4/namei.c         |   6 +-
 fs/f2fs/dir.c           |   3 +-
 fs/inode.c              |   1 +
 fs/ubifs/dir.c          |   4 +-
 include/linux/fscrypt.h |  10 +-
 21 files changed, 860 insertions(+), 141 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.26.2

