Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590CA6B555E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjCJXNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCJXND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:13:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3896C151;
        Fri, 10 Mar 2023 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9kwFCfwOIqZ8Cdb+WBuaqm9+ckdViHa0b9t6sNQLN/s=; b=R88tOJvPjmUunQU7dZm8jO9RCR
        l90YURDFXcS3uhgoLjy2AsuPdkqFCaUXepuIa3HeeX8QIN9KUe0HRtEEyJ8RIgLZfWK/8xY6pRk7J
        mYi9s18nulh+IGbd/oTDJF4ljHi0EmMXlTHpxvL0tim0eRzoD0vy/Leoz94bP/WqIQI6xR3RSZb9O
        ZpNoP6DKThNQPgVtkJXudFNIr0nN/aLro0Hpn7rzqJl8sNb2L0OcxeiWafdFIfswJzX4gkY8kkuOn
        epEKcW/dR8hUe0UAgZi92hDM6ly1bNcuU7lEoN3MmWPyoVsm8fec3LVqZhDenNKv5U9dXg8TbVrbl
        ukJY/clg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paluB-00GaJD-6J; Fri, 10 Mar 2023 23:12:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/5] fs/cachefiles: simplify one-level sysctl registration for cachefiles_sysctls
Date:   Fri, 10 Mar 2023 15:12:02 -0800
Message-Id: <20230310231206.3952808-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310231206.3952808-1-mcgrof@kernel.org>
References: <20230310231206.3952808-1-mcgrof@kernel.org>
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
 fs/cachefiles/error_inject.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
index 58f8aec964e4..18de8a876b02 100644
--- a/fs/cachefiles/error_inject.c
+++ b/fs/cachefiles/error_inject.c
@@ -22,18 +22,9 @@ static struct ctl_table cachefiles_sysctls[] = {
 	{}
 };
 
-static struct ctl_table cachefiles_sysctls_root[] = {
-	{
-		.procname	= "cachefiles",
-		.mode		= 0555,
-		.child		= cachefiles_sysctls,
-	},
-	{}
-};
-
 int __init cachefiles_register_error_injection(void)
 {
-	cachefiles_sysctl = register_sysctl_table(cachefiles_sysctls_root);
+	cachefiles_sysctl = register_sysctl("cachefiles", cachefiles_sysctls);
 	if (!cachefiles_sysctl)
 		return -ENOMEM;
 	return 0;
-- 
2.39.1

