Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1172957B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjFIJhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbjFIJhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:37:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4935B6
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:32:35 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58B623F364
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303106;
        bh=vrSLXZHEwLe9YpY7S+iEIultOMj9M2+aSnalHWlUNN0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kafag6kYhAkHmjB1A60bd6wDVoAsL6GT4wdEDXkql+kYFcEk2Ah2J7MSgfRgmSLic
         0OtFwOj5L8a4me1LpZSKcSGPfJGthC3b/g8ueK2z6Mv2ImwyVFpCW/ZVHgFKFz4ayC
         tsQX0L9SUf6nptpWSALF9aGcmHhDilQBC1typGPLOgVeZXZdz+qfNcfZxaSrUzrh1p
         IGaBgRj63mcti8ZtUJzn8+g7sViywL1/oe8rMugw6kYDEO/BHV5NWSECFAIk2qziyj
         gDM54Z8pOivAt2bLMwKytjQ3syQvMLqiTBLQQbT5IbbdeECJRhjV7DlSXRtzvOImVg
         4EK9m/xLg0+xA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9715654aba1so195443866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303106; x=1688895106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrSLXZHEwLe9YpY7S+iEIultOMj9M2+aSnalHWlUNN0=;
        b=jtjL67LpnB0xehVSR1aB9fay1TsHHzIQJq7hJNGKzDSoJasvj61p2KMeaDj5CX/2B3
         gxmexNRo5so3vAI8jFe7A1a0HoaAz/en7XgvHqaKgoUA8TGen11YBmDKAMsDMatUNBbH
         +CsvDhU6J2KPMX3Xk/LnhD+Wh28/coDkJx9/NOQH7pCybyzOoS/wcr9ctj8q5hQt5k8+
         neV1kl6+oHzjEUX2q2vhM3ZXqMrWAdCQmkNsQUjBrCXH2jCa+C0cWXhAwFUOBh2vFri9
         RknNljZ1qQ7ZY+k0O/gXfbV7gG7PiXFTCXBRyF+1ed/XSIpiayBllA/bojuERJe7OyA1
         QDBw==
X-Gm-Message-State: AC+VfDzsQiwbxfFkOxLASrvVXaeMud6wda2AwFF9m4+132XIFvVqYFMR
        o4Dzv9Z4TV7hmwKbSnXfu5oBF0KM8pma9/6/pApbAQGtYJrZk4fUpcHWIPc+jzHT1Ykb9hVvgkR
        1SEZTCKRvjGEq/QMPHzACjgaig2AKHdqG1Sq0tB6FJYs=
X-Received: by 2002:a17:907:25ca:b0:971:55e2:82c3 with SMTP id ae10-20020a17090725ca00b0097155e282c3mr917684ejc.20.1686303105815;
        Fri, 09 Jun 2023 02:31:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43qi0W9hVzVAvr6xyE448+AS/h1aB2iMqoukZApWferDsKxZuiGsPUZiPWaLQD97Hf8vzEkg==
X-Received: by 2002:a17:907:25ca:b0:971:55e2:82c3 with SMTP id ae10-20020a17090725ca00b0097155e282c3mr917677ejc.20.1686303105504;
        Fri, 09 Jun 2023 02:31:45 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:31:44 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/15] ceph: support idmapped mounts
Date:   Fri,  9 Jun 2023 11:31:10 +0200
Message-Id: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v6: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v6
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

Note. There is a known issue that idmapped mounts are not fully compatible with
MDS (server side) UID/GID-based path restriction, and full support of this requires
massive VFS changes or Cephfs protocol change. Anyway, we've tested the first version
of this patchset for more that a year with the container workloads and it works perfecly
well and it seems that even with this limitation it worth adding support of idmapped mounts.

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

Alexander Mikhalitsyn (6):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: pass idmap to __ceph_setattr
  ceph: pass idmap to ceph_do_getattr
  ceph: pass idmap to __ceph_setxattr
  ceph: pass idmap to ceph_open/ioctl_set_layout/readdir
  ceph: pass idmap to ceph_netfs_issue_op_inline

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

 fs/ceph/acl.c                 |  8 +++----
 fs/ceph/addr.c                | 15 +++++++++++-
 fs/ceph/caps.c                | 10 ++++----
 fs/ceph/crypto.c              |  2 +-
 fs/ceph/dir.c                 |  6 +++++
 fs/ceph/export.c              |  2 +-
 fs/ceph/file.c                | 28 ++++++++++++++++------
 fs/ceph/inode.c               | 45 +++++++++++++++++++++--------------
 fs/ceph/ioctl.c               |  9 +++++--
 fs/ceph/mds_client.c          | 27 +++++++++++++++++----
 fs/ceph/mds_client.h          |  1 +
 fs/ceph/quota.c               |  2 +-
 fs/ceph/super.c               |  6 ++---
 fs/ceph/super.h               | 21 ++++++++++------
 fs/ceph/xattr.c               | 18 +++++++-------
 fs/mnt_idmapping.c            |  2 ++
 include/linux/mnt_idmapping.h |  3 +++
 17 files changed, 144 insertions(+), 61 deletions(-)

-- 
2.34.1

