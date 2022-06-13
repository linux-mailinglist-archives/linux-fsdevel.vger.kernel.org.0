Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71C54A286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiFMXUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiFMXUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5B2983D;
        Mon, 13 Jun 2022 16:20:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 34EB11F959;
        Mon, 13 Jun 2022 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dv0t/moe0oo2g4yNdVPUDgVdwdMBKpyu/x9jlXnCUWQ=;
        b=gat8BNdlwOtlhRNhKV7bDO0aFl07I0a2ImRNHxKdZm/OlKMUeP89eD7Vy0zTlZzn+fswIW
        BJBM3zg3jTWoZsgs0i5+oizCj6FvQ82vjWdHWLy/CPZ1lH+r529KPtVc9r/6gNiX2UlryB
        en50mmh+nZQeoojQnNnd+KiTbC01BgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dv0t/moe0oo2g4yNdVPUDgVdwdMBKpyu/x9jlXnCUWQ=;
        b=C0BcQJ7jOn+AVLULjJbrc70KgLqI8xMLcwgkLYm31PuvYVhtEl0PGgF4leaYNeOmCmrwuM
        E+UlmOtqwBVkhhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E824A134CF;
        Mon, 13 Jun 2022 23:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gk8JKEPGp2LNbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:35 +0000
Subject: [PATCH 04/12] VFS: move dput() and mnt_drop_write() into
 done_path_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516230198.21248.8276913837756883567.stgit@noble.brown>
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

All calls to done_path_update() are followed by the same two calls, so
merge them in.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 83ce2f7083be..f13bff877e30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1732,6 +1732,8 @@ static void done_path_update(struct path *path, struct dentry *dentry,
 	} else {
 		inode_unlock(dir);
 	}
+	dput(dentry);
+	mnt_drop_write(path->mnt);
 }
 
 static struct dentry *lookup_fast(struct nameidata *nd,
@@ -3953,8 +3955,6 @@ void done_path_create_wq(struct path *path, struct dentry *dentry,
 			 wait_queue_head_t *wq)
 {
 	done_path_update(path, dentry, wq);
-	dput(dentry);
-	mnt_drop_write(path->mnt);
 	path_put(path);
 }
 EXPORT_SYMBOL(done_path_create_wq);
@@ -4276,8 +4276,6 @@ int do_rmdir(int dfd, struct filename *name)
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
 exit3:
 	done_path_update(&path, dentry, &wq);
-	dput(dentry);
-	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -4412,8 +4410,6 @@ int do_unlinkat(int dfd, struct filename *name)
 				   &delegated_inode);
 exit3:
 		done_path_update(&path, dentry, &wq);
-		dput(dentry);
-		mnt_drop_write(path.mnt);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */


