Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4043F0687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhHROWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhHROWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:22:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E0C0612E7;
        Wed, 18 Aug 2021 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mg81CqRAZmZfDj14bc3WrVlEByj2jtQtmklitDTRhOU=; b=OTlOyB9WwcjLOvQvfh7xU2KCUc
        tiXAXSH66WT8kGH44M8eINhTDMYtmJCHyyzRr2MrVCIab9nXUGi25HOz5/J/fWaRIgT4orvVFk0aB
        ZQ4UsHzlhNnqydnsFLOYK2eZv3k9mQzxTWhVSRxHj9Qm2GtE1lH/YzxlQV4iFN/svLnRij9xvpwQv
        XZiUZaduenhMJfWN++HX0TCCsGuhlG3phL048CHZ9DNttvZXVss4lgOEvj4NRNDdbop1sP/wyZEng
        phL/yPMKJ1qmKZZ5mfW2xeCsX45unEKwDQIp8V4wNlVBAPqtwzZy21i+lVOEPzRwbHyRkZfipqmPL
        mO20Txyg==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMLF-003uhx-Uo; Wed, 18 Aug 2021 14:15:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 06/11] unicode: remove the unused utf8{,n}age{min,max} functions
Date:   Wed, 18 Aug 2021 16:06:46 +0200
Message-Id: <20210818140651.17181-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c | 113 -----------------------------------------
 fs/unicode/utf8n.h     |  16 ------
 2 files changed, 129 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 12abf89ae6ec..4b1b53391ce4 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -391,119 +391,6 @@ static utf8leaf_t *utf8lookup(const struct utf8data *data,
 	return utf8nlookup(data, hangul, s, (size_t)-1);
 }
 
-/*
- * Maximum age of any character in s.
- * Return -1 if s is not valid UTF-8 unicode.
- * Return 0 if only non-assigned code points are used.
- */
-int utf8agemax(const struct utf8data *data, const char *s)
-{
-	utf8leaf_t	*leaf;
-	int		age = 0;
-	int		leaf_age;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-
-	while (*s) {
-		leaf = utf8lookup(data, hangul, s);
-		if (!leaf)
-			return -1;
-
-		leaf_age = utf8agetab[LEAF_GEN(leaf)];
-		if (leaf_age <= data->maxage && leaf_age > age)
-			age = leaf_age;
-		s += utf8clen(s);
-	}
-	return age;
-}
-EXPORT_SYMBOL(utf8agemax);
-
-/*
- * Minimum age of any character in s.
- * Return -1 if s is not valid UTF-8 unicode.
- * Return 0 if non-assigned code points are used.
- */
-int utf8agemin(const struct utf8data *data, const char *s)
-{
-	utf8leaf_t	*leaf;
-	int		age;
-	int		leaf_age;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-	age = data->maxage;
-	while (*s) {
-		leaf = utf8lookup(data, hangul, s);
-		if (!leaf)
-			return -1;
-		leaf_age = utf8agetab[LEAF_GEN(leaf)];
-		if (leaf_age <= data->maxage && leaf_age < age)
-			age = leaf_age;
-		s += utf8clen(s);
-	}
-	return age;
-}
-EXPORT_SYMBOL(utf8agemin);
-
-/*
- * Maximum age of any character in s, touch at most len bytes.
- * Return -1 if s is not valid UTF-8 unicode.
- */
-int utf8nagemax(const struct utf8data *data, const char *s, size_t len)
-{
-	utf8leaf_t	*leaf;
-	int		age = 0;
-	int		leaf_age;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-
-	while (len && *s) {
-		leaf = utf8nlookup(data, hangul, s, len);
-		if (!leaf)
-			return -1;
-		leaf_age = utf8agetab[LEAF_GEN(leaf)];
-		if (leaf_age <= data->maxage && leaf_age > age)
-			age = leaf_age;
-		len -= utf8clen(s);
-		s += utf8clen(s);
-	}
-	return age;
-}
-EXPORT_SYMBOL(utf8nagemax);
-
-/*
- * Maximum age of any character in s, touch at most len bytes.
- * Return -1 if s is not valid UTF-8 unicode.
- */
-int utf8nagemin(const struct utf8data *data, const char *s, size_t len)
-{
-	utf8leaf_t	*leaf;
-	int		leaf_age;
-	int		age;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-	age = data->maxage;
-	while (len && *s) {
-		leaf = utf8nlookup(data, hangul, s, len);
-		if (!leaf)
-			return -1;
-		leaf_age = utf8agetab[LEAF_GEN(leaf)];
-		if (leaf_age <= data->maxage && leaf_age < age)
-			age = leaf_age;
-		len -= utf8clen(s);
-		s += utf8clen(s);
-	}
-	return age;
-}
-EXPORT_SYMBOL(utf8nagemin);
-
 /*
  * Length of the normalization of s.
  * Return -1 if s is not valid UTF-8 unicode.
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 85a7bebf6927..e4c8a767cf7a 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -33,22 +33,6 @@ int utf8version_is_supported(unsigned int version);
 extern const struct utf8data *utf8nfdi(unsigned int maxage);
 extern const struct utf8data *utf8nfdicf(unsigned int maxage);
 
-/*
- * Determine the maximum age of any unicode character in the string.
- * Returns 0 if only unassigned code points are present.
- * Returns -1 if the input is not valid UTF-8.
- */
-extern int utf8agemax(const struct utf8data *data, const char *s);
-extern int utf8nagemax(const struct utf8data *data, const char *s, size_t len);
-
-/*
- * Determine the minimum age of any unicode character in the string.
- * Returns 0 if any unassigned code points are present.
- * Returns -1 if the input is not valid UTF-8.
- */
-extern int utf8agemin(const struct utf8data *data, const char *s);
-extern int utf8nagemin(const struct utf8data *data, const char *s, size_t len);
-
 /*
  * Determine the length of the normalized from of the string,
  * excluding any terminating NULL byte.
-- 
2.30.2

