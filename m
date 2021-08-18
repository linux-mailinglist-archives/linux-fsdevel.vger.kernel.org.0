Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEEB3F068E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhHROXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhHROXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:23:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E14C07E5E0;
        Wed, 18 Aug 2021 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LK8VlrRcKR0O2tJY3isCs3pM/e17RyWbKPDimZLEThA=; b=SaqTl615icihQdyj6cH4ZebOOY
        CqeeoB06hXy/5ZM5skyZ78sQVNip29QpdM9j85yX/SFLsWLpUAcoPHIU/Gqt5VV7SJBuNhPZfUJ8Q
        g9hTb0kCU+dKAcmGLsmpywLzdu+EvYilR0Ivo5PWtGU56Uj2FFBlXzonIV0iHe2SWXyCdKOw3gpLI
        uP60aLYIigfzV5uKBoVLPrhGQjKRmmpKqHXiW8k9Bb6phAzpp7LsS2+kShH8tQ5ZEKNLwhc14+JP4
        I8P1rMGI+rnia2acIGH7zrH2dNt41qTZuaZ0Umdzua6iBCC8Kg+NQ1cMduVzkuNyK1idOLtn1pdyN
        2XLJzoIw==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMN1-003un9-7F; Wed, 18 Aug 2021 14:17:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 07/11] unicode: simplify utf8len
Date:   Wed, 18 Aug 2021 16:06:47 +0200
Message-Id: <20210818140651.17181-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the utf8nlen implementation with a (size_t)-1 len argument,
similar to utf8_lookup.  Also move the function to utf8-selftest.c, as
it isn't used anywhere else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c     | 30 ------------------------------
 fs/unicode/utf8-selftest.c |  5 +++++
 fs/unicode/utf8n.h         |  1 -
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 4b1b53391ce4..348d6e97553f 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -391,36 +391,6 @@ static utf8leaf_t *utf8lookup(const struct utf8data *data,
 	return utf8nlookup(data, hangul, s, (size_t)-1);
 }
 
-/*
- * Length of the normalization of s.
- * Return -1 if s is not valid UTF-8 unicode.
- *
- * A string of Default_Ignorable_Code_Point has length 0.
- */
-ssize_t utf8len(const struct utf8data *data, const char *s)
-{
-	utf8leaf_t	*leaf;
-	size_t		ret = 0;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-	while (*s) {
-		leaf = utf8lookup(data, hangul, s);
-		if (!leaf)
-			return -1;
-		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
-			ret += utf8clen(s);
-		else if (LEAF_CCC(leaf) == DECOMPOSE)
-			ret += strlen(LEAF_STR(leaf));
-		else
-			ret += utf8clen(s);
-		s += utf8clen(s);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(utf8len);
-
 /*
  * Length of the normalization of s, touch at most len bytes.
  * Return -1 if s is not valid UTF-8 unicode.
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 37f33890e012..80fb7c75acb2 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -160,6 +160,11 @@ static const struct {
 	}
 };
 
+static ssize_t utf8len(const struct utf8data *data, const char *s)
+{
+	return utf8nlen(data, s, (size_t)-1);
+}
+
 static void check_utf8_nfdi(void)
 {
 	int i;
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index e4c8a767cf7a..41182e5464df 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -39,7 +39,6 @@ extern const struct utf8data *utf8nfdicf(unsigned int maxage);
  * Returns 0 if only ignorable code points are present.
  * Returns -1 if the input is not valid UTF-8.
  */
-extern ssize_t utf8len(const struct utf8data *data, const char *s);
 extern ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len);
 
 /* Needed in struct utf8cursor below. */
-- 
2.30.2

