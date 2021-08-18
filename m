Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A63F0699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhHROYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbhHROXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:23:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC190C0363D0;
        Wed, 18 Aug 2021 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SOc3r12UbZImhOQ8XI/e2k7Id25YwiW68M0eNb04T5g=; b=aVYPf0Yv7/DrYZZGznvRz4N3Zz
        MzuHRHjOp3Jfr63w2xHHOj93ep5ePbrEsZKIzwZCzQIoWan+SZjKbEtRcr1ygM0dB0gttYn40uBDB
        pXRAqbc3b/V24aAEZntF/I97VFA6eVmknwwnARiISK75FbdK/bMSkNW/Vo4IYLtTmss6FQlBO8qFr
        mBM/gag7oJVWe6Doakt/njXKeU4yIrYEztXoMmtDcGk4QcrxE04zYDnRIt6Cd7+nMpm0DQWNejQ4u
        FRrq+OoJ1E4j6R66BY/1myMaOxlx3GslCq4F6kIG9jpejMuC2U+WOXS+xkPB5RwI+1+5GvI8HwEfH
        UaEVg7bA==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMPY-003v2s-J9; Wed, 18 Aug 2021 14:19:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 09/11] unicode: cache the normalization tables in struct unicode_map
Date:   Wed, 18 Aug 2021 16:06:49 +0200
Message-Id: <20210818140651.17181-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of repeatedly looking up the version add pointers to the
NFD and NFD+CF tables to struct unicode_map, and pass a
unicode_map plus index to the functions using the normalization
tables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-core.c     | 37 +++++++++---------
 fs/unicode/utf8-norm.c     | 45 ++++++++++-----------
 fs/unicode/utf8-selftest.c | 80 ++++++++++++++++----------------------
 fs/unicode/utf8n.h         | 10 +++--
 include/linux/unicode.h    | 19 +++++++++
 5 files changed, 97 insertions(+), 94 deletions(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dca2865c3bee..d9f713d38c0a 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -5,16 +5,13 @@
 #include <linux/slab.h>
 #include <linux/parser.h>
 #include <linux/errno.h>
-#include <linux/unicode.h>
 #include <linux/stringhash.h>
 
 #include "utf8n.h"
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str)
 {
-	const struct utf8data *data = utf8nfdi(um->version);
-
-	if (utf8nlen(data, str->name, str->len) < 0)
+	if (utf8nlen(um, UTF8_NFDI, str->name, str->len) < 0)
 		return -1;
 	return 0;
 }
@@ -23,14 +20,13 @@ EXPORT_SYMBOL(utf8_validate);
 int utf8_strncmp(const struct unicode_map *um,
 		 const struct qstr *s1, const struct qstr *s2)
 {
-	const struct utf8data *data = utf8nfdi(um->version);
 	struct utf8cursor cur1, cur2;
 	int c1, c2;
 
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+	if (utf8ncursor(&cur1, um, UTF8_NFDI, s1->name, s1->len) < 0)
 		return -EINVAL;
 
-	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
+	if (utf8ncursor(&cur2, um, UTF8_NFDI, s2->name, s2->len) < 0)
 		return -EINVAL;
 
 	do {
@@ -50,14 +46,13 @@ EXPORT_SYMBOL(utf8_strncmp);
 int utf8_strncasecmp(const struct unicode_map *um,
 		     const struct qstr *s1, const struct qstr *s2)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur1, cur2;
 	int c1, c2;
 
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+	if (utf8ncursor(&cur1, um, UTF8_NFDICF, s1->name, s1->len) < 0)
 		return -EINVAL;
 
-	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
+	if (utf8ncursor(&cur2, um, UTF8_NFDICF, s2->name, s2->len) < 0)
 		return -EINVAL;
 
 	do {
@@ -81,12 +76,11 @@ int utf8_strncasecmp_folded(const struct unicode_map *um,
 			    const struct qstr *cf,
 			    const struct qstr *s1)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur1;
 	int c1, c2;
 	int i = 0;
 
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+	if (utf8ncursor(&cur1, um, UTF8_NFDICF, s1->name, s1->len) < 0)
 		return -EINVAL;
 
 	do {
@@ -105,11 +99,10 @@ EXPORT_SYMBOL(utf8_strncasecmp_folded);
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur;
 	size_t nlen = 0;
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+	if (utf8ncursor(&cur, um, UTF8_NFDICF, str->name, str->len) < 0)
 		return -EINVAL;
 
 	for (nlen = 0; nlen < dlen; nlen++) {
@@ -128,12 +121,11 @@ EXPORT_SYMBOL(utf8_casefold);
 int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
 		       struct qstr *str)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
 	struct utf8cursor cur;
 	int c;
 	unsigned long hash = init_name_hash(salt);
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+	if (utf8ncursor(&cur, um, UTF8_NFDICF, str->name, str->len) < 0)
 		return -EINVAL;
 
 	while ((c = utf8byte(&cur))) {
@@ -149,11 +141,10 @@ EXPORT_SYMBOL(utf8_casefold_hash);
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
-	const struct utf8data *data = utf8nfdi(um->version);
 	struct utf8cursor cur;
 	ssize_t nlen = 0;
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+	if (utf8ncursor(&cur, um, UTF8_NFDI, str->name, str->len) < 0)
 		return -EINVAL;
 
 	for (nlen = 0; nlen < dlen; nlen++) {
@@ -180,7 +171,17 @@ struct unicode_map *utf8_load(unsigned int version)
 	if (!um)
 		return ERR_PTR(-ENOMEM);
 	um->version = version;
+	um->ntab[UTF8_NFDI] = utf8nfdi(version);
+	if (!um->ntab[UTF8_NFDI])
+		goto out_free_um;
+	um->ntab[UTF8_NFDICF] = utf8nfdicf(version);
+	if (!um->ntab[UTF8_NFDICF])
+		goto out_free_um;
 	return um;
+
+out_free_um:
+	kfree(um);
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL(utf8_load);
 
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 1ac90fa00070..7c1f28ab31a8 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -309,21 +309,19 @@ utf8hangul(const char *str, unsigned char *hangul)
  * is well-formed and corresponds to a known unicode code point.  The
  * shorthand for this will be "is valid UTF-8 unicode".
  */
-static utf8leaf_t *utf8nlookup(const struct utf8data *data,
-			       unsigned char *hangul, const char *s, size_t len)
+static utf8leaf_t *utf8nlookup(const struct unicode_map *um,
+		enum utf8_normalization n, unsigned char *hangul, const char *s,
+		size_t len)
 {
-	utf8trie_t	*trie = NULL;
+	utf8trie_t	*trie = utf8data + um->ntab[n]->offset;
 	int		offlen;
 	int		offset;
 	int		mask;
 	int		node;
 
-	if (!data)
-		return NULL;
 	if (len == 0)
 		return NULL;
 
-	trie = utf8data + data->offset;
 	node = 1;
 	while (node) {
 		offlen = (*trie & OFFLEN) >> OFFLEN_SHIFT;
@@ -385,29 +383,28 @@ static utf8leaf_t *utf8nlookup(const struct utf8data *data,
  *
  * Forwards to utf8nlookup().
  */
-static utf8leaf_t *utf8lookup(const struct utf8data *data,
-			      unsigned char *hangul, const char *s)
+static utf8leaf_t *utf8lookup(const struct unicode_map *um,
+		enum utf8_normalization n, unsigned char *hangul, const char *s)
 {
-	return utf8nlookup(data, hangul, s, (size_t)-1);
+	return utf8nlookup(um, n, hangul, s, (size_t)-1);
 }
 
 /*
  * Length of the normalization of s, touch at most len bytes.
  * Return -1 if s is not valid UTF-8 unicode.
  */
-ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len)
+ssize_t utf8nlen(const struct unicode_map *um, enum utf8_normalization n,
+		const char *s, size_t len)
 {
 	utf8leaf_t	*leaf;
 	size_t		ret = 0;
 	unsigned char	hangul[UTF8HANGULLEAF];
 
-	if (!data)
-		return -1;
 	while (len && *s) {
-		leaf = utf8nlookup(data, hangul, s, len);
+		leaf = utf8nlookup(um, n, hangul, s, len);
 		if (!leaf)
 			return -1;
-		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
+		if (utf8agetab[LEAF_GEN(leaf)] > um->ntab[n]->maxage)
 			ret += utf8clen(s);
 		else if (LEAF_CCC(leaf) == DECOMPOSE)
 			ret += strlen(LEAF_STR(leaf));
@@ -430,14 +427,13 @@ EXPORT_SYMBOL(utf8nlen);
  *
  * Returns -1 on error, 0 on success.
  */
-int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
-		const char *s, size_t len)
+int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
+		enum utf8_normalization n, const char *s, size_t len)
 {
-	if (!data)
-		return -1;
 	if (!s)
 		return -1;
-	u8c->data = data;
+	u8c->um = um;
+	u8c->n = n;
 	u8c->s = s;
 	u8c->p = NULL;
 	u8c->ss = NULL;
@@ -512,9 +508,9 @@ int utf8byte(struct utf8cursor *u8c)
 
 		/* Look up the data for the current character. */
 		if (u8c->p) {
-			leaf = utf8lookup(u8c->data, u8c->hangul, u8c->s);
+			leaf = utf8lookup(u8c->um, u8c->n, u8c->hangul, u8c->s);
 		} else {
-			leaf = utf8nlookup(u8c->data, u8c->hangul,
+			leaf = utf8nlookup(u8c->um, u8c->n, u8c->hangul,
 					   u8c->s, u8c->len);
 		}
 
@@ -524,7 +520,8 @@ int utf8byte(struct utf8cursor *u8c)
 
 		ccc = LEAF_CCC(leaf);
 		/* Characters that are too new have CCC 0. */
-		if (utf8agetab[LEAF_GEN(leaf)] > u8c->data->maxage) {
+		if (utf8agetab[LEAF_GEN(leaf)] >
+		    u8c->um->ntab[u8c->n]->maxage) {
 			ccc = STOPPER;
 		} else if (ccc == DECOMPOSE) {
 			u8c->len -= utf8clen(u8c->s);
@@ -538,7 +535,7 @@ int utf8byte(struct utf8cursor *u8c)
 				goto ccc_mismatch;
 			}
 
-			leaf = utf8lookup(u8c->data, u8c->hangul, u8c->s);
+			leaf = utf8lookup(u8c->um, u8c->n, u8c->hangul, u8c->s);
 			if (!leaf)
 				return -1;
 			ccc = LEAF_CCC(leaf);
@@ -611,7 +608,6 @@ const struct utf8data *utf8nfdi(unsigned int maxage)
 		return NULL;
 	return &utf8nfdidata[i];
 }
-EXPORT_SYMBOL(utf8nfdi);
 
 const struct utf8data *utf8nfdicf(unsigned int maxage)
 {
@@ -623,4 +619,3 @@ const struct utf8data *utf8nfdicf(unsigned int maxage)
 		return NULL;
 	return &utf8nfdicfdata[i];
 }
-EXPORT_SYMBOL(utf8nfdicf);
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 04628b50351d..cfa3832b75f4 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -18,9 +18,7 @@ unsigned int failed_tests;
 unsigned int total_tests;
 
 /* Tests will be based on this version. */
-#define latest_maj 12
-#define latest_min 1
-#define latest_rev 0
+#define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
 
 #define _test(cond, func, line, fmt, ...) do {				\
 		total_tests++;						\
@@ -160,29 +158,22 @@ static const struct {
 	}
 };
 
-static ssize_t utf8len(const struct utf8data *data, const char *s)
+static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n,
+		const char *s)
 {
-	return utf8nlen(data, s, (size_t)-1);
+	return utf8nlen(um, n, s, (size_t)-1);
 }
 
-static int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
-		const char *s)
+static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
+		enum utf8_normalization n, const char *s)
 {
-	return utf8ncursor(u8c, data, s, (unsigned int)-1);
+	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
 }
 
-static void check_utf8_nfdi(void)
+static void check_utf8_nfdi(struct unicode_map *um)
 {
 	int i;
 	struct utf8cursor u8c;
-	const struct utf8data *data;
-
-	data = utf8nfdi(UNICODE_AGE(latest_maj, latest_min, latest_rev));
-	if (!data) {
-		pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		int len = strlen(nfdi_test_data[i].str);
@@ -190,10 +181,11 @@ static void check_utf8_nfdi(void)
 		int j = 0;
 		unsigned char c;
 
-		test((utf8len(data, nfdi_test_data[i].str) == nlen));
-		test((utf8nlen(data, nfdi_test_data[i].str, len) == nlen));
+		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
+		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
+			nlen));
 
-		if (utf8cursor(&u8c, data, nfdi_test_data[i].str) < 0)
+		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
 			pr_err("can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
@@ -207,18 +199,10 @@ static void check_utf8_nfdi(void)
 	}
 }
 
-static void check_utf8_nfdicf(void)
+static void check_utf8_nfdicf(struct unicode_map *um)
 {
 	int i;
 	struct utf8cursor u8c;
-	const struct utf8data *data;
-
-	data = utf8nfdicf(UNICODE_AGE(latest_maj, latest_min, latest_rev));
-	if (!data) {
-		pr_err("%s: Unable to load utf8-%d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
 		int len = strlen(nfdicf_test_data[i].str);
@@ -226,10 +210,13 @@ static void check_utf8_nfdicf(void)
 		int j = 0;
 		unsigned char c;
 
-		test((utf8len(data, nfdicf_test_data[i].str) == nlen));
-		test((utf8nlen(data, nfdicf_test_data[i].str, len) == nlen));
+		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
+				nlen));
+		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
+				nlen));
 
-		if (utf8cursor(&u8c, data, nfdicf_test_data[i].str) < 0)
+		if (utf8cursor(&u8c, um, UTF8_NFDICF,
+				nfdicf_test_data[i].str) < 0)
 			pr_err("can't create cursor\n");
 
 		while ((c = utf8byte(&u8c)) > 0) {
@@ -243,16 +230,9 @@ static void check_utf8_nfdicf(void)
 	}
 }
 
-static void check_utf8_comparisons(void)
+static void check_utf8_comparisons(struct unicode_map *table)
 {
 	int i;
-	struct unicode_map *table = utf8_load(UNICODE_AGE(12, 1, 0));
-
-	if (IS_ERR(table)) {
-		pr_err("%s: Unable to load utf8 %d.%d.%d. Skipping.\n",
-		       __func__, latest_maj, latest_min, latest_rev);
-		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
 		const struct qstr s1 = {.name = nfdi_test_data[i].str,
@@ -273,8 +253,6 @@ static void check_utf8_comparisons(void)
 		test_f(!utf8_strncasecmp(table, &s1, &s2),
 		       "%s %s comparison mismatch\n", s1.name, s2.name);
 	}
-
-	utf8_unload(table);
 }
 
 static void check_supported_versions(void)
@@ -286,8 +264,7 @@ static void check_supported_versions(void)
 	test(utf8version_is_supported(UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(
-		UNICODE_AGE(latest_maj, latest_min, latest_rev)));
+	test(utf8version_is_supported(UTF8_LATEST));
 
 	/* Next versions don't exist. */
 	test(!utf8version_is_supported(UNICODE_AGE(13, 0, 0)));
@@ -297,19 +274,28 @@ static void check_supported_versions(void)
 
 static int __init init_test_ucd(void)
 {
+	struct unicode_map *um;
+
 	failed_tests = 0;
 	total_tests = 0;
 
+	um = utf8_load(UTF8_LATEST);
+	if (IS_ERR(um)) {
+		pr_err("%s: Unable to load utf8 table.\n", __func__);
+		return PTR_ERR(um);
+	}
+
 	check_supported_versions();
-	check_utf8_nfdi();
-	check_utf8_nfdicf();
-	check_utf8_comparisons();
+	check_utf8_nfdi(um);
+	check_utf8_nfdicf(um);
+	check_utf8_comparisons(um);
 
 	if (!failed_tests)
 		pr_info("All %u tests passed\n", total_tests);
 	else
 		pr_err("%u out of %u tests failed\n", failed_tests,
 		       total_tests);
+	utf8_unload(um);
 	return 0;
 }
 
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 736b6460a38c..206c89f0dbf7 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -39,7 +39,8 @@ extern const struct utf8data *utf8nfdicf(unsigned int maxage);
  * Returns 0 if only ignorable code points are present.
  * Returns -1 if the input is not valid UTF-8.
  */
-extern ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len);
+ssize_t utf8nlen(const struct unicode_map *um, enum utf8_normalization n,
+		const char *s, size_t len);
 
 /* Needed in struct utf8cursor below. */
 #define UTF8HANGULLEAF	(12)
@@ -48,7 +49,8 @@ extern ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len);
  * Cursor structure used by the normalizer.
  */
 struct utf8cursor {
-	const struct utf8data	*data;
+	const struct unicode_map *um;
+	enum utf8_normalization n;
 	const char	*s;
 	const char	*p;
 	const char	*ss;
@@ -65,8 +67,8 @@ struct utf8cursor {
  * Returns 0 on success.
  * Returns -1 on failure.
  */
-extern int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
-		       const char *s, size_t len);
+int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
+		enum utf8_normalization n, const char *s, size_t len);
 
 /*
  * Get the next byte in the normalization.
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index a5cc44a8f90c..3e502c7456e8 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -5,6 +5,8 @@
 #include <linux/init.h>
 #include <linux/dcache.h>
 
+struct utf8data;
+
 /* Encoding a unicode version number as a single unsigned int. */
 #define UNICODE_MAJ_SHIFT		(16)
 #define UNICODE_MIN_SHIFT		(8)
@@ -14,8 +16,25 @@
 	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
 	 ((unsigned int)(REV)))
 
+/*
+ * Two normalization forms are supported:
+ * 1) NFDI
+ *   - Apply unicode normalization form NFD.
+ *   - Remove any Default_Ignorable_Code_Point.
+ * 2) NFDICF
+ *   - Apply unicode normalization form NFD.
+ *   - Remove any Default_Ignorable_Code_Point.
+ *   - Apply a full casefold (C + F).
+ */
+enum utf8_normalization {
+	UTF8_NFDI = 0,
+	UTF8_NFDICF,
+	UTF8_NMAX,
+};
+
 struct unicode_map {
 	unsigned int version;
+	const struct utf8data *ntab[UTF8_NMAX];
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
-- 
2.30.2

