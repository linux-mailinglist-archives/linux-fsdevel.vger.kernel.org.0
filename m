Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780AF4F4D35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581737AbiDEXkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573548AbiDETWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129038196;
        Tue,  5 Apr 2022 12:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A6E60A5F;
        Tue,  5 Apr 2022 19:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB7DC385A1;
        Tue,  5 Apr 2022 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186432;
        bh=xEtHWYraQLVXM7siAXtFsrglffaWtvmMBMXrNh2FoQY=;
        h=From:To:Cc:Subject:Date:From;
        b=rgKQEBjeDncRHFY/vDHbldz2KGt0rBlpyj6pNF2qiLHGZkPASBPeR8q2SFG8KAxBG
         B7m77S876tMl0cUzTpwFPYVlLqgQuEoWNGigQKBcUDjmsh2oHg1uEVHblUlkcmRKm3
         ujah+AhUIFTbL8CFp+XHP1dK9i3J183hWTKtO4SPvTTzbuOtv4Qk3WuMtdpcPIZwNt
         fH+YDhmEdW7RYOoGERcnkAI90CrUD+kMOR3O9nZKI7sEWKxUnOIhTkbiySdg8fpD99
         0rlnse6YvVVXl/MmM2EvivB20Lng/MycRrwtYFdweYMtarAV/r0DjkLOjFD4mQDVAo
         xibfj61hOTn7A==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 00/59] ceph+fscrypt: full support
Date:   Tue,  5 Apr 2022 15:19:31 -0400
Message-Id: <20220405192030.178326-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yet another ceph+fscrypt posting! This time, I've included the revised
sparse read support patches as they have gotten some small revisions and
the main impetus for them is fscrypt anyway.

The main changes since v12:

- rebased onto v5.18-rc1 and fixed up minor merge conflicts
:w

- some minor cleanups and simplifications to the sparse_read
  infrastructure

- dropped a patch from Luis that added a legacy v1 key prefix. He's
  pursuing a more appropriate userland fix for xfstests instead

- the patch to add has_stable_inodes operation to ceph has been dropped.
  That operation is only applicable for special storage hardware, so it
  has no purpose on ceph.

- the patch to export new_inode_pseudo has been replaced with one that
  changes the I_CREATING test in inode_insert5. This allows us to use
  new_inode instead.

For now, I've dropped these from the ceph-client/testing branch, but
I'll plan to merge them again in a couple of weeks once we rebase
ceph-client/master onto a v5.18-rc release (usually around -rc2 or
-rc3).

Jeff Layton (49):
  libceph: add spinlock around osd->o_requests
  libceph: define struct ceph_sparse_extent and add some helpers
  libceph: add sparse read support to msgr2 crc state machine
  libceph: add sparse read support to OSD client
  libceph: support sparse reads on msgr2 secure codepath
  libceph: add sparse read support to msgr1
  ceph: add new mount option to enable sparse reads
  fs: change test in inode_insert5 for adding to the sb list
  fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: preallocate inode for ops that may create one
  ceph: fscrypt_auth handling for ceph
  ceph: ensure that we accept a new context from MDS for new inodes
  ceph: add support for fscrypt_auth/fscrypt_file to cap messages
  ceph: implement -o test_dummy_encryption mount option
  ceph: decode alternate_name in lease info
  ceph: add fscrypt ioctls
  ceph: make ceph_msdc_build_path use ref-walk
  ceph: add encrypted fname handling to ceph_mdsc_build_path
  ceph: send altname in MClientRequest
  ceph: encode encrypted name in dentry release
  ceph: properly set DCACHE_NOKEY_NAME flag in lookup
  ceph: set DCACHE_NOKEY_NAME in atomic open
  ceph: make d_revalidate call fscrypt revalidator for encrypted
    dentries
  ceph: add helpers for converting names for userland presentation
  ceph: add fscrypt support to ceph_fill_trace
  ceph: create symlinks with encrypted and base64-encoded targets
  ceph: make ceph_get_name decrypt filenames
  ceph: add a new ceph.fscrypt.auth vxattr
  ceph: add some fscrypt guardrails
  libceph: add CEPH_OSD_OP_ASSERT_VER support
  ceph: size handling for encrypted inodes in cap updates
  ceph: fscrypt_file field handling in MClientRequest messages
  ceph: get file size from fscrypt_file when present in inode traces
  ceph: handle fscrypt fields in cap messages from MDS
  ceph: update WARN_ON message to pr_warn
  ceph: add infrastructure for file encryption and decryption
  libceph: allow ceph_osdc_new_request to accept a multi-op read
  ceph: disable fallocate for encrypted inodes
  ceph: disable copy offload on encrypted inodes
  ceph: don't use special DIO path for encrypted inodes
  ceph: align data in pages in ceph_sync_write
  ceph: add read/modify/write to ceph_sync_write
  ceph: plumb in decryption during sync reads
  ceph: add fscrypt decryption support to ceph_netfs_issue_op
  ceph: set i_blkbits to crypto block size for encrypted inodes
  ceph: add encryption support to writepage
  ceph: fscrypt support for writepages

Luis Henriques (1):
  ceph: don't allow changing layout on encrypted files/directories

Xiubo Li (9):
  ceph: make the ioctl cmd more readable in debug log
  ceph: fix base64 encoded name's length check in ceph_fname_to_usr()
  ceph: pass the request to parse_reply_info_readdir()
  ceph: add ceph_encode_encrypted_dname() helper
  ceph: add support to readdir for encrypted filenames
  ceph: add __ceph_get_caps helper support
  ceph: add __ceph_sync_read helper support
  ceph: add object version support for sync read
  ceph: add truncate size handling support for fscrypt

 fs/ceph/Makefile                |   1 +
 fs/ceph/acl.c                   |   4 +-
 fs/ceph/addr.c                  | 136 ++++++--
 fs/ceph/caps.c                  | 219 ++++++++++--
 fs/ceph/crypto.c                | 442 ++++++++++++++++++++++++
 fs/ceph/crypto.h                | 256 ++++++++++++++
 fs/ceph/dir.c                   | 182 +++++++---
 fs/ceph/export.c                |  44 ++-
 fs/ceph/file.c                  | 579 +++++++++++++++++++++++++++-----
 fs/ceph/inode.c                 | 546 +++++++++++++++++++++++++++---
 fs/ceph/ioctl.c                 | 126 ++++++-
 fs/ceph/mds_client.c            | 465 +++++++++++++++++++++----
 fs/ceph/mds_client.h            |  24 +-
 fs/ceph/super.c                 | 107 +++++-
 fs/ceph/super.h                 |  43 ++-
 fs/ceph/xattr.c                 |  29 ++
 fs/crypto/fname.c               |  44 ++-
 fs/crypto/fscrypt_private.h     |   9 +-
 fs/crypto/hooks.c               |   6 +-
 fs/crypto/policy.c              |  35 +-
 fs/inode.c                      |  11 +-
 include/linux/ceph/ceph_fs.h    |  21 +-
 include/linux/ceph/messenger.h  |  32 ++
 include/linux/ceph/osd_client.h |  89 ++++-
 include/linux/ceph/rados.h      |   4 +
 include/linux/fscrypt.h         |  10 +
 net/ceph/messenger.c            |   1 +
 net/ceph/messenger_v1.c         |  98 +++++-
 net/ceph/messenger_v2.c         | 287 ++++++++++++++--
 net/ceph/osd_client.c           | 306 ++++++++++++++++-
 30 files changed, 3753 insertions(+), 403 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.35.1

