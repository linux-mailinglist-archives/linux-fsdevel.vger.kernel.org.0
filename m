Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27B5F7978
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJGOG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJGOGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BD1162D3;
        Fri,  7 Oct 2022 07:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F48361D16;
        Fri,  7 Oct 2022 14:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFF0C433B5;
        Fri,  7 Oct 2022 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665151575;
        bh=P6dyzGAsMDVLDq/B6zkr37iKl5Yvf5YQk/c92ojHmy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2s4em9hHSst8jQC2UVxzYi1c/reQc60R0pEAtAqwhrT6qjiu8PYBGRB7OGb9rMUc
         zqqBqa3gmVWYczgabRIpL16P3Qom1L6K/AvhjPZKE9lgeMuq4Wiwvafbn/t1qASbR8
         jAKENYLe5Ansnei3EGu+KVtjqcGnUvadwfouqPgbmwOhxO3+o0xRDi0UgKn/lpuMBU
         o+juE0oaSJTmRzZAxS+4w1UA+FocF/yveH1k0TIkuUshfXG8VyrQ1aEHThIi69gAwy
         AESzmPmFQ6fC1AuZUm8gPLanbnbN85A4nsrOZpqrC7oTlNNrMKDQWvdsXXW1oRF0mg
         zDBeOvv1Tfrng==
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
Subject: [PATCH v2 4/5] ovl: remove privs in ovl_copyfile()
Date:   Fri,  7 Oct 2022 16:05:42 +0200
Message-Id: <20221007140543.1039983-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007140543.1039983-1-brauner@kernel.org>
References: <20221007140543.1039983-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=brauner@kernel.org; h=from:subject; bh=r1jrxTVO4+AiXpDFHIxGNphHkxYYvzzS/GTAYxL2v7A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ7GBns/J8aJ7dpSbRn2lXWzNVm82PC8h/uMGKvad6UwdDo tGJiRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUtzH8z/Xlfr5dYeX1DQo283UZD/ CLqVeKZD2zOxw9U2EH0+YcBYb/jofTGawXTrb6F9Me6rUrutTf7XPkztKFEz5PCF//WXg1LwA=
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
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---

Notes:
    /* v2 */
    Acked-by: Miklos Szeredi <miklos@szeredi.hu>

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

