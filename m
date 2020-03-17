Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D567189153
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 23:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCQW0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 18:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQW0d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:26:33 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671B420752;
        Tue, 17 Mar 2020 22:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483992;
        bh=/i2vwW7x+lULf2jKqs7l5ljBtw14lm8sygArd3aDPg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/fj6pDm6AvSNBZ8X0eht/rA5I0u6k80Srot55tJ4D0LI91IqqRxrxoKM2TeBpz6h
         B20mKCSrGO+sw8vHcx3XskI7YAwr5T2MWY7GUFIZwFkmna2zDMskPjB99VbnL8/z8w
         ANC/q/5mb3gmt1fN8y/Z7d9OVwMGJCuDsSb6SYo8=
Received: by pali.im (Postfix)
        id 9E80E700; Tue, 17 Mar 2020 23:26:30 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] exfat: Remove unused functions exfat_high_surrogate() and exfat_low_surrogate()
Date:   Tue, 17 Mar 2020 23:25:54 +0100
Message-Id: <20200317222555.29974-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317222555.29974-1-pali@kernel.org>
References: <20200317222555.29974-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After applying previous two patches, these functions are not used anymore.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/exfat/exfat_fs.h |  2 --
 fs/exfat/nls.c      | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 67d4e46fb810..8a176a803206 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -492,8 +492,6 @@ int exfat_nls_to_utf16(struct super_block *sb,
 		struct exfat_uni_name *uniname, int *p_lossy);
 int exfat_create_upcase_table(struct super_block *sb);
 void exfat_free_upcase_table(struct exfat_sb_info *sbi);
-unsigned short exfat_high_surrogate(unicode_t u);
-unsigned short exfat_low_surrogate(unicode_t u);
 
 /* exfat/misc.c */
 void __exfat_fs_error(struct super_block *sb, int report, const char *fmt, ...)
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 6d1c3ae130ff..e3a9f5e08f68 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -537,22 +537,9 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 	return unilen;
 }
 
-#define PLANE_SIZE	0x00010000
 #define SURROGATE_MASK	0xfffff800
 #define SURROGATE_PAIR	0x0000d800
 #define SURROGATE_LOW	0x00000400
-#define SURROGATE_BITS	0x000003ff
-
-unsigned short exfat_high_surrogate(unicode_t u)
-{
-	return ((u - PLANE_SIZE) >> 10) + SURROGATE_PAIR;
-}
-
-unsigned short exfat_low_surrogate(unicode_t u)
-{
-	return ((u - PLANE_SIZE) & SURROGATE_BITS) | SURROGATE_PAIR |
-		SURROGATE_LOW;
-}
 
 static int __exfat_utf16_to_nls(struct super_block *sb,
 		struct exfat_uni_name *p_uniname, unsigned char *p_cstring,
-- 
2.20.1

