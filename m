Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B7B6B559A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCJX3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCJX3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:29:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D312D494;
        Fri, 10 Mar 2023 15:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8/k/0g/cnB7JjkrJw62pfw7YETy2O4gsL5oxM2+sWXg=; b=nd7BSFiHFERaOSa0SJThwAwJMS
        bbXewyZgxa0XeZgYNC33U2n/qLEgBIMD3UDzFrq4bIhCUC6jfGewKah3QT/gLm6j/tVgx95ergkqv
        cahwvJB84yGe0Dhc+eq7pRz53STsCK/3l2EmN/Ab17V2/29GQ8N4ozL7ZXYGYrZnLmKoqe9lrYnyp
        wlha/IAEtdmNGOxHTq0h/Zao0/oKC3/+UfKw9n7uNq1ZJuULPtANW8MgD4VEuKSFrH2RK3Z69LpfE
        STv+MNARqOh7s0E1BKlBlhNmrBa+WarhclejAJ//sijYv5s4H1LJ7RH57DJdHauD+nqLPxMkbPLKx
        Dq3odsMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamAN-00GcMA-32; Fri, 10 Mar 2023 23:28:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] ppc: simplify one-level sysctl registration for nmi_wd_lpm_factor_ctl_table
Date:   Fri, 10 Mar 2023 15:28:50 -0800
Message-Id: <20230310232850.3960676-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230310232850.3960676-1-mcgrof@kernel.org>
References: <20230310232850.3960676-1-mcgrof@kernel.org>
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
 arch/powerpc/platforms/pseries/mobility.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 4cea71aa0f41..2b58e76abef8 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -62,18 +62,10 @@ static struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
 	},
 	{}
 };
-static struct ctl_table nmi_wd_lpm_factor_sysctl_root[] = {
-	{
-		.procname       = "kernel",
-		.mode           = 0555,
-		.child          = nmi_wd_lpm_factor_ctl_table,
-	},
-	{}
-};
 
 static int __init register_nmi_wd_lpm_factor_sysctl(void)
 {
-	register_sysctl_table(nmi_wd_lpm_factor_sysctl_root);
+	register_sysctl("kernel", nmi_wd_lpm_factor_ctl_table);
 
 	return 0;
 }
-- 
2.39.1

