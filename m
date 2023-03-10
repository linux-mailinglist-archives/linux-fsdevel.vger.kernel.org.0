Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C76B54F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCJW6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 17:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCJW6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:58:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E711AC81;
        Fri, 10 Mar 2023 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CI7wUFe4HoAyZSn/G8BSxZXCldpIdIVkdFkiT2hi/YU=; b=oK2etHUPnlp7nBlLvwy1fUlUbE
        RfZnxL7Hi7ugHjVsrcBw1aSuS47Oascs0KpARm4hgfQxeUZVE+HcH8VVjNGNeY/TjH5zt6yu0tHaw
        8QvI2iwH+Q3C2JLyxFjDdpJTLpM2OJqOimtPjgmGZ+Yaz+KFickUNLcK4ba4k/o8jfja1TZap1RyJ
        qVP1HJpnN4aoMCdC9IBD+AlJP6uVPzpz37E4T8W62Bm1nwmH8GHbatJMXeCPY8wNgE2XVs0MnBZPP
        fc8rrbo0lH3hnZk5rfrM1JqJj0g1EI2283iB7qxRkQEyBYOXpmPiDjnzTOqtNEzXlb2i9/976dKpY
        JHGUih8Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1palhD-00GYlT-3q; Fri, 10 Mar 2023 22:58:43 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] lockd: simplify two-level sysctl registration for nlm_sysctls
Date:   Fri, 10 Mar 2023 14:58:40 -0800
Message-Id: <20230310225842.3946871-2-mcgrof@kernel.org>
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
 fs/lockd/svc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 914ea1c3537d..5bca33758bc8 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -510,24 +510,6 @@ static struct ctl_table nlm_sysctls[] = {
 	{ }
 };
 
-static struct ctl_table nlm_sysctl_dir[] = {
-	{
-		.procname	= "nfs",
-		.mode		= 0555,
-		.child		= nlm_sysctls,
-	},
-	{ }
-};
-
-static struct ctl_table nlm_sysctl_root[] = {
-	{
-		.procname	= "fs",
-		.mode		= 0555,
-		.child		= nlm_sysctl_dir,
-	},
-	{ }
-};
-
 #endif	/* CONFIG_SYSCTL */
 
 /*
@@ -644,7 +626,7 @@ static int __init init_nlm(void)
 
 #ifdef CONFIG_SYSCTL
 	err = -ENOMEM;
-	nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root);
+	nlm_sysctl_table = register_sysctl("fs/nfs", nlm_sysctls);
 	if (nlm_sysctl_table == NULL)
 		goto err_sysctl;
 #endif
-- 
2.39.1

