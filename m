Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1834B00D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 23:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiBIW6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 17:58:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiBIW6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:58:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A02E05113C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nsugG1aY+eCV3xlkrk9fdkpQvS4e16AIEQdzKJsZfK0=; b=daub91PuaAEbq9mkC1I+mm3kxp
        zkteLGgmOu2NZBYNtimuI26b+fBB5cDQpydvkd2bDH1fiTVQkxvlN1i+MWfk6mTFXLIY3SczCe0Gp
        Qev1s+ueRXIfgMSchWNuVoxZzGomu3S1eArpAPaBMVJ+ii/1isU16MHLL2gBbyxHcqHmwG81aAM0B
        xGpANUUSCOSDrk2XfN5r35oV9jqY8zSiLStv3RZ5mbqYMi0JMfngkm1IuRc9s5rtWugJ4xB3zMR6d
        /XMODoy8e4MnOZNEqdSXHLjPuHob3bRTx2sD78tlvabeH3j9CmqOsUmEaMsAbSNr9iuxtWnyPQSXg
        HP/xp6/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvuV-00202h-2s; Wed, 09 Feb 2022 22:58:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com
Cc:     linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Luis Chamberlain <mcgrof@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] fs: move binfmt_misc sysctl to its own file as built-in
Date:   Wed,  9 Feb 2022 14:57:58 -0800
Message-Id: <20220209225758.476724-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the second attempt to move binfmt_misc sysctl to its
own file. The issue with the first move was that we moved
the binfmt_misc sysctls to the binfmt_misc module, but the
way things work on some systems is that the binfmt_misc
module will load if the sysctl is present. If we don't force
the sysctl on, the module won't load. The proper thing to do
is to register the sysctl if the module was built or the
binfmt_misc code was built-in, we do this by using the helper
IS_ENABLED() now.

The rationale for the move:

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

This moves the binfmt_misc sysctl to its own file to help remove clutter
from kernel/sysctl.c.

Cc: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: Tong Zhang <ztong0001@gmail.com>
Reviewed-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Andrew,

If we get tested-by from Domenico and Tong I think this is ready.

Demenico, Tong, can you please test this patch? Linus' tree
should already have all the prior work reverted as Domenico requested
so this starts fresh.

 fs/file_table.c |  2 ++
 kernel/sysctl.c | 13 -------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 57edef16dce4..4969021fa676 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -119,6 +119,8 @@ static struct ctl_table fs_stat_sysctls[] = {
 static int __init init_fs_stat_sysctls(void)
 {
 	register_sysctl_init("fs", fs_stat_sysctls);
+	if (IS_ENABLED(CONFIG_BINFMT_MISC))
+		register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 fs_initcall(init_fs_stat_sysctls);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 241cfc6bc36f..788b9a34d5ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] = {
 	{ }
 };
 
-static struct ctl_table fs_table[] = {
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	{
-		.procname	= "binfmt_misc",
-		.mode		= 0555,
-		.child		= sysctl_mount_point,
-	},
-#endif
-	{ }
-};
-
 static struct ctl_table debug_table[] = {
 #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
 	{
@@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] = {
 
 DECLARE_SYSCTL_BASE(kernel, kern_table);
 DECLARE_SYSCTL_BASE(vm, vm_table);
-DECLARE_SYSCTL_BASE(fs, fs_table);
 DECLARE_SYSCTL_BASE(debug, debug_table);
 DECLARE_SYSCTL_BASE(dev, dev_table);
 
@@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
 {
 	register_sysctl_base(kernel);
 	register_sysctl_base(vm);
-	register_sysctl_base(fs);
 	register_sysctl_base(debug);
 	register_sysctl_base(dev);
 
-- 
2.34.1

