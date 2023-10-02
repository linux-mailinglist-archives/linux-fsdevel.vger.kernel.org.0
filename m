Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73717B4ACE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjJBCch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:32:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21899
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PfMFJEm5A7yLka9iOS31iWCBDEFtH0eaxQuSkPNFxSQ=; b=MRCHqgAXpo2u+0MxKwODfG67iD
        Y1OgSCLcKjG9W0S/mcP9BKVa1EK3yM5GuvElFuWcQTBL4J9uNBhDJ5jjBo1dpo5O+tOyNcjnI4MD1
        PK2IDEPfMw7lggUT80oJmXRMyIRDkvHkr39MtbQjj8Mmw27NjiRQjMFqu3q2z6IT3SAjCM1qZ7bZK
        XZHUbVGDGEX4QVSG1W2Y4Kxeb51+fwxf+Mw7NVp5yBqST329q4X++FQqTlUYldIOds64hVK+mDEHC
        ep5n70+o3J1YCq+IalCKKHLVycbGPQRrq/NyFFQPenwDdXxjNq8+24BiHiscQCEl38OIdSSfBCaDZ
        glq5H6AQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8jY-00EDtp-02;
        Mon, 02 Oct 2023 02:32:32 +0000
Date:   Mon, 2 Oct 2023 03:32:31 +0100
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
Subject: [PATCH 06/15] procfs: move dropping pde and pid from ->evict_inode()
 to ->free_inode()
Message-ID: <20231002023231.GG3389589@ZenIV>
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

that keeps both around until struct inode is freed, making access
to them safe from rcu-pathwalk

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c  |  2 --
 fs/proc/inode.c | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..8e93b11a0fed 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1881,8 +1881,6 @@ void proc_pid_evict_inode(struct proc_inode *ei)
 		hlist_del_init_rcu(&ei->sibling_inodes);
 		spin_unlock(&pid->lock);
 	}
-
-	put_pid(pid);
 }
 
 struct inode *proc_pid_make_inode(struct super_block *sb,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 532dc9d240f7..c83e1a55da42 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -30,7 +30,6 @@
 
 static void proc_evict_inode(struct inode *inode)
 {
-	struct proc_dir_entry *de;
 	struct ctl_table_header *head;
 	struct proc_inode *ei = PROC_I(inode);
 
@@ -38,17 +37,8 @@ static void proc_evict_inode(struct inode *inode)
 	clear_inode(inode);
 
 	/* Stop tracking associated processes */
-	if (ei->pid) {
+	if (ei->pid)
 		proc_pid_evict_inode(ei);
-		ei->pid = NULL;
-	}
-
-	/* Let go of any associated proc directory entry */
-	de = ei->pde;
-	if (de) {
-		pde_put(de);
-		ei->pde = NULL;
-	}
 
 	head = ei->sysctl;
 	if (head) {
@@ -80,6 +70,13 @@ static struct inode *proc_alloc_inode(struct super_block *sb)
 
 static void proc_free_inode(struct inode *inode)
 {
+	struct proc_inode *ei = PROC_I(inode);
+
+	if (ei->pid)
+		put_pid(ei->pid);
+	/* Let go of any associated proc directory entry */
+	if (ei->pde)
+		pde_put(ei->pde);
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
-- 
2.39.2

