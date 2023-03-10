Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CD6B54E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCJW6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 17:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCJW6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:58:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2B10EAA8;
        Fri, 10 Mar 2023 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IhZZbKD1WKnq6M386c99sK7smpr0/fPnG05q4GVFpm8=; b=bLVTVRbRNqMlWICtQ+JBfb3zge
        UyUY7WJRD6BRaa4ns/utecRHd7Ssm/+VA/CVmAqtN+k2ndIx8YaDV/M73Vj64SWE3i1TU2CkEsarK
        woVn9zjciNL1TN8NAkaoRmTzxhC/vOYmAKEYswupLSFNksk1iJZX05MN8cB2IpSQuB0AYlL5Q6QYY
        epch0/yi6YgA1wS7M/+bYD8ZHpgNXFl3LaqvLiA6HgCzI9PlEhnlg8To/YDdpJGN8GHqInLGwyJ3P
        CL2HpL07q0ZKFxbaQe1LxATGZU96atFeBweJa7pPRVPcrQ2T90Xw5mV7FXPn2gOBBcivsof3kzdTL
        T28og8Sw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1palhD-00GYlV-5F; Fri, 10 Mar 2023 22:58:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/3] nfs: simplify two-level sysctl registration for nfs4_cb_sysctls
Date:   Fri, 10 Mar 2023 14:58:41 -0800
Message-Id: <20230310225842.3946871-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310225842.3946871-1-mcgrof@kernel.org>
References: <20230310225842.3946871-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to declare two tables to just create directories,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/nfs/nfs4sysctl.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index c394e4447100..e776200e9a11 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -37,27 +37,10 @@ static struct ctl_table nfs4_cb_sysctls[] = {
 	{ }
 };
 
-static struct ctl_table nfs4_cb_sysctl_dir[] = {
-	{
-		.procname = "nfs",
-		.mode = 0555,
-		.child = nfs4_cb_sysctls,
-	},
-	{ }
-};
-
-static struct ctl_table nfs4_cb_sysctl_root[] = {
-	{
-		.procname = "fs",
-		.mode = 0555,
-		.child = nfs4_cb_sysctl_dir,
-	},
-	{ }
-};
-
 int nfs4_register_sysctl(void)
 {
-	nfs4_callback_sysctl_table = register_sysctl_table(nfs4_cb_sysctl_root);
+	nfs4_callback_sysctl_table = register_sysctl("fs/nfs",
+						     nfs4_cb_sysctls);
 	if (nfs4_callback_sysctl_table == NULL)
 		return -ENOMEM;
 	return 0;
-- 
2.39.1

