Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC136B5587
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjCJXWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCJXWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:22:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A5115656;
        Fri, 10 Mar 2023 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Vl75lOivwxRd2Gq7JNUD53sjLJaqgVHzQJHDdO+38Jc=; b=fSLTvqIpq4dw1JrHrXBJ7039LX
        4ywebvj4dFbVA3TjRRJuPgWV9StjK8zXQ+a33IdDsS2fX/Q4QMGirL1WDRqizNZaVxL5GOW/eEKcH
        knTkNc3fPmnsodNzCJSQadU7ceRhoWNXvAXAs42kFHGQFUWyqoveZ9fBzX/NNfX8HVOjxC8jM3sha
        Fh4x1QLHlaygVz3C8Z86xLsrXpJTorZ9XEO5EPD694G1HxD2WxvbNUGi6mI9cGTPiwWzuF97RmKfc
        dOJl8U0pKM/8OMtSaGldSYx7rtCmXJF6/pjxFkUfmKc4VNxBgosIrj9LkAOyJaDzbbf5sArUfdQ7w
        taZI1tcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pam3b-00GbRI-Jz; Fri, 10 Mar 2023 23:21:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     ebiederm@xmission.com, linux-crypto@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] crypto: simplify one-level sysctl registration for crypto_sysctl_table
Date:   Fri, 10 Mar 2023 15:21:50 -0800
Message-Id: <20230310232150.3957148-1-mcgrof@kernel.org>
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

If not clear, see this new doc:

https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

But the skinny is we can deprecate long term APIs from sysctl that
uses recursion.

 crypto/fips.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/crypto/fips.c b/crypto/fips.c
index b05d3c7b3ca5..92fd506abb21 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -66,20 +66,11 @@ static struct ctl_table crypto_sysctl_table[] = {
 	{}
 };
 
-static struct ctl_table crypto_dir_table[] = {
-	{
-		.procname       = "crypto",
-		.mode           = 0555,
-		.child          = crypto_sysctl_table
-	},
-	{}
-};
-
 static struct ctl_table_header *crypto_sysctls;
 
 static void crypto_proc_fips_init(void)
 {
-	crypto_sysctls = register_sysctl_table(crypto_dir_table);
+	crypto_sysctls = register_sysctl("crypto", crypto_sysctl_table);
 }
 
 static void crypto_proc_fips_exit(void)
-- 
2.39.1

