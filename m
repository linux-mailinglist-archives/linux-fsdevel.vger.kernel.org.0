Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311E340C003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhIOHEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhIOHEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:04:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FBC061574;
        Wed, 15 Sep 2021 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VKaffHFWSRm/yCMplD53VSse+hztiHYRn8PjIcWPpKM=; b=uj0Ofy7XgP6OgXzPjYT8sCdKLc
        NyBvXZ86VKghnXyKlkxoMWuRNlBSau2Cr0BiTRWjUDSRpnAawHCTSILZdvrnFSxd3moUbiGYM8vy2
        c2Tfs81/1HqrptgNOsTQawhO7eYpM537/9imvqmO2kTcuzm/IqqLEqxaEovwfBC58+sqT7XajvSOR
        xmvYVaPxQXYGMV8dEdtqoaltpm2wXWY9CTVK3Wm2ADGfmee+MHxTpKo5rKZSiKHX4y3uvfstGK0sa
        GGbxM6FNbNZKbmPafz0eN7lmthZBfKG2ElatGu44y2ZSy3RJtINa9QxVnhlNYXN7qT3Q7sus+FNwa
        LgQYwCnw==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOvd-00FRXp-O7; Wed, 15 Sep 2021 07:02:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 03/11] unicode: remove the charset field from struct unicode_map
Date:   Wed, 15 Sep 2021 08:59:58 +0200
Message-Id: <20210915070006.954653-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is hardcoded and only used for a f2fs sysfs file where it can be
hardcoded just as easily.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/sysfs.c         | 3 +--
 fs/unicode/utf8-core.c  | 3 ---
 include/linux/unicode.h | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a32fe31c33b8e..650e84398f744 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -196,8 +196,7 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 	struct super_block *sb = sbi->sb;
 
 	if (f2fs_sb_has_casefold(sbi))
-		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
-			sb->s_encoding->charset,
+		return snprintf(buf, PAGE_SIZE, "UTF-8 (%d.%d.%d)\n",
 			(sb->s_encoding->version >> 16) & 0xff,
 			(sb->s_encoding->version >> 8) & 0xff,
 			sb->s_encoding->version & 0xff);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed96..86f42a078d99b 100644
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
index 74484d44c7554..6a392cd9f076d 100644
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

