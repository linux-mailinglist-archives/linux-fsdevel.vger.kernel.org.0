Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4760D7109D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbjEYKQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjEYKQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1554C12E;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 11DE81FDFA;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=;
        b=pe0+3hEzZs7uN2Ol1+io5lGnFYDTh14sFgC0p8Ydn8E6J1k8UmcEA+dOfNAfh1gnrQF31z
        1U9OGFsBqpX4AASin+dz8m9io5sc9GoSnWXVl+wgTuVLSvdyMTrk4PMgcafpzURnp3AQO8
        /hPmuePDSH5Q6vbvtJ6qwbFnIfCNB4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOBPab5sBc+U602a0bs2SOLbJwxohD0hSk5muDSlfQg=;
        b=v2LWRjHb+z/Fzc1yDbthCZ8Pn4nZRl48BHUTptKXVjiYJyHOzF/e05RnyYm3SQTVozdyHg
        ULbpgWrAA6w+evDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01D64134B2;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BWpWAHk1b2RIdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 577BCA075D; Thu, 25 May 2023 12:16:24 +0200 (CEST)
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
Subject: [PATCH 1/6] ext4: Remove ext4 locking of moved directory
Date:   Thu, 25 May 2023 12:16:07 +0200
Message-Id: <20230525101624.15814-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=jack@suse.cz; h=from:subject; bh=XV5CJdcSgiBkW1x4p8thTfL0TVuanLRiOHdfMG5wLnM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVnIGpGZWT4yPVsBHE7bfA4OPMkWz6HswnwkkBL wMv1XtaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81ZwAKCRCcnaoHP2RA2djMB/ 9TuRgCE19tiF4YfdSdVgRs89YRrDmmE3NTXAbSIuixbqPMs/OBoKR+IrdEhocemPpvsbhKgYyq6pde GD08bNXqBYlC0N7WtEw16cb4LN/eI/F61YOFBg4KAWdPP2MW1hrfKqRKHgRiuRHCbdmZqLVok3aTFp 1Qr+X/ew4ZRXZQKMLFXhUsaRRQ+efZvQh7lYWVuVP0wKGwST8ZqSgemvm5nH7h/75mR768e1g414NX MYIQoHxmL5RXtLav4o/2MuPeb2D45T1AzoSUYrkMR8J/mTGAc+39zgKAT2B5r8H3rnw95ZrS6ps/N1 ALUuca31HdAz6ByRtuZyPuvC/Wt2sJ
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

Remove locking of moved directory in ext4_rename2(). We will take care
of it in VFS instead. This effectively reverts commit 0813299c586b
("ext4: Fix possible corruption when moving a directory") and followup
fixes.

CC: Ted Tso <tytso@mit.edu>
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 45b579805c95..0caf6c730ce3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3834,19 +3834,10 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			return retval;
 	}
 
-	/*
-	 * We need to protect against old.inode directory getting converted
-	 * from inline directory format into a normal one.
-	 */
-	if (S_ISDIR(old.inode->i_mode))
-		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
-
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
 				 &old.inlined);
-	if (IS_ERR(old.bh)) {
-		retval = PTR_ERR(old.bh);
-		goto unlock_moved_dir;
-	}
+	if (IS_ERR(old.bh))
+		return PTR_ERR(old.bh);
 
 	/*
 	 *  Check for inode number is _not_ due to possible IO errors.
@@ -4043,10 +4034,6 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	brelse(old.bh);
 	brelse(new.bh);
 
-unlock_moved_dir:
-	if (S_ISDIR(old.inode->i_mode))
-		inode_unlock(old.inode);
-
 	return retval;
 }
 
-- 
2.35.3

