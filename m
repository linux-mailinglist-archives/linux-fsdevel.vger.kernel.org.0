Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A746B52D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCJV2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4731269B6;
        Fri, 10 Mar 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gMRVk9alI+8EWOaupK6tdpMdZP6n/jEk5vdgSWB8iIo=; b=aBiYWIj/FFql3mDoJoCrpNjliH
        lDrPD21A5bENfsef/ahV5xpG6xFR1h7IMK9Am1AleaoR1n9vWkvpcdOCipslYrFhf7udUqOE6y39G
        H3FLUZ5yN7613QFS07/lR7tCdrYIWJl5hn1A0KHn3C1e5ljrQEBOSSdJX7bqsaj5FY8QyFSI+MacJ
        8RVmf7nmunB1tT3+kRoJX31uXpK3OKj8z43VulUQgwZMH5P1RHRnK4EXDY255hdJy1/N5lAtfTv78
        nTlUZo2C+yT5Srz/vSPmi3X0kRD4pGyTpBs4fTgzpbgGPVpaVUUnZoCYsu6BVqXW8WWJnfroI7nCs
        e7jk+tDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHG-00FR6P-1F;
        Fri, 10 Mar 2023 21:27:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] fuse_dev_ioctl(): switch to fdget()
Date:   Fri, 10 Mar 2023 21:27:48 +0000
Message-Id: <20230310212748.3679076-8-viro@zeniv.linux.org.uk>
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
 fs/fuse/dev.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index eb4f88e3dc97..1a8f82f478cb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2257,30 +2257,31 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
+	struct fd f;
 
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
-		res = -EFAULT;
-		if (!get_user(oldfd, (__u32 __user *)arg)) {
-			struct file *old = fget(oldfd);
-
-			res = -EINVAL;
-			if (old) {
-				/*
-				 * Check against file->f_op because CUSE
-				 * uses the same ioctl handler.
-				 */
-				if (old->f_op == file->f_op)
-					fud = fuse_get_dev(old);
-
-				if (fud) {
-					mutex_lock(&fuse_mutex);
-					res = fuse_device_clone(fud->fc, file);
-					mutex_unlock(&fuse_mutex);
-				}
-				fput(old);
-			}
+		if (get_user(oldfd, (__u32 __user *)arg))
+			return -EFAULT;
+
+		f = fdget(oldfd);
+		if (!f.file)
+			return -EINVAL;
+
+		/*
+		 * Check against file->f_op because CUSE
+		 * uses the same ioctl handler.
+		 */
+		if (f.file->f_op == file->f_op)
+			fud = fuse_get_dev(f.file);
+
+		res = -EINVAL;
+		if (fud) {
+			mutex_lock(&fuse_mutex);
+			res = fuse_device_clone(fud->fc, file);
+			mutex_unlock(&fuse_mutex);
 		}
+		fdput(f);
 		break;
 	default:
 		res = -ENOTTY;
-- 
2.30.2

