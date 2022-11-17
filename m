Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8662E50B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiKQTMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 14:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiKQTMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:12:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC087561;
        Thu, 17 Nov 2022 11:12:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 13406605DED7;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LJYlS4X-wXkK; Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 56CDB63E5168;
        Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YGGq6Y6GdMPl; Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B763963E5146;
        Thu, 17 Nov 2022 20:12:06 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/3] NFS: NFSD: Allow crossing mounts when re-exporting
Date:   Thu, 17 Nov 2022 20:11:48 +0100
Message-Id: <20221117191151.14262-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently when re-exporting a NFS share the NFS cross mount feature does
not work [0].
This patch series outlines an approach to address the problem.

Crossing mounts does not work for two reasons:

1. As soon the NFS client (on the re-exporting server) sees a different
filesystem id, it installs an automount. That way the other filesystem
will be mounted automatically when someone enters the directory.
But the cross mount logic of KNFS does not know about automount.
This patch series addresses the problem and teach both KNFSD
and the exportfs logic of NFS to deal with automount.

2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to in=
stall
a new export for the target mount point. Beside of authentication rpc.mou=
ntd
also has to find a filesystem id for the new export. Is the to be exporte=
d
filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it =
and
refuses to export. In the logs you'll see errors such as:

mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or f=
sid=3D required

To deal with that I've changed rpc.mountd to use generate and store fsids=
 [1].
Since the kernel side of my changes did change for a long time I decided =
to
try upstreaming it first.
A 3rd iteration of my rpc.mountd will happen soon.

[0] https://marc.info/?l=3Dlinux-nfs&m=3D161653016627277&w=3D2
[1] https://lore.kernel.org/linux-nfs/20220217131531.2890-1-richard@nod.a=
t/

Richard Weinberger (3):
  NFSD: Teach nfsd_mountpoint() auto mounts
  fs: namei: Allow follow_down() to uncover auto mounts
  NFS: nfs_encode_fh: Remove S_AUTOMOUNT check

 fs/namei.c      | 2 +-
 fs/nfs/export.c | 2 +-
 fs/nfsd/vfs.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.26.2

