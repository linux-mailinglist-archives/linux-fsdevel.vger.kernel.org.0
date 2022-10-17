Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDC601273
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiJQPJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJQPI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:08:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74941510;
        Mon, 17 Oct 2022 08:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7A18B81903;
        Mon, 17 Oct 2022 15:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21E1C43140;
        Mon, 17 Oct 2022 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019322;
        bh=qwCkQyp+gCVR66Y5vEJFbr0vfKp7DrwSiV/A5d4Ljo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7evAuum9/S/YU0sBY7uZhF6yrtYbaLubqHZaGIgHmjcC2I4ZuTwtXILUAlRBfxTZ
         1ZGRbPNGZAtNT4LYJU8Lorv5QGifA4r8eW8cWAsBh6LBE2owS380rNN6JQI+7cvoFe
         gg7HT2mETCQp4AJjqjq+pxSUIeqxKPJFzOinvoxJwLZ6S9qmCelgQ2Mgxo+zmoouER
         dRNcPl1yjTMPULAoIYnArP7Z68ogXf/Hte8I2CsuUQO4bFuyS7rKMiG+byKWTh1wLB
         sAiAk4HRwijBBdUF+h2mVEutYhhhASWKTEYzXqNj6VmEbuw7iBFL5FW7vTe+qFDfN6
         K7JJylLRhWZMA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH v4 6/6] ovl: remove privs in ovl_fallocate()
Date:   Mon, 17 Oct 2022 17:06:39 +0200
Message-Id: <20221017150640.112577-7-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017150640.112577-1-brauner@kernel.org>
References: <20221017150640.112577-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=brauner@kernel.org; h=from:subject; bh=jtbtbj251E0kABtB82zZ5jw8YBCX3AUoEX4swbhCcy8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST75ufe6V/l3Plw4dfujWlrkqe+MthS4D21ROmG4LQN140d DJdKdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk73aG/84pDv1iL23ebP5ay/Z4w3 vlo7NMCnrtyrmrWUMb7papzGJkuHjc9OF9KTZDj/UGa1wZVxVvEeMw/qvlzbqyc+XFtPWyDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Underlying fs doesn't remove privs because fallocate is called with
privileged mounter credentials.

This fixes some failure in fstests generic/683..687.

Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Notes:
    /* v2 */
    Acked-by: Miklos Szeredi <miklos@szeredi.hu>
    
    /* v3 */
    unchanged
    
    /* v4 */
    unchanged

 fs/overlayfs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 755a11c63596..d066be3b9226 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -517,9 +517,16 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	const struct cred *old_cred;
 	int ret;
 
+	inode_lock(inode);
+	/* Update mode */
+	ovl_copyattr(inode);
+	ret = file_remove_privs(file);
+	if (ret)
+		goto out_unlock;
+
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
@@ -530,6 +537,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	fdput(real);
 
+out_unlock:
+	inode_unlock(inode);
+
 	return ret;
 }
 
-- 
2.34.1

