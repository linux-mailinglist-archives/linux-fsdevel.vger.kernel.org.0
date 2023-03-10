Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2A6B52D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCJV14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DAD1194CD;
        Fri, 10 Mar 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bSmsxAPgv1/DEUtR+jwbmPjYuJT7O+N2x+boPF0Dnlc=; b=RPJmZehAvNi64nQjUVYzkmx3nU
        XTT5TMmDNwrUeqn0cftNaCEfdlwbYE/XCGqvXH3OHmcRjyOKsInEOEQMewnHzP/xGyO2vPt1xulUt
        jWBL3g+GKgQsCp+VJ7psfwQlRQw0XxgxM4DgMmXdFs3sXt4Zzz21bFQNkzKQzDBhwHE5wGXssc0uH
        yvYJEqz8BKVrqvQtwHxK5PUY2/nXiIB2Hl3Sh0YtCL/Lq1YnwxKkGBPJrwz649ij26VPatqK1+EPF
        8WndelCBHMBo2wlbOF3f6uY/oerZ6kE/X+jAksu17wBBKYlmo7CG3vB0fcdDMlQ5XMytxN/Jw2Zcz
        yignoAuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHF-00FR6G-2g;
        Fri, 10 Mar 2023 21:27:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] build_mount_idmapped(): switch to fdget()
Date:   Fri, 10 Mar 2023 21:27:45 +0000
Message-Id: <20230310212748.3679076-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
References: <20230310212536.GX3390869@ZenIV>
 <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bc0f15257b49..d26ea0d9041f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4197,7 +4197,7 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	int err = 0;
 	struct ns_common *ns;
 	struct user_namespace *mnt_userns;
-	struct file *file;
+	struct fd f;
 
 	if (!((attr->attr_set | attr->attr_clr) & MOUNT_ATTR_IDMAP))
 		return 0;
@@ -4213,16 +4213,16 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	if (attr->userns_fd > INT_MAX)
 		return -EINVAL;
 
-	file = fget(attr->userns_fd);
-	if (!file)
+	f = fdget(attr->userns_fd);
+	if (!f.file)
 		return -EBADF;
 
-	if (!proc_ns_file(file)) {
+	if (!proc_ns_file(f.file)) {
 		err = -EINVAL;
 		goto out_fput;
 	}
 
-	ns = get_proc_ns(file_inode(file));
+	ns = get_proc_ns(file_inode(f.file));
 	if (ns->ops->type != CLONE_NEWUSER) {
 		err = -EINVAL;
 		goto out_fput;
@@ -4251,7 +4251,7 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 	kattr->mnt_userns = get_user_ns(mnt_userns);
 
 out_fput:
-	fput(file);
+	fdput(f);
 	return err;
 }
 
-- 
2.30.2

