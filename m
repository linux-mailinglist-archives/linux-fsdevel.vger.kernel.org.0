Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB906B55EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCJXpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCJXpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:45:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480712B007;
        Fri, 10 Mar 2023 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BdtDngCz11vLEZXj7V3uC9J00TCr9KSXBOiIikCKO7U=; b=Tmh2ag0sjCovH4EJWWQwXdUxX+
        tenwk94A3/aExZGoKIycS4E/qwjvw6GBoYfMCn+Ts3UWB9Q8IxsFLVsKIEwRsQCRy1HU5h3V4Z2zz
        m6HJNegAhauwIIB4ZysU9UXzB0vIIFo8xoHYNHWY3rTbktsNh6Qr2xDGTUm3R7SFdhWczzwQX5pY6
        CyimNzOoggaPYT46Z0oKm+CeOxCyVPQoniSfJes2rWunXJYH4vwzDGa1nFKSDTPJrdC2vHFw1AHDJ
        4e7fnVs6H7XBkt3r5su+QCXMkzc1rIdlikYOzfLgGyR/qXn/dg+OnpFliqe0hMsZ0lQfyhZns9S1N
        P7aN9aeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamQS-00Gj2r-0b; Fri, 10 Mar 2023 23:45:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/6] s390: simplify one-level sysctl registration for topology_ctl_table
Date:   Fri, 10 Mar 2023 15:45:20 -0800
Message-Id: <20230310234525.3986352-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310234525.3986352-1-mcgrof@kernel.org>
References: <20230310234525.3986352-1-mcgrof@kernel.org>
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
 arch/s390/kernel/topology.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..e5d6a1c25d13 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -637,16 +637,6 @@ static struct ctl_table topology_ctl_table[] = {
 	{ },
 };
 
-static struct ctl_table topology_dir_table[] = {
-	{
-		.procname	= "s390",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= topology_ctl_table,
-	},
-	{ },
-};
-
 static int __init topology_init(void)
 {
 	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
@@ -654,7 +644,7 @@ static int __init topology_init(void)
 		set_topology_timer();
 	else
 		topology_update_polarization_simple();
-	register_sysctl_table(topology_dir_table);
+	register_sysctl("s390", topology_ctl_table);
 	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
 }
 device_initcall(topology_init);
-- 
2.39.1

