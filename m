Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78B6A8A53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCBU3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCBU3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535CE1A969;
        Thu,  2 Mar 2023 12:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aQxjJTI+/dgkfmOIkPQGBpoNeT0L25JfaRzqJBNjzfI=; b=M9Ls3cLPjLxNw64e3/lgGKMi96
        8TAGSLVibINE1yswDzR8JzobcbigsqbuREDkc+CYrF+RiHQSMgAmf6yrV1lO4kjZ2FzXnswl3+03A
        fcXNLxcyw8wBceOCZgds3wn3ORO7gc72kXSfmwu1mIvI/VrkdFToLXMUmTN/4AFfj8FMxmgxKCTlW
        a2hz5P4cP+sg7uV9qEpfkZGPF+NtATW9+gSwUB4XXxjdkzh/W3WwvSlZt9iJNRHdedq1LxFqmXf7F
        v2p6ZK6mtaRZOj4/WdAkAizmAIpcCkvVRU8DvSY2i5CXtjK6tQvdpqTDANTTSQUtTD/eXXdsfuX5j
        +pvTdI2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxF-4H; Thu, 02 Mar 2023 20:28:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 04/11] apparmor: simplify sysctls with register_sysctl_init()
Date:   Thu,  2 Mar 2023 12:28:19 -0800
Message-Id: <20230302202826.776286-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302202826.776286-1-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using register_sysctl_paths() is really only needed if you have
subdirectories with entries. We can use the simple register_sysctl()
instead.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 security/apparmor/lsm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d6cc4812ca53..47c7ec7e5a80 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1764,11 +1764,6 @@ static int apparmor_dointvec(struct ctl_table *table, int write,
 	return proc_dointvec(table, write, buffer, lenp, ppos);
 }
 
-static struct ctl_path apparmor_sysctl_path[] = {
-	{ .procname = "kernel", },
-	{ }
-};
-
 static struct ctl_table apparmor_sysctl_table[] = {
 	{
 		.procname       = "unprivileged_userns_apparmor_policy",
@@ -1790,8 +1785,7 @@ static struct ctl_table apparmor_sysctl_table[] = {
 
 static int __init apparmor_init_sysctl(void)
 {
-	return register_sysctl_paths(apparmor_sysctl_path,
-				     apparmor_sysctl_table) ? 0 : -ENOMEM;
+	return register_sysctl("kernel", apparmor_sysctl_table) ? 0 : -ENOMEM;
 }
 #else
 static inline int apparmor_init_sysctl(void)
-- 
2.39.1

