Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A760127E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJQPJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiJQPJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:09:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D0F5B6;
        Mon, 17 Oct 2022 08:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B8DB8129F;
        Mon, 17 Oct 2022 15:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759F4C43143;
        Mon, 17 Oct 2022 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019319;
        bh=Hlwxu3UHd1cGVWkNG7tjVjUYJ3+DVrfANCyrtYgy0us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFHzRkeM+gyK/hfGu826iLcFcatbRNFeMzw8DwoJFbOOINjTpsjsgUsf7RDewlr7k
         mmFfR2ha8995GyVuKZPRS7FIQWtTa0oqTqywzzswfig4quBTkmFGlp6kBSnyKmUqwt
         GRSXLvpRjNs5rDLfkT+LduS0frUbA0tEuEcMC0CxA8j+OASLbHwXxW1DBi7jyxJpjS
         8BacbzIrTK2CqAQFNAzLCFVk9ZqY+ieG2rLvcjl0UOeYA+hZ6sRXeXCfhyujyonC4N
         ZS1szWmkYbTJ70S/MGtAlmWVsAlxZ2/BZRNGUW6GyZ43kFaE746wPPZD2Inot+Bgof
         7jD7rGzUfHo/Q==
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
Subject: [PATCH v4 5/6] ovl: remove privs in ovl_copyfile()
Date:   Mon, 17 Oct 2022 17:06:38 +0200
Message-Id: <20221017150640.112577-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017150640.112577-1-brauner@kernel.org>
References: <20221017150640.112577-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=brauner@kernel.org; h=from:subject; bh=G+t/gL8q/11PeMgU8ZzpGcGrkQyigKSVK23xo9w5S3E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST75ueETDhuV15dsE2v+D6bY/fryKvz2/waDnGdOabw77On 3HPhjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcK2Fk2Dyj+uXuTwsUE8WZbvVk9D Au5j2wb13ADokep99um9K4qhn+qdTyq3u69viqa80KKTow9dvlowbcRgmlDyTu/cv/L3+QBQA=
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

Underlying fs doesn't remove privs because copy_range/remap_range are
called with privileged mounter credentials.

This fixes some failures in fstest generic/673.

Fixes: 8ede205541ff ("ovl: add reflink/copyfile/dedup support")
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

 fs/overlayfs/file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a1a22f58ba18..755a11c63596 100644
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

