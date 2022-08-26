Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA805A1EAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiHZCRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiHZCRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:17:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9ECCB5C6;
        Thu, 25 Aug 2022 19:17:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8075D37C48;
        Fri, 26 Aug 2022 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+8viLpougDqoZ3c2irip0hIncJfW0LZqVa6iHVhTNQ=;
        b=tE7Ar2PfLeRF49+BfC+zIylyt66pdi+70EsThmDh3Eh9ym4yC1G2qufHiowPkUbLi/ru+1
        3sQu/zDLA8k9yDwHY3w/UrXWkYUAOiL/ldYI3hR0HWTWzjViFGrerRgd6AVsRa6fWTsm21
        i22kGXZnn0M0l//G7LkRhTtVJbkzMZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+8viLpougDqoZ3c2irip0hIncJfW0LZqVa6iHVhTNQ=;
        b=TdJUMPaapoWi/O8DM8cNqlIzQ+Zq6g6x3W9NCoKJZScnStTOwJqEi/sTviwRQ3uz8dhs6v
        Jt7NSgDcyF1WKyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E289413A65;
        Fri, 26 Aug 2022 02:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XlaBJjotCGOAMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:17:30 +0000
Subject: [PATCH 05/10] VFS: export done_path_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984375.25420.10074672773757634204.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function will be useful to nfsd, so export it.  As most callers
will want "with_wq" to be true, rename the current done_path_update() to
__done_path_update() and add a new done_path_update() which sets with_wq
to true.

done_path_create_wq() is now simple enough to be "static inline"
rather than an explicit export.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            |   16 +++++-----------
 include/linux/namei.h |   16 ++++++++++++++--
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8df09c19f2b0..13f8ac9721be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1723,8 +1723,8 @@ struct dentry *lookup_hash_update_len(const char *name, int nlen,
 }
 EXPORT_SYMBOL(lookup_hash_update_len);
 
-static void done_path_update(struct path *path, struct dentry *dentry,
-			     bool with_wq)
+void __done_path_update(struct path *path, struct dentry *dentry,
+			bool with_wq)
 {
 	struct inode *dir = path->dentry->d_inode;
 
@@ -1737,6 +1737,7 @@ static void done_path_update(struct path *path, struct dentry *dentry,
 	dput(dentry);
 	mnt_drop_write(path->mnt);
 }
+EXPORT_SYMBOL(__done_path_update);
 
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
@@ -3987,13 +3988,6 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
 }
 EXPORT_SYMBOL(kern_path_create);
 
-void done_path_create_wq(struct path *path, struct dentry *dentry, bool with_wq)
-{
-	done_path_update(path, dentry, with_wq);
-	path_put(path);
-}
-EXPORT_SYMBOL(done_path_create_wq);
-
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 				       struct path *path, unsigned int lookup_flags)
 {
@@ -4309,7 +4303,7 @@ int do_rmdir(int dfd, struct filename *name)
 	mnt_userns = mnt_user_ns(path.mnt);
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit3:
-	done_path_update(&path, dentry, true);
+	done_path_update(&path, dentry);
 exit2:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -4443,7 +4437,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_userns, path.dentry->d_inode, dentry,
 				   &delegated_inode);
 exit3:
-		done_path_update(&path, dentry, true);
+		done_path_update(&path, dentry);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b7a123b489b1..b1a210a51210 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -64,11 +64,23 @@ extern struct dentry *user_path_create(int, const char __user *, struct path *,
 extern struct dentry *lookup_hash_update_len(const char *name, int nlen,
 					     struct path *path, unsigned int flags,
 					     wait_queue_head_t *wq);
-extern void done_path_create_wq(struct path *, struct dentry *, bool);
+extern void __done_path_update(struct path *, struct dentry *, bool);
+static inline void done_path_update(struct path *path, struct dentry *dentry)
+{
+	__done_path_update(path, dentry, true);
+}
 static inline void done_path_create(struct path *path, struct dentry *dentry)
 {
-	done_path_create_wq(path, dentry, false);
+	__done_path_update(path, dentry, false);
+	path_put(path);
 }
+static inline void done_path_create_wq(struct path *path, struct dentry *dentry,
+				       bool with_wq)
+{
+	__done_path_update(path, dentry, with_wq);
+	path_put(path);
+}
+
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);


