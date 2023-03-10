Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887A6B55AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCJXdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjCJXdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:33:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919D1C328;
        Fri, 10 Mar 2023 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=W5CkyZqwpXK0guxscdXqblrjimKCSpeT3+UESPQJLyc=; b=jaGse98W/kVZnbkxIDlAa5Drtm
        ECzv1p4Va1Hgmq7iQInbYEWIWvG0pU3LUqjB7qxhyWsFe4plRrao8z4nx91dk03I/JOV8xTn9WZSI
        Ck0ltx/i1X071oSNI6mK4vYVD7EW7qT28k10RGrJy3sSkZ9WQjtl15yeQJQR0i8zWxFWmt1soS/EO
        s6Iybcdyqzkn9FQzrTTYGuritihgr9N2iHV+sZMvBJgCo9thoieew7QXBQA1M3r2rkBwvC/+v9kVw
        2WDNkESPCXQlstFXilVEN2DwjsZsU1VpPXXo/1HSZmC0beYK1x8hrsqCpocYLNk7bfwRPky4ukBzL
        RtR+37YA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamED-00Gdb1-UP; Fri, 10 Mar 2023 23:32:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] x86: simplify one-level sysctl registration for abi_table2
Date:   Fri, 10 Mar 2023 15:32:47 -0800
Message-Id: <20230310233248.3965389-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310233248.3965389-1-mcgrof@kernel.org>
References: <20230310233248.3965389-1-mcgrof@kernel.org>
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
 arch/x86/entry/vdso/vdso32-setup.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 3b300a773c7e..f3b3cacbcbb0 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -70,18 +70,9 @@ static struct ctl_table abi_table2[] = {
 	{}
 };
 
-static struct ctl_table abi_root_table2[] = {
-	{
-		.procname = "abi",
-		.mode = 0555,
-		.child = abi_table2
-	},
-	{}
-};
-
 static __init int ia32_binfmt_init(void)
 {
-	register_sysctl_table(abi_root_table2);
+	register_sysctl("abi", abi_table2);
 	return 0;
 }
 __initcall(ia32_binfmt_init);
-- 
2.39.1

