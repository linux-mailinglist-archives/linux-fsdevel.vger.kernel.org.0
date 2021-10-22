Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E228C43809F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhJVXbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVXbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731CC061764;
        Fri, 22 Oct 2021 16:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FX9aI+GOJtOeeTz+wRNr+Q7TYcV4NPLZcLRWv0CVBZA=; b=DfFZiKrMCEv4e8JL8vj+/nmYvn
        n19fnVz2kzPmgmW304OU8rnoV15yFm4+c60NCXRaByYWkA0ZvC/qGU588dRdVLzr2DwemotOONZGh
        2wlaAVX/biwL6Jx8iOSWdrYwFcyB0oN7D7WKnRCjteykQPGDn1TFTUA1UQIOHQ74MAx/FudPH07pt
        X75ZOSDyvDb1oo8jEFJTEBXdLdFiwRIvldK63iWpHb5aLjAcSEV35fCmcX1IXOUOKmS0bRKkJutGU
        PdomJfXb9qCK+C32dVqMjdIIZTdg9CVyIBL8s2jYARcT2G6R6RQVXGrqc8YktP0QgaDIACeTGE5Rn
        AqKnkp3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me3xx-00C7us-53; Fri, 22 Oct 2021 23:28:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fs/super.c: defer more work after super_block is off of the super_blocks list
Date:   Fri, 22 Oct 2021 16:28:46 -0700
Message-Id: <20211022232846.2890326-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once it is off the super_blocks list we don't really need to hold the
sb_lock anymore, we can defer the rest of the work. This reduces a few
uneeded operations from contention from the sb_lock.

This is a minor optimization found through code inspection. If the
sb_lock is not needed, no need for contention to wait while we free
items. While at it, add a bit of documentation about the extent to
which the sb_lock is used.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index bcef3a6f4c4b..24a76490c46f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -43,6 +43,13 @@
 static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
+
+/**
+ * Protects the super_blocks list as well as the respective fs_type->fs_supers.
+ * When removing a super block it is first removed from the fs_type->fs_supers
+ * through generic_shutdown_super(). The final nail on the super block is the
+ * last temporary reference with __put_super().
+ */
 static DEFINE_SPINLOCK(sb_lock);
 
 static char *sb_writers_name[SB_FREEZE_LEVELS] = {
@@ -160,6 +167,11 @@ static void destroy_super_work(struct work_struct *work)
 							destroy_work);
 	int i;
 
+	security_sb_free(s);
+	fscrypt_sb_free(s);
+	put_user_ns(s->s_user_ns);
+	kfree(s->s_subtype);
+
 	for (i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -292,10 +304,6 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
-		security_sb_free(s);
-		fscrypt_sb_free(s);
-		put_user_ns(s->s_user_ns);
-		kfree(s->s_subtype);
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
@@ -471,7 +479,7 @@ void generic_shutdown_super(struct super_block *sb)
 		}
 	}
 	spin_lock(&sb_lock);
-	/* should be initialized for __put_super_and_need_restart() */
+	/* and so __put_super() does not need to deal with this */
 	hlist_del_init(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
-- 
2.30.2

