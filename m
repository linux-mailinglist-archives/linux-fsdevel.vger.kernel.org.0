Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2D6B55F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjCJXpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCJXpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:45:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A012B03A;
        Fri, 10 Mar 2023 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LMz951lH+GTlXBdT5Z97YwiBE8EmQ72In88ZwOJtlek=; b=OflQ0N4/CEo1p1GvnhPn14bpjg
        vmz+hv+Jy3oouD/nIf1Vs6OZVTZLHssU2qrv5wXv26MXvSDxbzSf/ixlaGq9di1FLc3Tt+NaldRzl
        gVkepqTIr+4FuiUK0XdHT/UeYiYo8Xp7YYrDphAe04rmoUut+n/Iv0DkWyLbvTbzbM7EwE2raaTmg
        3dD+DLd3lGYlD8qCF+wZi0zvK7gWAapuOSVbXih5eWvfZ/3xzZwVEzDLXlMO7Z2JZaY6eGW15pOaR
        CN27Hg3mEWxeTKsLrPi17eAX6fCPSZuiDaBT18bXXVPZtUwwUtLkxbZeNKuOONRADTL4BZLYiluq3
        ag/IEb0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamQS-00Gj2v-1v; Fri, 10 Mar 2023 23:45:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/6] s390: simplify one-level syctl registration for s390dbf_table
Date:   Fri, 10 Mar 2023 15:45:21 -0800
Message-Id: <20230310234525.3986352-3-mcgrof@kernel.org>
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
 arch/s390/kernel/debug.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b376f0377a2c..221c865785c2 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -981,16 +981,6 @@ static struct ctl_table s390dbf_table[] = {
 	{ }
 };
 
-static struct ctl_table s390dbf_dir_table[] = {
-	{
-		.procname	= "s390dbf",
-		.maxlen		= 0,
-		.mode		= S_IRUGO | S_IXUGO,
-		.child		= s390dbf_table,
-	},
-	{ }
-};
-
 static struct ctl_table_header *s390dbf_sysctl_header;
 
 /**
@@ -1574,7 +1564,7 @@ static int debug_sprintf_format_fn(debug_info_t *id, struct debug_view *view,
  */
 static int __init debug_init(void)
 {
-	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table);
+	s390dbf_sysctl_header = register_sysctl("s390dbf", s390dbf_table);
 	mutex_lock(&debug_mutex);
 	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT, NULL);
 	initialized = 1;
-- 
2.39.1

