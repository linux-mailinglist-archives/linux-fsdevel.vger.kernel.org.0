Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672603E3B74
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhHHQZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhHHQZk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CCC061159;
        Sun,  8 Aug 2021 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439921;
        bh=z/FhqL9hG3wsAsCw14eqfq6cdKCY6sXwbLTyVeyWntw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eGaZ5eaTBGadLSABdqluDPMNhsqP/wYRtcVcsjA5pSDpnP9/4mP259wjzz/CPWuqr
         bri5qcFT3o6QCGpF1b1c4cq9uYgsm8tooRc9TRbbtp5g3gyjo9SyTfVwbSzL+MCaSK
         TBVbCixDf70sxwy4hRbJCd3CKGwzY8Dux+JxLv1E0QiCgqHXOH95md7XqSbJlVEObI
         PojIcURWFuuMzoZqi7g04Hd6mZyyiLTKAEO9KNJ4YOlxZkwbPH2c14VZj1DAryDntR
         rPyv6tIYuKcHdgZyhHOe2JUT/4Z7Dpm6foeLVgBilLuCdF9a5OYENrJo8+oGaNMPkq
         mnjvdHV7tieiA==
Received: by pali.im (Postfix)
        id 3DCD413DC; Sun,  8 Aug 2021 18:25:21 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 17/20] ntfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Sun,  8 Aug 2021 18:24:50 +0200
Message-Id: <20210808162453.1653-18-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS table for utf8 is broken and cannot be fixed.

So instead of broken utf8 nls functions char2uni() and uni2char() use
functions utf8s_to_utf16s() and utf16s_to_utf8s() which implements correct
conversion between UTF-16 and UTF-8.

These functions implements also correct processing of UTF-16 surrogate
pairs and therefore after this change ntfs driver would be able to correctly
handle also file names with 4-byte UTF-8 sequences.

