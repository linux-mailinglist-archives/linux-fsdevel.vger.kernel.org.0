Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95E7109CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbjEYKQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjEYKQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E951AB;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73BB41FDFD;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qb4QVxqWbxY1BUOm/HZ1IAfPjmpuRF1GxZ/XtPI44ow=;
        b=dtO9RTZnM1fRgA0bjNf++oA62lCe+zVeecOqlSOBb/tz4PcV5d2oX7oWQYpalOoEH6ZpoN
        9pwOiU+ZoJTOq2RvRat5ivePyYu3GhG3k9KnsE8N9wLaGW0qy6tRlbbtPacjvFXOxtexoz
        IDlZaYBrVerxDU+oekFobdFaKAWYjAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qb4QVxqWbxY1BUOm/HZ1IAfPjmpuRF1GxZ/XtPI44ow=;
        b=efn70QkU372o8H6xDPqEw653+1DqpgjqZS4dC7xtD6/6Za7bbNHH+Xn3DXt+ylh+mLACOZ
        5TIb4krY6txILKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61B8313A2C;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P9zvF3k1b2RUdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 71E21A0765; Thu, 25 May 2023 12:16:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] fs: Restrict lock_two_nondirectories() to non-directory inodes
Date:   Thu, 25 May 2023 12:16:12 +0200
Message-Id: <20230525101624.15814-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=jack@suse.cz; h=from:subject; bh=19vPa5MXihbI/vWBHK7A4hiBHoUR5MdlQiCbMXq3hU8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVrykH7A7q3YHZUXsS6ieeUX672QjHsKNA8icRS hsWFj0GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81awAKCRCcnaoHP2RA2YARB/ 9gmSc9fUNiS36GUafnxhkegVOmOuan17kymaFtzzDDxN0mssrXV2LmeEzAklvwvI0n34vYU6TMF47N kBXJYSEm04O/dr8b+YfAm/fBhg7ZLnlX1a4KmqVwsadXXB+YZ1dlWniYhakV2xlyKu8HwETV1ghFsD usEyvQwXBA0f9yabKbZ3tQcXBh30hqIuffinSeGCr5mZpGkB4sBiO8Qsnq65x0kJMNZnk5aVxHbIfT zrdP+6kkv7TYve3PtK+qeTwrbYiTcEMLz3mJ8azfb8TbOfGicp7mzhJhPJJyjaYUO8x71eEVNNVWHr EfU5sthG72webH7lxc9Nooo8hkuKpN
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

Currently lock_two_nondirectories() is skipping any passed directories.
After vfs_rename() uses lock_two_inodes(), all the remaining four users
of this function pass only regular files to it. So drop the somewhat
unusual "skip directory" logic and instead warn if anybody passes
directory to it. This also allows us to use lock_two_inodes() in
lock_two_nondirectories() to concentrate the lock ordering logic in less
places.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2015fa50d34a..accf5125a049 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1140,7 +1140,7 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
- * Lock any non-NULL argument that is not a directory.
+ * Lock any non-NULL argument. Passed objects must not be directories.
  * Zero, one or two objects may be locked by this function.
  *
  * @inode1: first inode to lock
@@ -1148,13 +1148,9 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
  */
 void lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
 {
-	if (inode1 > inode2)
-		swap(inode1, inode2);
-
-	if (inode1 && !S_ISDIR(inode1->i_mode))
-		inode_lock(inode1);
-	if (inode2 && !S_ISDIR(inode2->i_mode) && inode2 != inode1)
-		inode_lock_nested(inode2, I_MUTEX_NONDIR2);
+	WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
+	WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
+	lock_two_inodes(inode1, inode2, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
 }
 EXPORT_SYMBOL(lock_two_nondirectories);
 
-- 
2.35.3

