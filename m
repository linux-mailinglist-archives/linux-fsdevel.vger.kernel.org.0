Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028C3189152
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 23:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCQW0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 18:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgCQW0a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:26:30 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB9920770;
        Tue, 17 Mar 2020 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483989;
        bh=4k6KBBn76eVZsFSeQRaasQ+3DSNYdmTUZZs6bJU4Vhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcinbrpGXPhXFPtgVDx67OBRJkkJLC76CkkTiVX7ZDuuRVlJ3EDoPDieDiflWfX5N
         d9Ehg3RUcXWMGWr1kVLev8heFv0MpmvYyDWpnjqAZwYrOS0FiITSRgc9t0I53ak5Ba
         7NcvR2Ma1BHHfUNWD84QKMubI8yeU/ctrGSZzpC8=
Received: by pali.im (Postfix)
        id EAEDC700; Tue, 17 Mar 2020 23:26:27 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] exfat: Simplify exfat_utf8_d_cmp() for code points above U+FFFF
Date:   Tue, 17 Mar 2020 23:25:53 +0100
Message-Id: <20200317222555.29974-3-pali@kernel.org>
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

If two Unicode code points represented in UTF-16 are different then also
their UTF-32 representation must be different. Therefore conversion from
UTF-32 to UTF-16 is not needed.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/exfat/namei.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e0ec4ff366f5..f07cab5fcd28 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -179,14 +179,9 @@ static int exfat_utf8_d_cmp(const struct dentry *dentry, unsigned int len,
 		if (u_a <= 0xFFFF && u_b <= 0xFFFF) {
 			if (exfat_toupper(sb, u_a) != exfat_toupper(sb, u_b))
 				return 1;
-		} else if (u_a > 0xFFFF && u_b > 0xFFFF) {
-			if (exfat_low_surrogate(u_a) !=
-					exfat_low_surrogate(u_b) ||
-			    exfat_high_surrogate(u_a) !=
-					exfat_high_surrogate(u_b))
-				return 1;
 		} else {
-			return 1;
+			if (u_a != u_b)
+				return 1;
 		}
 	}
 
-- 
2.20.1

