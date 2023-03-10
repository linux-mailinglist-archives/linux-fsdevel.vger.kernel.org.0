Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA896B55F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCJXqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjCJXpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:45:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CFD12B7D3;
        Fri, 10 Mar 2023 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N5vx1FBpbc8LlYLlnu7qtqpLSHJPRrla5oNVHVuiKnI=; b=IK/npqdfvhyNAJvSI8r427YlNX
        RSVirLCMWv4Rr8iJyWSYktDBdNXsX1ZR+c6rhA0TmzDEkh3Vcrp/uF0UQJ+utUs5tPGi+F4VP4/rU
        tSdo7bRWz1clO+u+ufJTqZ2YzDinsFuuvFpcigeJ/rU6oLLooGaUqIWgOrdA9XPMxcLBFzUL273aU
        iyqelPcFo9CDdxyxD/7ANzhY92cyIPXjB9mTxx4+ZDErTgZq8xgYjWNpZaI12xLAImgh9S3imGmzk
        0mHwKUcM2B/suuA5MX+v2xKZ6AsD0nHJx/RB10Ka3C+9yGPPsrFJDtJWv7ZI12vaqmPNlCLlUgMzm
        12IlGySA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamQS-00Gj31-5G; Fri, 10 Mar 2023 23:45:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, sudipm.mukherjee@gmail.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/6] s390: simplify one level sysctl registration for cmm_table
Date:   Fri, 10 Mar 2023 15:45:23 -0800
Message-Id: <20230310234525.3986352-5-mcgrof@kernel.org>
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
 arch/s390/mm/cmm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 9141ed4c52e9..5300c6867d5e 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -335,16 +335,6 @@ static struct ctl_table cmm_table[] = {
 	{ }
 };
 
-static struct ctl_table cmm_dir_table[] = {
-	{
-		.procname	= "vm",
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= cmm_table,
-	},
-	{ }
-};
-
 #ifdef CONFIG_CMM_IUCV
 #define SMSG_PREFIX "CMM"
 static void cmm_smsg_target(const char *from, char *msg)
@@ -389,7 +379,7 @@ static int __init cmm_init(void)
 {
 	int rc = -ENOMEM;
 
-	cmm_sysctl_header = register_sysctl_table(cmm_dir_table);
+	cmm_sysctl_header = register_sysctl("vm", cmm_table);
 	if (!cmm_sysctl_header)
 		goto out_sysctl;
 #ifdef CONFIG_CMM_IUCV
-- 
2.39.1

