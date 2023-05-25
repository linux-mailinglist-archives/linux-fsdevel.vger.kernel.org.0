Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C317109BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjEYKQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbjEYKQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674F19C;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DE951FDF3;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1a706nvJAUFN5XV8S/WpIDOKkkOdApV/Ro1TI96n07M=;
        b=WF7ucq3EohcQN4Zdd0uT/fFdsa8wjWrK6l6vxoEqctxmlkzB4ooSOvY3VcWiLa7+g34cR7
        VHGXOHjAnbf4SezXiEu502plqKbzYSjzLI+GLpNq6EMLCFyQWC9aoWbaU2jBGH1ViU5jHp
        /fK4tgoaDvoCBgCm/w1TLpScqmvNKDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1a706nvJAUFN5XV8S/WpIDOKkkOdApV/Ro1TI96n07M=;
        b=eqqvROyawmipPY/sh6fIFMu5wo+Um28Jle2T5lFkcvKQAMEfANT86QA5ChAiT5SwmD3TWy
        Hd/7Jpd5YLdKclCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF0BE13A83;
        Thu, 25 May 2023 10:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8gEyOng1b2RFdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67514A0763; Thu, 25 May 2023 12:16:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH 4/6] fs: Establish locking order for unrelated directories
Date:   Thu, 25 May 2023 12:16:10 +0200
Message-Id: <20230525101624.15814-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255; i=jack@suse.cz; h=from:subject; bh=7Zjx87tnvKzgfzM5iEQSkxMSNXquNjJWVKfK0RapY3g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVppUsaG0BgBchvbsn9Z5bJBxKa6RWvd1b3zeFa aJovYjWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81aQAKCRCcnaoHP2RA2VFZCA DDEhaZsVxenuLiK64HlnVAlGnOmVGorNpQmXxPET1UHzPGs0Tow9+aBVymq+BRY1IOFoG8IaiJGPJa YBEyFb3TIXNXqluOIIw9AACBYYnTUh0D9dKdbUJ+K3o6hA10l61kbLpwHwSAAE06kMKTyopzZ4j+Im ClMZ8FfO6c39OhKTvpnZ5rjAgYMaKkn/Pb4Z0kOMLWgk092TwOaBDvXh7sunqQeXdg21fvTP4ISZtO 9EpoYoqZ7WT2j0eNE/o6GWWfL0mhvjsankyL4hgCxFkZoBEU9SkORA8MPexpHhI0zsapm72Uvdk/jn IKbtyKkJ43wtrM4E999/0WmIDFKUch
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the locking order of inode locks for directories that are not
in ancestor relationship is not defined because all operations that
needed to lock two directories like this were serialized by
sb->s_vfs_rename_mutex. However some filesystems need to lock two
subdirectories for RENAME_EXCHANGE operations and for this we need the
locking order established even for two tree-unrelated directories.
Provide a helper function lock_two_inodes() that establishes lock
ordering for any two inodes and use it in lock_two_directories().

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c    | 34 ++++++++++++++++++++++++++++++++++
 fs/internal.h |  2 ++
 fs/namei.c    |  4 ++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 577799b7855f..2015fa50d34a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1103,6 +1103,40 @@ void discard_new_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(discard_new_inode);
 
+/**
+ * lock_two_inodes - lock two inodes (may be regular files but also dirs)
+ *
+ * Lock any non-NULL argument. The caller must make sure that if he is passing
+ * in two directories, one is not ancestor of the other.  Zero, one or two
+ * objects may be locked by this function.
+ *
+ * @inode1: first inode to lock
+ * @inode2: second inode to lock
+ * @subclass1: inode lock subclass for the first lock obtained
+ * @subclass2: inode lock subclass for the second lock obtained
+ */
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2)
+{
+	if (!inode1 || !inode2)
+		goto lock;
+
+	/*
+	 * If one object is directory and the other is not, we must make sure
+	 * to lock directory first as the other object may be its child.
+	 */
+	if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
+		if (inode1 > inode2)
+			swap(inode1, inode2);
+	} else if (!S_ISDIR(inode1->i_mode))
+		swap(inode1, inode2);
+lock:
+	if (inode1)
+		inode_lock_nested(inode1, subclass1);
+	if (inode2 && inode2 != inode1)
+		inode_lock_nested(inode2, subclass2);
+}
+
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..377030a50aca 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -152,6 +152,8 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
 int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
 bool in_group_or_capable(struct mnt_idmap *idmap,
 			 const struct inode *inode, vfsgid_t vfsgid);
+void lock_two_inodes(struct inode *inode1, struct inode *inode2,
+		     unsigned subclass1, unsigned subclass2);
 
 /*
  * fs-writeback.c
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..148570aabe74 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3028,8 +3028,8 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 		return p;
 	}
 
-	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	lock_two_inodes(p1->d_inode, p2->d_inode,
+			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
 
-- 
2.35.3

