Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A486B55AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjCJXdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCJXdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:33:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AC01C33B;
        Fri, 10 Mar 2023 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6kH6TW9SCm4CLG1162nEiEpjHId+0HDM53xsYqrk2ko=; b=yGbOtkBdkzK9DR156GfevBSavx
        FYxKQ0mZtsA/is4KPevTGXX2qJxIYCpqi6VgnqI+fdhnym3lNLbRanuNJeqnnoqmejhfroeLjiino
        aRF6BiD2irVm0dG8eoZ9EYsumPf2pqT5R7d3kEdxkt+hf6M3FV4Ofw2wzT1TFz6wpzfwAZspCxvXQ
        LW8taDDQMdlMYLsSp7CKbhzoSvY4DQf84b4lTQGLpbMMx+Nflr7EwZmFrZvMH6X0Hu2ty+2CUoe0E
        R96x6oFljugKD+xZq9+PV+Oct9cjnU/nYSGo9hFeJLJZ1G1DkfK8xYw84tzAawP8u1KWBjQr1HIbh
        2yf1nvBQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamED-00Gdb3-W6; Fri, 10 Mar 2023 23:32:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] x86: simplify one-level sysctl registration for itmt_kern_table
Date:   Fri, 10 Mar 2023 15:32:48 -0800
Message-Id: <20230310233248.3965389-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310233248.3965389-1-mcgrof@kernel.org>
References: <20230310233248.3965389-1-mcgrof@kernel.org>
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
 arch/x86/kernel/itmt.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9ff480e94511..670eb08b972a 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -77,15 +77,6 @@ static struct ctl_table itmt_kern_table[] = {
 	{}
 };
 
-static struct ctl_table itmt_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= itmt_kern_table,
-	},
-	{}
-};
-
 static struct ctl_table_header *itmt_sysctl_header;
 
 /**
@@ -114,7 +105,7 @@ int sched_set_itmt_support(void)
 		return 0;
 	}
 
-	itmt_sysctl_header = register_sysctl_table(itmt_root_table);
+	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
 	if (!itmt_sysctl_header) {
 		mutex_unlock(&itmt_update_mutex);
 		return -ENOMEM;
-- 
2.39.1

