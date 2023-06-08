Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E37283E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjFHPnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbjFHPnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529CE26B2
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 216E63F460
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686238994;
        bh=syV5HaxadzVX4WovEx170zRO/U/ZlS3A/61NcNcDyQ0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Kb9HRnCMm9OzLBty63fS4+/fAvSXoxuj/Vw6KV5aTzKv4AwMc4PeY6+cpn8BxCQmr
         m2nh2DldvUzUOCrOZvxz7zgdoTzm0b/AGwToUoVNiJtdiUx+z0LKgDK24xzgr8vCL0
         3hseQyjpacCQM9EHjym1njxZiDRAKmf4Zj/lovIUASJ25vb+A7xrJsQsdX0flYBUlv
         QF4lTAW32No06ximId8m8k7DE20HnmwG7tbQ9ZfBQ9Bx+xcITy6+72cj9D8pc8jzPn
         FOTYIS+lbFQaxqz0GZMkrJQZyPiJohSF69NWPzJebatLzqPr6EjeN07GiUNq2vQOFw
         4ydWdCWQpMaag==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-514abe67064so778436a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238993; x=1688830993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syV5HaxadzVX4WovEx170zRO/U/ZlS3A/61NcNcDyQ0=;
        b=UiEIJWIJOO9rlJ6HyJTC0vc+4wMML6fEMtdSqrpySgG7ldqGJn70p/Nu34WZimhScu
         iIn/NsermlaHKdoMU+eTAOFLz6yacMAfE52MrzMmJK9knKnJpTj+3+1wXNtDROmJLNoh
         0Ot0BEnUp0qiNSMiSu2wlvFiR5ytLzbl/kySLmg4q4gmMGOoIEkuEEoH/Z+2DwTgIj+9
         WXdPlfOFduB6fiduOdfo9ckK+gxYndZqrU6MA0r9G8xwoi5K2EfgWVSYRQkVLQE2DVma
         rX8vav2sWdX/W0zmRF9B9tn9WJ/WbOeDDHl5hud7xVenna2/0XTpFVHjDey0mCNRNY/P
         dvHg==
X-Gm-Message-State: AC+VfDyID5844JC2WiPsdQNMY5v2B/VvrV13RP6OK1qt+HPigydMVetL
        5HYhfZ8FYGPwdDNEgxsFpvMH5xf83szb7T/i260kQkVwP3taX8DjKO0TzH7EkmvERF05QkaTeGZ
        7rK93LgY/3jUe5tqbuVJgxRys47JgCExIaZaAuSOKDj8=
X-Received: by 2002:aa7:cfc8:0:b0:514:b1d6:d37f with SMTP id r8-20020aa7cfc8000000b00514b1d6d37fmr7721997edy.19.1686238993343;
        Thu, 08 Jun 2023 08:43:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lGm9L8z4YDDL2kvecwJoQh9lLjIraoOWEV4/1L2E1amdrCtmpK/U5m366rjL5caORy4NspA==
X-Received: by 2002:aa7:cfc8:0:b0:514:b1d6:d37f with SMTP id r8-20020aa7cfc8000000b00514b1d6d37fmr7721982edy.19.1686238993055;
        Thu, 08 Jun 2023 08:43:13 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/14] ceph: support idmapped mounts
Date:   Thu,  8 Jun 2023 17:42:41 +0200
Message-Id: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear friends,

This patchset was originally developed by Christian Brauner but I'll continue
to push it forward. Christian allowed me to do that :)

This feature is already actively used/tested with LXD/LXC project.

Git tree (based on https://github.com/ceph/ceph-client.git master):
v5: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
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

I can confirm that this version passes xfstests.

Links to previous versions:
v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4

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

Alexander Mikhalitsyn (5):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: pass idmap to __ceph_setattr
  ceph: pass idmap to ceph_do_getattr
  ceph: pass idmap to __ceph_setxattr
  ceph: pass idmap to ceph_open/ioctl_set_layout

Christian Brauner (9):
  ceph: stash idmapping in mdsc request
  ceph: handle idmapped mounts in create_request_message()
  ceph: pass an idmapping to mknod/symlink/mkdir/rename
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  8 ++++----
 fs/ceph/addr.c                |  3 ++-
 fs/ceph/caps.c                |  3 ++-
 fs/ceph/dir.c                 |  4 ++++
 fs/ceph/export.c              |  2 +-
 fs/ceph/file.c                | 21 ++++++++++++++-----
 fs/ceph/inode.c               | 38 +++++++++++++++++++++--------------
 fs/ceph/ioctl.c               |  9 +++++++--
 fs/ceph/mds_client.c          | 27 +++++++++++++++++++++----
 fs/ceph/mds_client.h          |  1 +
 fs/ceph/quota.c               |  2 +-
 fs/ceph/super.c               |  6 +++---
 fs/ceph/super.h               | 14 ++++++++-----
 fs/ceph/xattr.c               | 18 +++++++++--------
 fs/mnt_idmapping.c            |  2 ++
 include/linux/mnt_idmapping.h |  3 +++
 16 files changed, 111 insertions(+), 50 deletions(-)

-- 
2.34.1

