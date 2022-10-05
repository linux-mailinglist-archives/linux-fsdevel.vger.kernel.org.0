Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EE5F574D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 17:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiJEPPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJEPPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:15:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD112092;
        Wed,  5 Oct 2022 08:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 534BEB81E0E;
        Wed,  5 Oct 2022 15:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1F7C433C1;
        Wed,  5 Oct 2022 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982895;
        bh=Ja1CrhxOhSSkGzw4LvaMh9NJ41+mBO25kqRjvlu0K/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GONssRcLkxS9tys3amqkTiE5kWP4ER62/1K2O0r3uOoMDxXTJntSZlCWSc14BvbJ0
         Pij2G2OJLJt6/7mua7Mrnzjhj22KmsY/W293qBpQoQWJ2qfx4UvdGIMr0pSqbUpOKd
         ICT6WEv9X1PJD5cwIKf6pMI/dyjyOTqX4FICqSeLOo8JIq6f281QulSSx1rfx2JBMR
         mcequB1O+nPk4/iHyhRHjMr2ZJU4hqSpxxeJd7iWmtQZVz0QTjOLXe/5NhGNUEXrGc
         pIt4rVOcab5QSAPNS9x+Vsm5hXPsMP6IrtAPCVuhfxdCiBd0b7M8R47oHEdiarCI7n
         9UlZs+XNj4exQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] ovl: remove privs in ovl_fallocate()
Date:   Wed,  5 Oct 2022 17:14:33 +0200
Message-Id: <20221005151433.898175-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221005151433.898175-1-brauner@kernel.org>
References: <20221005151433.898175-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=brauner@kernel.org; h=from:subject; bh=MuRieyJdDJ1LDYkkzamQsUA3AXDut6E1op0Efq3Kakw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTbzndQvNB03oGv3rdz9yVOfed+/vxjN1kOyFssOPW7e3rw KuPkjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImcnsjwT3GW0GPuhQt4mr7pfBa21Q opPuX0W+O0i8qCM7cyX5ie7WJkuHXtWJqSr3XACz97CUdPy8dX3M6war1petQ/IVlbyaOEFwA=
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

Underlying fs doesn't remove privs because fallocate is called with
privileged mounter credentials.

This fixes some failure in fstests generic/683..687.

Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 362a4eed92b5..a34f8042724c 100644
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

