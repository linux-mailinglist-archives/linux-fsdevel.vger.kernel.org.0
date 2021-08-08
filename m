Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA73E3B71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhHHQZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhHHQZl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3EE61167;
        Sun,  8 Aug 2021 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439922;
        bh=RhrZdv58wrpLoisOY8RK6pQHPOS7MXQ/Qzm4k+Axs/0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CofXhcoqL4ymQMtpBdn3B+KVHCCOv5olzacMdBa2xX2ovggh/yV1W0tCibTtMqEp4
         XBivMqwynQgqNsMOale8Lb904z/juyedkR6vM0u6WvZgy98G3o7N9PWPJdw6cCuklz
         kj3rxTpcAEmTnjqAluVAjps/KxdKcOWMgcB8BczWpXDFgfcO628qo0ZPDDRUOyOw8e
         Uqc9MJTQgIlUjpSA5j9vpov4M2QWPutbN3b5BbSbKlm/ftNuPj7KTXQns7wxnTREhL
         LCQ4ErOB7Au0T5xXjt8GfQQLCOKZNkch/W5XvX5e+o+JVz7Zc74MVShMEHHkKLkSbG
         JLk8miEAp6z+g==
Received: by pali.im (Postfix)
        id 3055A13DC; Sun,  8 Aug 2021 18:25:22 +0200 (CEST)
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
Subject: [RFC PATCH 19/20] cifs: Remove usage of load_nls_default() calls
Date:   Sun,  8 Aug 2021 18:24:52 +0200
Message-Id: <20210808162453.1653-20-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cifs functions will use UTF-8 encoding when nls_table is set to NULL. So
there is no need to load "dummy" NLS table for some operations.

On few places in dfs_cache replace utf8 nls by utf8_to_utf32() function
which converts UTF-8 sequence to unicode code points (stored as type
unicode_t). This should fix handling of (UTF-16) CIFS paths with UTF-16
surrogare pairs, which utf8 nls module cannot handle.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/cifs/cifssmb.c   |  8 ++------
 fs/cifs/dfs_cache.c | 24 ++++++++----------------
 fs/cifs/smb2pdu.c   | 17 ++++-------------
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 65d1a65bfc37..8a2eb380c97d 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -119,7 +119,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	int rc;
 	struct cifs_ses *ses;
 	struct TCP_Server_Info *server;
-	struct nls_table *nls_codepage;
 	int retries;
 
 	/*
@@ -186,8 +185,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	if (!ses->need_reconnect && !tcon->need_reconnect)
 		return 0;
 
-	nls_codepage = load_nls_default();
-
 	/*
 	 * need to prevent multiple threads trying to simultaneously
 	 * reconnect the same SMB session
@@ -207,7 +204,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 
 	rc = cifs_negotiate_protocol(0, ses);
 	if (rc == 0 && ses->need_reconnect)
-		rc = cifs_setup_session(0, ses, nls_codepage);
+		rc = cifs_setup_session(0, ses, NULL);
 
 	/* do we need to reconnect tcon? */
 	if (rc || !tcon->need_reconnect) {
@@ -216,7 +213,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	}
 
 	cifs_mark_open_files_invalid(tcon);
-	rc = cifs_tree_connect(0, tcon, nls_codepage);
+	rc = cifs_tree_connect(0, tcon, NULL);
 	mutex_unlock(&ses->session_mutex);
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
 
@@ -252,7 +249,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 		rc = -EAGAIN;
 	}
 
-	unload_nls(nls_codepage);
 	return rc;
 }
 
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 283745592844..3ba748e59e64 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -66,8 +66,6 @@ static struct workqueue_struct *dfscache_wq __read_mostly;
 static int cache_ttl;
 static DEFINE_SPINLOCK(cache_ttl_lock);
 
-static struct nls_table *cache_cp;
-
 /*
  * Number of entries in the cache
  */
@@ -194,14 +192,14 @@ char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int
 	if (!path || strlen(path) < 3 || (*path != '\\' && *path != '/'))
 		return ERR_PTR(-EINVAL);
 
