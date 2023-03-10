Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC596B52D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjCJV1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjCJV1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C0515EC;
        Fri, 10 Mar 2023 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ykzTGx7R9W3sLULXLejbbyWeBUSjFR2qsR1HFkSL8vc=; b=wT7jmOpvq6ccMQzckpop7tA1tV
        0HDonD1dM6bUwUyCtAFCXxiXQwUnp4j8e6/IQDbj1xrMYoGAFrtfUgQ4H+pktqoecx2bkFORJ6ZMB
        sU0ZcKLcxg0Fw9chFK7uLAs3U0T3ug5g8TiC6tKGhcMWbA06TWD1lB9HAvtEY8wNtGR+1a9BmeIO8
        P637LJu2XLGtjFFMgXdI9xqMJ7ZsoJpxmL762m+ObjgJPK+Eds/6MHvjcJrRDWNHJAcSalqOWCFZB
        sLDJW85ODwyt4rf+Kui3Jpxa5l50haHx6Z2G+ACDgSVvnH8iJeoo47m609tFw582lEq2l1WOJV9I9
        LWykwR4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHE-00FR63-27;
        Fri, 10 Mar 2023 21:27:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] convert setns(2) to fdget()/fdput()
Date:   Fri, 10 Mar 2023 21:27:41 +0000
Message-Id: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212536.GX3390869@ZenIV>
References: <20230310212536.GX3390869@ZenIV>
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
 kernel/nsproxy.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index a487ff24129b..80d9c6d77a45 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -545,21 +545,20 @@ static void commit_nsset(struct nsset *nsset)
 
 SYSCALL_DEFINE2(setns, int, fd, int, flags)
 {
-	struct file *file;
+	struct fd f = fdget(fd);
 	struct ns_common *ns = NULL;
 	struct nsset nsset = {};
 	int err = 0;
 
-	file = fget(fd);
-	if (!file)
+	if (!f.file)
 		return -EBADF;
 
-	if (proc_ns_file(file)) {
-		ns = get_proc_ns(file_inode(file));
+	if (proc_ns_file(f.file)) {
+		ns = get_proc_ns(file_inode(f.file));
 		if (flags && (ns->ops->type != flags))
 			err = -EINVAL;
 		flags = ns->ops->type;
-	} else if (!IS_ERR(pidfd_pid(file))) {
+	} else if (!IS_ERR(pidfd_pid(f.file))) {
 		err = check_setns_flags(flags);
 	} else {
 		err = -EINVAL;
@@ -571,17 +570,17 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (err)
 		goto out;
 
-	if (proc_ns_file(file))
+	if (proc_ns_file(f.file))
 		err = validate_ns(&nsset, ns);
 	else
-		err = validate_nsset(&nsset, file->private_data);
+		err = validate_nsset(&nsset, f.file->private_data);
 	if (!err) {
 		commit_nsset(&nsset);
 		perf_event_namespaces(current);
 	}
 	put_nsset(&nsset);
 out:
-	fput(file);
+	fdput(f);
 	return err;
 }
 
-- 
2.30.2

