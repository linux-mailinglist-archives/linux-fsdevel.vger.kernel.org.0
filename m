Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7B34959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfFDNtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40246 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sUkt16DkNGaeDaDUlJpBnU7+k9eoZf/1/V7fgVyS4AI=; b=ED9JSnJw1mxPBfZ1w6FPy4AuaV
        8/+jwTXE3kPInNnYymgn1HYFWofqZ2b7J7rAWOshi7N5eRcqjGyI6hqJQ7xitgO2nYM/t3iaGenVy
        uFztXDK35AAkXteVK7rt5dynDDtRTIVpkH1hetVvsXaL35HSOHF13hcgS6KQQ3sj1hhgRcc9m8D+C
        1HbTHyitBE/JKO7LXC4Ph+ZcI5LaBZHfsBBmcUKEcgNEmMKcdHBnLZ79Q3KditSG5EWlQCNIIZBt+
        y9EhvBGPO/fl6DQ7V19TMrxU1VJ2jdCtFH7E2tdSy0ag6FOa6rNACL78x/INGpqN9ddDlwAJXOpLz
        kkiZtWuQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34824 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9ox-0001bL-Qk; Tue, 04 Jun 2019 14:49:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9ox-00084j-5S; Tue, 04 Jun 2019 14:49:47 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] fs/adfs: use %pV for error messages
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9ox-00084j-5S@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:47 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than using vsnprintf() with a temporary buffer on the stack, use
%pV to print error messages.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 26b4b66df2c7..f35db5d64c17 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -24,16 +24,18 @@
 
 void __adfs_error(struct super_block *sb, const char *function, const char *fmt, ...)
 {
-	char error_buf[128];
+	struct va_format vaf;
 	va_list args;
 
 	va_start(args, fmt);
-	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
-	va_end(args);
+	vaf.fmt = fmt;
+	vaf.va = &args;
 
-	printk(KERN_CRIT "ADFS-fs error (device %s)%s%s: %s\n",
+	printk(KERN_CRIT "ADFS-fs error (device %s)%s%s: %pV\n",
 		sb->s_id, function ? ": " : "",
-		function ? function : "", error_buf);
+		function ? function : "", &vaf);
+
+	va_end(args);
 }
 
 static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
-- 
2.7.4

