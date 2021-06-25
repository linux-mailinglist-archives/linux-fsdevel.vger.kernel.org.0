Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA13B3F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFYIhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 04:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:37:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D515C061574;
        Fri, 25 Jun 2021 01:35:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso5103587pjp.5;
        Fri, 25 Jun 2021 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMxz+BXwsGn8gwergLkFOAK6vzjs3xm3i+d6yFgzGzU=;
        b=TqOKoDAfEhm0IK32lKiC5rsoS+A+D0FW4WQg93hSnioHpUfst4Sx1jSz2cHyzdJ9Hj
         +YtjJwrLSYA/j03IRmQ77IVtxdVkV+nHLCfBO18dRQQf7uGc18rNhHZTkJbHcfZsK6i+
         AOj6InWaD7CKSvdnjA9o2uzosBv3krYeD8JlmzlFEo+Y6TX1WX1kLPkIVDSgQWEIQWo6
         Tri5LA1CqDfqKVi9xFmoL9rBMkJCUF8xPu/xcW8xWO/tXoaw5mhQ3xZSkJ/zk4AruiDW
         +QQHyfn0oFrGOg/P2DrITqUxVm6bYXBOlXsII3UsdXTrrIDQ2nhir30dDwqW5X08RRQr
         zluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMxz+BXwsGn8gwergLkFOAK6vzjs3xm3i+d6yFgzGzU=;
        b=smH+AXtfuIJK/WcLWj6t3tkbV9m9GVIyQFOIJdFleJxsBVHOUDKp1vrfD8IrMc/V8y
         cJn5ol7eGciP32Omf+iYfvz4n2PpbIL43FvG4aOjnSAoXygxEnhTXZUGYdtTpww0Sy4s
         qk+zNFVr2MY1U6XQ41Zqiv5CRQBHXZANNco47ZGBlgl/yoUF+TaShG50h10zHGTW4JKa
         jV94vcPHxyS9cvp+K2Sezt6Pf+ZDevZtsmRymqtNxNi46eLg0z9gat7NF80/4ZxKEe3j
         ExYy/oqCfSfZzIJis+adhbJ33p+uBE6n+9UzDBBg+fxonlvR6HE65XtKvu1r5Q2+UCvN
         dKEA==
X-Gm-Message-State: AOAM532tQdFiOf/DuQvxtLGCsjxWVvXWGmXt8FTiTmcANLVBVCKMZIRW
        oWHXjYmifysoCtXCNePYWfg=
X-Google-Smtp-Source: ABdhPJzWE40oAWUpIUXepiPIeHKByuypK2Y9CgEsI3TnIJxp6l4fKG8eQsjGZO4uq0dZou6D9XBmrw==
X-Received: by 2002:a17:90a:d082:: with SMTP id k2mr20414113pju.15.1624610131979;
        Fri, 25 Jun 2021 01:35:31 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id k1sm4876102pfa.30.2021.06.25.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:35:31 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sysctl: fix permission check while owner isn't GLOBAL_ROOT_UID
Date:   Fri, 25 Jun 2021 01:33:38 -0700
Message-Id: <20210625083338.384184-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

With user namespace enabled, root in container can't modify
/proc/sys/net/ipv4/ip_forward. While /proc/sys/net/ipv4/ip_forward
belongs to root and mode is 644. Since root in container may
be non-root in host, but test_perm() doesn't consider about it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 fs/proc/proc_sysctl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index dea0f5ee540c..71d7b2c2c8e3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -400,18 +400,19 @@ static void next_entry(struct ctl_table_header **phead, struct ctl_table **pentr
  * some sysctl variables are readonly even to root.
  */
 
-static int test_perm(int mode, int op)
+static int test_perm(struct inode *inode, int mode, int op)
 {
-	if (uid_eq(current_euid(), GLOBAL_ROOT_UID))
+	if (uid_eq(current_euid(), inode->i_uid))
 		mode >>= 6;
-	else if (in_egroup_p(GLOBAL_ROOT_GID))
+	else if (in_egroup_p(inode->i_gid))
 		mode >>= 3;
 	if ((op & ~mode & (MAY_READ|MAY_WRITE|MAY_EXEC)) == 0)
 		return 0;
 	return -EACCES;
 }
 
-static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, int op)
+static int sysctl_perm(struct inode *inode,
+	struct ctl_table_header *head, struct ctl_table *table, int op)
 {
 	struct ctl_table_root *root = head->root;
 	int mode;
@@ -421,7 +422,7 @@ static int sysctl_perm(struct ctl_table_header *head, struct ctl_table *table, i
 	else
 		mode = table->mode;
 
-	return test_perm(mode, op);
+	return test_perm(inode, mode, op);
 }
 
 static struct inode *proc_sys_make_inode(struct super_block *sb,
@@ -554,7 +555,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	 * and won't be until we finish.
 	 */
 	error = -EPERM;
-	if (sysctl_perm(head, table, write ? MAY_WRITE : MAY_READ))
+	if (sysctl_perm(inode, head, table, write ? MAY_WRITE : MAY_READ))
 		goto out;
 
 	/* if that can happen at all, it should be -EINVAL, not -EISDIR */
@@ -803,7 +804,7 @@ static int proc_sys_permission(struct user_namespace *mnt_userns,
 	if (!table) /* global root - r-xr-xr-x */
 		error = mask & MAY_WRITE ? -EACCES : 0;
 	else /* Use the permissions on the sysctl table entry */
-		error = sysctl_perm(head, table, mask & ~MAY_NOT_BLOCK);
+		error = sysctl_perm(inode, head, table, mask & ~MAY_NOT_BLOCK);
 
 	sysctl_head_finish(head);
 	return error;
-- 
2.25.1

