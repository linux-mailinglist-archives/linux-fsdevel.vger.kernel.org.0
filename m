Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCD656350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiLZOXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiLZOWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D263A8;
        Mon, 26 Dec 2022 06:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E10B8B80C02;
        Mon, 26 Dec 2022 14:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED7AC433F0;
        Mon, 26 Dec 2022 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064538;
        bh=fCynkXJ2ApONoQQC/ojXHkaREg+LG2l1GbUTcOSrgdM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TywsxGype9uslbISt9pHvZte/7BFs4KYX5tGNNHq6Gup5Au/egJh7ajRWW3I5ZY6Q
         dNfGRf9udc6MGdngo3llDZgMSBEXVBbCV8dA/hlX3gRFavc1BrO/Kp3IKliFEjPAFL
         1KvJTFn/9E+la6xGnkOkAu2oJJB2kvshIF/swsc6BufW1QvXw9vpZD+mXHVM69klHw
         4aLnUwBp/aHUw2sDfrITGtGlVVvQHLgvPAKuIx1lt20P7xTRAGAiKpkdtqYn8LJUef
         oVMbChNvkmBGKIonMuxEPSwToZQRH0hnn7xKYy4NeWiawDHyYfsC0+oQuZG2dkxgLk
         XdDQgRcxyvCtw==
Received: by pali.im (Postfix)
        id 1AAC69D7; Mon, 26 Dec 2022 15:22:18 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 16/18] cifs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:48 +0100
Message-Id: <20221226142150.13324-17-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS table for utf8 is broken and cannot be fixed.

So instead of broken utf8 nls functions char2uni() and uni2char() use
functions utf8s_to_utf16s() and utf16s_to_utf8s() which implements correct
conversion between UTF-16 and UTF-8.

When iochatset=utf8 is used then set ctx->iocharset to NULL and use it for
distinguish between the fact if NLS table or native UTF-8 functions should
be used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/cifs/cifs_unicode.c | 128 +++++++++++++++++++++++++++--------------
 fs/cifs/cifs_unicode.h |   2 +-
 fs/cifs/cifsfs.c       |   2 +
 fs/cifs/connect.c      |   8 ++-
 fs/cifs/dir.c          |  28 +++++++--
 fs/cifs/winucase.c     |  14 +++--
 6 files changed, 124 insertions(+), 58 deletions(-)

diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
index e7582dd79179..94b861e666e3 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -130,20 +130,17 @@ cifs_mapchar(char *target, const __u16 *from, const struct nls_table *cp,
 		  convert_sfu_char(src_char, target))
 		return len;
 
-	/* if character not one of seven in special remap set */
-	len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
-	if (len <= 0)
-		goto surrogate_pair;
-
-	return len;
+	if (cp) {
+		/* if character not one of seven in special remap set */
+		len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
+		if (len <= 0)
+			goto unknown;
+	} else {
+		len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
+		if (len <= 0)
+			goto unknown;
+	}
 
-surrogate_pair:
-	/* convert SURROGATE_PAIR and IVS */
-	if (strcmp(cp->charset, "utf8"))
-		goto unknown;
-	len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
-	if (len <= 0)
-		goto unknown;
 	return len;
 
 unknown:
@@ -239,6 +236,37 @@ cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 	return outlen;
 }
 
+static int cifs_utf8s_to_utf16s(const char *s, int inlen, __le16 *pwcs)
+{
+	__le16 *op;
+	int size;
+	unicode_t u;
+
+	op = pwcs;
+	while (inlen > 0 && *s) {
+		if (*s & 0x80) {
+			size = utf8_to_utf32(s, inlen, &u);
+			if (size <= 0) {
+				u = 0x003f; /* A question mark */
+				size = 1;
+			}
+			s += size;
+			inlen -= size;
+			if (u >= 0x10000) {
+				u -= 0x10000;
+				*op++ = __cpu_to_le16(0xd800 | ((u >> 10) & 0x03ff));
+				*op++ = __cpu_to_le16(0xdc00 | (u & 0x03ff));
+			} else {
+				*op++ = __cpu_to_le16(u);
+			}
+		} else {
+			*op++ = __cpu_to_le16(*s++);
+			inlen--;
+		}
+	}
+	return op - pwcs;
+}
+
 /*
  * NAME:	cifs_strtoUTF16()
  *
@@ -254,24 +282,14 @@ cifs_strtoUTF16(__le16 *to, const char *from, int len,
 	wchar_t wchar_to; /* needed to quiet sparse */
 
 	/* special case for utf8 to handle no plane0 chars */
-	if (!strcmp(codepage->charset, "utf8")) {
+	if (!codepage) {
 		/*
 		 * convert utf8 -> utf16, we assume we have enough space
 		 * as caller should have assumed conversion does not overflow
-		 * in destination len is length in wchar_t units (16bits)
-		 */
-		i  = utf8s_to_utf16s(from, len, UTF16_LITTLE_ENDIAN,
-				       (wchar_t *) to, len);
-
-		/* if success terminate and exit */
-		if (i >= 0)
-			goto success;
-		/*
-		 * if fails fall back to UCS encoding as this
-		 * function should not return negative values
-		 * currently can fail only if source contains
-		 * invalid encoded characters
+		 * in destination len is length in __le16 units
 		 */
+		i  = cifs_utf8s_to_utf16s(from, len, to);
+		goto success;
 	}
 
 	for (i = 0; len && *from; i++, from += charlen, len -= charlen) {
@@ -502,25 +520,29 @@ cifsConvertToUTF16(__le16 *target, const char *source, int srclen,
 		 * as they use backslash as separator.
 		 */
 		if (dst_char == 0) {
-			charlen = cp->char2uni(source + i, srclen - i, &tmp);
-			dst_char = cpu_to_le16(tmp);
-
-			/*
-			 * if no match, use question mark, which at least in
-			 * some cases serves as wild card
-			 */
-			if (charlen > 0)
-				goto ctoUTF16;
-
-			/* convert SURROGATE_PAIR */
-			if (strcmp(cp->charset, "utf8") || !wchar_to)
-				goto unknown;
-			if (*(source + i) & 0x80) {
-				charlen = utf8_to_utf32(source + i, 6, &u);
-				if (charlen < 0)
+			if (cp) {
+				charlen = cp->char2uni(source + i, srclen - i, &tmp);
+				dst_char = cpu_to_le16(tmp);
+
+				/*
+				 * if no match, use question mark, which at least in
+				 * some cases serves as wild card
+				 */
+				if (charlen > 0)
+					goto ctoUTF16;
+				else
 					goto unknown;
-			} else
+			}
+
+			/* UTF-8 to UTF-16 conversion */
+
+			if (!wchar_to)
 				goto unknown;
+
+			charlen = utf8_to_utf32(source + i, 6, &u);
+			if (charlen < 0)
+				goto unknown;
+
 			ret  = utf8s_to_utf16s(source + i, charlen,
 					       UTF16_LITTLE_ENDIAN,
 					       wchar_to, 6);
@@ -589,8 +611,26 @@ cifs_local_to_utf16_bytes(const char *from, int len,
 {
 	int charlen;
 	int i;
+	int outlen;
+	unicode_t u_to;
 	wchar_t wchar_to;
 
+	if (!codepage) {
+		outlen = 0;
+		for (i = 0; len && *from; i++, from += charlen, len -= charlen) {
+			charlen = utf8_to_utf32(from, len, &u_to);
+			/* Failed conversion defaults to a question mark */
+			if (charlen < 1) {
+				charlen = 1;
+				outlen += 2;
+			} else if (u_to <= 0xFFFF)
+				outlen += 2;
+			else
+				outlen += 4;
+		}
+		return outlen;
+	}
+
 	for (i = 0; len && *from; i++, from += charlen, len -= charlen) {
 		charlen = codepage->char2uni(from, len, &wchar_to);
 		/* Failed conversion defaults to a question mark */
diff --git a/fs/cifs/cifs_unicode.h b/fs/cifs/cifs_unicode.h
index 80b3d845419f..b9a3290faaf7 100644
--- a/fs/cifs/cifs_unicode.h
+++ b/fs/cifs/cifs_unicode.h
@@ -106,7 +106,7 @@ extern __le16 *cifs_strndup_to_utf16(const char *src, const int maxlen,
 				     int remap);
 #endif
 
-wchar_t cifs_toupper(wchar_t in);
+unicode_t cifs_toupper(unicode_t in);
 
 /*
  * UniStrcat:  Concatenate the second string to the first
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 10e00c624922..1537bc8bb698 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -591,6 +591,8 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 					   cifs_sb->ctx->dir_mode);
 	if (cifs_sb->ctx->iocharset)
 		seq_printf(s, ",iocharset=%s", cifs_sb->ctx->iocharset);
+	else
+		seq_puts(s, ",iocharset=utf8");
 	if (tcon->seal)
 		seq_puts(s, ",seal");
 	else if (tcon->ses->server->ignore_signature)
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d371259d6808..fb841a7baef6 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2676,7 +2676,11 @@ compare_mount_options(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 	    old->ctx->dir_mode != new->ctx->dir_mode)
 		return 0;
 
-	if (strcmp(old->local_nls->charset, new->local_nls->charset))
+	if (old->local_nls && !new->local_nls)
+		return 0;
+	if (!old->local_nls && new->local_nls)
+		return 0;
+	if (old->local_nls && new->local_nls && strcmp(old->local_nls->charset, new->local_nls->charset))
 		return 0;
 
 	if (old->ctx->acregmax != new->ctx->acregmax)
@@ -3162,7 +3166,7 @@ int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb)
 	if (ctx->iocharset == NULL) {
 		/* load_nls_default cannot return null */
 		cifs_sb->local_nls = load_nls_default();
-	} else {
+	} else if (strcmp(ctx->iocharset, "utf8") != 0) {
 		cifs_sb->local_nls = load_nls(ctx->iocharset);
 		if (cifs_sb->local_nls == NULL) {
 			cifs_dbg(VFS, "CIFS mount error: iocharset %s not found\n",
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ad4208bf1e32..83deba65e188 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -804,16 +804,22 @@ static int cifs_ci_hash(const struct dentry *dentry, struct qstr *q)
 {
 	struct nls_table *codepage = CIFS_SB(dentry->d_sb)->local_nls;
 	unsigned long hash;
+	unicode_t u;
 	wchar_t c;
 	int i, charlen;
 
 	hash = init_name_hash(dentry);
 	for (i = 0; i < q->len; i += charlen) {
-		charlen = codepage->char2uni(&q->name[i], q->len - i, &c);
+		if (codepage) {
+			charlen = codepage->char2uni(&q->name[i], q->len - i, &c);
+			if (likely(charlen > 0))
+				u = c;
+		} else
+			charlen = utf8_to_utf32(&q->name[i], q->len - i, &u);
 		/* error out if we can't convert the character */
 		if (unlikely(charlen < 0))
 			return charlen;
-		hash = partial_name_hash(cifs_toupper(c), hash);
+		hash = partial_name_hash(cifs_toupper(u), hash);
 	}
 	q->hash = end_name_hash(hash);
 
@@ -824,6 +830,7 @@ static int cifs_ci_compare(const struct dentry *dentry,
 		unsigned int len, const char *str, const struct qstr *name)
 {
 	struct nls_table *codepage = CIFS_SB(dentry->d_sb)->local_nls;
+	unicode_t u1, u2;
 	wchar_t c1, c2;
 	int i, l1, l2;
 
@@ -837,9 +844,18 @@ static int cifs_ci_compare(const struct dentry *dentry,
 		return 1;
 
 	for (i = 0; i < len; i += l1) {
-		/* Convert characters in both strings to UTF-16. */
-		l1 = codepage->char2uni(&str[i], len - i, &c1);
-		l2 = codepage->char2uni(&name->name[i], name->len - i, &c2);
+		/* Convert characters in both strings to UTF-32. */
+		if (codepage) {
+			l1 = codepage->char2uni(&str[i], len - i, &c1);
+			l2 = codepage->char2uni(&name->name[i], name->len - i, &c2);
+			if (likely(l1 > 0))
+				u1 = c1;
+			if (likely(l2 > 0))
+				u2 = c2;
+		} else {
+			l1 = utf8_to_utf32(&str[i], len - i, &u1);
+			l2 = utf8_to_utf32(&name->name[i], name->len - i, &u2);
+		}
 
 		/*
 		 * If we can't convert either character, just declare it to
@@ -860,7 +876,7 @@ static int cifs_ci_compare(const struct dentry *dentry,
 			return 1;
 
 		/* Now compare uppercase versions of these characters */
-		if (cifs_toupper(c1) != cifs_toupper(c2))
+		if (cifs_toupper(u1) != cifs_toupper(u2))
 			return 1;
 	}
 
diff --git a/fs/cifs/winucase.c b/fs/cifs/winucase.c
index 2f075b5b50df..b3647b35a7e1 100644
--- a/fs/cifs/winucase.c
+++ b/fs/cifs/winucase.c
@@ -17,7 +17,7 @@
 
 #include <linux/nls.h>
 
-wchar_t cifs_toupper(wchar_t in);  /* quiet sparse */
+unicode_t cifs_toupper(unicode_t in);  /* quiet sparse */
 
 static const wchar_t t2_00[256] = {
 	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
@@ -615,20 +615,24 @@ static const wchar_t *const toplevel[256] = {
 };
 
 /**
- * cifs_toupper - convert a wchar_t from lower to uppercase
+ * cifs_toupper - convert a unicode_t from lower to uppercase
  * @in: character to convert from lower to uppercase
  *
- * This function consults the static tables above to convert a wchar_t from
+ * This function consults the static tables above to convert a unicode_t from
  * lower to uppercase. In the event that there is no mapping, the original
  * "in" character is returned.
  */
-wchar_t
-cifs_toupper(wchar_t in)
+unicode_t
+cifs_toupper(unicode_t in)
 {
 	unsigned char idx;
 	const wchar_t *tbl;
 	wchar_t out;
 
+	/* cifs_toupper table has only defines for plane-0 */
+	if (in > 0xffff)
+		return in;
+
 	/* grab upper byte */
 	idx = (in & 0xff00) >> 8;
 
-- 
2.20.1

