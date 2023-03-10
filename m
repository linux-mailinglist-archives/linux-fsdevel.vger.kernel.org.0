Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F476B5557
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCJXNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCJXM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:12:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F94490;
        Fri, 10 Mar 2023 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vwgcdlyuo+GJ5jvlI6ItnonZwvRm0XCG4SGb6jgIIUk=; b=dMTygatsLoA/2mFiksWRScl55F
        vdQLDay0b6L3bB/x+/odyMiMicp6eud00Iajv04D2ddWCyvWiafl9OIo5tou8FIOsvyLu16ZBB50x
        swGL2v8tqMw0P8jJEYy3/QzIRKcd88WHrFDx0Hv1gO8EwjgzhCItc5tQj3tyBcAWXcibMN7A1fcgA
        SMwQlmrB5SHEVnl6ReEcNznTdZurq/VPVJdZc9Pr6iaGLKObUHughlIWS1F9ChW5GGv5RfBNQ8vom
        VXqAaYigO9jd4r/iE6KHoTCdsFfRQOb4LmAAkwcxo/oeY0KwFQxHUMFl+uFQq94ITAjN2zgaZNmLM
        IvKM80xQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paluB-00GaJL-AJ; Fri, 10 Mar 2023 23:12:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/5] coda: simplify one-level sysctl registration for coda_table
Date:   Fri, 10 Mar 2023 15:12:05 -0800
Message-Id: <20230310231206.3952808-5-mcgrof@kernel.org>
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
 fs/coda/sysctl.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index fda3b702b1c5..a247c14aaab7 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -39,19 +39,10 @@ static struct ctl_table coda_table[] = {
 	{}
 };
 
-static struct ctl_table fs_table[] = {
-	{
-		.procname	= "coda",
-		.mode		= 0555,
-		.child		= coda_table
-	},
-	{}
-};
-
 void coda_sysctl_init(void)
 {
 	if ( !fs_table_header )
-		fs_table_header = register_sysctl_table(fs_table);
+		fs_table_header = register_sysctl("coda", coda_table);
 }
 
 void coda_sysctl_clean(void)
-- 
2.39.1

