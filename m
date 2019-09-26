Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B03BEE53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfIZJVU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 05:21:20 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25461 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfIZJVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:21:20 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 05:21:19 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1569488751; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=j9hJPeSEFOyEzZdx7YMosQVOurAlCYD5ZpqOQbxNSatNGiXhe+7gC8mco6BggGYZqleTmOBPVRML+8cqzW7YgUVhp8cVOh5qerNhvmb9G7uBgadHjagx944d5y+DmQ8Pe5oCBcGLUuzu+QXaoie+u5aw7kCHMaOmC6UTLQ+CRp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569488751; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=kUYFipe9t17hI+mhfvxZ6NTVPVX2Qy1+eViJ87bmXuU=; 
        b=KaCpt1Fq+PwOa/4Xjar6EN6ih7jOJCh/X89jq1nYPChinvjkFK+BxBFIwBpaCtzaYmVZeXYl4985/G2kgMqiUUOI2w/IEUbj4T6q5WSJpGus2KDbaO+XhELVpyeTIfGbYc4V4qDtEQdcWGUT+XidQnriCjvIdzEEiy5GRV5UiAk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1569488749870923.5349215485212; Thu, 26 Sep 2019 17:05:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190926090535.3470-1-cgxu519@zoho.com.cn>
Subject: [PATCH] dcookies.c: code cleanup for hash_bits calculation in dcookie_init()
Date:   Thu, 26 Sep 2019 17:05:35 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Code cleanup for hash_bits calculation by calling
ilog2() in dcookie_init().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/dcookies.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/dcookies.c b/fs/dcookies.c
index 6eeb61100a09..4c3253926b55 100644
--- a/fs/dcookies.c
+++ b/fs/dcookies.c
@@ -245,11 +245,7 @@ static int dcookie_init(void)
 	 * a power-of-two.
 	 */
 	hash_size = PAGE_SIZE / sizeof(struct list_head);
-	hash_bits = 0;
-	do {
-		hash_bits++;
-	} while ((hash_size >> hash_bits) != 0);
-	hash_bits--;
+	hash_bits = ilog2(hash_size);
 
 	/*
 	 * Re-calculate the actual number of entries and the mask
-- 
2.20.1



