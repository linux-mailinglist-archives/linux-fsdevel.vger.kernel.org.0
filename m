Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA26A8A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCBU3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCBU3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830A19F35;
        Thu,  2 Mar 2023 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HudEwxK4LxjEbcX61XhJokDY+tUfMk0/fd7PxDNcDCE=; b=P8dofZ6rdK4Re2PjCV19YaCRW9
        Dtf2EhtYU92txmayFoU3Ntggo+CVRTt7tPZP04nR23G2ZKUznaTDWlmNm+N41EYbpYsreJ6QWU0dd
        H7Q3JpaAzLWd2+gc9QduwlwxocaYhfEDjw/KmpIBV81LTBRG2HAVG1/44e3rJA2jJ672uR8Zh/XEF
        YOZH7e0ncbWHwEpumBjLvR5QW75JM9mdyfXylHusHgm4l+vc+I92tDx0ZElDm0lnK4iTBUUqafdwC
        EMPEhMOEe7SnM5PHQ0jzTvOvbzt7nG9/3wWlWfupXUvp4CrqR7zPfYC6VoRJBhADapyST8phjyXMD
        yOozgATg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXS-003FxR-Ia; Thu, 02 Mar 2023 20:28:30 +0000
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
Subject: [PATCH 10/11] csky: simplify alignment sysctl registration
Date:   Thu,  2 Mar 2023 12:28:25 -0800
Message-Id: <20230302202826.776286-11-mcgrof@kernel.org>
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

Using register_sysctl_paths() is only required if we are using
leafs with entries but all we are doing is creates leafs with
just one leaf and then entries and register_sysctl_init() works
well with that already.

The 555 permission is already retained by the new_dir() proc
sysctl directory creator.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/csky/abiv1/alignment.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 2df115d0e210..b60259daed1b 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -332,22 +332,9 @@ static struct ctl_table alignment_tbl[5] = {
 	{}
 };
 
-static struct ctl_table sysctl_table[2] = {
-	{
-	 .procname = "csky_alignment",
-	 .mode = 0555,
-	 .child = alignment_tbl},
-	{}
-};
-
-static struct ctl_path sysctl_path[2] = {
-	{.procname = "csky"},
-	{}
-};
-
 static int __init csky_alignment_init(void)
 {
-	register_sysctl_paths(sysctl_path, sysctl_table);
+	register_sysctl_init("csky/csky_alignment", alignment_tbl);
 	return 0;
 }
 
-- 
2.39.1

