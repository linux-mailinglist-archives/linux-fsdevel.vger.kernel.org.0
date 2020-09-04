Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717C25DF5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgIDQFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgIDQFm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:42 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951282074D;
        Fri,  4 Sep 2020 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235541;
        bh=6KszTCYTryzCZ4YNK73zckrQJTBvMnGBEebLXoJ1vZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=m81eW4FHYAREaHjv4JHfVRnaw6xmPPfIC03H2kUReq4sdKya8JRkg44Xgeii3kbKd
         RU6COwZvdA+gTshOUcQjRLwjqBF62Huy459ojjHXnCb/ohSlDNk6AaLXuQmflCYLWy
         ZLNQfkidNlHjPyTe55YMc/Aciz5ON6cvZBNS+WEs=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 00/18] ceph+fscrypt: context, filename and symlink support
Date:   Fri,  4 Sep 2020 12:05:19 -0400
Message-Id: <20200904160537.76663-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a second posting of the ceph+fscrypt integration work that I've
been experimenting with. The main change with this patch is that I've
based this on top of Eric's fscrypt-pending set. That necessitated a
change to allocate inodes much earlier than we have traditionally, prior
to sending an RPC instead of waiting on the reply.

Note that this just covers the crypto contexts and filenames. I've also
added a patch to encrypt symlink contents as well, but it doesn't seem to
be working correctly.

The file contents work is next, but I'm sort of waiting until some work
to the fscache infrastructure is settled. It would be nice if fscache
also stored encrypted file contents when we plumb this in.

Jeff Layton (18):
  vfs: export new_inode_pseudo
  fscrypt: drop unused inode argument from fscrypt_fname_alloc_buffer
  fscrypt: export fscrypt_d_revalidate
  fscrypt: add fscrypt_new_context_from_inode
  fscrypt: don't balk when inode is already marked encrypted
  fscrypt: move nokey_name conversion to separate function and export it
  lib: lift fscrypt base64 conversion into lib/
  ceph: add fscrypt ioctls
  ceph: crypto context handling for ceph
  ceph: preallocate inode for ops that may create one
  ceph: add routine to create context prior to RPC
  ceph: set S_ENCRYPTED bit if new inode has encryption.ctx xattr
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: add support to readdir for encrypted filenames
  ceph: add fscrypt support to ceph_fill_trace
  ceph: create symlinks with encrypted and base64-encoded targets

 fs/ceph/Makefile             |   1 +
 fs/ceph/crypto.c             | 179 +++++++++++++++++++++++++++++
 fs/ceph/crypto.h             |  83 ++++++++++++++
 fs/ceph/dir.c                | 162 ++++++++++++++++++++------
 fs/ceph/file.c               |  56 +++++----
 fs/ceph/inode.c              | 213 ++++++++++++++++++++++++++++++-----
 fs/ceph/ioctl.c              |  25 ++++
 fs/ceph/mds_client.c         |  75 ++++++++----
 fs/ceph/mds_client.h         |   1 +
 fs/ceph/super.c              |  37 ++++++
 fs/ceph/super.h              |  19 +++-
 fs/ceph/xattr.c              |  32 ++++++
 fs/crypto/Kconfig            |   1 +
 fs/crypto/fname.c            | 139 ++++++++---------------
 fs/crypto/hooks.c            |   2 +-
 fs/crypto/keysetup.c         |   2 +-
 fs/crypto/policy.c           |  20 ++++
 fs/ext4/dir.c                |   2 +-
 fs/ext4/namei.c              |   7 +-
 fs/f2fs/dir.c                |   2 +-
 fs/inode.c                   |   1 +
 fs/ubifs/dir.c               |   2 +-
 include/linux/base64_fname.h |  11 ++
 include/linux/fscrypt.h      |  10 +-
 lib/Kconfig                  |   3 +
 lib/Makefile                 |   1 +
 lib/base64_fname.c           |  71 ++++++++++++
 27 files changed, 943 insertions(+), 214 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h
 create mode 100644 include/linux/base64_fname.h
 create mode 100644 lib/base64_fname.c

-- 
2.26.2

