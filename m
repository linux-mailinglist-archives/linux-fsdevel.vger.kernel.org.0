Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B625562E50F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiKQTMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 14:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbiKQTMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:12:12 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E6587569;
        Thu, 17 Nov 2022 11:12:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 320B163E5175;
        Thu, 17 Nov 2022 20:12:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EeudFGW_NLvE; Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CBA1063E516B;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IduuldTnhFni; Thu, 17 Nov 2022 20:12:08 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 4918F63E5168;
        Thu, 17 Nov 2022 20:12:08 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/3] NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
Date:   Thu, 17 Nov 2022 20:11:51 +0100
Message-Id: <20221117191151.14262-4-richard@nod.at>
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

Now with NFSD being able to cross into auto mounts,
the check can be removed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/nfs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 01596f2d0a1e..0a5ee1754d50 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -42,7 +42,7 @@ nfs_encode_fh(struct inode *inode, __u32 *p, int *max_l=
en, struct inode *parent)
 	dprintk("%s: max fh len %d inode %p parent %p",
 		__func__, *max_len, inode, parent);
=20
-	if (*max_len < len || IS_AUTOMOUNT(inode)) {
+	if (*max_len < len) {
 		dprintk("%s: fh len %d too small, required %d\n",
 			__func__, *max_len, len);
 		*max_len =3D len;
--=20
2.26.2

