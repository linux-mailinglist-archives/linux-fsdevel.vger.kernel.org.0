Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61965F7979
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJGOGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJGOG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8248120EEA;
        Fri,  7 Oct 2022 07:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D31B82359;
        Fri,  7 Oct 2022 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9203C433D6;
        Fri,  7 Oct 2022 14:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665151580;
        bh=kYZCPGqWz1NYR4jfQZxOSvhyw36cMU9LOCXeRuuhMXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ln/YMZDCcuQpJBCWFwZWKPDTwbS4D9/cCe8LY4rVkZ//EBWxGAP+aJniBtywT0t59
         HPSB6HtP5PXsy4gls4vaxyoTvwRYstDNLRXwDeSWyIROOpyYkHW/xMV+5WmtIcSQAv
         pyGNFCqChisGLp5Ggb9Qw58MF0akfxshnUjMN3QSfalONRBU2IPAymaaV+0/w3fgW9
         1hVuwG+EoeR0FzO+26uKiKFnizuBSV5Hx5lb2W4fpjrhPsJ3/6g4Rjp6gzJX52PGtq
         GAusUTLgZDr7Sr+iWqe5Vfuf5f8wtdciHO76x/TYCKLQ4re5qOg+F7Xjr5Rv5Yy0uF
         EosxZ4HDfFKlw==
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
Subject: [PATCH v2 5/5] ovl: remove privs in ovl_fallocate()
Date:   Fri,  7 Oct 2022 16:05:43 +0200
Message-Id: <20221007140543.1039983-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007140543.1039983-1-brauner@kernel.org>
References: <20221007140543.1039983-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=brauner@kernel.org; h=from:subject; bh=RfTC6I5AnyRwnqFU/X+mTdM+dBKeRqNszf5L5jWyXuE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ7GBlcuDS58/ih9Z8ZT0mc7v69eI+l9fNZRTfmuflXV8ts /dm3t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiSVsZGZZvPXTcaNHrk16rnk65fr Jdm+c8723Txjq1LdeLXjmGGv9i+Gf8OvRvpp/uDb1T7xqTVB6wnWGU1K61Oz719LagCZ8lynkB
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
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
---

Notes:
    /* v2 */
    Acked-by: Miklos Szeredi <miklos@szeredi.hu>

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

