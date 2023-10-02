Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0F97B4AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjJBCf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:35:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64381A7
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Stmulw48FdcNh/sko1+XXezL/Lvn9Cb50aXxMLdgwF8=; b=eJsWYDu1NTflig0onPEEh0pWvH
        Ow4GzqHF/CklTIgec8B7h08CElswTobBDdgFqMuN8dYD0JcYvQAruxk5Dzi3cUlhDNyLe3gmNlJDZ
        /cMxwOVSOKI9dKz/19bmHUlvinTnFVSj9AgGvoVMwICTUrVNqgPLJZdRxodcIAj5kakGUUoIWsw5v
        3m/bMezhzC+SGdp4pcgxSQQqRKU+S4IwJ1+JBeNDavBO6nY6AYFCmzjnXLo46fBeRd8EhNq1qndIX
        g4iBSMaPaM6Wen3WhRq23x3M3lMF9akvv7sn8g6ZqgvoUer3n6/EZYcSjWPRPOzMnnS/c5qFsOFhZ
        xuOLOgEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8mH-00EDxn-2J;
        Mon, 02 Oct 2023 02:35:21 +0000
Date:   Mon, 2 Oct 2023 03:35:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/15] fuse: fix UAF in rcu pathwalks
Message-ID: <20231002023521.GL3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->permission(), ->get_link() and ->inode_get_acl() might dereference
->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
as well) when called from rcu pathwalk.

Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
and dropping ->user_ns rcu-delayed too.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/cuse.c   |  3 +--
 fs/fuse/fuse_i.h |  1 +
 fs/fuse/inode.c  | 15 +++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..b6cad106c37e 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -474,8 +474,7 @@ static int cuse_send_init(struct cuse_conn *cc)
 
 static void cuse_fc_release(struct fuse_conn *fc)
 {
-	struct cuse_conn *cc = fc_to_cc(fc);
-	kfree_rcu(cc, fc.rcu);
+	kfree(fc_to_cc(fc));
 }
 
 /**
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..0c45014fbb03 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -873,6 +873,7 @@ struct fuse_mount {
 
 	/* Entry on fc->mounts */
 	struct list_head fc_entry;
+	struct rcu_head rcu;
 };
 
 static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..e13c9312cb55 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -881,6 +881,14 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
+static void delayed_release(struct rcu_head *p)
+{
+	struct fuse_conn *fc = container_of(p, struct fuse_conn, rcu);
+
+	put_user_ns(fc->user_ns);
+	fc->release(fc);
+}
+
 void fuse_conn_put(struct fuse_conn *fc)
 {
 	if (refcount_dec_and_test(&fc->count)) {
@@ -892,13 +900,12 @@ void fuse_conn_put(struct fuse_conn *fc)
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
-		put_user_ns(fc->user_ns);
 		bucket = rcu_dereference_protected(fc->curr_bucket, 1);
 		if (bucket) {
 			WARN_ON(atomic_read(&bucket->count) != 1);
 			kfree(bucket);
 		}
-		fc->release(fc);
+		call_rcu(&fc->rcu, delayed_release);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
@@ -1316,7 +1323,7 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
 void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
-	kfree_rcu(fc, rcu);
+	kfree(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_free_conn);
 
@@ -1833,7 +1840,7 @@ static void fuse_sb_destroy(struct super_block *sb)
 void fuse_mount_destroy(struct fuse_mount *fm)
 {
 	fuse_conn_put(fm->fc);
-	kfree(fm);
+	kfree_rcu(fm, rcu);
 }
 EXPORT_SYMBOL(fuse_mount_destroy);
 
-- 
2.39.2

