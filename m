Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA59B057
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiHTURE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTURC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:17:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6D30570
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jlm32nyGtnCnSG7q0B++K8ERpThUdpqRlTinI+FTl7Q=; b=CVTNsnJE0Ogh+f1mfbK2Mk91th
        Q6Km4BvwUqRqVwMoAHhA5Lf1h+hk8TzGiac1NQva7k1hv6pT5ATx13ElQ+XoydpQmE7qMvVoLNma7
        7cbn88UYLofGLhzO5CC2W8AhX6v9rs2UoUuDY4DGXPiF7tg+JPpKT8Gmir66VL94HyDm9s/P9Ykd3
        NIUWwjjoqsD7DRqPpa0ZriGkc0uimGAhR5dj1eu8fN5TUmmQIdT/7jPVem2DE4t/txmwnp95jR2Kq
        LyaRSoIlW4RVfU1ygx2xWGboOTeuIPt8Xd8Elg2oaHEd7oSt2Cg4UxbkMxRL2suOs2VDhYGW8r5jc
        +Ocv/o+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUtv-006T9y-T4;
        Sat, 20 Aug 2022 20:17:00 +0000
Date:   Sat, 20 Aug 2022 21:16:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 4/8] bprm_fill_uid(): don't open-code file_inode()
Message-ID: <YwFBO19tkIUm49Zs@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f793221f4eb6..c1867122204a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1595,7 +1595,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 {
 	/* Handle suid and sgid on files */
 	struct user_namespace *mnt_userns;
-	struct inode *inode;
+	struct inode *inode = file_inode(file);
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
@@ -1606,7 +1606,6 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	if (task_no_new_privs(current))
 		return;
 
-	inode = file->f_path.dentry->d_inode;
 	mode = READ_ONCE(inode->i_mode);
 	if (!(mode & (S_ISUID|S_ISGID)))
 		return;
-- 
2.30.2

