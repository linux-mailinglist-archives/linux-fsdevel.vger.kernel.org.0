Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE49962E50C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiKQTMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 14:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiKQTMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:12:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61383606A1;
        Thu, 17 Nov 2022 11:12:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6BD1663E5149;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ki1dMyhX9hbu; Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C5E7463E516C;
        Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O7S3p5HUjSNY; Thu, 17 Nov 2022 20:12:07 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4985B63E5149;
        Thu, 17 Nov 2022 20:12:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/3] NFSD: Teach nfsd_mountpoint() auto mounts
Date:   Thu, 17 Nov 2022 20:11:49 +0100
Message-Id: <20221117191151.14262-2-richard@nod.at>
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

Currently nfsd_mountpoint() tests for mount points using d_mountpoint(),
this works only when a mount point is already uncovered.
In our case the mount point is of type auto mount and can be coverted.
i.e. ->d_automount() was not called.

Using d_managed() nfsd_mountpoint() can test whether a mount point is
either already uncovered or can be uncovered later.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f650afedd67f..157f0df0e93a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -160,7 +160,7 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc=
_export *exp)
 		return 1;
 	if (nfsd4_is_junction(dentry))
 		return 1;
-	if (d_mountpoint(dentry))
+	if (d_managed(dentry))
 		/*
 		 * Might only be a mountpoint in a different namespace,
 		 * but we need to check.
--=20
2.26.2

