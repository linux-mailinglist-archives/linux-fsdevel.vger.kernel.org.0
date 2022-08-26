Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571155A1EA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiHZCRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244762AbiHZCR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:17:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C9CAC92;
        Thu, 25 Aug 2022 19:17:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D466205B5;
        Fri, 26 Aug 2022 02:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX1J6cQNA1PNLcbJb0A3ip/on9dJ42qAkxah5LchdGc=;
        b=ZMrYY+B+4FbMMl74JGtpR8KBHV10aX6Pl3/aWU4ILDlNGEfxh18N+y9wj6oqgbV7G5SXUi
        jW/w+7+2MtyBCIPHBkQaJCNGRSdFp/AO1diIhOAGmzMACAd0rezrxfpDtM0tbLdP6IYwC7
        1SKuagjidoYpY4ahMfO7JvL7s206Ogg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX1J6cQNA1PNLcbJb0A3ip/on9dJ42qAkxah5LchdGc=;
        b=repLqx9CgqqKBvMLIzvMWpUVrKAFvZCRNtRMpv8QTE+BahyB8jr3JcSStdoBWP8ZQi4GIo
        QXzlI0Yuxhg8eVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A66F313A65;
        Fri, 26 Aug 2022 02:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4sQ4GDQtCGN8MQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:17:24 +0000
Subject: [PATCH 04/10] VFS: move dput() and mnt_drop_write() into
 done_path_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984374.25420.5286418066446165003.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All calls to done_path_update() are followed by the same two calls, so
merge them in.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 73c3319a1703..8df09c19f2b0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1734,6 +1734,8 @@ static void done_path_update(struct path *path, struct dentry *dentry,
 		inode_unlock_shared(dir);
 	else
 		inode_unlock(dir);
+	dput(dentry);
+	mnt_drop_write(path->mnt);
 }
 
 static struct dentry *lookup_fast(struct nameidata *nd)
@@ -3988,8 +3990,6 @@ EXPORT_SYMBOL(kern_path_create);
 void done_path_create_wq(struct path *path, struct dentry *dentry, bool with_wq)
 {
 	done_path_update(path, dentry, with_wq);
-	dput(dentry);
-	mnt_drop_write(path->mnt);
 	path_put(path);
 }
 EXPORT_SYMBOL(done_path_create_wq);
@@ -4310,8 +4310,6 @@ int do_rmdir(int dfd, struct filename *name)
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit3:
 	done_path_update(&path, dentry, true);
-	dput(dentry);
-	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -4446,8 +4444,6 @@ int do_unlinkat(int dfd, struct filename *name)
 				   &delegated_inode);
 exit3:
 		done_path_update(&path, dentry, true);
-		dput(dentry);
-		mnt_drop_write(path.mnt);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */


