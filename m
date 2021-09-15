Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F540C015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhIOHGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbhIOHGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:06:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CDAC061574;
        Wed, 15 Sep 2021 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KsXmrjpfDbdjzrGejtWFdupij1XDA15Xpdjwg03hmRI=; b=P8pkxQb0U7MXKXnzkyWaxqWkjC
        Mju5qarOanGVfohSXL+XJd+HyPQO9vWgTxTnvKjctM8rrf2mLNktH6n9Vdxy7BenoqFaXVYNySr1Z
        siiyojnVbHZ8T8D1tD+ySrkjRc2MM14ukh6qZyC8vGEIw0nxv5j21Q6GVQrhfYSStzaXVe9ZRAJyp
        Zoet7JmYxAMuAkQRXlqQC/54cbUUsspA8ViXDaVL3FiijizLdVb0A91Um018/ZVPXBkyIcmuemQVO
        YglqEUSGzl6LayT0cHdQXo3YnloaMqp5x9LxE0Su699a2OuYHhBjrwxgtGuVZgBj6AGmoitJ9Cn8q
        pMfAiBNw==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOyE-00FRdX-DU; Wed, 15 Sep 2021 07:04:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 06/11] unicode: remove the unused utf8{,n}age{min,max} functions
Date:   Wed, 15 Sep 2021 09:00:01 +0200
Message-Id: <20210915070006.954653-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
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
index 12abf89ae6eca..4b1b53391ce4b 100644
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
index 85a7bebf69275..e4c8a767cf7a5 100644
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

