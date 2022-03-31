Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB544EDCEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiCaPdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiCaPdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04E21C70F;
        Thu, 31 Mar 2022 08:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 234E0B82011;
        Thu, 31 Mar 2022 15:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F15C3410F;
        Thu, 31 Mar 2022 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740692;
        bh=3Xwf5ItUvh/SkebCX/UU0LVYzbnhxproJEbfBlhxng0=;
        h=From:To:Cc:Subject:Date:From;
        b=NZkXE6cq5CKLKDNI851WEV0f4OVl46oC0yo/zngDQTm/QeoB6t+EpnDcNz70D5AHc
         WiIq5vh7pYADyA6DfN3BbhhURFVkUj68h6S1gZtGoQfjiMYE6rdO3RksIHtdzU8qUu
         MNBTTfU7RWEEJKjaCdOw73zDRhKJaNdVOcV1yBjgi/J+LUuut+q0c0HJHgK0mOmovc
         bk1CkPQk3lqq/47AwQlIv6O0CawznmBcpdSRe2ib0Jf2ZT58ukNlVifql3bwzGUots
         ULGK96R7iaxZFfwsLf+Ldaa4b7/PyIjnl/zbEkrbNn4NoLsXIVuPbdi5aI0nZGrzQ+
         jTejr8LK9IBMw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/54] ceph+fscrypt: fully-working prototype
Date:   Thu, 31 Mar 2022 11:30:36 -0400
Message-Id: <20220331153130.41287-1-jlayton@kernel.org>
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

This patchset represents a fully-working prototype of fscrypt
integration into cephfs. The main difference from the series I posted
last week is a pile of bugfixes. At this point most of the xfstests that
pass without -o test_dummy_encryption work with it as well, and most of
the "encrypt" group also passes.

The main reason I'm calling this a prototype is because this doesn't yet
support proper integration with fscache. For that, the plan is to
migrate more of the ceph I/O paths to use netfs helpers, and to plumb
the necessary support for fscrypt integration into there.

We could either wait for that support before merging this, or go ahead
and take what we have now and adapt to the netfs helpers later. I'm open
to suggestions here.

Note that this series relies on the sparse read support for the client
that is currently sitting in the "testing" branch in the ceph-client
tree [1].  At this point I'm planning to push this series into the
testing branch as well, so we start getting some testing coverage in
teuthology.

Currently, if you wish to test fscrypt functionality, you will need ceph
built from branch that tracks the master branch. I'm hoping to get one
last required OSD fix in for Quincy, but it may not make GA [2].

Finally, special thanks to Luis and Xiubo, for all of their help with
this, and to Eric Biggers for advice and review. David Howells has also
been instrumental with the netfs work.

We might actually finish this!

[1] https://github.com/ceph/ceph-client
[2] https://github.com/ceph/ceph/pull/45736

Jeff Layton (43):
  vfs: export new_inode_pseudo
  fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
  fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
  fscrypt: add fscrypt_context_for_new_inode
  ceph: preallocate inode for ops that may create one
  ceph: crypto context handling for ceph
  ceph: add a has_stable_inodes operation for ceph
  ceph: ensure that we accept a new context from MDS for new inodes
  ceph: add support for fscrypt_auth/fscrypt_file to cap messages
  ceph: add ability to set fscrypt_auth via setattr
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

Luís Henriques (1):
  ceph: support legacy v1 encryption policy keysetup

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
 fs/ceph/addr.c                  | 128 ++++++--
 fs/ceph/caps.c                  | 216 +++++++++++--
 fs/ceph/crypto.c                | 449 ++++++++++++++++++++++++++
 fs/ceph/crypto.h                | 256 +++++++++++++++
 fs/ceph/dir.c                   | 182 ++++++++---
 fs/ceph/export.c                |  44 ++-
 fs/ceph/file.c                  | 536 ++++++++++++++++++++++++++-----
 fs/ceph/inode.c                 | 547 +++++++++++++++++++++++++++++---
 fs/ceph/ioctl.c                 | 126 +++++++-
 fs/ceph/mds_client.c            | 465 +++++++++++++++++++++++----
 fs/ceph/mds_client.h            |  24 +-
 fs/ceph/super.c                 |  91 +++++-
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
 26 files changed, 2944 insertions(+), 365 deletions(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

-- 
2.35.1

