Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043776B555C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCJXNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCJXND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:13:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506F9028;
        Fri, 10 Mar 2023 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KO2HxTUOZzbjQ3y76wpSpZnZj3+bp1GiNAt8DWUNdxU=; b=k6dL7lF5h50jRNr0sP1WQeyO2+
        eYsLqyIE9wANrimmvLh1SLKSaKAQLXJUk1alQIuj4XBGvJRj9uRieruhcs+U6SV+HR+VvPc1UPSuY
        OCc8YZiS6Kb6vpacPRdCb765jGYyQ6mzFufMLIU/iSRNrAp5CXlIIMcmb0RuF4weYhUKE0HejaRS4
        jhrpz+NLg0h7aljcxQP1MoA91eAVuC2Z15E+ZXUHvRkn9mDApq0e9at52A/DmXtjojSQ7Fenv5WEO
        k+NlhBWmlWjDlx6pKRtetpvCU+1DPxNSA7GfdJg2p1cN+xRBYPPZpZa9blNrjwlGC0KgFPyFFinA6
        UUi2v2Bw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paluB-00GaJN-BZ; Fri, 10 Mar 2023 23:12:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5/5] ntfs: simplfy one-level sysctl registration for ntfs_sysctls
Date:   Fri, 10 Mar 2023 15:12:06 -0800
Message-Id: <20230310231206.3952808-6-mcgrof@kernel.org>
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
 fs/ntfs/sysctl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index a030d00af90c..174fe536a1c0 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -31,16 +31,6 @@ static struct ctl_table ntfs_sysctls[] = {
 	{}
 };
 
-/* Define the parent directory /proc/sys/fs. */
-static struct ctl_table sysctls_root[] = {
-	{
-		.procname	= "fs",
-		.mode		= 0555,
-		.child		= ntfs_sysctls
-	},
-	{}
-};
-
 /* Storage for the sysctls header. */
 static struct ctl_table_header *sysctls_root_table;
 
@@ -54,7 +44,7 @@ int ntfs_sysctl(int add)
 {
 	if (add) {
 		BUG_ON(sysctls_root_table);
-		sysctls_root_table = register_sysctl_table(sysctls_root);
+		sysctls_root_table = register_sysctl("fs", ntfs_sysctls);
 		if (!sysctls_root_table)
 			return -ENOMEM;
 	} else {
-- 
2.39.1

