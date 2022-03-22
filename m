Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11324E409F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiCVOQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiCVOPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADCD8596B;
        Tue, 22 Mar 2022 07:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C646B615C7;
        Tue, 22 Mar 2022 14:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BB8C340EC;
        Tue, 22 Mar 2022 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958433;
        bh=ivm2aAVpqaKmPIFnOCUWQASOdRXkBq52kM+CW/CaRFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaSidzOO7I8os2ZFyBV/cYDfbFYAS9UXfOKFdaZNCXMuvBCPhehQkjLJdQzHEQ3q7
         PJY0RK7f2YgAzws8HnPBcKH+o5559Wi7qjS2anJjjR9mC16JQtBK8pKH8P/3siTmtj
         2D6VNOJYwk4ZNND/+sDtzblRD8Phi11+TihwcmunU081zugr5aFpAMj4kCGfZlXbJB
         XxI3EtB/QwoZj1+p9VbpZmJN2hmn8gDBZvRAYK5SgjA3qrTHuaWng9YyFOFaOetRhr
         75HJWsn9dPYbL76bhiL1psecorINSgIJD7HQwxWSzhrPPX/wyxTPIZJDHBgLzrVRiz
         z02E2GAs37DDw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 36/51] ceph: add __ceph_get_caps helper support
Date:   Tue, 22 Mar 2022 10:13:01 -0400
Message-Id: <20220322141316.41325-37-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Break out the guts of ceph_get_caps into a helper that takes an inode
and ceph_file_info instead of a file pointer.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c  | 19 +++++++++++++------
 fs/ceph/super.h |  2 ++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index fbf120a6aa96..2aa338219d27 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2946,10 +2946,9 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
  * due to a small max_size, make sure we check_max_size (and possibly
  * ask the mds) so we don't get hung up indefinitely.
  */
-int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got)
+int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
+		    int want, loff_t endoff, int *got)
 {
-	struct ceph_file_info *fi = filp->private_data;
-	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	int ret, _got, flags;
@@ -2958,7 +2957,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 	if (ret < 0)
 		return ret;
 
-	if ((fi->fmode & CEPH_FILE_MODE_WR) &&
+	if (fi && (fi->fmode & CEPH_FILE_MODE_WR) &&
 	    fi->filp_gen != READ_ONCE(fsc->filp_gen))
 		return -EBADF;
 
@@ -2966,7 +2965,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 
 	while (true) {
 		flags &= CEPH_FILE_MODE_MASK;
-		if (atomic_read(&fi->num_locks))
+		if (fi && atomic_read(&fi->num_locks))
 			flags |= CHECK_FILELOCK;
 		_got = 0;
 		ret = try_get_cap_refs(inode, need, want, endoff,
@@ -3011,7 +3010,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 				continue;
 		}
 
-		if ((fi->fmode & CEPH_FILE_MODE_WR) &&
+		if (fi && (fi->fmode & CEPH_FILE_MODE_WR) &&
 		    fi->filp_gen != READ_ONCE(fsc->filp_gen)) {
 			if (ret >= 0 && _got)
 				ceph_put_cap_refs(ci, _got);
@@ -3074,6 +3073,14 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 	return 0;
 }
 
+int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got)
+{
+	struct ceph_file_info *fi = filp->private_data;
+	struct inode *inode = file_inode(filp);
+
+	return __ceph_get_caps(inode, fi, need, want, endoff, got);
+}
+
 /*
  * Take cap refs.  Caller must already know we hold at least one ref
  * on the caps in question or we don't know this is safe.
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8f5fdb59344c..fef4cda44861 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1238,6 +1238,8 @@ extern int ceph_encode_dentry_release(void **p, struct dentry *dn,
 				      struct inode *dir,
 				      int mds, int drop, int unless);
 
+extern int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi,
+			   int need, int want, loff_t endoff, int *got);
 extern int ceph_get_caps(struct file *filp, int need, int want,
 			 loff_t endoff, int *got);
 extern int ceph_try_get_caps(struct inode *inode,
-- 
2.35.1