When iochatset=utf8 is used then set vol->nls_map to NULL and use it for
distinguish between the fact if NLS table or native UTF-8 functions should
be used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/ntfs/dir.c    |  6 ++++--
 fs/ntfs/inode.c  |  5 ++++-
 fs/ntfs/super.c  | 41 ++++++++++++++++++++++++-----------------
 fs/ntfs/unistr.c | 27 ++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index cd96083a12c8..035582b92aa2 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1034,7 +1034,8 @@ static inline int ntfs_filldir(ntfs_volume *vol,
 	}
 	name_len = ntfs_ucstonls(vol, (ntfschar*)&ie->key.file_name.file_name,
 			ie->key.file_name.file_name_length, &name,
-			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
+			NTFS_MAX_NAME_LEN *
+			(vol->nls_map ? NLS_MAX_CHARSET_SIZE : 4) + 1);
 	if (name_len <= 0) {
 		ntfs_warning(vol->sb, "Skipping unrepresentable inode 0x%llx.",
 				(long long)MREF_LE(ie->data.dir.indexed_file));
@@ -1118,7 +1119,8 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	 * Allocate a buffer to store the current name being processed
 	 * converted to format determined by current NLS.
 	 */
-	name = kmalloc(NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1, GFP_NOFS);
+	name = kmalloc(NTFS_MAX_NAME_LEN *
+		       (vol->nls_map ? NLS_MAX_CHARSET_SIZE : 4) + 1, GFP_NOFS);
 	if (unlikely(!name)) {
 		err = -ENOMEM;
 		goto err_out;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 3676f185b4a0..1437944be66d 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2303,7 +2303,10 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_printf(sf, ",fmask=0%o", vol->fmask);
 		seq_printf(sf, ",dmask=0%o", vol->dmask);
 	}
-	seq_printf(sf, ",iocharset=%s", vol->nls_map->charset);
+	if (vol->nls_map)
+		seq_printf(sf, ",iocharset=%s", vol->nls_map->charset);
+	else
+		seq_puts(sf, ",iocharset=utf8");
 	if (NVolCaseSensitive(vol))
 		seq_printf(sf, ",case_sensitive");
 	if (NVolShowSystemFiles(vol))
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 69c7871b742e..358f5e9e3c46 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -84,7 +84,7 @@ static int simple_getbool(char *s, bool *setval)
  *
  * Parse the recognized options in @opt for the ntfs volume described by @vol.
  */
-static bool parse_options(ntfs_volume *vol, char *opt)
+static bool parse_options(ntfs_volume *vol, char *opt, int remount)
 {
 	char *p, *v, *ov;
 	static char *utf8 = "utf8";
@@ -95,6 +95,7 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 	int mft_zone_multiplier = -1, on_errors = -1;
 	int show_sys_files = -1, case_sensitive = -1, disable_sparse = -1;
 	struct nls_table *nls_map = NULL;
+	int have_iocharset = 0;
 
 	/* I am lazy... (-8 */
 #define NTFS_GETOPT_WITH_DEFAULT(option, variable, default_value)	\
@@ -196,12 +197,16 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 				goto needs_arg;
 use_utf8:
 			unload_nls(nls_map);
-			nls_map = load_nls(v);
-			if (!nls_map) {
-				ntfs_error(vol->sb, "NLS character set "
-					   "%s not found.", v);
-				return false;
+			nls_map = NULL;
+			if (strcmp(v, "utf8") != 0) {
+				nls_map = load_nls(v);
+				if (!nls_map) {
+					ntfs_error(vol->sb, "NLS character set "
+						   "%s not found.", v);
+					return false;
+				}
 			}
+			have_iocharset = 1;
 		} else if (!strcmp(p, "utf8")) {
 			bool val = false;
 			ntfs_warning(vol->sb, "Option utf8 is no longer "
@@ -241,25 +246,27 @@ static bool parse_options(ntfs_volume *vol, char *opt)
 			return false;
 		}
 	}
-	if (nls_map) {
-		if (vol->nls_map && vol->nls_map != nls_map) {
+	if (have_iocharset) {
+		if (remount && vol->nls_map != nls_map) {
 			ntfs_error(vol->sb, "Cannot change NLS character set "
 					"on remount.");
 			return false;
-		} /* else (!vol->nls_map) */
-		ntfs_debug("Using NLS character set %s.", nls_map->charset);
-		vol->nls_map = nls_map;
-	} else /* (!nls_map) */ {
-		if (!vol->nls_map) {
+		} else (!remount) {
+			ntfs_debug("Using NLS character set %s.",
+					nls_map ? nls_map->charset : "utf8");
+			vol->nls_map = nls_map;
+		}
+	} else if (!remount) {
+		if (strcmp(CONFIG_NLS_DEFAULT, "utf8") != 0) {
 			vol->nls_map = load_nls_default();
 			if (!vol->nls_map) {
 				ntfs_error(vol->sb, "Failed to load default "
 						"NLS character set.");
 				return false;
 			}
-			ntfs_debug("Using default NLS character set (%s).",
-					vol->nls_map->charset);
 		}
+		ntfs_debug("Using default NLS character set (%s).",
+				vol->nls_map ? vol->nls_map->charset : "utf8");
 	}
 	if (mft_zone_multiplier != -1) {
 		if (vol->mft_zone_multiplier && vol->mft_zone_multiplier !=
@@ -534,7 +541,7 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *opt)
 
 	// TODO: Deal with *flags.
 
-	if (!parse_options(vol, opt))
+	if (!parse_options(vol, opt, 1))
 		return -EINVAL;
 
 	ntfs_debug("Done.");
@@ -2731,7 +2738,7 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
 	NVolSetSparseEnabled(vol);
 
 	/* Important to get the mount options dealt with now. */
-	if (!parse_options(vol, (char*)opt))
+	if (!parse_options(vol, (char*)opt, 0))
 		goto err_out_now;
 
 	/* We support sector sizes up to the PAGE_SIZE. */
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index 75a7f73bccdd..f29d83fb09bb 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -254,6 +254,16 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 	if (likely(ins)) {
 		ucs = kmem_cache_alloc(ntfs_name_cache, GFP_NOFS);
 		if (likely(ucs)) {
+			if (!nls) {
+				wc_len = utf8s_to_utf16s(ins, ins_len,
+						UTF16_LITTLE_ENDIAN, ucs,
+						NTFS_MAX_NAME_LEN);
+				if (wc_len < 0 || wc_len >= NTFS_MAX_NAME_LEN)
+					goto name_err;
+				ucs[wc_len] = 0;
+				*outs = ucs;
+				return o;
+			}
 			for (i = o = 0; i < ins_len; i += wc_len) {
 				wc_len = nls->char2uni(ins + i, ins_len - i,
 						&wc);
@@ -283,7 +293,7 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 	if (wc_len < 0) {
 		ntfs_error(vol->sb, "Name using character set %s contains "
 				"characters that cannot be converted to "
-				"Unicode.", nls->charset);
+				"Unicode.", nls ? nls->charset : "utf8");
 		i = -EILSEQ;
 	} else /* if (o >= NTFS_MAX_NAME_LEN) */ {
 		ntfs_error(vol->sb, "Name is too long (maximum length for a "
@@ -335,11 +345,22 @@ int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
 			goto conversion_err;
 		}
 		if (!ns) {
-			ns_len = ins_len * NLS_MAX_CHARSET_SIZE;
+			ns_len = ins_len * (nls ? NLS_MAX_CHARSET_SIZE : 4);
 			ns = kmalloc(ns_len + 1, GFP_NOFS);
 			if (!ns)
 				goto mem_err_out;
 		}
+		if (!nls) {
+			o = utf16s_to_utf8s(ins, ins_len, UTF16_LITTLE_ENDIAN,
+					ns, ns_len);
+			if (o >= ns_len) {
+				wc = -ENAMETOOLONG;
+				goto conversion_err;
+			}
+			ns[o] = 0;
+			*outs = ns;
+			return o;
+		}
 		for (i = o = 0; i < ins_len; i++) {
 retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 					ns_len - o);
@@ -373,7 +394,7 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
 	ntfs_error(vol->sb, "Unicode name contains characters that cannot be "
 			"converted to character set %s.  You might want to "
 			"try to use the mount option iocharset=utf8.",
-			nls->charset);
+			nls ? nls->charset : "utf8");
 	if (ns != *outs)
 		kfree(ns);
 	if (wc != -ENAMETOOLONG)
-- 
2.20.1

