Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362E3342A84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCTEfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:47 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58346 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDQ-9h; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] cifs: constify get_normalized_path() properly
Date:   Sat, 20 Mar 2021 04:32:59 +0000
Message-Id: <20210320043304.1803623-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
 <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As it is, it takes const char * and, in some cases, stores it in
caller's variable that is plain char *.  Fortunately, none of the
callers actually proceeded to modify the string via now-non-const
alias, but that's trouble waiting to happen.

It's easy to do properly, anyway...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/dfs_cache.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index e4617ccf0a23..b1fa30fefe1f 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -81,23 +81,24 @@ static void refresh_cache_worker(struct work_struct *work);
 
 static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
 
-static int get_normalized_path(const char *path, char **npath)
+static int get_normalized_path(const char *path, const char **npath)
 {
 	if (!path || strlen(path) < 3 || (*path != '\\' && *path != '/'))
 		return -EINVAL;
 
 	if (*path == '\\') {
-		*npath = (char *)path;
+		*npath = path;
 	} else {
-		*npath = kstrdup(path, GFP_KERNEL);
-		if (!*npath)
+		char *s = kstrdup(path, GFP_KERNEL);
+		if (!s)
 			return -ENOMEM;
-		convert_delimiter(*npath, '\\');
+		convert_delimiter(s, '\\');
+		*npath = s;
 	}
 	return 0;
 }
 
-static inline void free_normalized_path(const char *path, char *npath)
+static inline void free_normalized_path(const char *path, const char *npath)
 {
 	if (path != npath)
 		kfree(npath);
@@ -882,7 +883,7 @@ int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 		   struct dfs_cache_tgt_list *tgt_list)
 {
 	int rc;
-	char *npath;
+	const char *npath;
 	struct cache_entry *ce;
 
 	rc = get_normalized_path(path, &npath);
@@ -936,7 +937,7 @@ int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 			 struct dfs_cache_tgt_list *tgt_list)
 {
 	int rc;
-	char *npath;
+	const char *npath;
 	struct cache_entry *ce;
 
 	rc = get_normalized_path(path, &npath);
@@ -991,7 +992,7 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 			     const struct dfs_cache_tgt_iterator *it)
 {
 	int rc;
-	char *npath;
+	const char *npath;
 	struct cache_entry *ce;
 	struct cache_dfs_tgt *t;
 
@@ -1053,7 +1054,7 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 				   const struct dfs_cache_tgt_iterator *it)
 {
 	int rc;
-	char *npath;
+	const char *npath;
 	struct cache_entry *ce;
 	struct cache_dfs_tgt *t;
 
@@ -1111,7 +1112,7 @@ int dfs_cache_get_tgt_referral(const char *path,
 			       struct dfs_info3_param *ref)
 {
 	int rc;
-	char *npath;
+	const char *npath;
 	struct cache_entry *ce;
 
 	if (!it || !ref)
@@ -1484,7 +1485,7 @@ static int refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
 {
 	int rc = 0;
 	unsigned int xid;
-	char *path, *npath;
+	const char *path, *npath;
 	struct cache_entry *ce;
 	struct cifs_ses *root_ses = NULL, *ses;
 	struct dfs_info3_param *refs = NULL;
-- 
2.11.0

