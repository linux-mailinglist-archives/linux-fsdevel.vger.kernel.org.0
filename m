Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43F6E4EA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDQQz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQQz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B90E9;
        Mon, 17 Apr 2023 09:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7982B62851;
        Mon, 17 Apr 2023 16:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E5FC433D2;
        Mon, 17 Apr 2023 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681750554;
        bh=+d/lVi1J7BqYOvVt6PAqOL5mAcrAhRVB95e6IpiVqjo=;
        h=From:To:Cc:Subject:Date:From;
        b=sE+FKdeXE4ervgvpNrQ1+ziY+As3s8uAvlcMWrQjT9aYUT5D3UzeRmpsUzoo1sBL5
         pu2JeoGNMvuqrxSbinwViDMtMkQpSh97DCxkHQHm6p4ppmDJ7vFD/zrSim3ChUSu9W
         nJS5dvKL2yCtAm3Z/kK1OoQKYlChb4ejr9SIs44rdl4id2Wv5TOhANM3zmUVy1VKAv
         vnLavpfrej46/KoEwl8rCSwkQxrNo8RV1JLqVRpzWv/P22vtrRKCWNHr94G1EzUkxf
         NiNf9FMhGk13yi8qH3a/giUsruCbJ3jdslOHhfPRGFjNSo9wedR3FNQxW6lVyor2xr
         g1/lDTvtyu29w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <brauner@kernel.org>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: use vfs_getattr_nosec to get the i_version
Date:   Mon, 17 Apr 2023 12:55:51 -0400
Message-Id: <20230417165551.31130-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IMA currently accesses the i_version out of the inode directly when it
does a measurement. This is fine for most simple filesystems, but can be
problematic with more complex setups (e.g. overlayfs).

Make IMA instead call vfs_getattr_nosec to get this info. This allows
the filesystem to determine whether and how to report the i_version, and
should allow IMA to work properly with a broader class of filesystems in
the future.

Reported-and-Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/integrity/ima/ima_api.c  |  9 ++++++---
 security/integrity/ima/ima_main.c | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d3662f4acadc..c45902e72044 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
-#include <linux/iversion.h>
 #include <linux/fsverity.h>
 
 #include "ima.h"
@@ -246,10 +245,11 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	struct inode *inode = file_inode(file);
 	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct kstat stat;
 	int result = 0;
 	int length;
 	void *tmpbuf;
-	u64 i_version;
+	u64 i_version = 0;
 
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -268,7 +268,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	i_version = inode_query_iversion(inode);
+	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
+				   AT_STATX_SYNC_AS_STAT);
+	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
+		i_version = stat.change_cookie;
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d66a0a36415e..365db0e43d7c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
-#include <linux/iversion.h>
 #include <linux/fs.h>
 
 #include "ima.h"
@@ -164,11 +163,16 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) == 1) {
+		struct kstat stat;
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
-		if (!IS_I_VERSION(inode) ||
-		    !inode_eq_iversion(inode, iint->version) ||
-		    (iint->flags & IMA_NEW_FILE)) {
+		if ((iint->flags & IMA_NEW_FILE) ||
+		    vfs_getattr_nosec(&file->f_path, &stat,
+				      STATX_CHANGE_COOKIE,
+				      AT_STATX_SYNC_AS_STAT) ||
+		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
+		    stat.change_cookie != iint->version) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
-- 
2.39.2

