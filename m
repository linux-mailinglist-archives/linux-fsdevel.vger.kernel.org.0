Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0D5F5749
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJEPPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJEPO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDE15FE7;
        Wed,  5 Oct 2022 08:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CDE6174D;
        Wed,  5 Oct 2022 15:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55163C4347C;
        Wed,  5 Oct 2022 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982892;
        bh=UTmKvMiicnjo7j8audhnHPeTRVq4/WEP3ZPyvTpzvuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Laor0GStEY5TPyxZtNVrFpZdEUoJqGhqBFYILaNaHXIUnXztTM3N0QEzw/Qlt6Yfc
         nDGSjmFuu94ZXXnaNfo46XjSrphYtYO+KJ6YBBqcB4izoOmcSo5T9g4YeqVIs/B2eX
         3Oyg+f5p6JiJGffdlddmupn8+eLtfM6IzPCPe2WqUDexJFsMQainOLXIOP1rpjGZqT
         uPyS7hiCs0hsO2aoeawBjVyRxSzCYPe9Q0KCdgXCMgf7GvbwlfjmQWw7PUjghEgtQc
         XGULUvMfq5SMuFjT8QcQy//O3NKsQDS5tDUfE3LTyrsVcRi2DL4A0lH8EWPD0Ezzx/
         zYjI0LlADBieg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] ovl: remove privs in ovl_copyfile()
Date:   Wed,  5 Oct 2022 17:14:32 +0200
Message-Id: <20221005151433.898175-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221005151433.898175-1-brauner@kernel.org>
References: <20221005151433.898175-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=brauner@kernel.org; h=from:subject; bh=f07IbRvta9bNyNzPo0n5eOvNgGJ8JSIOS8BsQ5agtVY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTbznd4zp2bVPv6WkY2E8+utW82Nyrqn+q89cX2vc3a4omt Fy9XdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk+XNGhmXcxlyeTxmCwm+v+nG5S2 XlPuVay9V3WbesF1OX7WdnjmJk+JZ9THjFVUP2fNtY1YU3bdg1zhXPTvvPOtnO1t5E77gpGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Underlying fs doesn't remove privs because copy_range/remap_range are
called with privileged mounter credentials.

This fixes some failures in fstest generic/673.

Fixes: 8ede205541ff ("ovl: add reflink/copyfile/dedup support")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index daff601b5c41..362a4eed92b5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -567,14 +567,23 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	const struct cred *old_cred;
 	loff_t ret;
 
+	inode_lock(inode_out);
+	if (op != OVL_DEDUPE) {
+		/* Update mode */
+		ovl_copyattr(inode_out);
+		ret = file_remove_privs(file_out);
+		if (ret)
+			goto out_unlock;
+	}
+
 	ret = ovl_real_fdget(file_out, &real_out);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = ovl_real_fdget(file_in, &real_in);
 	if (ret) {
 		fdput(real_out);
-		return ret;
+		goto out_unlock;
 	}
 
 	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
@@ -603,6 +612,9 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	fdput(real_in);
 	fdput(real_out);
 
+out_unlock:
+	inode_unlock(inode_out);
+
 	return ret;
 }
 
-- 
2.34.1

