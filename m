Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9236B5592
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjCJXYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjCJXYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:24:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047685CECC;
        Fri, 10 Mar 2023 15:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n3ibBOSHwLtyYWSPz4byfz4X1HpWIu7EDA2VdrWLfGg=; b=oY5BhI0UKiQJz+oVu3mMg8gY7t
        zqnqSgmo9/fkhKmgDQNJSot1ASq8dmZpKF3mHqTbtmtmRukQ/tB7GS1fAluaTbQfhd4TOlTqMapR5
        PPp1v2kxfb5Tqdx3/FAIg9O3eYr8KFWck+wdleTjGP4Dfsym9ZsKEUpRKs19Cz2nigJ8ilbF+zrIC
        /ZzQ3KQ2Ih8LAvctLYJv4LfZUEpXXms0Lmu3Wix/wtbK5SmHjF8VFe4zBfvTuQcL1dZWHikG+huRl
        yp5D0i3FpTXu5kH5iMkVSi4ZOoRVeNxM4PhFF7utzvjjCUfJkKJVAfmVtesXWAtp2oqeOqc99R+U9
        Sc/kDHhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pam5w-00Gbr0-MM; Fri, 10 Mar 2023 23:24:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-ia64@vger.kernel.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] ia64: simplify one-level sysctl registration for kdump_ctl_table
Date:   Fri, 10 Mar 2023 15:24:16 -0800
Message-Id: <20230310232416.3958751-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
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

There is no need to declare an extra tables to just create directory,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

If ia64 is not removed from the kernel feel free to take this or I can
take it through sysctl-next.

 arch/ia64/kernel/crash.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 76730f34685c..88b3ce3e66cd 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -234,15 +234,6 @@ static struct ctl_table kdump_ctl_table[] = {
 	},
 	{ }
 };
-
-static struct ctl_table sys_table[] = {
-	{
-	  .procname = "kernel",
-	  .mode = 0555,
-	  .child = kdump_ctl_table,
-	},
-	{ }
-};
 #endif
 
 static int
@@ -257,7 +248,7 @@ machine_crash_setup(void)
 	if((ret = register_die_notifier(&kdump_init_notifier_nb)) != 0)
 		return ret;
 #ifdef CONFIG_SYSCTL
-	register_sysctl_table(sys_table);
+	register_sysctl("kernel", kdump_ctl_table);
 #endif
 	return 0;
 }
-- 
2.39.1

