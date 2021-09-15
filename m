Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A440C01F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhIOHIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhIOHIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CDC061574;
        Wed, 15 Sep 2021 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6OPFUqW/e7vubD4u/iFL4D4EShCGd15ditWyTiZVzcg=; b=rNI1M4cQEZ7nw/T7h4zQmqhG8w
        xc5M0lxSkAa9a03MMgv7aK9MoF8jdjVsD8b2qes0/i8gU9aMpwPDxoxVdlTrGBziodeNYLNKTJr5G
        RtsrLtytoJKmjEqaP5BnTFSo1xAMSeTdhlvP7mOpCbiA7bGeQ2nU8PkZOkjIOTw1z2ta7SvjH9Zdu
        LMAHkx8ed2ouF7M28Dl0xnAYeJOqWVzLvRieNGvVDB94XAk/n4pfq5DrnjpXptcwzae/ndPo6oumy
        cZgWn7HTg3T14Y4QEp+eQpBW+uSG06RtxM64j7/Lp6WzeZRq3pjoAkj3E+O3I67VXRMTFwyXVOefP
        eXhvczeg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOyp-00FRgx-Vs; Wed, 15 Sep 2021 07:05:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 07/11] unicode: simplify utf8len
Date:   Wed, 15 Sep 2021 09:00:02 +0200
Message-Id: <20210915070006.954653-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
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
index 4b1b53391ce4b..348d6e97553f2 100644
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
index 37f33890e012f..80fb7c75acb28 100644
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
index e4c8a767cf7a5..41182e5464dfa 100644
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

