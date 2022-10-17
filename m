Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00C600BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJQKGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiJQKGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607855F7E2;
        Mon, 17 Oct 2022 03:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2955E6100B;
        Mon, 17 Oct 2022 10:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB704C43146;
        Mon, 17 Oct 2022 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666001190;
        bh=8+pm1Gyok99ypGEogBIk14qQkX8CSGRb7U5My8BNvzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzCj2+gNR1P+t28OAb3Nu/nwJ4Q0PH+ztE2XpdITQJ6mSXiSUSAY0Z1ldT39BeDfE
         TTVI4CUptT3tJYpdY94f5muSr8n36HeB/pvi9gYGT7qG9QpwUiNCV9Etur9ccbJOyp
         GR5yBucqiq0CBvW1tDY2SABZ4RiR4qTNVq9tzSUrG7he9bCGZuAvt2+q/1hE+d67oN
         QCqMg84v2PVhP+hDEtZ6EVIt7VaAfSuY2bhMz9s5a4Htmp3WuLmThCRhgWfPK3aGop
         dXEZdilf2bZCHgwUipyEZsC8C5tJIlafsK/9seKXIoqkoWeq4ZDTPiwlNEpMvK6phk
         rK8dm1uiHk0KQ==
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
Subject: [PATCH v3 5/5] ovl: remove privs in ovl_fallocate()
Date:   Mon, 17 Oct 2022 12:06:00 +0200
Message-Id: <20221017100600.70269-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017100600.70269-1-brauner@kernel.org>
References: <20221017100600.70269-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=brauner@kernel.org; h=from:subject; bh=K5sAcB0+cO0LiB6mZF1v9GKE2/+4csaj3McCkOWmEbs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7avxeuOjzHUX7/Jy+2pWFFjwdDNXsz9ueH7n35UVUmd7X 41e0OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCcoqR4buwTLr9VsnuzRLeti8fLb l1zDFeoeFJbKHaygOzPxpr8jD8T1rT85Yp+bqRVduW3//NZVr9JfYUM+1wLxI53vuYofQ0EwA=
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
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---

Notes:
    /* v2 */
    Acked-by: Miklos Szeredi <miklos@szeredi.hu>
    
    /* v3 */
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

