Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219586831ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjAaP4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjAaP4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FA17154;
        Tue, 31 Jan 2023 07:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0331B6158D;
        Tue, 31 Jan 2023 15:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A9BC433D2;
        Tue, 31 Jan 2023 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675180570;
        bh=FDlHK/H4Jh89Tca25M42ibJ74C6dgzbMwkQIcxTDWhE=;
        h=From:To:Cc:Subject:Date:From;
        b=D0G7i5l+vHCPeJhaI7CisXTHBWimO9WD5x6Jx9RQKfhtjpD11MBk49H+Q9dib9Wnm
         ehvasr+/pg88d2zULRByTanGWs4ymgOkECrEVuNgW1EoaFoyd6v45ikDohdGoodlvf
         yOzQAisSW+ZnL5Py7DZ9SV1ISXOxorcCper207AKwMFnH+yxeg69rdoRybErEUZ6du
         LDmGxdGzDI6ZdbhDs+QiWIq14DtjVPdiUleUvIRQaAM8Csw+kWRg3NTR2fdvyWXMMI
         6kQaMGZ68qjWnsVaJzZ2suNNmWxSvK4BU2uKT0HKMyFzLNJAcuVDyKqWmZp3sUgGkX
         o1GWTMPG/9L1w==
From:   Chao Yu <chao@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
Date:   Tue, 31 Jan 2023 23:55:58 +0800
Message-Id: <20230131155559.35800-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__proc_create() has limited dirent's max name length with 255, let's
add this limitation in proc_lookup_de(), so that it can return
-ENAMETOOLONG correctly instead of -ENOENT when stating a file which
has out-of-range name length.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/proc/generic.c  | 5 ++++-
 fs/proc/internal.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 878d7c6db919..f547e9593a77 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -245,6 +245,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 {
 	struct inode *inode;
 
+	if (dentry->d_name.len > PROC_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	read_lock(&proc_subdir_lock);
 	de = pde_subdir_find(de, dentry->d_name.name, dentry->d_name.len);
 	if (de) {
@@ -401,7 +404,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 		goto out;
 	qstr.name = fn;
 	qstr.len = strlen(fn);
-	if (qstr.len == 0 || qstr.len >= 256) {
+	if (qstr.len == 0 || qstr.len > PROC_NAME_LEN) {
 		WARN(1, "name len %u\n", qstr.len);
 		return NULL;
 	}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b701d0207edf..7611bc684d9e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -142,6 +142,9 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
+/* Max name length of procfs dirent */
+#define PROC_NAME_LEN		255
+
 /*
  * array.c
  */
-- 
2.36.1

