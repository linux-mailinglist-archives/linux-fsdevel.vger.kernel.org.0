Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF66342A8B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCTEfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 00:35:48 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58358 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCTEfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDa-NV; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] cifs: switch build_path_from_dentry() to using dentry_path_raw()
Date:   Sat, 20 Mar 2021 04:33:04 +0000
Message-Id: <20210320043304.1803623-7-viro@zeniv.linux.org.uk>
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

The cost is that we might need to flip '/' to '\\' in more than
just the prefix.  Needs profiling, but I suspect that we won't
get slowdown on that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/dir.c | 83 +++++++++++++++--------------------------------------------
 1 file changed, 21 insertions(+), 62 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 6e855f004f50..3febf667d119 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -93,20 +93,16 @@ char *
 build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 				       bool prefix)
 {
-	struct dentry *temp;
-	int namelen;
 	int dfsplen;
 	int pplen = 0;
-	char *full_path = page;
-	char dirsep;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
-	unsigned seq;
+	char dirsep = CIFS_DIR_SEP(cifs_sb);
+	char *s;
 
 	if (unlikely(!page))
 		return ERR_PTR(-ENOMEM);
 
-	dirsep = CIFS_DIR_SEP(cifs_sb);
 	if (prefix)
 		dfsplen = strnlen(tcon->treeName, MAX_TREE_SIZE + 1);
 	else
@@ -115,74 +111,37 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH)
 		pplen = cifs_sb->prepath ? strlen(cifs_sb->prepath) + 1 : 0;
 
-cifs_bp_rename_retry:
-	namelen = dfsplen + pplen;
-	seq = read_seqbegin(&rename_lock);
-	rcu_read_lock();
-	for (temp = direntry; !IS_ROOT(temp);) {
-		namelen += (1 + temp->d_name.len);
-		temp = temp->d_parent;
-	}
-	rcu_read_unlock();
-
-	if (namelen >= PAGE_SIZE)
+	s = dentry_path_raw(direntry, page, PAGE_SIZE);
+	if (IS_ERR(s))
+		return s;
+	if (s < (char *)page + pplen + dfsplen)
 		return ERR_PTR(-ENAMETOOLONG);
-
-	full_path[namelen] = 0;	/* trailing null */
-	rcu_read_lock();
-	for (temp = direntry; !IS_ROOT(temp);) {
-		spin_lock(&temp->d_lock);
-		namelen -= 1 + temp->d_name.len;
-		if (namelen < 0) {
-			spin_unlock(&temp->d_lock);
-			break;
-		} else {
-			full_path[namelen] = dirsep;
-			strncpy(full_path + namelen + 1, temp->d_name.name,
-				temp->d_name.len);
-			cifs_dbg(FYI, "name: %s\n", full_path + namelen);
-		}
-		spin_unlock(&temp->d_lock);
-		temp = temp->d_parent;
-	}
-	rcu_read_unlock();
-	if (namelen != dfsplen + pplen || read_seqretry(&rename_lock, seq)) {
-		cifs_dbg(FYI, "did not end path lookup where expected. namelen=%ddfsplen=%d\n",
-			 namelen, dfsplen);
-		/* presumably this is only possible if racing with a rename
-		of one of the parent directories  (we can not lock the dentries
-		above us to prevent this, but retrying should be harmless) */
-		goto cifs_bp_rename_retry;
-	}
-	/* DIR_SEP already set for byte  0 / vs \ but not for
-	   subsequent slashes in prepath which currently must
-	   be entered the right way - not sure if there is an alternative
-	   since the '\' is a valid posix character so we can not switch
-	   those safely to '/' if any are found in the middle of the prepath */
-	/* BB test paths to Windows with '/' in the midst of prepath */
-
 	if (pplen) {
-		int i;
-
 		cifs_dbg(FYI, "using cifs_sb prepath <%s>\n", cifs_sb->prepath);
-		memcpy(full_path+dfsplen+1, cifs_sb->prepath, pplen-1);
-		full_path[dfsplen] = dirsep;
-		for (i = 0; i < pplen-1; i++)
-			if (full_path[dfsplen+1+i] == '/')
-				full_path[dfsplen+1+i] = CIFS_DIR_SEP(cifs_sb);
+		s -= pplen;
+		memcpy(s + 1, cifs_sb->prepath, pplen - 1);
+		*s = '/';
 	}
+	if (dirsep != '/') {
+		/* BB test paths to Windows with '/' in the midst of prepath */
+		char *p;
 
+		for (p = s; *p; p++)
+			if (*p == '/')
+				*p = dirsep;
+	}
 	if (dfsplen) {
-		strncpy(full_path, tcon->treeName, dfsplen);
+		s -= dfsplen;
+		memcpy(page, tcon->treeName, dfsplen);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
 			int i;
 			for (i = 0; i < dfsplen; i++) {
-				if (full_path[i] == '\\')
-					full_path[i] = '/';
+				if (s[i] == '\\')
+					s[i] = '/';
 			}
 		}
 	}
-	return full_path;
+	return s;
 }
 
 /*
-- 
2.11.0

