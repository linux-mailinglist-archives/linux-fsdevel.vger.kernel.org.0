Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F66A8AA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCBUqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCBUqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:46:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B94393C;
        Thu,  2 Mar 2023 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b/ElRNVyLTcjLcjUYbTcuyx0KXFL0MQ9s53W3J7Nkdk=; b=JCk7vmd3WPk/eusfOMOFOK2REk
        1XVuRYTKBgLvoHrvgM9QB8cHTbTgvan1wf+AtXio6deB/kkhZpQfQneT6nmVXKxIezrONKrOTELf3
        rmCdFYzMHmg0TONwR5JS3VZ4zjWOMvXxjMFqyI6psWBRhwrNFSzKCozLL3Y7WMmT9MwO2epJUmMn1
        nx1ETSbvwg/quZ3YXXD2gyOYG/pSUp1kP3DtHGRkmCdbO6zoWCzkVSo+qXR4XGbcXKmbNwBRWEY4U
        V/tsgcudL0zXWPh1vuYy3EMUxTm83D/qlj7qqRLAlpw6hkLDL5UQ5XuwLQuQCuAhQx5o/qgOt8lew
        PxDMLkug==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpoc-003HXW-Pv; Thu, 02 Mar 2023 20:46:14 +0000
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
Subject: [PATCH 6/7] tty: simplify sysctl registration
Date:   Thu,  2 Mar 2023 12:46:11 -0800
Message-Id: <20230302204612.782387-7-mcgrof@kernel.org>
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
register_sysctl_init() can do the directory creation for you so just use
that

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/tty/tty_io.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 36fb945fdad4..766750e355ac 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3614,31 +3614,13 @@ static struct ctl_table tty_table[] = {
 	{ }
 };
 
-static struct ctl_table tty_dir_table[] = {
-	{
-		.procname	= "tty",
-		.mode		= 0555,
-		.child		= tty_table,
-	},
-	{ }
-};
-
-static struct ctl_table tty_root_table[] = {
-	{
-		.procname	= "dev",
-		.mode		= 0555,
-		.child		= tty_dir_table,
-	},
-	{ }
-};
-
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 int __init tty_init(void)
 {
-	register_sysctl_table(tty_root_table);
+	register_sysctl_init("dev/tty", tty_table);
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
-- 
2.39.1

