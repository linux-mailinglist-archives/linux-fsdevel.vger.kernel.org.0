Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9733F0690
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbhHROXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbhHROXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628FC06122F;
        Wed, 18 Aug 2021 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XRJcay04c4+HGP8hA0k71ugb0TyE1umxocLGpm5yt80=; b=iVm0ncHopjP/X9nEmDSlzFnERU
        JKbD0lCGfy7zwAjuiKHB3s5gAxtodQVEZDAjn+Gfn/4dm2VXdzxQhP8PWZ8Zoe4ReKH21Zv6sH1bW
        QmEvKCjp501xWmFSz51Bi1HpWBxQScfahXr/7jACyvcd5MpImceC7PByna31Z7Vh19bZGqJvXhnt2
        xKBMfyWNHJ30rXvh0R9pZfwvfBa/Mzq2K/EVeiHRYbLWyrJpz8s15qSJdsGGh45/sZb+u/bJZ+/NG
        nkE/R1+VDD3bafiXiyn8PuW9kcnC7Tspn9v0MszsilEv545lvAJKyijYWBr8jaArsDB3DHCMMe2P1
        mcmP3XxQ==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMOU-003uwG-4s; Wed, 18 Aug 2021 14:18:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 08/11] unicode: move utf8cursor to utf8-selftest.c
Date:   Wed, 18 Aug 2021 16:06:48 +0200
Message-Id: <20210818140651.17181-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only used by the tests, so no need to keep it in the core.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c     | 16 ----------------
 fs/unicode/utf8-selftest.c |  6 ++++++
 fs/unicode/utf8n.h         |  2 --
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 348d6e97553f..1ac90fa00070 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -456,22 +456,6 @@ int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
 }
 EXPORT_SYMBOL(utf8ncursor);
 
-/*
- * Set up an utf8cursor for use by utf8byte().
- *
- *   u8c    : pointer to cursor.
- *   data   : const struct utf8data to use for normalization.
- *   s      : NUL-terminated string.
- *
- * Returns -1 on error, 0 on success.
- */
-int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
-	       const char *s)
-{
-	return utf8ncursor(u8c, data, s, (unsigned int)-1);
-}
-EXPORT_SYMBOL(utf8cursor);
-
 /*
  * Get one byte from the normalized form of the string described by u8c.
  *
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 80fb7c75acb2..04628b50351d 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -165,6 +165,12 @@ static ssize_t utf8len(const struct utf8data *data, const char *s)
 	return utf8nlen(data, s, (size_t)-1);
 }
 
+static int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
+		const char *s)
+{
+	return utf8ncursor(u8c, data, s, (unsigned int)-1);
+}
+
 static void check_utf8_nfdi(void)
 {
 	int i;
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 41182e5464df..736b6460a38c 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -65,8 +65,6 @@ struct utf8cursor {
  * Returns 0 on success.
  * Returns -1 on failure.
  */
-extern int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
-		      const char *s);
 extern int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
 		       const char *s, size_t len);
 
-- 
2.30.2

