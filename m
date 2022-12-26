Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCF656348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiLZOXR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiLZOWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72236404;
        Mon, 26 Dec 2022 06:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E37A60EC4;
        Mon, 26 Dec 2022 14:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962AC433F1;
        Mon, 26 Dec 2022 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064539;
        bh=C9hpYs5SfjcSEusd2O4PwIN/sol9PZlsNg0ce4muq9s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qrZ66dr2mYGyXJ9dpyMUaNCLPxhIlaRWjTHgoAyF1lEmGiF1AJYUsM6NaZqbcFx2w
         7iJMyDNL/grtQhmS59x3ND4/dpiaBtDMPKoUeARpwTTtB+ETaTFN6aUqWUaRIkquw7
         zwzqy4o+GgFBqFSjIvRCajWdCSfZ/+GpzuXo87Wg7Du+iwhe13CvkF0e6y48ueZ+sX
         R+b8cGcvZ1ZCJ6xt0gJb3iQmQLGKMtdgSdeI5Lfmnd4qAICxRaRCEfPDiR7l4tM6ld
         jYyBH2ygLjy5X7Xv7yQ5/HV9Q3trWHLryksVqYLDC9OOk3D15QtkxcsZ0UwoqstCk8
         5JpDY7kEq+b1w==
Received: by pali.im (Postfix)
        id 251389D7; Mon, 26 Dec 2022 15:22:19 +0100 (CET)
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
Subject: [RFC PATCH v2 17/18] cifs: Remove usage of load_nls_default() calls
Date:   Mon, 26 Dec 2022 15:21:49 +0100
Message-Id: <20221226142150.13324-18-pali@kernel.org>
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
 fs/cifs/smb2pdu.c   | 18 ++++--------------
 3 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 23f10e0d6e7e..3db882fdc21d 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -69,7 +69,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	int rc;
 	struct cifs_ses *ses;
 	struct TCP_Server_Info *server;
-	struct nls_table *nls_codepage;
 	int retries;
 
 	/*
@@ -147,8 +146,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	nls_codepage = load_nls_default();
-
 	/*
 	 * Recheck after acquire mutex. If another thread is negotiating
 	 * and the server never sends an answer the socket will be closed
@@ -182,7 +179,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	mutex_lock(&ses->session_mutex);
 	rc = cifs_negotiate_protocol(0, ses, server);
 	if (!rc)
-		rc = cifs_setup_session(0, ses, server, nls_codepage);
+		rc = cifs_setup_session(0, ses, server, NULL);
 
 	/* do we need to reconnect tcon? */
 	if (rc || !tcon->need_reconnect) {
@@ -192,7 +189,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 
 skip_sess_setup:
 	cifs_mark_open_files_invalid(tcon);
-	rc = cifs_tree_connect(0, tcon, nls_codepage);
+	rc = cifs_tree_connect(0, tcon, NULL);
 	mutex_unlock(&ses->session_mutex);
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
 
@@ -228,7 +225,6 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 		rc = -EAGAIN;
 	}
 
-	unload_nls(nls_codepage);
 	return rc;
 }
 
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 43ad1176dcb9..4794f2cf721a 100644
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
@@ -173,14 +171,14 @@ char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int
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
@@ -392,9 +390,6 @@ int dfs_cache_init(void)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
 	atomic_set(&cache_count, 0);
-	cache_cp = load_nls("utf8");
-	if (!cache_cp)
-		cache_cp = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
 	return 0;
@@ -408,11 +403,11 @@ static int cache_entry_hash(const void *data, int size, unsigned int *hash)
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
@@ -601,14 +596,14 @@ static int add_cache_entry_locked(struct dfs_info3_param *refs, int numrefs)
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
@@ -698,7 +693,6 @@ static struct cache_entry *lookup_cache_entry(const char *path)
 void dfs_cache_destroy(void)
 {
 	cancel_delayed_work_sync(&refresh_task);
-	unload_nls(cache_cp);
 	free_mount_group_list();
 	flush_cache_ents();
 	kmem_cache_destroy(cache_slab);
@@ -744,11 +738,9 @@ static int get_dfs_referral(const unsigned int xid, struct cifs_ses *ses, const
 
 	if (!ses || !ses->server || !ses->server->ops->get_dfs_refer)
 		return -EOPNOTSUPP;
-	if (unlikely(!cache_cp))
-		return -EINVAL;
 
 	cifs_dbg(FYI, "%s: ipc=%s referral=%s\n", __func__, ses->tcon_ipc->tree_name, path);
-	rc =  ses->server->ops->get_dfs_refer(xid, ses, path, refs, numrefs, cache_cp,
+	rc =  ses->server->ops->get_dfs_refer(xid, ses, path, refs, numrefs, NULL,
 					      NO_MAP_UNI_RSVD);
 	if (!rc) {
 		struct dfs_info3_param *ref = *refs;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index a5695748a89b..3dc69787ae17 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -144,7 +144,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server)
 {
 	int rc = 0;
-	struct nls_table *nls_codepage;
 	struct cifs_ses *ses;
 	int retries;
 
@@ -250,8 +249,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		 tcon->ses->chans_need_reconnect,
 		 tcon->need_reconnect);
 
-	nls_codepage = load_nls_default();
-
 	/*
 	 * Recheck after acquire mutex. If another thread is negotiating
 	 * and the server never sends an answer the socket will be closed
@@ -284,7 +281,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	mutex_lock(&ses->session_mutex);
 	rc = cifs_negotiate_protocol(0, ses, server);
 	if (!rc) {
-		rc = cifs_setup_session(0, ses, server, nls_codepage);
+		rc = cifs_setup_session(0, ses, server, NULL);
 		if ((rc == -EACCES) && !tcon->retry) {
 			mutex_unlock(&ses->session_mutex);
 			rc = -EHOSTDOWN;
@@ -309,7 +306,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (tcon->use_persistent)
 		tcon->need_reopen_files = true;
 
-	rc = cifs_tree_connect(0, tcon, nls_codepage);
+	rc = cifs_tree_connect(0, tcon, NULL);
 	mutex_unlock(&ses->session_mutex);
 
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
@@ -345,7 +342,6 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		rc = -EAGAIN;
 	}
 failed:
-	unload_nls(nls_codepage);
 	return rc;
 }
 
@@ -503,12 +499,10 @@ build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt)
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
 	return ALIGN(le16_to_cpu(pneg_ctxt->DataLength) + sizeof(struct smb2_neg_context), 8);
 }
@@ -2568,7 +2562,6 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 			    const char *treename, const __le16 *path)
 {
 	int treename_len, path_len;
-	struct nls_table *cp;
 	const __le16 sep[] = {cpu_to_le16('\\'), cpu_to_le16(0x0000)};
 
 	/*
@@ -2595,8 +2588,7 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 	if (!*out_path)
 		return -ENOMEM;
 
-	cp = load_nls_default();
-	cifs_strtoUTF16(*out_path, treename, treename_len, cp);
+	cifs_strtoUTF16(*out_path, treename, treename_len, NULL);
 
 	/* Do not append the separator if the path is empty */
 	if (path[0] != cpu_to_le16(0x0000)) {
@@ -2604,8 +2596,6 @@ alloc_path_with_tree_prefix(__le16 **out_path, int *out_size, int *out_len,
 		UniStrcat(*out_path, path);
 	}
 
-	unload_nls(cp);
-
 	return 0;
 }
 
-- 
2.20.1

