Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63F6B5568
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCJXRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCJXRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:17:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB1DBF9;
        Fri, 10 Mar 2023 15:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pgG6wYlLqJqvOJPF09LlwBdJHikie1Bdz5Z0msFQ56w=; b=TkhZQ2cn7q9bRC5SaYpuPU/sGh
        xEaOEmXy+0FpiXlLGjGcIbaxqiMxVQidMvumKg3n2TynZ3ZrSduuLIced1VHPCaYbbzqihJRv3foY
        oeLwO/0oLXTpdPsahHbMorMbWfGRHqN5bpN72J/qRsrCO4wYsgp/aGVdAiu5lcoDIOxQ5G3AHoWEy
        mXE852Anb7wm0aaiBirm7KOVdJYo1cY/BpWVrOkp4v4F25COfBsQb9xUH3kX2l0ScmCnSYcHqOkDH
        KE+rIsMUlk9qZYM/y++Cyc4lv7ipARhlgSfusrravVsNnwmEInWIrsph01SN/Cy/ppaOcB6HgIKoZ
        rZFNY/JQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1palyr-00GatI-5f; Fri, 10 Mar 2023 23:16:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     pvorel@suse.cz, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, keescook@chromium.org, Jason@zx2c4.com
Cc:     ebiederm@xmission.com, yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] utsname: simplify one-level sysctl registration for uts_kern_table
Date:   Fri, 10 Mar 2023 15:16:56 -0800
Message-Id: <20230310231656.3955051-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
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

This is part of the effort to phase out calls that can recurse from
sysctl registration [0]. If you have a tree to take this in feel free
to take it, or I can take it too through sysclt-next. Let me know!

This file has no explicit maintainer, so I assume there is no tree.

If I so no one taking it I can take in as part of sysctl-next later.

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u

 kernel/utsname_sysctl.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
index f50398cb790d..019e3a1566cf 100644
--- a/kernel/utsname_sysctl.c
+++ b/kernel/utsname_sysctl.c
@@ -123,15 +123,6 @@ static struct ctl_table uts_kern_table[] = {
 	{}
 };
 
-static struct ctl_table uts_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= uts_kern_table,
-	},
-	{}
-};
-
 #ifdef CONFIG_PROC_SYSCTL
 /*
  * Notify userspace about a change in a certain entry of uts_kern_table,
@@ -147,7 +138,7 @@ void uts_proc_notify(enum uts_proc proc)
 
 static int __init utsname_sysctl_init(void)
 {
-	register_sysctl_table(uts_root_table);
+	register_sysctl("kernel", uts_kern_table);
 	return 0;
 }
 
-- 
2.39.1

