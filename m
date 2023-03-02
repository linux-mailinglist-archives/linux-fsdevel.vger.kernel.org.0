Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05CB6A8AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCBUq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCBUqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:46:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB543937;
        Thu,  2 Mar 2023 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FdfA4hbd8rob4fQ8ALRTamLZAV/vYtVA6accqcc3SkE=; b=fhFYPSITeZQoANR5nzpZq4Y0OT
        BQwHzsCAGMKWCiIoSIoIot7NNKjVrWJ2csclbdX/OOhLJYxICH7Q27IOcnWVnqBV6tXuU8kS52aj/
        YqHN4NX4N7fDDw4Ys9oApL+1jemtpaghDeLGYs3gvxuvAl+0KPuQkX4VoZYK3yKfBN3VTD7lR+L5y
        zoheqXVFYPGrL8npa41ZLEY4CWXClu94akdIDtt8HOvD3vZ7MVf6ahgT4td72SzQ/DFF6hyJSXBYo
        SVjTazXdtUIiOEkwWaBbVYO6PEJRqGYpTuZBgGoMQZtE1KOOqHJdw0x9dSfjUV+NG5jW2pzVBmTGb
        MxuTRIgg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpoc-003HXS-K5; Thu, 02 Mar 2023 20:46:14 +0000
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
Subject: [PATCH 4/7] md: simplify sysctl registration
Date:   Thu,  2 Mar 2023 12:46:09 -0800
Message-Id: <20230302204612.782387-5-mcgrof@kernel.org>
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
 drivers/md/md.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 927a43db5dfb..546b1b81eb28 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -322,26 +322,6 @@ static struct ctl_table raid_table[] = {
 	{ }
 };
 
-static struct ctl_table raid_dir_table[] = {
-	{
-		.procname	= "raid",
-		.maxlen		= 0,
-		.mode		= S_IRUGO|S_IXUGO,
-		.child		= raid_table,
-	},
-	{ }
-};
-
-static struct ctl_table raid_root_table[] = {
-	{
-		.procname	= "dev",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= raid_dir_table,
-	},
-	{  }
-};
-
 static int start_readonly;
 
 /*
@@ -9650,7 +9630,7 @@ static int __init md_init(void)
 	mdp_major = ret;
 
 	register_reboot_notifier(&md_notifier);
-	raid_table_header = register_sysctl_table(raid_root_table);
+	raid_table_header = register_sysctl("dev/raid", raid_table);
 
 	md_geninit();
 	return 0;
-- 
2.39.1

