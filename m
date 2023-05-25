Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DFA7109C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjEYKQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjEYKQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:16:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708C1A8;
        Thu, 25 May 2023 03:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00FF321C04;
        Thu, 25 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685009785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioHF3wJZOEdK9Zi2g8x0HxHqMAZdyIP3moICR5/W8ZM=;
        b=zlI5luAWs6dlefQrgCyE8/RxotUnEISB/qpqoF0e6pJkMf70IuPfZsQ+zPVXMciXD80L5y
        KE9IraxZiqxObo476RsgM+aR8fA2F0/n+EuBJJ2hN5Lp3yn0u5EjEJOwfWQQhSdQHXxPlX
        MuVIjOmhBhYpP2rtxhl1RAAqwTJu0t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685009785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ioHF3wJZOEdK9Zi2g8x0HxHqMAZdyIP3moICR5/W8ZM=;
        b=Bq+jfOFsP+9HFcZSWTVhJXL79d71c35osZNrCmaovcKk2E0tzyKERfjBVYIXaFAFjomY01
        Is72rB8LCDpCnPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E60E313A2C;
        Thu, 25 May 2023 10:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +G4iOHg1b2RDdgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 10:16:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D1CEA075F; Thu, 25 May 2023 12:16:24 +0200 (CEST)
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
Subject: [PATCH 2/6] Revert "udf: Protect rename against modification of moved directory"
Date:   Thu, 25 May 2023 12:16:08 +0200
Message-Id: <20230525101624.15814-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=jack@suse.cz; h=from:subject; bh=cUFu/3mUBi4bt/K+j6IZ3Ng8iPItrjlJa92MM2nlCwY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkbzVnIPd8xE0p+HpULv7ZaonyuahLzBKAgbz88fay PJv6AsKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG81ZwAKCRCcnaoHP2RA2fRdB/ wMo8PsY3/7QbU+9pwKfl8SOaMaHlJdjPgdRPs0Q59CmemAwPozLN+6Q+dDzy++ajVHXFcxUC1slW/J vNVYlOShU3+bOeu1zmdzl7mmYDeDDJjibd0gjB06IwHZRXlUG/KXqso6fC0CgL7NQhyiaqphZCP1qn VaXNgip5UnA5k75piXNMOfpFaskUp6AKbSMl1J2jumzY8VCN4UFEf/0T5Q8vhIOFm8Ebv/j6ntGavm fMDxQs0qeaZxtGOkeRc/VF1hZ0tRU8r48DUw+rgdvUqAw104da3ANAxNZVE/hGVfozW6eL3Cltet5+ hO6b8NX0cYp8i2tWVvshjSuV8AXU1m
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

This reverts commit f950fd0529130a617b3da526da9fb6a896ce87c2. The
locking is going to be provided by vfs_rename() in the following
patches.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fd20423d3ed2..fd29a66e7241 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -793,11 +793,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (!empty_dir(new_inode))
 				goto out_oiter;
 		}
-		/*
-		 * We need to protect against old_inode getting converted from
-		 * ICB to normal directory.
-		 */
-		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
 		if (retval == -ENOENT) {
@@ -806,10 +801,8 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				old_inode->i_ino);
 			retval = -EFSCORRUPTED;
 		}
-		if (retval) {
-			inode_unlock(old_inode);
+		if (retval)
 			goto out_oiter;
-		}
 		has_diriter = true;
 		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
 		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
@@ -889,7 +882,6 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
-		inode_unlock(old_inode);
 
 		inode_dec_link_count(old_dir);
 		if (new_inode)
@@ -901,10 +893,8 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 	return 0;
 out_oiter:
-	if (has_diriter) {
+	if (has_diriter)
 		udf_fiiter_release(&diriter);
-		inode_unlock(old_inode);
-	}
 	udf_fiiter_release(&oiter);
 
 	return retval;
-- 
2.35.3

