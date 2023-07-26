Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90881763892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjGZOMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjGZOLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA33594
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:59 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9269F413C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380635;
        bh=SYeeGp92pdelv4rH6q2bM2VgBXIS4lj+xBV/rEvt80A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=W9B5Hga76dmw6Cwp98Kg+XSmvuxD3pflpP3VjD4ylk85k5eAtNTqF/QyWFWDsZuD1
         47eh+QpR1Fm15HMqxUVd05FKolGgl+A2elFR+bBRHk49ij4ceh89Qz3Y7ddXb63m7r
         9KYmsUFzAbj0pyAP858GwrQUiJTWywtm98VBFI/+gBMnnfO8E82Wpii6pWb0ownMbi
         6E5G8D6pfVAO7vYw9zGn/+ysqZHwT8mA36Cqr/atAdyr4eMgEhzFsXqfQ63prgL3fB
         fz+KhgpyAmUId7ECs6qlSPR1rTnq5K5xvMTeAa2AtJ71qNrmn2hfUn0qe0zWg5W3/6
         NxXXmr2FiSjAA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f3932e595dso6272327e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380635; x=1690985435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYeeGp92pdelv4rH6q2bM2VgBXIS4lj+xBV/rEvt80A=;
        b=gzkqC7WhAHYt5YKV/B2yMu1m+9TvD7c5ChrgEV6b+gMe95RMBDeo3NbD6pymG3hVTS
         GfiGyctmdvhcCYADp8i+YDTtHLvqtgtjFOFpGdkEV/LmACT0RrVLWlPEIRzeiz4XcmH1
         WlpnweDXZEbycU1YhPlQhVmnOiZGHVQcJI8XpsNIiEC9ZrzJjdUrsmjRumxt0M5ohFpg
         lpPOg/q+/lcAXcE7b4zRHkIvUHoSudoo+TQVMtbWId+CZBF0xVpX+ybx65rZAQyF9i+J
         b+0cxrKDfQIT346OyrZfPLe31AnnHcQrbaFRnH4f82gXhGhF/go1H2/3cQ6uPvOfUqBo
         60TA==
X-Gm-Message-State: ABy/qLYJ1m/t3Q4DUxH8bF102XSkEmuBlnvEagpWgqWCFl3wUNWWEDAS
        myG/bnRkjWtvRXzc3Igb+IX3KByocRSO8/EohXBL6mlCyF3hMw4tvf7mkd0xP9gxKDrkAZJU2B5
        HsQVl9I3AZeTbhqrOFlTySAwo/khruZ62aRZpXCc+hJM=
X-Received: by 2002:a19:4f0a:0:b0:4f4:d071:be48 with SMTP id d10-20020a194f0a000000b004f4d071be48mr1767028lfb.14.1690380634931;
        Wed, 26 Jul 2023 07:10:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+pKKz+TQ00BjeGo7fn/RjcpP3sr4jb7LlRAlUm8acPsC/vm4aPjWusq8G96utV9AMXGQLIw==
X-Received: by 2002:a19:4f0a:0:b0:4f4:d071:be48 with SMTP id d10-20020a194f0a000000b004f4d071be48mr1767003lfb.14.1690380634545;
        Wed, 26 Jul 2023 07:10:34 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/11] ceph: support idmapped mounts
Date:   Wed, 26 Jul 2023 16:10:15 +0200
Message-Id: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear friends,

This patchset was originally developed by Christian Brauner but I'll continue
to push it forward. Christian allowed me to do that :)

This feature is already actively used/tested with LXD/LXC project.

Git tree (based on https://github.com/ceph/ceph-client.git testing):
v7: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v7
current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph

In the version 3 I've changed only two commits:
- fs: export mnt_idmap_get/mnt_idmap_put
- ceph: allow idmapped setattr inode op
and added a new one:
- ceph: pass idmap to __ceph_setattr

In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
is filled. It's more safer approach and prevents possible refcounter underflow
on error paths where __register_request wasn't called but ceph_mdsc_release_request is
called.

Changelog for version 5:
- a few commits were squashed into one (as suggested by Xiubo Li)
- started passing an idmapping everywhere (if possible), so a caller
UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)

Changelog for version 6:
- rebased on top of testing branch
- passed an idmapping in a few places (readdir, ceph_netfs_issue_op_inline)

Changelog for version 7:
- rebased on top of testing branch
- this thing now requires a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
https://github.com/ceph/ceph/pull/52575

I can confirm that this version passes xfstests.

Links to previous versions:
v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4
v5: https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
v6: https://lore.kernel.org/lkml/20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v6

Kind regards,
Alex

Original description from Christian:
========================================================================
This patch series enables cephfs to support idmapped mounts, i.e. the
ability to alter ownership information on a per-mount basis.

Container managers such as LXD support sharaing data via cephfs between
the host and unprivileged containers and between unprivileged containers.
They may all use different idmappings. Idmapped mounts can be used to
create mounts with the idmapping used for the container (or a different
one specific to the use-case).

There are in fact more use-cases such as remapping ownership for
mountpoints on the host itself to grant or restrict access to different
users or to make it possible to enforce that programs running as root
will write with a non-zero {g,u}id to disk.

The patch series is simple overall and few changes are needed to cephfs.
There is one cephfs specific issue that I would like to discuss and
solve which I explain in detail in:

[PATCH 02/12] ceph: handle idmapped mounts in create_request_message()

It has to do with how to handle mds serves which have id-based access
restrictions configured. I would ask you to please take a look at the
explanation in the aforementioned patch.

The patch series passes the vfs and idmapped mount testsuite as part of
xfstests. To run it you will need a config like:

[ceph]
export FSTYP=ceph
export TEST_DIR=/mnt/test
export TEST_DEV=10.103.182.10:6789:/
export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password

and then simply call

sudo ./check -g idmapped

========================================================================

Alexander Mikhalitsyn (3):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: handle idmapped mounts in create_request_message()
  ceph: pass idmap to __ceph_setattr

Christian Brauner (8):
  ceph: stash idmapping in mdsc request
  ceph: pass an idmapping to mknod/symlink/mkdir
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  6 +++---
 fs/ceph/crypto.c              |  2 +-
 fs/ceph/dir.c                 |  3 +++
 fs/ceph/file.c                | 10 ++++++++--
 fs/ceph/inode.c               | 29 +++++++++++++++++------------
 fs/ceph/mds_client.c          | 25 +++++++++++++++++++++++++
 fs/ceph/mds_client.h          |  6 +++++-
 fs/ceph/super.c               |  2 +-
 fs/ceph/super.h               |  3 ++-
 fs/mnt_idmapping.c            |  2 ++
 include/linux/ceph/ceph_fs.h  |  4 +++-
 include/linux/mnt_idmapping.h |  3 +++
 12 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.34.1

