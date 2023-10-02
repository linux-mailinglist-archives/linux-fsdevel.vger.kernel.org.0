Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5D7B4ACB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjJBCbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBCbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:31:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A999
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EjWkAFYMC0New8r7aI9BMXvNYwHQVwhCzm32GsCIcMM=; b=LNMOzE9HNjI7l5/HOfjK+R9TjL
        OD8Xi7CUMgF7CBxoST/Qqex7A8cDPOijTTQmtc5dzf+nH5BDzkblTiP+Dj8+o26F7NUS5kWBeTBgI
        In6daHJa3mTHaaNOqUoV+w4amdJL3M6Gpi3whG+dlKRUDhUfGRdZjknPq5YqFqp471zbSQAjW1MM8
        v1DmLAbPmq9urd69IA1G3EKrrM3dOusLfXAvPROys5sgUws9m/fCBlDtr3GLuxonk63cixh0vhfR4
        hyNfc5ODFb5mql2YfVQRXcpMC9ihbJr/H/ru6ukvcaPLQ6y7LtVIL5CQQxkNetXyJR76ozg7hk4VU
        wqJxHU+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8iT-00EDrb-2C;
        Mon, 02 Oct 2023 02:31:25 +0000
Date:   Mon, 2 Oct 2023 03:31:25 +0100
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
Subject: [PATCH 04/15] hfsplus: switch to rcu-delayed unloading of nls and
 freeing ->s_fs_info
Message-ID: <20231002023125.GE3389589@ZenIV>
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

->d_hash() and ->d_compare() use those, so we need to delay freeing
them.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/super.c      | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7ededcb720c1..012a3d003fbe 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -190,6 +190,7 @@ struct hfsplus_sb_info {
 	int work_queued;               /* non-zero delayed work is queued */
 	struct delayed_work sync_work; /* FS sync delayed work */
 	spinlock_t work_lock;          /* protects sync_work and work_queued */
+	struct rcu_head rcu;
 };
 
 #define HFSPLUS_SB_WRITEBACKUP	0
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..97920202790f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -277,6 +277,14 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
 	spin_unlock(&sbi->work_lock);
 }
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct hfsplus_sb_info *sbi = container_of(p, struct hfsplus_sb_info, rcu);
+
+	unload_nls(sbi->nls);
+	kfree(sbi);
+}
+
 static void hfsplus_put_super(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
@@ -302,9 +310,7 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	unload_nls(sbi->nls);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	call_rcu(&sbi->rcu, delayed_free);
 }
 
 static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
-- 
2.39.2

