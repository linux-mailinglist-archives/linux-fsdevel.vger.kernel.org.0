Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99486B55B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCJXfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCJXfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:35:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104D13F685;
        Fri, 10 Mar 2023 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hPK/fuqWGb+L/yq0FoqZh+t2EUt8CyQKsPoCgU3n1N4=; b=WyfomRn9EHkdBQ+D/rCj4zc+2d
        r1EkjoZHO3xPwW9cM6oVpfstEGHHLjaz7SIF2ztkAnQJE1Iz67ybBYXnt5DbPlwRcLyxjBM7CdK6Z
        3G5wGOORt71OnSCkdt+LgvoPKi4hcWBiV0dRwd4UzJodzpMlrsIL0mxYojGnHLBp2MajyRA2MubuA
        hqPgTuwbAXnWNGtKuQFgphJrHQVW+KbudGfyvVmrwvtwbGPfT8+VXPevRh/qAW17qFfMUVWMWO53n
        UJuLTolXNEXGWjwbq+fBz6npkmEEP+5V+5VoYdJtYiote9/eo/NXh0Sx1pGmtx5XMhtw7EX4O7sUd
        zzMRjGsw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamGh-00GfIo-DK; Fri, 10 Mar 2023 23:35:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] arm: simplify two-level sysctl registration for ctl_isa_vars
Date:   Fri, 10 Mar 2023 15:35:21 -0800
Message-Id: <20230310233521.3971907-1-mcgrof@kernel.org>
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

There is no need to declare two tables to just create directories,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

For more details see the new docs being updated [0].

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

 arch/arm/kernel/isa.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
index d8a509c5d5bd..20218876bef2 100644
--- a/arch/arm/kernel/isa.c
+++ b/arch/arm/kernel/isa.c
@@ -40,27 +40,11 @@ static struct ctl_table ctl_isa_vars[4] = {
 
 static struct ctl_table_header *isa_sysctl_header;
 
-static struct ctl_table ctl_isa[2] = {
-	{
-		.procname	= "isa",
-		.mode		= 0555,
-		.child		= ctl_isa_vars,
-	}, {}
-};
-
-static struct ctl_table ctl_bus[2] = {
-	{
-		.procname	= "bus",
-		.mode		= 0555,
-		.child		= ctl_isa,
-	}, {}
-};
-
 void __init
 register_isa_ports(unsigned int membase, unsigned int portbase, unsigned int portshift)
 {
 	isa_membase = membase;
 	isa_portbase = portbase;
 	isa_portshift = portshift;
-	isa_sysctl_header = register_sysctl_table(ctl_bus);
+	isa_sysctl_header = register_sysctl("bus/isa", ctl_isa_vars);
 }
-- 
2.39.1

