Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D6656351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiLZOXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiLZOWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C363F4;
        Mon, 26 Dec 2022 06:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0675BB80D40;
        Mon, 26 Dec 2022 14:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51663C433D2;
        Mon, 26 Dec 2022 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064537;
        bh=RK9DOOb9HQTHiFbnB9yl27BsQqt4tsB/kdDZtxluKjg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A7as4conG80j3KTRyKa+pZqH2p0+HLcM2KRFTFrHeRHtwwEh0B3ScNLvlE5gT4QUH
         8/C3yU+iAcX7YjDaj9Ax2VnfevhCUw7yKVg6agLFv2tIavN2uYUuiXgrJEuPBEDSaN
         0WJLfE9fKshKT4R7zs+sVGwxdBh39MdfdfmgRTQPE8j9peTJWxIj7H+DY078+Mht6y
         5zY25iRlomgxKTKRQZgDx3E/Q2ZW1lsTglJE2ZZbrsdHh8AQB/NJcD34MLXljLhbD4
         wsCXF73UKZTVw369GLBx1RysIjZo+kgOTOoU3rnaYYkBimlp+HQRtuDtTqfgu1Nuke
         PozOaVpfexFtg==
Received: by pali.im (Postfix)
        id 0C7F39D7; Mon, 26 Dec 2022 15:22:17 +0100 (CET)
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
Subject: [RFC PATCH v2 15/18] ntfs: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:47 +0100
Message-Id: <20221226142150.13324-16-pali@kernel.org>
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
 fs/ntfs/unistr.c | 28 +++++++++++++++++++++++++---
 4 files changed, 57 insertions(+), 23 deletions(-)

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
index 2ab071c4560d..795b5495a897 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2314,7 +2314,10 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
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
index b4f26035e750..b15cd92a9dad 100644
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
+		} else if (!remount) {
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
@@ -2732,7 +2739,7 @@ static int ntfs_fill_super(struct super_block *sb, void *opt, const int silent)
 	NVolSetSparseEnabled(vol);
 
 	/* Important to get the mount options dealt with now. */
-	if (!parse_options(vol, (char*)opt))
+	if (!parse_options(vol, (char*)opt, 0))
 		goto err_out_now;
 
 	/* We support sector sizes up to the PAGE_SIZE. */
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index 75a7f73bccdd..c52141265f99 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -254,6 +254,17 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 	if (likely(ins)) {
 		ucs = kmem_cache_alloc(ntfs_name_cache, GFP_NOFS);
 		if (likely(ucs)) {
+			if (!nls) {
+				wc_len = utf8s_to_utf16s(ins, ins_len,
+							 UTF16_LITTLE_ENDIAN,
+							 (wchar_t *)ucs,
+							 NTFS_MAX_NAME_LEN);
+				if (wc_len < 0 || wc_len >= NTFS_MAX_NAME_LEN)
+					goto name_err;
+				ucs[wc_len] = 0;
+				*outs = ucs;
+				return o;
+			}
 			for (i = o = 0; i < ins_len; i += wc_len) {
 				wc_len = nls->char2uni(ins + i, ins_len - i,
 						&wc);
@@ -283,7 +294,7 @@ int ntfs_nlstoucs(const ntfs_volume *vol, const char *ins,
 	if (wc_len < 0) {
 		ntfs_error(vol->sb, "Name using character set %s contains "
 				"characters that cannot be converted to "
-				"Unicode.", nls->charset);
+				"Unicode.", nls ? nls->charset : "utf8");
 		i = -EILSEQ;
 	} else /* if (o >= NTFS_MAX_NAME_LEN) */ {
 		ntfs_error(vol->sb, "Name is too long (maximum length for a "
@@ -335,11 +346,22 @@ int ntfs_ucstonls(const ntfs_volume *vol, const ntfschar *ins,
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
+			o = utf16s_to_utf8s((const wchar_t *)ins, ins_len,
+					    UTF16_LITTLE_ENDIAN, ns, ns_len);
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
@@ -373,7 +395,7 @@ retry:			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
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

