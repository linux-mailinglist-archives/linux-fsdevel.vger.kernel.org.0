Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B854A28F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiFMXUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiFMXUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A52B18B;
        Mon, 13 Jun 2022 16:20:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1359221AA0;
        Mon, 13 Jun 2022 23:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MtfIrHZ/Ov+xd8eT4mDLOzkjS/G6SbIerKz5jiAI3I=;
        b=emhdbCNAOOE1/IwfamybQdjwRm6qZn705F8LzcQ4TGJWtMsWORR1RV8wvdI8R8UBwg+nqt
        eK5+M5UOZer6S5B8g2ga1SnAxggMidfD8MMxQpXfG++i5tF2QWh3rFD6OCqoSLfwIanldA
        jnosA1MI1CsarnyZzyJkV+EE52Oo9Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MtfIrHZ/Ov+xd8eT4mDLOzkjS/G6SbIerKz5jiAI3I=;
        b=7PhoTejWCCKC2GX1e1gWHKvG7tRdUbGbaSU82YIgswwoD+B5NXPg1o1E6WArermrtNdijf
        nJlbv0/YcU2Yl0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4033134CF;
        Mon, 13 Jun 2022 23:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NEFuI0nGp2LXbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:41 +0000
Subject: [PATCH 05/12] VFS: export done_path_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516230198.21248.8675541854979948509.stgit@noble.brown>
In-Reply-To: <165516173293.21248.14587048046993234326.stgit@noble.brown>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
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

This function will be be useful to nfsd, so export it.

done_path_create_wq() is now simple enough to be "static inline"
rather than an explicit export.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            |   11 ++---------
 include/linux/namei.h |   10 +++++++++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f13bff877e30..8ce7aa16b704 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1719,7 +1719,7 @@ struct dentry *lookup_hash_update_len(const char *name, int nlen,
 }
 EXPORT_SYMBOL(lookup_hash_update_len);
 
-static void done_path_update(struct path *path, struct dentry *dentry,
+void done_path_update(struct path *path, struct dentry *dentry,
 			     wait_queue_head_t *wq)
 {
 	struct inode *dir = path->dentry->d_inode;
@@ -1735,6 +1735,7 @@ static void done_path_update(struct path *path, struct dentry *dentry,
 	dput(dentry);
 	mnt_drop_write(path->mnt);
 }
+EXPORT_SYMBOL(done_path_update);
 
 static struct dentry *lookup_fast(struct nameidata *nd,
 				  struct inode **inode,
@@ -3951,14 +3952,6 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
 }
 EXPORT_SYMBOL(kern_path_create);
 
-void done_path_create_wq(struct path *path, struct dentry *dentry,
-			 wait_queue_head_t *wq)
-{
-	done_path_update(path, dentry, wq);
-	path_put(path);
-}
-EXPORT_SYMBOL(done_path_create_wq);
-
 inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 				       struct path *path, unsigned int lookup_flags)
 {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index f75c6639dd1a..217aa6de9f25 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -64,11 +64,19 @@ extern struct dentry *user_path_create(int, const char __user *, struct path *,
 extern struct dentry *lookup_hash_update_len(const char *name, int nlen,
 					     struct path *path, unsigned int flags,
 					     wait_queue_head_t *wq);
-extern void done_path_create_wq(struct path *, struct dentry *, wait_queue_head_t *wq);
+extern void done_path_update(struct path *, struct dentry *, wait_queue_head_t *);
+static inline void done_path_create_wq(struct path *path, struct dentry *dentry,
+				       wait_queue_head_t *wq)
+{
+	done_path_update(path, dentry, wq);
+	path_put(path);
+}
+
 static inline void done_path_create(struct path *path, struct dentry *dentry)
 {
 	done_path_create_wq(path, dentry, NULL);
 }
+
 extern struct dentry *kern_path_locked(const char *, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);


