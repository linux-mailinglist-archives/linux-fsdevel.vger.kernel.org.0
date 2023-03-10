Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7906B55F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCJXp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCJXpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:45:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159DB12B942;
        Fri, 10 Mar 2023 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nHMN7uwZ1jz4t3b3KbBdxN2XO9S9Ia12wFzWNFd3opY=; b=3GDvwXXQTMtsfQLNqy0vJ3E8tc
        6n7irTuEwDXgM6CQLVv8I1yk6aK+TDHsXV86/H2xr6+YRZTiP0ByLSm8F7t8FVREr2m4jd5VaVRLa
        Rq63/fdFYH5SdwcxIz+v2kxZC7QiYkwwbQ8/BlfNQxBOncdyV5fuBBUsPxkWc7+xlY7t9OAy/aBGs
        +vpbqjiAfwhDgDAxTemRveRQB+7DdGJCae8xMhSFN1OAYe0bsNxr0zQW94wypu6N3TY3zyKGSdFFS
        vbDpisKqOX1y+h6VL7kC1FIRNbL4ZUHRIcIdZ1Y+AIi/5E1eM5nmaM/J5JAsEeniE9bUanhpP4xCZ
        ddqDO9xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamQS-00Gj33-7A; Fri, 10 Mar 2023 23:45:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/6] s390: simplify one-level sysctl registration for page_table_sysctl
Date:   Fri, 10 Mar 2023 15:45:24 -0800
Message-Id: <20230310234525.3986352-6-mcgrof@kernel.org>
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
 arch/s390/mm/pgalloc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 2de48b2c1b04..0f68b7257e08 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -33,19 +33,9 @@ static struct ctl_table page_table_sysctl[] = {
 	{ }
 };
 
-static struct ctl_table page_table_sysctl_dir[] = {
-	{
-		.procname	= "vm",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= page_table_sysctl,
-	},
-	{ }
-};
-
 static int __init page_table_register_sysctl(void)
 {
-	return register_sysctl_table(page_table_sysctl_dir) ? 0 : -ENOMEM;
+	return register_sysctl("vm", page_table_sysctl) ? 0 : -ENOMEM;
 }
 __initcall(page_table_register_sysctl);
 
-- 
2.39.1

