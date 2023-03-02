Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270C66A8AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCBUqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBUqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:46:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8A43937;
        Thu,  2 Mar 2023 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dtfyNVshuDQIj+dlbLKUh3FrBpHjPuB+OiDl4kHMg0w=; b=y+/KNE5d+TW3hH8L9Iql5pMuDY
        mtQ2q1980lq3pkwG/xQP1LmilCyPNzezGqF7q0DG5V7xsGEwDTYwL1JvJCDFTe/zRXH57HGHD5QW/
        O8UeGtO2rrvC7q1JiYXTkhaSl2XwOkiMf9u7Bw475hl1I50DYfKypH7bafzPo/5auQO5nAWWpyMzo
        gGUrJvFV6cuTyc3hE4lyn5hDmXOrOPtNk1IXXmXNQPVhLjpjwJ7GPmbWttNzvSv3PP/4O3nghH0oh
        Q9RypKa5XuLJaNXMpBIQPO6xY6fjA5jHIzzVMBlTxnFZ6w8BOSv37SOKMsJSXJC05q7iNhPjFZil9
        SHo+B+Mg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpoc-003HXY-T5; Thu, 02 Mar 2023 20:46:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, minyard@acm.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, song@kernel.org, robinmholt@gmail.com,
        steve.wahl@hpe.com, mike.travis@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        xen-devel@lists.xenproject.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 7/7] xen: simplify sysctl registration for balloon
Date:   Thu,  2 Mar 2023 12:46:12 -0800
Message-Id: <20230302204612.782387-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302204612.782387-1-mcgrof@kernel.org>
References: <20230302204612.782387-1-mcgrof@kernel.org>
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

register_sysctl_table() is a deprecated compatibility wrapper.
register_sysctl_init() can do the directory creation for you so just
use that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/xen/balloon.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 617a7f4f07a8..586a1673459e 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -97,24 +97,6 @@ static struct ctl_table balloon_table[] = {
 	{ }
 };
 
-static struct ctl_table balloon_root[] = {
-	{
-		.procname	= "balloon",
-		.mode		= 0555,
-		.child		= balloon_table,
-	},
-	{ }
-};
-
-static struct ctl_table xen_root[] = {
-	{
-		.procname	= "xen",
-		.mode		= 0555,
-		.child		= balloon_root,
-	},
-	{ }
-};
-
 #else
 #define xen_hotplug_unpopulated 0
 #endif
@@ -747,7 +729,7 @@ static int __init balloon_init(void)
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 	set_online_page_callback(&xen_online_page);
 	register_memory_notifier(&xen_memory_nb);
-	register_sysctl_table(xen_root);
+	register_sysctl_init("xen/balloon", balloon_table);
 #endif
 
 	balloon_add_regions();
-- 
2.39.1

