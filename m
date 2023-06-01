Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351DD719A52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFAK6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjFAK6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:58:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9412C;
        Thu,  1 Jun 2023 03:58:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FFBE1FD99;
        Thu,  1 Jun 2023 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685617111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzXOzo95g617qUk7Z949h4EoD3WLK3t1qcqqyGoLxTU=;
        b=JnxZsTeRlkpGAeNVzMjBvMt7Um93iLPpsI45FFwBn30paVGGbNnEWH9M38MdENSm/kGngr
        DioDvnCcG1CcHf7FQaY8W0HEFG7aKNjvivi3Ap/HmVOb0RlNIIEAtXneeUIB3XUbbBvMbk
        zXCS+ZxYtK5OM8dZmOv8TRYohjVDer8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685617111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzXOzo95g617qUk7Z949h4EoD3WLK3t1qcqqyGoLxTU=;
        b=12MljAV3Jn4lWXoFOIkKiAO7uA5l6sXWVPVfp8DSkd5pTHVzE2MnGWF2CEZjuth948cp5s
        BtU9qfzM+5cVWrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 122FA13A34;
        Thu,  1 Jun 2023 10:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mmNoBNd5eGSCWAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 10:58:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2CDDBA0764; Thu,  1 Jun 2023 12:58:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 6/6] fs: Restrict lock_two_nondirectories() to non-directory inodes
Date:   Thu,  1 Jun 2023 12:58:26 +0200
Message-Id: <20230601105830.13168-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230601104525.27897-1-jack@suse.cz>
References: <20230601104525.27897-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=jack@suse.cz; h=from:subject; bh=yzjONH0NaYO0JExUsRNFVNqF61b/6Z8qTkqJfHdGKlg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkeHnRAOKwOpYmoYaDVDZoAJJC7iZvp0hWjbPFBMUr e9B2zauJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZHh50QAKCRCcnaoHP2RA2ZLRB/ 9A5mErZNr1GSw4bvqyRiHpBJmYLCWR4lihVK9MrTDZk08vVOCpc8BAsxg5oODQk0iMm3VyWYYLKWrR tZpGfLNVVN9J+mp08tZRHTqzVmO2Vg1q/2eiHEQkWYSPHnJHAmAPXsS2XuUUkxDmK5B+rPgf+hKsFQ 5qg5tUZAuaUsZGy1zMAqXObFZSzjefBZrc251g++8ukB03T/LNLAVwtjvKgGmesBoq8BJdO93TYFlB INP8z2ollQ8Oqi7hSsJH2uhrQleqLb+y1+OfV/Ocf+LM4vBCuWoJGtGua+7Rg5bpG/kpJEXZmghiEY 6HGqXDo1+FmRvBPkx7nJT/lFffiE8I
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4000ab08bbc0..e8d10fd18378 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1148,7 +1148,7 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
 /**
  * lock_two_nondirectories - take two i_mutexes on non-directory objects
  *
- * Lock any non-NULL argument that is not a directory.
+ * Lock any non-NULL argument. Passed objects must not be directories.
  * Zero, one or two objects may be locked by this function.
  *
  * @inode1: first inode to lock
@@ -1156,13 +1156,9 @@ void lock_two_inodes(struct inode *inode1, struct inode *inode2,
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
 
@@ -1173,9 +1169,11 @@ EXPORT_SYMBOL(lock_two_nondirectories);
  */
 void unlock_two_nondirectories(struct inode *inode1, struct inode *inode2)
 {
-	if (inode1 && !S_ISDIR(inode1->i_mode))
+	WARN_ON_ONCE(S_ISDIR(inode1->i_mode));
+	WARN_ON_ONCE(S_ISDIR(inode2->i_mode));
+	if (inode1)
 		inode_unlock(inode1);
-	if (inode2 && !S_ISDIR(inode2->i_mode) && inode2 != inode1)
+	if (inode2 && inode2 != inode1)
 		inode_unlock(inode2);
 }
 EXPORT_SYMBOL(unlock_two_nondirectories);
-- 
2.35.3

