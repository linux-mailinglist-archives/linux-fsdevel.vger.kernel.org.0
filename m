Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469406A8AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCBUq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCBUqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:46:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3DD457CF;
        Thu,  2 Mar 2023 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MXqH7HxuGUp4vr/6baVHWsjCOA7cvGA5MJGn2lYMgHY=; b=Wn18YuHvszFD95jKeWngGibMfk
        m0dkZQ/T4wh0lgQnmNyqnPNU8wiR3wNNIOFAQ/uJApiYoYiCX6W4rfGp9dazoMtM2bwoM+0WBiCNC
        Zufdri5+sD3Q341upVXgIu1muzt5P4Jq3In7jEXridJQdLINYWC/lbJZRuwwbCAPQbiRw2Gifn7PV
        5l4S/BZ9ufO6qSJiEuCDouaynQw+hbOCQIXagyqfer/Tf0CgxPlq9N55pKEXLUt0GgP9bjK+YI+um
        6CZGflx9Hg4Q3sGl2wesUq57AAJ6djo3BjCYRDNYjrv49f8LE+JOOtmq1J70LFUnI4mMWXgd2vQ2k
        0Y7scWbg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpoc-003HXO-Df; Thu, 02 Mar 2023 20:46:14 +0000
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
Subject: [PATCH 2/7] ipmi: simplify sysctl registration
Date:   Thu,  2 Mar 2023 12:46:07 -0800
Message-Id: <20230302204612.782387-3-mcgrof@kernel.org>
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
register_sysctl() can do the directory creation for you so just use
that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/char/ipmi/ipmi_poweroff.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 163ec9749e55..870659d91db2 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -659,20 +659,6 @@ static struct ctl_table ipmi_table[] = {
 	{ }
 };
 
-static struct ctl_table ipmi_dir_table[] = {
-	{ .procname	= "ipmi",
-	  .mode		= 0555,
-	  .child	= ipmi_table },
-	{ }
-};
-
-static struct ctl_table ipmi_root_table[] = {
-	{ .procname	= "dev",
-	  .mode		= 0555,
-	  .child	= ipmi_dir_table },
-	{ }
-};
-
 static struct ctl_table_header *ipmi_table_header;
 #endif /* CONFIG_PROC_FS */
 
@@ -689,7 +675,7 @@ static int __init ipmi_poweroff_init(void)
 		pr_info("Power cycle is enabled\n");
 
 #ifdef CONFIG_PROC_FS
-	ipmi_table_header = register_sysctl_table(ipmi_root_table);
+	ipmi_table_header = register_sysctl("dev/ipmi", ipmi_table);
 	if (!ipmi_table_header) {
 		pr_err("Unable to register powercycle sysctl\n");
 		rv = -ENOMEM;
-- 
2.39.1

