Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824862E507
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 20:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiKQTMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 14:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbiKQTMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:12:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0287567;
        Thu, 17 Nov 2022 11:12:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 953E963E516C;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2d-a3it2RGeZ; Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4A76063E516F;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uDGT4ROq8FZk; Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C32F463E516B;
        Thu, 17 Nov 2022 20:12:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto mounts
Date:   Thu, 17 Nov 2022 20:11:50 +0100
Message-Id: <20221117191151.14262-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20221117191151.14262-1-richard@nod.at>
References: <20221117191151.14262-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is only used by NFSD to cross mount points.
If a mount point is of type auto mount, follow_down() will
not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
to have ->d_automount() called when NFSD walks down the
mount tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..000c4b84e6be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1462,7 +1462,7 @@ int follow_down(struct path *path)
 {
 	struct vfsmount *mnt =3D path->mnt;
 	bool jumped;
-	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
+	int ret =3D traverse_mounts(path, &jumped, NULL, LOOKUP_AUTOMOUNT);
=20
 	if (path->mnt !=3D mnt)
 		mntput(mnt);
--=20
2.26.2

