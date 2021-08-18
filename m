Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD163F05E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhHROMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhHROMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:12:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C6C061764;
        Wed, 18 Aug 2021 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W/CqL+1UTR7dYoG9/tA55jo9OSLvjLN7QCowW5Mp68U=; b=Ob7acBy/jQh0420cin743NdF+s
        UWZ1A9nQSG04dgymqMMAv+PEvVUwZSQkWsEiEZlHToY7VsbpEiPphSrmj8xK2ikXME/M/EmM1r6my
        pCKz4ad/Gh2bEQYXoOqR31skqwjgyfizT4+VatB5LbN++nNw9KuIJaVT2XgQsHmEfcyCWpoCtAXdY
        YpyvpxP1pTkR0QDadcDp/29hIqmgaQJvD3lphDl0dZPH5FsPNuoeniI10yvofWcGET5AkYcLMiesT
        cuxYLsBdGDfJTizYUHTUMigkijH4+m+O+4GwwYUJtb8R5MyU/JdOcycglLhCvYy25/klgsWiWNYre
        ar/bBM8A==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMH5-003uVF-4y; Wed, 18 Aug 2021 14:11:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 03/11] unicode: remove the charset field from struct unicode_map
Date:   Wed, 18 Aug 2021 16:06:43 +0200
Message-Id: <20210818140651.17181-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is hardcoded and only used for a f2fs sysfs file where it can be
hardcoded just as easily.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/sysfs.c         | 3 +--
 fs/unicode/utf8-core.c  | 3 ---
 include/linux/unicode.h | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..d9ecf75e445d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -195,8 +195,7 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 	struct super_block *sb = sbi->sb;
 
 	if (f2fs_sb_has_casefold(sbi))
-		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
-			sb->s_encoding->charset,
+		return snprintf(buf, PAGE_SIZE, "UTF-8 (%d.%d.%d)\n",
 			(sb->s_encoding->version >> 16) & 0xff,
 			(sb->s_encoding->version >> 8) & 0xff,
 			sb->s_encoding->version & 0xff);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed9..86f42a078d99 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -219,10 +219,7 @@ struct unicode_map *utf8_load(const char *version)
 	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
 	if (!um)
 		return ERR_PTR(-ENOMEM);
-
-	um->charset = "UTF-8";
 	um->version = unicode_version;
-
 	return um;
 }
 EXPORT_SYMBOL(utf8_load);
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 74484d44c755..6a392cd9f076 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -6,7 +6,6 @@
 #include <linux/dcache.h>
 
 struct unicode_map {
-	const char *charset;
 	int version;
 };
 
-- 
2.30.2