-	if (unlikely(strcmp(cp->charset, cache_cp->charset))) {
+	if (unlikely(cp)) {
 		tmp = (char *)cifs_strndup_to_utf16(path, strlen(path), &plen, cp, remap);
 		if (!tmp) {
 			cifs_dbg(VFS, "%s: failed to convert path to utf16\n", __func__);
 			return ERR_PTR(-EINVAL);
 		}
 
-		npath = cifs_strndup_from_utf16(tmp, plen, true, cache_cp);
+		npath = cifs_strndup_from_utf16(tmp, plen, true, NULL);
 		kfree(tmp);
 
 		if (!npath) {
@@ -413,9 +411,6 @@ int dfs_cache_init(void)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
 	atomic_set(&cache_count, 0);
-	cache_cp = load_nls("utf8");
-	if (!cache_cp)
-		cache_cp = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
 	return 0;
@@ -429,11 +424,11 @@ static int cache_entry_hash(const void *data, int size, unsigned int *hash)
 {
 	int i, clen;
 	const unsigned char *s = data;
-	wchar_t c;
+	unicode_t c;
 	unsigned int h = 0;
 
 	for (i = 0; i < size; i += clen) {
-		clen = cache_cp->char2uni(&s[i], size - i, &c);
+		clen = utf8_to_utf32(&s[i], size - i, &c);
 		if (unlikely(clen < 0)) {
 			cifs_dbg(VFS, "%s: can't convert char\n", __func__);
 			return clen;
@@ -622,14 +617,14 @@ static int add_cache_entry_locked(struct dfs_info3_param *refs, int numrefs)
 static bool dfs_path_equal(const char *s1, int len1, const char *s2, int len2)
 {
 	int i, l1, l2;
-	wchar_t c1, c2;
+	unicode_t c1, c2;
 
 	if (len1 != len2)
 		return false;
 
 	for (i = 0; i < len1; i += l1) {
-		l1 = cache_cp->char2uni(&s1[i], len1 - i, &c1);
-		l2 = cache_cp->char2uni(&s2[i], len2 - i, &c2);
+		l1 = utf8_to_utf32(&s1[i], len1 - i, &c1);
+		l2 = utf8_to_utf32(&s2[i], len2 - i, &c2);
 		if (unlikely(l1 < 0 && l2 < 0)) {
 			if (s1[i] != s2[i])
 				return false;
@@ -719,7 +714,6 @@ static struct cache_entry *lookup_cache_entry(const char *path)
 void dfs_cache_destroy(void)
 {
 	cancel_delayed_work_sync(&refresh_task);
-	unload_nls(cache_cp);
 	free_mount_group_list();
 	flush_cache_ents();
 	kmem_cache_destroy(cache_slab);
@@ -767,10 +761,8 @@ static int get_dfs_referral(const unsigned int xid, struct cifs_ses *ses, const
 
 	if (!ses || !ses->server || !ses->server->ops->get_dfs_refer)
 		return -EOPNOTSUPP;
-	if (unlikely(!cache_cp))
-		return -EINVAL;
 
-	rc =  ses->server->ops->get_dfs_refer(xid, ses, path, refs, numrefs, cache_cp,
+	rc =  ses->server->ops->get_dfs_refer(xid, ses, path, refs, numrefs, NULL,
 					      NO_MAP_UNI_RSVD);
 	if (!rc) {
 		struct dfs_info3_param *ref = *refs;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 781d14e5f2af..b44f91dd2782 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -145,7 +145,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server)
 {
 	int rc;
-	struct nls_table *nls_codepage;
 	struct cifs_ses *ses;
 	int retries;
 
@@ -233,8 +232,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (!tcon->ses->need_reconnect && !tcon->need_reconnect)
 		return 0;
 
-	nls_codepage = load_nls_default();
-
 	/*
 	 * need to prevent multiple threads trying to simultaneously reconnect
 	 * the same SMB session
@@ -262,7 +259,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	rc = cifs_negotiate_protocol(0, tcon->ses);
 	if (!rc && tcon->ses->need_reconnect) {
-		rc = cifs_setup_session(0, tcon->ses, nls_codepage);
+		rc = cifs_setup_session(0, tcon->ses, NULL);
 		if ((rc == -EACCES) && !tcon->retry) {
 			rc = -EHOSTDOWN;
 			ses->binding = false;
@@ -286,7 +283,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (tcon->use_persistent)
 		tcon->need_reopen_files = true;
 
-	rc = cifs_tree_connect(0, tcon, nls_codepage);
+	rc = cifs_tree_connect(0, tcon, NULL);
 	mutex_unlock(&tcon->ses->session_mutex);
 
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
@@ -322,7 +319,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		rc = -EAGAIN;
 	}
 failed:
-	unload_nls(nls_codepage);
 	return rc;
 }
 
@@ -481,12 +477,10 @@ build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt)
 static unsigned int
 build_netname_ctxt(struct smb2_netname_neg_context *pneg_ctxt, char *hostname)
 {
-	struct nls_table *cp = load_nls_default();
-
 	pneg_ctxt->ContextType = SMB2_NETNAME_NEGOTIATE_CONTEXT_ID;
 
 	/* copy up to max of first 100 bytes of server name to NetName field */
-	pneg_ctxt->DataLength = cpu_to_le16(2 * cifs_strtoUTF16(pneg_ctxt->NetName, hostname, 100, cp));
+	pneg_ctxt->DataLength = cpu_to_le16(2 * cifs_strtoUTF16(pneg_ctxt->NetName, hostname, 100, NULL));
 	/* context size is DataLength + minimal smb2_neg_context */
 	return DIV_ROUND_UP(le16_to_cpu(pneg_ctxt->DataLength) +
 			sizeof(struct smb2_neg_context), 8) * 8;
@@ -2498,7 +2492,6 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 			    const char *treename, const __le16 *path)
 {
 	int treename_len, path_len;
-	struct nls_table *cp;
 	const __le16 sep[] = {cpu_to_le16('\\'), cpu_to_le16(0x0000)};
 
 	/*
@@ -2529,11 +2522,9 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 	if (!*out_path)
 		return -ENOMEM;
 
-	cp = load_nls_default();
-	cifs_strtoUTF16(*out_path, treename, treename_len, cp);
+	cifs_strtoUTF16(*out_path, treename, treename_len, NULL);
 	UniStrcat(*out_path, sep);
 	UniStrcat(*out_path, path);
-	unload_nls(cp);
 
 	return 0;
 }
-- 
2.20.1

