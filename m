Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EE6505A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiLRXZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRXYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:24:37 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14003BCAB
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405876;
        bh=fJAS5WOiNl8OGefvohv8GYDvU+ypBa5SutnfaYNBIeg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ooTWSiESAAaoZzIyWMvNN2mrZXKHRgEwEpqMnaAnUUiqysa1CeIHeMcvbODl149/p
         ZxHlZ3IcItkSdA6YGRWkUuUR5eR0jlVHQgR2Jb7/YgPP59flaSbp/NkZujydYhIvMf
         wVSeQwFtjKiPGjdk0czrveal/82z7/M2Ht0oBBvd3UVVun1vC9R81gUiqglOlywgFb
         0D9mu2fvC1XA+t4QRAzlU/Iixv9fE5h++JGiKNb3rgYwWHPHAjeI4xM9wO3HXJomqh
         b3Um0KRkpBeZJw/wiNVZscm2DxdTuUtyb1MzPkrAtTTBFW285lGzD4q2D1UZkXsuYY
         MiipNpcYtD0fQ==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id E0CDECC005D;
        Sun, 18 Dec 2022 23:24:35 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 09/10] fix error reporting in v9fs_dir_release
Date:   Sun, 18 Dec 2022 23:22:25 +0000
Message-Id: <20221218232217.1713283-10-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: a4izFcqvh2i1fGWRw_aPPq9hpnGkzlSU
X-Proofpoint-GUID: a4izFcqvh2i1fGWRw_aPPq9hpnGkzlSU
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=804 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180223
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checking the p9_fid_put value allows us to pass back errors
involved if we end up clunking the fid as part of dir_release.

This can help with more graceful response to errors in writeback
among other things.

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 fs/9p/vfs_dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 536769cdf7c8..b5495d6d0eff 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -197,7 +197,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 
 /**
- * v9fs_dir_release - close a directory
+ * v9fs_dir_release - called on a close of a file or directory
  * @inode: inode of the directory
  * @filp: file pointer to a directory
  *
@@ -209,6 +209,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	struct p9_fid *fid;
 	__le32 version;
 	loff_t i_size;
+	int retval = 0;
 
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
@@ -226,7 +227,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
-		p9_fid_put(fid);
+		retval = p9_fid_put(fid);
 	}
 
 	if ((filp->f_mode & FMODE_WRITE)) {
@@ -237,7 +238,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	} else {
 		fscache_unuse_cookie(v9fs_inode_cookie(v9inode), NULL, NULL);
 	}
-	return 0;
+	return retval;
 }
 
 const struct file_operations v9fs_dir_operations = {
-- 
2.37.2

